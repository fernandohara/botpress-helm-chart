{{- define "common.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "common.fullname" -}}
{{- if ne .Release.Name .Chart.Name -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}

{{- define "common.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
