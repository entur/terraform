{{/* vim: set filetype=mustache: */}}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kafka-connect-bigquery-sink.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kafka-connect-bigquery-sink.labels" -}}
app: {{ .Chart.Name }}
team: {{ .Values.labels.team }}
slack: {{ .Values.labels.slack }}
type: {{ .Values.labels.type }}
environment: {{ .Release.Namespace }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end -}}

{{/*
Prometheus JMX metrics export
*/}}
{{- define "prometheusJmxExporter" -}}
{{ $prometheus    := .Values.prometheus -}}
{{ $javaagent   := printf " -javaagent:%s=%s:%s " $prometheus.javaagentLib $prometheus.metricsPort $prometheus.configFile -}}

"{{ $javaagent }}"

{{- end -}}
