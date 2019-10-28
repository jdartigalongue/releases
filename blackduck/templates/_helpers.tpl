{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bd.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "bd.labels" -}}
helm.sh/chart: {{ include "bd.chart" . }}
{{ include "bd.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "bd.selectorLabels" -}}
app: blackduck
name: {{ .Release.Name }}
version: {{ .Chart.AppVersion }}
{{- end -}}

{{/*
Common labels without version
*/}}
{{- define "bd.labelsWihtoutVersion" -}}
helm.sh/chart: {{ include "bd.chart" . }}
{{ include "bd.selectorLabelsWihtoutVersion" . }}
{{- end -}}

{{/*
Selector labels without version
*/}}
{{- define "bd.selectorLabelsWihtoutVersion" -}}
app: blackduck
name: {{ .Release.Name }}
{{- end -}}

{{/*
Security Context if Kubernetes
*/}}
{{- define "bd.securityContext" -}}
{{- if .Values.isKubernetes -}}
securityContext:
  fsGroup: 0
{{- end -}}
{{- end -}}

{{/*
Image pull secrets to pull the image
*/}}
{{- define "bd.imagePullSecrets" }}
{{- with .Values.imagePullSecrets }}
imagePullSecrets:
{{- toYaml . | nindent 0 }}
{{- end }}
{{- end }}
