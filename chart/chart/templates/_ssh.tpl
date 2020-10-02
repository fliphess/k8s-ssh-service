{{/*
    Define sshd configuration file
*/}}

{{- define "ssh-service.sshd_config" -}}
{{- range $key, $value := .Values.sshdConfig }}
{{ $key }} {{ $value }}
{{- end }}
{{- end -}}


{{- define "ssh-service.ssh-hostkeys" -}}
{{- range $idx, $map := $.Values.sshHostKeys }}
{{ if and (ne $map.content "") $map.content }}
{{ $map.name | quote }}: {{ $map.content | b64enc | quote }}
{{ end }}
{{- end -}}
{{- end -}}
