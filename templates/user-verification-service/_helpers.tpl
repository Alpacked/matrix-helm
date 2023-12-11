{{/*
Shared secret for the Matrix user verification server authentication.
*/}}
{{- define "matrix.uvs.authToken" }}
{{- if .Values.matrix.uvs.authToken }}
{{- .Values.matrix.uvs.authToken }}
{{- else }}
{{- randAlphaNum 64 }}
{{- end }}
{{- end }}
