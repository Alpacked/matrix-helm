ARG PYTHON_VERSION=3.11

FROM alpine:latest as source-code

ARG SYNAPSE_VERSION=v1.80.0

RUN wget -qO- https://codeload.github.com/matrix-org/synapse/tar.gz/refs/tags/${SYNAPSE_VERSION} | tar xvz -C / \
    && mv /synapse-${SYNAPSE_VERSION:1} /synapse

###
### Stage 0: generate requirements.txt
###
FROM python:${PYTHON_VERSION}-alpine as requirements

ARG TEST_ONLY_SKIP_DEP_HASH_VERIFICATION
ARG TEST_ONLY_IGNORE_POETRY_LOCKFILE
ARG CARGO_NET_GIT_FETCH_WITH_CLI=false

ENV CARGO_NET_GIT_FETCH_WITH_CLI=$CARGO_NET_GIT_FETCH_WITH_CLI
ENV RUSTUP_HOME=/rust
ENV CARGO_HOME=/cargo
ENV PATH=/cargo/bin:/rust/bin:$PATH

WORKDIR /synapse

COPY --from=source-code /synapse/pyproject.toml /synapse/poetry.lock /synapse/

RUN \
    apk update && apk add --no-cache \
    build-base curl git libffi-dev openssl-dev \
    && rm -rf /var/cache/apk/* \
    && mkdir /rust /cargo \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path --default-toolchain stable --profile minimal \
    && pip install --no-cache-dir --user "poetry==1.3.2" \
    && if [ -z "$TEST_ONLY_IGNORE_POETRY_LOCKFILE" ]; then \
            /root/.local/bin/poetry export --extras all -o /synapse/requirements.txt ${TEST_ONLY_SKIP_DEP_HASH_VERIFICATION:+--without-hashes}; \
        else \
            touch /synapse/requirements.txt; \
        fi

###
### Stage 1: builder
###
FROM python:${PYTHON_VERSION}-alpine as builder

ARG CARGO_NET_GIT_FETCH_WITH_CLI=false
ARG TEST_ONLY_IGNORE_POETRY_LOCKFILE

ENV CARGO_NET_GIT_FETCH_WITH_CLI=$CARGO_NET_GIT_FETCH_WITH_CLI
ENV RUSTUP_HOME=/rust
ENV CARGO_HOME=/cargo
ENV PATH=/cargo/bin:/rust/bin:$PATH

RUN \
    --mount=type=cache,target=/var/cache/apk,sharing=locked \
    apk add --update --no-cache \
    build-base \
    libffi-dev \
    libjpeg-turbo-dev \
    libpq-dev \
    libssl1.1 \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    openssl-dev \
    zlib-dev \
    git \
    curl \
    icu-dev \
    pkgconfig \
    && rm -rf /var/cache/apk/*

RUN mkdir /rust /cargo \
    && curl -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain stable --profile minimal

COPY --from=requirements /synapse/requirements.txt /synapse/
COPY --from=source-code /synapse/pyproject.toml /synapse/poetry.lock /synapse/
COPY --from=source-code /synapse/rust /synapse/rust/
COPY --from=source-code /synapse/pyproject.toml /synapse/README.rst /synapse/build_rust.py /synapse/Cargo.toml /synapse/Cargo.lock /synapse/
COPY --from=source-code /synapse/synapse /synapse/synapse/

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --prefix="/install" --no-deps --no-warn-script-location -r /synapse/requirements.txt \
    && --mount=type=cache,target=/synapse/target,sharing=locked \
    --mount=type=cache,target=${CARGO_HOME}/registry,sharing=locked ;\
    if [ -z "$TEST_ONLY_IGNORE_POETRY_LOCKFILE" ]; then \
        pip install --prefix="/install" --no-deps --no-warn-script-location /synapse[all]; \
    fi

###
### Stage 2: runtime
###

FROM python:${PYTHON_VERSION}-alpine

LABEL org.opencontainers.image.url='https://matrix.org/docs/projects/server/synapse'
LABEL org.opencontainers.image.documentation='https://github.com/matrix-org/synapse/blob/master/docker/README.md'
LABEL org.opencontainers.image.source='https://github.com/matrix-org/synapse.git'
LABEL org.opencontainers.image.licenses='Apache-2.0'

ENV GOSU_VERSION 1.16

RUN \
    --mount=type=cache,target=/var/cache/apk,sharing=locked \
    --mount=type=cache,target=/var/lib/apk,sharing=locked \
    apk update && apk add --no-cache  --virtual .gosu-deps \
    ca-certificates \
    build-base \
    curl \
    dpkg \
    gnupg \
    libjpeg-turbo \
    postgresql-libs \
    libwebp \
    xmlsec \
    icu-libs \
    openssl \
    && rm -rf /var/cache/apk/* \
    && wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj \
    && cd jemalloc-5.2.1 \
    && ./configure \
    && make \
    && make install \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
# verify the signature
	&& export GNUPGHOME="$(mktemp -d)"; \
	gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
# clean up fetch dependencies
	apk del --no-network .gosu-deps; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version; \
	gosu nobody true

RUN mkdir /usr/lib/x86_64-linux-gnu/ \
    && cp ./usr/local/lib/libjemalloc.so.2 /usr/lib/x86_64-linux-gnu/libjemalloc.so.2 \
    && ln -s /usr/local/bin/gosu /usr/sbin/gosu \
    && apk add git libpq-dev gcc libc-dev icu-dev icu-libs \
    && pip3 install git+https://github.com/matrix-org/synapse-s3-storage-provider.git

COPY --from=builder /install /usr/local
COPY --from=source-code /synapse/docker/start.py /start.py
COPY --from=source-code /synapse/docker/conf /conf

EXPOSE 8008/tcp 8009/tcp 8448/tcp

ENTRYPOINT ["/start.py"]

HEALTHCHECK --start-period=5s --interval=15s --timeout=5s \
CMD curl -fSs http://localhost:8008/health || exit 1
