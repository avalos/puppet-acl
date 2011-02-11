# Require awk

class acl {

    define udefault( $id, $mode, $path) {
            exec { "apply_udefault":
                    command   => "/usr/bin/setfacl -m d:u:$id:$mode $path",
                    onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^default/ && \$2 ~ /user/ && \$3 ~/$id/  && \$4 ~ /$mode/  { exit 1 } '  "
            }
    }


    define gdefault( $id, $mode, $path) {
            exec { "apply_gdefault":
                    command   => "/usr/bin/setfacl -m d:g:$id:$mode $path",
                    onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^default/ && \$2 ~ /group/ && \$3 ~/$id/  && \$4 ~ /$mode/  { exit 1 } '  "
            }
    }


    define group( $id, $mode, $path) {
            exec { "apply_group":
                    command   => "/usr/bin/setfacl -m g:$id:$mode $path",
                    onlyif => "/usr/bin/getfacl $path  2>&1 | awk -F: ' \$1 ~ /^group/ && \$2 ~/$id/  && \$3 ~ /$mode/  { exit 1 } '  "
            }
    }
     

    define user( $id, $mode, $path) {
            exec { "apply_user":
                    command   => "/usr/bin/setfacl -m u:$id:$mode $path",
                    onlyif => "/usr/bin/getfacl $path 2>&1 | awk -F: ' \$1 ~ /^user/ && \$2 ~/$id/  && \$3 ~ /$mode/  { exit 1 } '  "
            }
    }

}
