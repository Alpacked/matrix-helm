{{/*
Shared secret for the Matrix user verification server authentication.
*/}}
{{- define "matrix.uvs.authToken" }}
{{- randAlphaNum 64 }}
{{- end }}
