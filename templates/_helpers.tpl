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
{{/*   Generic probe template for startupProbe, readinessProbe, and livenessProbe
  Usage: {{ include "probe" (dict "probe" .startupProbe) | nindent 2 }} */}}
{{- define "probe" -}}
  {{ .type }}:
    {{- if eq (.method | toString) "tcpSocket" }}
    tcpSocket:
      {{- with .port }}
      port:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- else if eq (.method | toString) "httpGet" }}
    httpGet:
      {{- with .path }}
      path: 
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .port }}
      port:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- else if eq (.method | toString) "grpc" }}
    grpc:
      {{- with .port }}
      port:
        {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- else if eq (.method | toString) "exec" }}
    exec:
      {{- with .command }}
      command: 
        {{- toYaml . | nindent 6 }}
      {{- end }}
    {{- else }}
      {{- with .custom }}
        {{- toYaml . | nindent 4 }}
      {{- end }}
    {{- end }}
    {{- with .initialDelaySeconds }}
    initialDelaySeconds: {{- toYaml . | nindent 6 | default 30 }}
    {{- end }}
    {{- with .periodSeconds }}
    periodSeconds: {{- toYaml . | nindent 6 | default 30 }}
    {{- end }}
    {{- with .successThreshold }}
    successThreshold: {{- toYaml . | nindent 6 | default 1 }}
    {{- end }}
    {{- with .failureThreshold }}
    failureThreshold: {{- toYaml . | nindent 6 | default 3 }}
    {{- end }}
    {{- with .timeoutSeconds }}
    timeoutSeconds: {{- toYaml . | nindent 6 | default 3 }}
    {{- end }}
{{- end }}