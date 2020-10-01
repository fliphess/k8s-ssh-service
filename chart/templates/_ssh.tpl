{{/*
    Define sshd configuration file
*/}}

{{- define "etc.ssh.sshd_config" -}}
{{- range $key, $value := .Values.sshdConfig }}
{{ $key }} {{ $value }}
{{- end -}}
{{- end -}}
