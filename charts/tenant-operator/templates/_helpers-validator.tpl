{{/*
return name for validator
*/}}
{{- define "tenant-validator.name" -}}
{{- printf "%s" "tenantvalidator" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant validator CertManager Certificate
*/}}
{{- define "tenant-validator.certManagerCertificate" -}}
{{- printf "%s-%s" (include "tenant-validator.name" .) "cert" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant validator CertManager Issuer
*/}}
{{- define "tenant-validator.certManagerIssuer" -}}
{{- printf "%s-%s" (include "tenant-validator.name" .) "selfsigned-issuer" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant validator service name
*/}}
{{- define "tenant-validator.svcName" -}}
{{- printf "%s-%s" .Values.tenantValidatorName "svc" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant validator pre delete hook name
*/}}
{{- define "tenant-validator.preDeleteHookName" -}}
{{- printf "%s-%s" .Values.tenantValidatorName "cleanup" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant validator name with prefix hpe service account
*/}}
{{- define "tenant-validator.hpePrefix" -}}
{{- printf "%s-%s" "hpe" .Values.tenantValidatorName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
return selector labels for validator
*/}}
{{- define "tenant-validator.selectorLabels" -}}
app: tenant-validator-app
{{- end }}

{{/*
return env for validator container
*/}}
{{- define "tenant-validator.env" -}}
- name : LOG_LEVEL
  value: "info"
{{- end }}

{{/*
return volume for validator container
*/}}
{{- define "tenant-validator.volumes" -}}
- name: tenant-validator-cert
  secret:
    secretName: tenant-validator-cert
{{- end }}

{{/*
return volumeMounts for validator container
*/}}
{{- define "tenant-validator.volumesMounts" -}}
- name: tenant-validator-cert
  mountPath: /tmp/k8s-webhook-server/serving-certs
  readOnly: true
{{- end }}

{{/*
Create a tenant-validator MutatingWebhook
*/}}
{{- define "tenant-validator.webhookMutatingName" -}}
{{- printf "%s-%s" (include "tenant-validator.name" .) "validating" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant-validator MutatingWebhookConfiguration
*/}}
{{- define "tenant-validator.webhookMutatingConfigurationName" -}}
{{- printf "%s-%s" (include "tenant-validator.webhookMutatingName" .) "cfg" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant-validator ValidatingWebhook
*/}}
{{- define "tenant-validator.webhookValidatingName" -}}
{{- printf "%s-%s" (include "tenant-validator.name" .) "validating" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a tenant-validator ValidatingWebhookConfiguration
*/}}
{{- define "tenant-validator.webhookValidatingConfigurationName" -}}
{{- printf "%s-%s" (include "tenant-validator.webhookValidatingName" .) "cfg" | trunc 63 | trimSuffix "-" }}
{{- end }}
