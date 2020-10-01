{{/*
    Define passwd file for /var/lib/extrausers/passwd
*/}}

{{- define "var.lib.extrausers.passwd" -}}
{{- range $key, $value := .Values.userConfig }}
{{ $key }}:x:{{ $value.uid }}:65534:,,,:/tmp:{{ $value.shell }}
{{- end -}}
{{- end -}}


{{/*
    Define shadow file for /var/lib/extrausers/shadow
*/}}

{{- define "var.lib.extrausers.shadow" -}}
{{- range $key, $value := .Values.userConfig }}
{{ $key }}:x:{{ $value.uid }}:0:99999:7:::
{{- end -}}
{{- end -}}
