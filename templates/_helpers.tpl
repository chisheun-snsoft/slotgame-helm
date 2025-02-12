{{/* Define a resource limits and requests for microservices */}}
{{- define "resourceRequest" -}}
resources:
  limits:
    cpu: {{ .limits.cpu | default "1" | quote }}
    memory: {{ .limits.memory | default "1" | quote }}
  requests:
    cpu: {{ .requests.cpu | default "1" | quote }}
    memory: {{ .requests.memory | default "1" | quote }}
{{- end }}
{{/* Define a default command entry for microservices */}}
{{- define "containerCommand" -}}
- "-a"
- "http://vault-ui.vault.svc.cluster.local/"
- "-t"
- "hvs.k1C8Swd9pGr7rrZzUanAGhaV"
- "-p"
{{- end }}