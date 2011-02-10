# Require awk


define acl_udefault( $id, $mode, $path) {
        exec { "apply_udefault":
                command   => "/usr/bin/setfacl -m d:u:$id:$mode $path",
                onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^default/ && \$2 ~ /user/ && \$3 ~/$id/  && \$4 ~ /$mode/  { exit 1 } '  "
        }
}


define acl_gdefault( $id, $mode, $path) {
        exec { "apply_gdefault":
                command   => "/usr/bin/setfacl -m d:g:$id:$mode $path",
                onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^default/ && \$2 ~ /group/ && \$3 ~/$id/  && \$4 ~ /$mode/  { exit 1 } '  "
        }
}


define acl_group( $id, $mode, $path) {
        exec { "apply_group":
                command   => "/usr/bin/setfacl -m g:$id:$mode $path",
                onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^group/ && \$2 ~/$id/  && \$3 ~ /$mode/  { exit 1 } '  "
        }
}
 

define acl_user( $id, $mode, $path) {
        exec { "apply_user":
                command   => "/usr/bin/setfacl -m u:$id:$mode $path",
                onlyif => "/usr/bin/getfacl $path 2>&1 | awk -F: ' \$1 ~ /^user/ && \$2 ~/$id/  && \$3 ~ /$mode/  { exit 1 } '  "
        }
}

# Acceptable modes :

# rwx
# rw-
# r--
# --x

# I think you got it right ?



# Example of usage
# acl_user { "avalos_rw_rc.local" :
# id => avalos,
# mode => "rw-",
# path => "/etc/rc.local",
# }

