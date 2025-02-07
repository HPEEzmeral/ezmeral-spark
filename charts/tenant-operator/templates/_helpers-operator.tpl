{{/*
return name for operator
*/}}.
{{- define "tenant-operator.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant operator name with prefix hpe
*/}}
{{- define "tenant-operator.hpePrefix" -}}
{{- printf "%s-%s" "hpe" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tenant-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
return selector labels for operator
*/}}
{{- define "tenant-operator.selectorLabels" -}}
app: {{ .Chart.Name }}
{{- end }}

{{/*
return podAntiAffinity for tenant components
*/}}
{{- define "tenant-operator.podAntiAffinity.preferred" -}}
- podAffinityTerm:
    labelSelector:
        matchExpressions:
            - key: "app"
              operator: "In"
              values:
                - {{ .Chart.Name }}
    topologyKey: "kubernetes.io/hostname"
  weight: 1
{{- end }}

{{/*
return env for operator container
*/}}
{{- define "tenant-operator.env" -}}
- name : WATCH_NAMESPACE
  value: ""
- name: POD_NAME
  valueFrom:
      fieldRef:
        fieldPath: metadata.name
- name : OPERATOR_NAME
  value: "tenant-operator"
- name : K8S_TYPE
  value: "vanilla"
- name : LOG_LEVEL
  value: "info"
{{- end }}

{{/*
return args for operator container
*/}}
{{- define "tenant-operator.args" -}}
- --zap-devel
{{- end }}

{{/*
return commands for operator container
*/}}
{{- define "tenant-operator.commands" -}}
- /usr/local/bin/tenant-operator
{{- end }}
