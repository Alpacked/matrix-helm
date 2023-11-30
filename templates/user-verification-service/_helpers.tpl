{{/*
Shared secret for the Matrix user verification server
*/}}
{{- define "matrix.uvs.accessToken" }}
{{- if .Values.matrix.uvs.accessToken }}
{{- .Values.matrix.uvs.accessToken }}
{{- else }}
{{- randAlphaNum 64 }}
{{- end }}
{{- end }}
