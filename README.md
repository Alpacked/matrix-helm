# matrix

![Version: 2.9.0](https://img.shields.io/badge/Version-2.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.23.0](https://img.shields.io/badge/AppVersion-1.23.0-informational?style=flat-square)

A helm chart for Matrix homeserver, element web-client, Jitsi conference and other components. This repo uses the [helm chart](https://github.com/typokign/matrix-chart) developed by @typokign as a basis.

**Homepage:** <https://github.com/Alpacked/matrix-helm>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| David Cruz | <david@typokign.com> | <https://github.com/typokign/> |
| Yevhenii Hordashnyk | <yevhenii@alpacked.io> | <https://github.com/jradikk/> |
| Volodymyr Starodubov | <volodymyr.starodubov@alpacked.io> | <https://github.com/v-starodubov/> |

## Source Code

* <https://github.com/dacruz21/matrix-chart>
* <https://github.com/Alpacked/matrix-helm>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 13.2.0 |
| https://charts.bitnami.com/bitnami | redis | 18.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` |  |
| bridges.discord.auth.botToken | string | `""` |  |
| bridges.discord.auth.clientId | string | `""` |  |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` |  |
| bridges.discord.data.capacity | string | `"512Mi"` |  |
| bridges.discord.data.storageClass | string | `""` |  |
| bridges.discord.defaultVisibility | string | `"public"` |  |
| bridges.discord.enabled | bool | `false` |  |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` |  |
| bridges.discord.image.tag | string | `"v1.0.0"` |  |
| bridges.discord.joinLeaveEvents | bool | `true` |  |
| bridges.discord.presence | bool | `true` |  |
| bridges.discord.readReceipt | bool | `true` |  |
| bridges.discord.replicaCount | int | `1` |  |
| bridges.discord.resources | object | `{}` |  |
| bridges.discord.selfService | bool | `false` |  |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` |  |
| bridges.discord.typingNotifications | bool | `true` |  |
| bridges.discord.users.nickname | string | `":nick"` |  |
| bridges.discord.users.username | string | `":username#:tag"` |  |
| bridges.irc.data.capacity | string | `"1Mi"` |  |
| bridges.irc.database | string | `"matrix_irc"` |  |
| bridges.irc.databaseSslVerify | bool | `true` |  |
| bridges.irc.enabled | bool | `false` |  |
| bridges.irc.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.irc.image.repository | string | `"matrixdotorg/matrix-appservice-irc"` |  |
| bridges.irc.image.tag | string | `"release-1.0.1"` |  |
| bridges.irc.presence | bool | `false` |  |
| bridges.irc.replicaCount | int | `1` |  |
| bridges.irc.resources | object | `{}` |  |
| bridges.irc.servers."chat.freenode.net".name | string | `"Freenode"` |  |
| bridges.irc.servers."chat.freenode.net".port | int | `6697` |  |
| bridges.irc.servers."chat.freenode.net".ssl | bool | `true` |  |
| bridges.irc.service.port | int | `9006` |  |
| bridges.irc.service.type | string | `"ClusterIP"` |  |
| bridges.volume.accessMode | string | `"ReadWriteMany"` |  |
| bridges.volume.capacity | string | `"1Mi"` |  |
| bridges.volume.storageClass | string | `""` |  |
| bridges.whatsapp.bot.avatar | string | `"mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr"` |  |
| bridges.whatsapp.bot.displayName | string | `"WhatsApp bridge bot"` |  |
| bridges.whatsapp.bot.username | string | `"whatsappbot"` |  |
| bridges.whatsapp.callNotices | bool | `true` |  |
| bridges.whatsapp.communityName | string | `"whatsapp_{{.Localpart}}={{.Server}}"` |  |
| bridges.whatsapp.connection.maxAttempts | int | `3` |  |
| bridges.whatsapp.connection.qrRegenCount | int | `2` |  |
| bridges.whatsapp.connection.reportRetry | bool | `true` |  |
| bridges.whatsapp.connection.retryDelay | int | `-1` |  |
| bridges.whatsapp.connection.timeout | int | `20` |  |
| bridges.whatsapp.data.capacity | string | `"512Mi"` |  |
| bridges.whatsapp.data.storageClass | string | `""` |  |
| bridges.whatsapp.enabled | bool | `false` |  |
| bridges.whatsapp.image.pullPolicy | string | `"Always"` |  |
| bridges.whatsapp.image.repository | string | `"dock.mau.dev/tulir/mautrix-whatsapp"` |  |
| bridges.whatsapp.image.tag | string | `"v0.10.3"` |  |
| bridges.whatsapp.permissions.* | string | `"relaybot"` |  |
| bridges.whatsapp.relaybot.enabled | bool | `false` |  |
| bridges.whatsapp.relaybot.invites | list | `[]` |  |
| bridges.whatsapp.relaybot.management | string | `"!foo:example.com"` |  |
| bridges.whatsapp.replicaCount | int | `1` |  |
| bridges.whatsapp.resources | object | `{}` |  |
| bridges.whatsapp.service.port | int | `29318` |  |
| bridges.whatsapp.service.type | string | `"ClusterIP"` |  |
| bridges.whatsapp.users.displayName | string | `"{{if .Notify}}{{.Notify}}{{else}}{{.Jid}}{{end}} (WA)"` |  |
| bridges.whatsapp.users.username | string | `"whatsapp_{{.}}"` |  |
| coturn.allowGuests | bool | `true` |  |
| coturn.enabled | bool | `false` |  |
| coturn.image.pullPolicy | string | `"IfNotPresent"` |  |
| coturn.image.repository | string | `"coturn/coturn"` |  |
| coturn.image.tag | string | `"4.6.2"` |  |
| coturn.kind | string | `"DaemonSet"` |  |
| coturn.labels.component | string | `"coturn"` |  |
| coturn.ports.from | int | `49152` |  |
| coturn.ports.to | int | `49172` |  |
| coturn.replicaCount | int | `1` |  |
| coturn.resources | object | `{}` |  |
| coturn.service.type | string | `"ClusterIP"` |  |
| coturn.sharedSecret | string | `""` |  |
| coturn.uris[0] | string | `"turn:marix.example.com?transport=udp"` |  |
| externalSecret.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | object | `{}` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.federation | bool | `true` |  |
| ingress.hosts.admin | string | `"admin.matrix.example.com"` |  |
| ingress.hosts.federation | string | `"federation.matrix.example.com"` |  |
| ingress.hosts.riot | string | `"element.matrix.example.com"` |  |
| ingress.hosts.synapse | string | `"matrix.example.com"` |  |
| ingress.tls | list | `[]` |  |
| mail.enabled | bool | `false` |  |
| mail.external.host | string | `""` |  |
| mail.external.password | string | `""` |  |
| mail.external.port | int | `25` |  |
| mail.external.requireTransportSecurity | bool | `true` |  |
| mail.external.username | string | `""` |  |
| mail.from | string | `"Matrix <matrix@example.com>"` |  |
| mail.relay.enabled | bool | `false` |  |
| mail.relay.image.pullPolicy | string | `"IfNotPresent"` |  |
| mail.relay.image.repository | string | `"devture/exim-relay"` |  |
| mail.relay.image.tag | string | `"4.96.2-r0-0"` |  |
| mail.relay.labels.component | string | `"mail"` |  |
| mail.relay.probes.liveness | object | `{}` |  |
| mail.relay.probes.readiness | object | `{}` |  |
| mail.relay.probes.startup | object | `{}` |  |
| mail.relay.replicaCount | int | `1` |  |
| mail.relay.resources | object | `{}` |  |
| mail.relay.service.port | int | `25` |  |
| mail.relay.service.type | string | `"ClusterIP"` |  |
| mail.riotUrl | string | `""` |  |
| matrix.adminEmail | string | `"admin@example.com"` |  |
| matrix.blockNonAdminInvites | bool | `false` |  |
| matrix.disabled | bool | `false` |  |
| matrix.disabledMessage | string | `""` |  |
| matrix.encryptByDefault | string | `"all"` |  |
| matrix.federation.allowPublicRooms | bool | `false` |  |
| matrix.federation.blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.federation.blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.federation.blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.federation.blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.federation.blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.federation.blacklist[5] | string | `"169.254.0.0/16"` |  |
| matrix.federation.blacklist[6] | string | `"::1/128"` |  |
| matrix.federation.blacklist[7] | string | `"fe80::/64"` |  |
| matrix.federation.blacklist[8] | string | `"fc00::/7"` |  |
| matrix.federation.enabled | bool | `false` |  |
| matrix.hostname | string | `"matrix.example.com"` |  |
| matrix.logging.rootLogLevel | string | `"DEBUG"` |  |
| matrix.logging.sqlLogLevel | string | `"WARNING"` |  |
| matrix.logging.synapseLogLevel | string | `"INFO"` |  |
| matrix.presence | bool | `true` |  |
| matrix.registration.allowGuests | bool | `false` |  |
| matrix.registration.autoJoinRooms[0] | string | `"\"#lobby:matrix.example.com\""` |  |
| matrix.registration.enabled | bool | `false` |  |
| matrix.registration.sharedSecret | string | `""` |  |
| matrix.retentionPeriod | string | `"7d"` |  |
| matrix.search | bool | `true` |  |
| matrix.security.enableRegistrationWithoutVerification | bool | `false` |  |
| matrix.security.macaroonSecretKey | string | `""` |  |
| matrix.security.suppressKeyServerWarning | bool | `true` |  |
| matrix.serverName | string | `"matrix.example.com"` |  |
| matrix.telemetry | bool | `false` |  |
| matrix.uploads.maxPixels | string | `"32M"` |  |
| matrix.uploads.maxSize | string | `"400M"` |  |
| matrix.urlPreviews.enabled | bool | `true` |  |
| matrix.urlPreviews.rules.ip.blacklist[0] | string | `"127.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[1] | string | `"10.0.0.0/8"` |  |
| matrix.urlPreviews.rules.ip.blacklist[2] | string | `"172.16.0.0/12"` |  |
| matrix.urlPreviews.rules.ip.blacklist[3] | string | `"192.168.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[4] | string | `"100.64.0.0/10"` |  |
| matrix.urlPreviews.rules.ip.blacklist[5] | string | `"169.254.0.0/16"` |  |
| matrix.urlPreviews.rules.ip.blacklist[6] | string | `"::1/128"` |  |
| matrix.urlPreviews.rules.ip.blacklist[7] | string | `"fe80::/64"` |  |
| matrix.urlPreviews.rules.ip.blacklist[8] | string | `"fc00::/7"` |  |
| matrix.urlPreviews.rules.maxSize | string | `"10M"` |  |
| matrix.urlPreviews.rules.url | object | `{}` |  |
| nameOverride | string | `""` |  |
| networkPolicies.enabled | bool | `false` |  |
| postgresql.auth.database | string | `"matrix"` |  |
| postgresql.auth.existingSecret | string | `""` |  |
| postgresql.auth.password | string | `"pa$$w0rd"` |  |
| postgresql.auth.username | string | `"matrixuser"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.hostname | string | `""` |  |
| postgresql.image.repository | string | `"bitnami/postgresql"` |  |
| postgresql.image.tag | string | `"16.0.0-debian-11-r13"` |  |
| postgresql.port | int | `5432` |  |
| postgresql.primary.containerSecurityContext.enabled | bool | `true` |  |
| postgresql.primary.containerSecurityContext.runAsUser | int | `1001` |  |
| postgresql.primary.initdb.args | string | `"--encoding=UTF8 --lc-collate=C --lc-ctype=C"` |  |
| postgresql.primary.initdb.scriptsConfigMap | string | `"{{ .Release.Name }}-postgresql-initdb"` |  |
| postgresql.primary.persistence.size | string | `"80Gi"` |  |
| postgresql.primary.persistence.storageClass | string | `""` |  |
| postgresql.primary.podSecurityContext.enabled | bool | `true` |  |
| postgresql.primary.podSecurityContext.fsGroup | int | `1001` |  |
| postgresql.tls.autoGenerated | bool | `true` |  |
| postgresql.tls.certCAFilename | string | `""` |  |
| postgresql.tls.certFilename | string | `""` |  |
| postgresql.tls.certKeyFilename | string | `""` |  |
| postgresql.tls.certificatesSecret | string | `""` |  |
| postgresql.tls.enabled | bool | `true` |  |
| postgresql.tls.sslMode | string | `"require"` |  |
| postgresql.volumePermissions.enabled | bool | `true` |  |
| redis.auth.database | string | `""` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.auth.existingSecret | string | `""` |  |
| redis.auth.password | string | `"pa$$w0rd"` |  |
| redis.enabled | bool | `false` |  |
| redis.hostname | string | `""` |  |
| redis.image.repository | string | `"bitnami/redis"` |  |
| redis.image.tag | string | `"7.2.3-debian-11-r0"` |  |
| redis.port | int | `6379` |  |
| redis.primary.containerSecurityContext.enabled | bool | `true` |  |
| redis.primary.containerSecurityContext.runAsUser | int | `1001` |  |
| redis.primary.persistence.size | string | `"1Gi"` |  |
| redis.primary.persistence.storageClass | string | `""` |  |
| redis.primary.podSecurityContext.enabled | bool | `true` |  |
| redis.primary.podSecurityContext.fsGroup | int | `1001` |  |
| redis.tls.autoGenerated | bool | `true` |  |
| redis.tls.certCAFilename | string | `""` |  |
| redis.tls.certFilename | string | `""` |  |
| redis.tls.certKeyFilename | string | `""` |  |
| redis.tls.enabled | bool | `false` |  |
| redis.tls.existingSecret | string | `""` |  |
| redis.volumePermissions.enabled | bool | `true` |  |
| riot.baseUrl | string | `"https://matrix.example.com"` |  |
| riot.branding.authFooterLinks | list | `[]` |  |
| riot.branding.authHeaderLogoUrl | string | `""` |  |
| riot.branding.brand | string | `"Element"` |  |
| riot.branding.welcomeBackgroundUrl | string | `""` |  |
| riot.enabled | bool | `true` |  |
| riot.image.pullPolicy | string | `"IfNotPresent"` |  |
| riot.image.repository | string | `"vectorim/element-web"` |  |
| riot.image.tag | string | `"v1.11.47"` |  |
| riot.integrations.api | string | `"https://scalar.vector.im/api"` |  |
| riot.integrations.enabled | bool | `true` |  |
| riot.integrations.ui | string | `"https://scalar.vector.im/"` |  |
| riot.integrations.widgets[0] | string | `"https://scalar.vector.im/_matrix/integrations/v1"` |  |
| riot.integrations.widgets[1] | string | `"https://scalar.vector.im/api"` |  |
| riot.integrations.widgets[2] | string | `"https://scalar-staging.vector.im/_matrix/integrations/v1"` |  |
| riot.integrations.widgets[3] | string | `"https://scalar-staging.vector.im/api"` |  |
| riot.integrations.widgets[4] | string | `"https://scalar-staging.riot.im/scalar/api"` |  |
| riot.jitsi.domain | string | `"meet.example.com"` |  |
| riot.labels.component | string | `"element"` |  |
| riot.labs[0] | string | `"feature_new_spinner"` |  |
| riot.labs[1] | string | `"feature_pinning"` |  |
| riot.labs[2] | string | `"feature_custom_status"` |  |
| riot.labs[3] | string | `"feature_custom_tags"` |  |
| riot.labs[4] | string | `"feature_state_counters"` |  |
| riot.labs[5] | string | `"feature_many_integration_managers"` |  |
| riot.labs[6] | string | `"feature_mjolnir"` |  |
| riot.labs[7] | string | `"feature_dm_verification"` |  |
| riot.labs[8] | string | `"feature_presence_in_room_list"` |  |
| riot.labs[9] | string | `"feature_custom_themes"` |  |
| riot.permalinkPrefix | string | `"https://marix.example.com"` |  |
| riot.probes.liveness | object | `{}` |  |
| riot.probes.readiness | object | `{}` |  |
| riot.probes.startup | object | `{}` |  |
| riot.replicaCount | int | `1` |  |
| riot.resources | object | `{}` |  |
| riot.roomDirectoryServers[0] | string | `"marix.example.com"` |  |
| riot.service.port | int | `80` |  |
| riot.service.type | string | `"ClusterIP"` |  |
| riot.welcomeUserId | string | `""` |  |
| synapse.hostAliases[0].hostnames[0] | string | `"matrix.example.com"` |  |
| synapse.hostAliases[0].ip | string | `"1.1.1.1"` |  |
| synapse.image.pullPolicy | string | `"IfNotPresent"` |  |
| synapse.image.repository | string | `"matrixdotorg/synapse"` |  |
| synapse.image.tag | string | `"v1.95.0"` |  |
| synapse.labels.component | string | `"synapse"` |  |
| synapse.metrics.annotations | bool | `true` |  |
| synapse.metrics.enabled | bool | `true` |  |
| synapse.metrics.port | int | `9092` |  |
| synapse.probes.liveness.periodSeconds | int | `10` |  |
| synapse.probes.liveness.timeoutSeconds | int | `5` |  |
| synapse.probes.readiness.periodSeconds | int | `10` |  |
| synapse.probes.readiness.timeoutSeconds | int | `5` |  |
| synapse.probes.startup.failureThreshold | int | `6` |  |
| synapse.probes.startup.periodSeconds | int | `5` |  |
| synapse.probes.startup.timeoutSeconds | int | `5` |  |
| synapse.replicaCount | int | `1` |  |
| synapse.resources.limits.memory | string | `"16Gi"` |  |
| synapse.resources.requests.memory | string | `"8Gi"` |  |
| synapse.service.federation.port | int | `80` |  |
| synapse.service.federation.type | string | `"ClusterIP"` |  |
| synapse.service.port | int | `80` |  |
| synapse.service.type | string | `"ClusterIP"` |  |
| synapseAdmin.enabled | bool | `false` |  |
| synapseAdmin.image.pullPolicy | string | `"IfNotPresent"` |  |
| synapseAdmin.image.repository | string | `"awesometechnologies/synapse-admin"` |  |
| synapseAdmin.image.tag | string | `"0.8.7"` |  |
| synapseAdmin.labels.component | string | `"synapse-admin"` |  |
| synapseAdmin.probes.liveness.periodSeconds | int | `10` |  |
| synapseAdmin.probes.liveness.timeoutSeconds | int | `5` |  |
| synapseAdmin.probes.readiness.periodSeconds | int | `10` |  |
| synapseAdmin.probes.readiness.timeoutSeconds | int | `5` |  |
| synapseAdmin.probes.startup.failureThreshold | int | `6` |  |
| synapseAdmin.probes.startup.periodSeconds | int | `5` |  |
| synapseAdmin.probes.startup.timeoutSeconds | int | `5` |  |
| synapseAdmin.replicaCount | int | `1` |  |
| synapseAdmin.resources | object | `{}` |  |
| synapseAdmin.service.port | int | `80` |  |
| synapseAdmin.service.type | string | `"ClusterIP"` |  |
| synapseAdmin.useSecureConnection | bool | `true` |  |
| volumes.media.capacity | string | `"10Gi"` |  |
| volumes.media.storageClass | string | `""` |  |
| volumes.signingKey.capacity | string | `"1Mi"` |  |
| volumes.signingKey.storageClass | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
