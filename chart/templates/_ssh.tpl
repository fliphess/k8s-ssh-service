{{/*
    Define sshd configuration file
*/}}

{{- define "ssh-service.sshd_config" -}}
{{- range $key, $value := .Values.sshdConfig }}
{{ $key }} {{ $value }}
{{ end -}}
{{- end -}}


{{- define "ssh-service.ssh_hostkeys" -}}
{{- range $idx, $map := $.Values.sshHostKeys }}
{{ if and (ne $map.content "") $map.content }}
{{ $map.name | quote }}: {{ $map.content | b64enc | quote }}
{{ end }}
{{- end -}}
{{- end -}}

{{- define "ssh-service.tcp_wrappers" -}}
{{- range $key, $value := $.Values.userConfig -}}
{{- range $ip := $value.ip_addresses }}
ALL : {{ $ip }}
{{ end }}
{{ end }}
sshd : LOCAL
{{- end -}}
