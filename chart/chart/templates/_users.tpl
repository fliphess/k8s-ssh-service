{{/*
    Define passwd file for /var/lib/extrausers/passwd
*/}}

{{- define "ssh-service.passwd" -}}
{{- range $key, $value := $.Values.userConfig -}}
{{ printf "%s:x:%s:65534:,,,:%s:%s\n" $key ($value.uid | toString) (default "/tmp" $.Values.homeDir) (default "/bin/bash" $value.shell) }}
{{- end -}}
{{- end -}}


{{/*
    Define shadow file for /var/lib/extrausers/shadow
*/}}

{{- define "ssh-service.shadow" -}}
{{- range $key, $value := $.Values.userConfig -}}
{{ printf "%s:x:%s:0:99999:7:::\n" $key ($value.uid | toString) }}
{{- end -}}
{{- end -}}
