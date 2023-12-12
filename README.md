# Matrix Helm Chart

![Version: 2.9.0](https://img.shields.io/badge/Version-2.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.23.0](https://img.shields.io/badge/AppVersion-1.23.0-informational?style=flat-square)
[![Docker Build and Scan Image](https://github.com/Alpacked/matrix-helm/actions/workflows/docker-build-scan.yaml/badge.svg?branch=master)](https://github.com/Alpacked/matrix-helm/actions/workflows/docker-build-scan.yaml)

A helm chart for Matrix homeserver, element web-client, Jitsi conference and other components. This repo uses the [helm chart](https://github.com/typokign/matrix-chart) developed by @typokign as a basis.
## Source Code

* <https://github.com/dacruz21/matrix-chart>
* <https://github.com/Alpacked/matrix-helm>

## Table of Contents
- [Features](#features)
- [Configuration](#configuration)
- [Caveats](#caveats)
- [Requirements](#requirements)
- [Values](#values)
- [Maintainers](#maintainers)

## Features

- Latest version of Synapse with plugin installation support.
- (Optional) Element (Riot) Web ([vectorim/element-web](https://github.com/element-hq/element-web))
- (Optional) Synapse Admin Web ([awesometechnologies/synapse-admin](https://github.com/Awesome-Technologies/synapse-admin))
- (Optional) User Verification Service ([matrixdotorg/matrix-user-verification-service](https://github.com/matrix-org/matrix-user-verification-service))
- (Optional) Exim relay or external mail server for email notifications ([devture/exim-relay](https://github.com/devture/exim-relay))
- (Optional) Coturn TURN server for VoIP calls ([coturn/coturn](https://github.com/coturn/coturn))
- (Optional) Jitsi for video conferences with Matrix authorization ([jitsi-contrib/jitsi-helm](https://github.com/jitsi-contrib/jitsi-helm))
- (Optional) PostgreSQL database cluster ([bitnami/postgresql](https://artifacthub.io/packages/helm/bitnami/postgresql))
- (Optional) Redis for multi-worker deployment ([bitnami/redis](https://artifacthub.io/packages/helm/bitnami/redis))
- (Optional) IRC bridge ([matrixdotorg/matrix-appservice-irc](https://github.com/matrix-org/matrix-appservice-irc))
- (Optional) WhatsApp bridge ([tulir/mautrix-whatsapp](https://github.com/mautrix/whatsapp))
- (Optional) Discord bridge ([halfshot/matrix-appservice-discord](https://github.com/matrix-org/matrix-appservice-discord))
- Fully configurable via values.yaml
- NGINX Ingress definition for federated Synapse, Admin, Element (Riot) and Jitsi.

## Configuration

The basic configuration of chart is done in default [values.yaml](values.yaml), main configuration by user is:
1. Enable optional services that you require.
2. Provide valid DNS names for applications.
3. Set persistent storages for your database and other apps, that require it.
4. Configure ingress for service endpoints (or use predefined for NGINX Ingress).
5. Deploy to your k8s cluster.

## Caveats

Jitsi application is configured to use Matrix authorization by default, but right now it can't be configured automatically via Helm chart installation.

After deployment of Synapse required to create admin user and get access token, that can be provided via `.Values.matrix.uvs.accessToken`.

More info about providing admin rights and API can be found [here](https://github.com/matrix-org/synapse/blob/develop/docs/usage/administration/admin_api/README.md).

![](how-to-get-access-token.png)

In future this can be changed (https://matrix.org/blog/2023/09/better-auth) and currently Matrix team testing side-car [matrix-authentication-service](https://matrix-org.github.io/matrix-authentication-service/).

Despite Redis included in this chart, the multi-worker Synapse is not tested and can be not fully configured in [homeserver.yaml](templates/synapse/_homeserver.yaml).

External Secret manifest can be used for more secure value storage, but it doesn't contain all chart values right not.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 13.2.0 |
| https://charts.bitnami.com/bitnami | redis | 18.2.0 |
| https://jitsi-contrib.github.io/jitsi-helm | jitsi(jitsi-meet) | 1.3.8 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| bridges.affinity | bool | `false` | Recommended to leave this disabled to allow bridges to be scheduled on separate nodes. |
| bridges.discord.auth | object | `{"botToken":"","clientId":""}` | Discord bot authentication |
| bridges.discord.channelName | string | `"[Discord] :guild :name"` | The name of bridged rooms |
| bridges.discord.data.capacity | string | `"512Mi"` | Size of the PVC to allocate for the SQLite database |
| bridges.discord.data.storageClass | string | `""` | Storage class (optional) |
| bridges.discord.defaultVisibility | string | `"public"` | Default visibility of bridged rooms (public/private) |
| bridges.discord.enabled | bool | `false` | Set to true to enable the Discord bridge |
| bridges.discord.image.pullPolicy | string | `"Always"` |  |
| bridges.discord.image.repository | string | `"halfshot/matrix-appservice-discord"` |  |
| bridges.discord.image.tag | string | `"v1.0.0"` |  |
| bridges.discord.joinLeaveEvents | bool | `true` | Set to false to disable Discord notifications when a user joins/leaves the Matrix channel |
| bridges.discord.presence | bool | `true` | Set to false to disable online/offline presence for Discord users |
| bridges.discord.readReceipt | bool | `true` | Set to false to disable the Discord bot read receipt, which advances whenever the bot bridges a message |
| bridges.discord.replicaCount | int | `1` |  |
| bridges.discord.resources | object | `{}` |  |
| bridges.discord.selfService | bool | `false` | Set to true to allow users to bridge rooms themselves using !discord commands |
| bridges.discord.service.port | int | `9005` |  |
| bridges.discord.service.type | string | `"ClusterIP"` |  |
| bridges.discord.typingNotifications | bool | `true` | Set to false to disable typing notifications (only for Discord to Matrix) |
| bridges.discord.users.nickname | string | `":nick"` | Nickname of bridged Discord users |
| bridges.discord.users.username | string | `":username#:tag"` | Username of bridged Discord users |
| bridges.irc.data.capacity | string | `"1Mi"` | Size of the data PVC to allocate |
| bridges.irc.database | string | `"matrix_irc"` | Name of Postgres database to store IRC bridge data in |
| bridges.irc.databaseSslVerify | bool | `true` |  |
| bridges.irc.enabled | bool | `false` | Set to true to enable the IRC bridge |
| bridges.irc.image.pullPolicy | string | `"IfNotPresent"` |  |
| bridges.irc.image.repository | string | `"matrixdotorg/matrix-appservice-irc"` |  |
| bridges.irc.image.tag | string | `"release-1.0.1"` |  |
| bridges.irc.presence | bool | `false` | Whether to enable presence (online/offline indicators).  |
| bridges.irc.replicaCount | int | `1` |  |
| bridges.irc.resources | object | `{}` |  |
| bridges.irc.servers."chat.freenode.net".name | string | `"Freenode"` | A human-readable short name. |
| bridges.irc.servers."chat.freenode.net".port | int | `6697` | The port to connect to. Optional. |
| bridges.irc.servers."chat.freenode.net".ssl | bool | `true` | Whether to use SSL or not. Default: false. |
| bridges.irc.service.port | int | `9006` |  |
| bridges.irc.service.type | string | `"ClusterIP"` |  |
| bridges.volume.accessMode | string | `"ReadWriteMany"` | Access mode of the shared volume. |
| bridges.volume.capacity | string | `"1Mi"` | Capacity of the shared volume for storing bridge/appservice registration files |
| bridges.volume.storageClass | string | `""` | Storage class (optional) |
| bridges.whatsapp.bot | object | `{"avatar":"mxc://maunium.net/NeXNQarUbrlYBiPCpprYsRqr","displayName":"WhatsApp bridge bot","username":"whatsappbot"}` | Username and display name of the WhatsApp bridge bot |
| bridges.whatsapp.callNotices | bool | `true` | Send notifications for incoming calls |
| bridges.whatsapp.communityName | string | `"whatsapp_{{.Localpart}}={{.Server}}"` | Display name for communities. |
| bridges.whatsapp.connection | object | `{"maxAttempts":3,"qrRegenCount":2,"reportRetry":true,"retryDelay":-1,"timeout":20}` | WhatsApp server connection settings |
| bridges.whatsapp.connection.maxAttempts | int | `3` | Maximum number of connection attempts before failing |
| bridges.whatsapp.connection.qrRegenCount | int | `2` | Number of QR codes to store, essentially multiplying the connection timeout |
| bridges.whatsapp.connection.reportRetry | bool | `true` | Whether or not to notify the user when attempting to reconnect. Set to false to only report when maxAttempts has been reached |
| bridges.whatsapp.connection.retryDelay | int | `-1` | Retry delay |
| bridges.whatsapp.connection.timeout | int | `20` | WhatsApp server connection timeout (seconds) |
| bridges.whatsapp.data.capacity | string | `"512Mi"` | Size of the PVC to allocate for the SQLite database |
| bridges.whatsapp.data.storageClass | string | `""` | Storage class (optional) |
| bridges.whatsapp.enabled | bool | `false` | Set to true to enable the WhatsApp bridge |
| bridges.whatsapp.image.pullPolicy | string | `"Always"` |  |
| bridges.whatsapp.image.repository | string | `"dock.mau.dev/tulir/mautrix-whatsapp"` |  |
| bridges.whatsapp.image.tag | string | `"v0.10.3"` |  |
| bridges.whatsapp.permissions | object | `{"*":"relaybot"}` | Permissions for using the bridge. |
| bridges.whatsapp.relaybot.enabled | bool | `false` | Set to true to enable the relaybot and management room |
| bridges.whatsapp.relaybot.invites | list | `[]` | Users to invite to the management room automatically |
| bridges.whatsapp.relaybot.management | string | `"!foo:example.com"` | Management room for the relay bot where status notifications are posted |
| bridges.whatsapp.replicaCount | int | `1` |  |
| bridges.whatsapp.resources | object | `{}` |  |
| bridges.whatsapp.service.port | int | `29318` |  |
| bridges.whatsapp.service.type | string | `"ClusterIP"` |  |
| bridges.whatsapp.users.displayName | string | `"{{if .Notify}}{{.Notify}}{{else}}{{.Jid}}{{end}} (WA)"` | Display name for WhatsApp users |
| bridges.whatsapp.users.username | string | `"whatsapp_{{.}}"` | Username for WhatsApp users |
| coturn.allowGuests | bool | `true` | Whether to allow guests to use the TURN server |
| coturn.enabled | bool | `false` | Set to true to enable the included deployment of Coturn |
| coturn.image.pullPolicy | string | `"IfNotPresent"` |  |
| coturn.image.repository | string | `"coturn/coturn"` |  |
| coturn.image.tag | string | `"4.6.2"` |  |
| coturn.kind | string | `"DaemonSet"` | How to deploy Coturn |
| coturn.labels | object | `{"component":"coturn"}` | Coturn specific labels |
| coturn.ports | object | `{"from":49152,"to":49172}` | UDP port range for TURN connections |
| coturn.replicaCount | int | `1` |  |
| coturn.resources | object | `{}` |  |
| coturn.service.type | string | `"ClusterIP"` | The type of service to deploy for routing Coturn traffic |
| coturn.sharedSecret | string | `""` | Shared secret for communication between Synapse and Coturn. |
| coturn.uris | list | `["turn:marix.example.com?transport=udp"]` | URIs of the Coturn servers |
| externalSecret.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | object | `{}` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/configuration-snippet" | string | `"proxy_intercept_errors off;\n"` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.federation | bool | `true` |  |
| ingress.hosts.admin | string | `"admin.matrix.example.com"` |  |
| ingress.hosts.federation | string | `"federation.matrix.example.com"` |  |
| ingress.hosts.jitsi | string | `"meet.example.com"` |  |
| ingress.hosts.riot | string | `"element.matrix.example.com"` |  |
| ingress.hosts.synapse | string | `"matrix.example.com"` |  |
| ingress.tls | list | `[]` |  |
| jitsi.enableAuth | bool | `true` |  |
| jitsi.enableGuests | bool | `false` |  |
| jitsi.enabled | bool | `false` |  |
| jitsi.extraCommonEnvs.AUTH_TYPE | string | `"matrix"` |  |
| jitsi.global | object | `{"podLabels":{"component":"jitsi"}}` | Jitsi specific labels |
| jitsi.jibri.enabled | bool | `false` |  |
| jitsi.jibri.image.repository | string | `"jjitsi/jibri"` |  |
| jitsi.jibri.image.tag | string | `"stable"` |  |
| jitsi.jibri.persistence.enabled | bool | `false` |  |
| jitsi.jibri.persistence.size | string | `"4Gi"` |  |
| jitsi.jibri.persistence.storageClassName | string | `""` |  |
| jitsi.jibri.replicaCount | int | `1` |  |
| jitsi.jibri.shm.enabled | bool | `true` |  |
| jitsi.jicofo.image.repository | string | `"jitsi/jicofo"` |  |
| jitsi.jicofo.image.tag | string | `"stable"` |  |
| jitsi.jicofo.replicaCount | int | `1` |  |
| jitsi.jvb.UDPPort | int | `10000` |  |
| jitsi.jvb.image.repository | string | `"jitsi/jvb"` |  |
| jitsi.jvb.image.tag | string | `"stable"` |  |
| jitsi.jvb.replicaCount | int | `1` |  |
| jitsi.jvb.service.enabled | bool | `true` |  |
| jitsi.jvb.service.externalTrafficPolicy | string | `""` |  |
| jitsi.jvb.service.type | string | `"ClusterIP"` |  |
| jitsi.prosody.enabled | bool | `true` |  |
| jitsi.prosody.extraEnvFrom[0].secretRef.name | string | `"{{ include \"matrix.fullname\" . }}-uvs"` |  |
| jitsi.prosody.extraEnvFrom[1].secretRef.name | string | `"{{ include \"matrix.fullname\" . }}-jicofo"` |  |
| jitsi.prosody.extraEnvFrom[2].secretRef.name | string | `"{{ include \"matrix.fullname\" . }}-jvb"` |  |
| jitsi.prosody.extraEnvFrom[3].configMapRef.name | string | `"{{ include \"matrix.fullname\" . }}-common"` |  |
| jitsi.prosody.image.repository | string | `"jitsi/prosody"` |  |
| jitsi.prosody.image.tag | string | `"stable"` |  |
| jitsi.prosody.persistence.enabled | bool | `false` |  |
| jitsi.prosody.persistence.size | string | `"3Gi"` |  |
| jitsi.prosody.persistence.storageClassName | string | `""` |  |
| jitsi.prosody.podSecurityContext.fsGroup | int | `102` |  |
| jitsi.publicURL | string | `"meet.example.com"` |  |
| jitsi.web.extraVolumeMounts[0].mountPath | string | `"/usr/share/jitsi-meet/.well-known/element/jitsi"` |  |
| jitsi.web.extraVolumeMounts[0].name | string | `"well-known-element-jitsi"` |  |
| jitsi.web.extraVolumeMounts[0].readOnly | bool | `true` |  |
| jitsi.web.extraVolumeMounts[0].subPath | string | `"jitsi.json"` |  |
| jitsi.web.extraVolumes[0].configMap.name | string | `"matrix-jitsi-web-config"` |  |
| jitsi.web.extraVolumes[0].name | string | `"well-known-element-jitsi"` |  |
| jitsi.web.image.repository | string | `"jitsi/web"` |  |
| jitsi.web.image.tag | string | `"stable"` |  |
| jitsi.web.replicaCount | int | `1` |  |
| jitsi.web.service.port | int | `80` |  |
| jitsi.web.service.type | string | `"ClusterIP"` |  |
| mail.enabled | bool | `false` | Set to false to disable all email notifications |
| mail.external | object | `{"host":"","password":"","port":25,"requireTransportSecurity":true,"username":""}` | External mail server |
| mail.from | string | `"Matrix <matrix@example.com>"` | Name and email address for outgoing mail |
| mail.relay | object | `{"enabled":false,"image":{"pullPolicy":"IfNotPresent","repository":"devture/exim-relay","tag":"4.96.2-r0-0"},"labels":{"component":"mail"},"probes":{"liveness":{},"readiness":{},"startup":{}},"replicaCount":1,"resources":{},"service":{"port":25,"type":"ClusterIP"}}` | Exim relay |
| mail.riotUrl | string | `""` | Optional: Element instance URL. |
| matrix.adminEmail | string | `"admin@example.com"` | Email address of the administrator |
| matrix.blockNonAdminInvites | bool | `false` | Set to true to block non-admins from inviting users to any rooms |
| matrix.disabled | bool | `false` | Set to true to globally block access to the homeserver |
| matrix.disabledMessage | string | `""` | Human readable reason for why the homeserver is blocked |
| matrix.encryptByDefault | string | `"all"` | Which types of rooms to enable end-to-end encryption on by default |
| matrix.federation.allowPublicRooms | bool | `false` | Set to true to allow members of other homeservers to fetch *public* rooms |
| matrix.federation.blacklist | list | `["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"]` | IP addresses to blacklist federation requests to |
| matrix.federation.enabled | bool | `false` | Set to true to enable federation and run an isolated homeserver |
| matrix.federation.whitelist | list | `[]` | Whitelist of domains to federate with (empty for all domains except blacklisted) |
| matrix.homeserverExtra | object | `{}` | Contents will be appended to the end of the default configuration. |
| matrix.homeserverOverride | object | `{}` | Entirety of homeserver.yaml will be replaced with the contents, if set. |
| matrix.hostname | string | `"matrix.example.com"` | Hostname where Synapse can be reached. |
| matrix.logging.rootLogLevel | string | `"DEBUG"` | Root log level is the default log level for log outputs that do not have more specific settings. |
| matrix.logging.sqlLogLevel | string | `"WARNING"` |  |
| matrix.logging.synapseLogLevel | string | `"INFO"` | The log level for the synapse server |
| matrix.presence | bool | `true` | Set to false to disable presence (online/offline indicators) |
| matrix.registration.allowGuests | bool | `false` | Allow users to join rooms as a guest |
| matrix.registration.autoJoinRooms | list | `["\"#lobby:matrix.example.com\""]` | Rooms to automatically join all new users to |
| matrix.registration.enabled | bool | `false` | Allow new users to register an account |
| matrix.registration.required3Pids | list | `[]` | Required "3PIDs" - third-party identifiers such as email or msisdn (SMS) |
| matrix.registration.sharedSecret | string | `""` | If set, allows registration of standard or admin accounts by anyone who has the shared secret, even if registration is otherwise disabled. |
| matrix.retentionPeriod | string | `"7d"` | How long to keep redacted events in unredacted form in the database |
| matrix.search | bool | `true` | Set to false to disable message searching |
| matrix.security.enableRegistrationWithoutVerification | bool | `false` | Enable this if you want start matrix without any type of verification (email, captcha, or token-based) |
| matrix.security.macaroonSecretKey | string | `""` | A secret which is used to sign access tokens. |
| matrix.security.suppressKeyServerWarning | bool | `true` | This disables the warning that is emitted when the trustedKeyServers include 'matrix.org'. See below. |
| matrix.serverName | string | `"matrix.example.com"` | Domain name of the server |
| matrix.telemetry | bool | `false` | Enable anonymous telemetry to matrix.org |
| matrix.uploads.maxPixels | string | `"32M"` | Max image size in pixels |
| matrix.uploads.maxSize | string | `"400M"` | Max upload size in bytes |
| matrix.urlPreviews.enabled | bool | `true` | Enable URL previews. |
| matrix.urlPreviews.rules.ip | object | `{"blacklist":["127.0.0.0/8","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16","100.64.0.0/10","169.254.0.0/16","::1/128","fe80::/64","fc00::/7"],"whitelist":[]}` | Whitelist and blacklist for crawlable IP addresses |
| matrix.urlPreviews.rules.maxSize | string | `"10M"` | Maximum size of a crawlable page. Keep this low to prevent a DOS vector |
| matrix.urlPreviews.rules.url | object | `{}` | Whitelist and blacklist based on URL pattern matching |
| matrix.uvs.accessToken | string | `""` | Access token for Matrix Synapse API. |
| matrix.uvs.authToken | string | `""` | Auth token to protect the API |
| matrix.uvs.disableIpBlacklist | bool | `true` | Disable check for non private IP range of homeserver. E.g. set to `true` if your homeserver domain resolves to a private IP. |
| matrix.uvs.enabled | bool | `false` |  |
| matrix.uvs.image.pullPolicy | string | `"IfNotPresent"` |  |
| matrix.uvs.image.repository | string | `"matrixdotorg/matrix-user-verification-service"` |  |
| matrix.uvs.image.tag | string | `"v3.0.0"` |  |
| matrix.uvs.labels | object | `{"component":"uvs"}` | UVS specific labels |
| matrix.uvs.logLevel | string | `"info"` |  |
| matrix.uvs.replicaCount | int | `1` |  |
| matrix.uvs.service.port | int | `3000` |  |
| matrix.uvs.service.type | string | `"ClusterIP"` |  |
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
| postgresql.primary.persistence.size | string | `"80Gi"` | Size of database storage |
| postgresql.primary.persistence.storageClass | string | `""` | Storage class (optional) |
| postgresql.primary.podSecurityContext.enabled | bool | `true` |  |
| postgresql.primary.podSecurityContext.fsGroup | int | `1001` |  |
| postgresql.tls.autoGenerated | bool | `true` | Generate automatically self-signed TLS certificates (disable if you want use external certificate) |
| postgresql.tls.certCAFilename | string | `""` |  |
| postgresql.tls.certFilename | string | `""` |  |
| postgresql.tls.certKeyFilename | string | `""` |  |
| postgresql.tls.certificatesSecret | string | `""` | Name of an existing secret that contains certificates. |
| postgresql.tls.enabled | bool | `true` |  |
| postgresql.tls.sslMode | string | `"require"` | Allowed modes: disable, allow, prefer, require, verify-ca, verify-full |
| postgresql.volumePermissions | object | `{"enabled":true}` | Enable init container that changes the owner and group of the persistent volume |
| redis.auth.database | string | `""` |  |
| redis.auth.enabled | bool | `false` |  |
| redis.auth.existingSecret | string | `""` | Use this if you want to provide password (auth.existingSecretPasswordKey) via Kubernetes secret. |
| redis.auth.password | string | `"pa$$w0rd"` |  |
| redis.enabled | bool | `false` | This must be enabled when using workers. |
| redis.hostname | string | `""` | Set this if redis.enabled = false |
| redis.image.repository | string | `"bitnami/redis"` |  |
| redis.image.tag | string | `"7.2.3-debian-11-r0"` |  |
| redis.port | int | `6379` |  |
| redis.primary.containerSecurityContext.enabled | bool | `true` |  |
| redis.primary.containerSecurityContext.runAsUser | int | `1001` |  |
| redis.primary.persistence.size | string | `"1Gi"` | Size of redis storage |
| redis.primary.persistence.storageClass | string | `""` | Storage class (optional) |
| redis.primary.podSecurityContext.enabled | bool | `true` |  |
| redis.primary.podSecurityContext.fsGroup | int | `1001` |  |
| redis.tls.autoGenerated | bool | `true` | Generate automatically self-signed TLS certificates (disable if you want use external certificate) |
| redis.tls.certCAFilename | string | `""` |  |
| redis.tls.certFilename | string | `""` |  |
| redis.tls.certKeyFilename | string | `""` |  |
| redis.tls.enabled | bool | `false` |  |
| redis.tls.existingSecret | string | `""` | Name of an existing secret that contains certificates. |
| redis.volumePermissions | object | `{"enabled":true}` | Enable init container that changes the owner and group of the persistent volume |
| riot.baseUrl | string | `"https://matrix.example.com"` |  |
| riot.branding | object | `{"authFooterLinks":[],"authHeaderLogoUrl":"","brand":"Element","welcomeBackgroundUrl":""}` | Organization/enterprise branding |
| riot.branding.authFooterLinks | list | `[]` | Array of links to show at the bottom of the login screen |
| riot.branding.authHeaderLogoUrl | string | `""` | Logo shown at top of login screen |
| riot.branding.brand | string | `"Element"` | Shown in email notifications |
| riot.branding.welcomeBackgroundUrl | string | `""` | Background of login splash screen |
| riot.enabled | bool | `true` | Set to false to disable a deployment of Element. |
| riot.image.pullPolicy | string | `"IfNotPresent"` |  |
| riot.image.repository | string | `"vectorim/element-web"` |  |
| riot.image.tag | string | `"v1.11.47"` |  |
| riot.integrations | object | `{"api":"https://scalar.vector.im/api","enabled":true,"ui":"https://scalar.vector.im/","widgets":["https://scalar.vector.im/_matrix/integrations/v1","https://scalar.vector.im/api","https://scalar-staging.vector.im/_matrix/integrations/v1","https://scalar-staging.vector.im/api","https://scalar-staging.riot.im/scalar/api"]}` | Element integrations configuration |
| riot.integrations.api | string | `"https://scalar.vector.im/api"` | API for the integration server |
| riot.integrations.enabled | bool | `true` | Set to false to disable the Integrations menu (including widgets, bots, and other plugins to Element) |
| riot.integrations.ui | string | `"https://scalar.vector.im/"` | UI to load when a user selects the Integrations button at the top-right of a room |
| riot.integrations.widgets | list | `["https://scalar.vector.im/_matrix/integrations/v1","https://scalar.vector.im/api","https://scalar-staging.vector.im/_matrix/integrations/v1","https://scalar-staging.vector.im/api","https://scalar-staging.riot.im/scalar/api"]` | Array of API paths providing widgets |
| riot.jitsi | object | `{"domain":""}` | Use this value to link with external Jitsi instance |
| riot.labels | object | `{"component":"element"}` | Element specific labels |
| riot.labs | list | `["feature_new_spinner","feature_pinning","feature_custom_status","feature_custom_tags","feature_state_counters","feature_many_integration_managers","feature_mjolnir","feature_dm_verification","feature_presence_in_room_list","feature_custom_themes"]` | Experimental features in Element |
| riot.permalinkPrefix | string | `"https://marix.example.com"` | Prefix before permalinks generated when users share links to rooms, users, or messages. If running an unfederated Synapse, set the below to the URL of your Element instance. |
| riot.probes.liveness | object | `{}` |  |
| riot.probes.readiness | object | `{}` |  |
| riot.probes.startup | object | `{}` |  |
| riot.replicaCount | int | `1` |  |
| riot.resources | object | `{}` |  |
| riot.roomDirectoryServers | list | `["marix.example.com"]` | Servers to show in the Explore menu (the current server is always shown) |
| riot.service.port | int | `80` |  |
| riot.service.type | string | `"ClusterIP"` |  |
| riot.welcomeUserId | string | `""` | Set to the user ID (@username:domain.tld) of a bot to invite all new users to a DM with the bot upon registration |
| synapse.hostAliases[0].hostnames[0] | string | `"matrix.example.com"` |  |
| synapse.hostAliases[0].ip | string | `"1.1.1.1"` |  |
| synapse.image.pullPolicy | string | `"IfNotPresent"` |  |
| synapse.image.repository | string | `"matrixdotorg/synapse"` |  |
| synapse.image.tag | string | `"v1.95.0"` |  |
| synapse.labels | object | `{"component":"synapse"}` | Labels to be appended to all Synapse resources |
| synapse.metrics | object | `{"annotations":true,"enabled":true,"port":9092}` | Prometheus metrics for Synapse |
| synapse.metrics.enabled | bool | `true` | Whether Synapse should capture metrics on an additional endpoint |
| synapse.metrics.port | int | `9092` | Port to listen on for metrics scraping |
| synapse.plugins | list | `["git+https://github.com/matrix-org/synapse-s3-storage-provider.git"]` | These plugins will be installed via pip3 install command at the start of synapse container |
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
| synapseAdmin.labels | object | `{"component":"synapse-admin"}` | Synapse admin specific labels |
| synapseAdmin.probes | object | `{"liveness":{"periodSeconds":10,"timeoutSeconds":5},"readiness":{"periodSeconds":10,"timeoutSeconds":5},"startup":{"failureThreshold":6,"periodSeconds":5,"timeoutSeconds":5}}` | Configure timings for readiness, startup, and liveness probes here |
| synapseAdmin.replicaCount | int | `1` |  |
| synapseAdmin.resources | object | `{}` |  |
| synapseAdmin.service.port | int | `80` |  |
| synapseAdmin.service.type | string | `"ClusterIP"` |  |
| synapseAdmin.useSecureConnection | bool | `true` | Set false if you want connect admin to synapse via http |
| volumes.media | object | `{"capacity":"10Gi","storageClass":""}` | Uploaded attachments/multimedia |
| volumes.media.capacity | string | `"10Gi"` | Capacity of the media persistent volume claim |
| volumes.media.storageClass | string | `""` | Storage class (optional) |
| volumes.signingKey.capacity | string | `"1Mi"` | Capacity of the signing key PVC |
| volumes.signingKey.storageClass | string | `""` | Storage class (optional) |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| David Cruz | <david@typokign.com> | <https://github.com/typokign/> |
| Yevhenii Hordashnyk | <yevhenii@alpacked.io> | <https://github.com/jradikk/> |
| Volodymyr Starodubov | <volodymyr.starodubov@alpacked.io> | <https://github.com/v-starodubov/> |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs) and [README.md.gotmpl](README.md.gotmpl)
