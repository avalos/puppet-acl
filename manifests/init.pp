# Require awk

class acl {

    file { checkacl:
        path => "/usr/local/bin/checkacl",
        ensure => absent,
    }

    file { chuckacl:
        path => "/usr/local/bin/chuckacl",
        content => template("acl/chuckacl"),
        owner => root, group => root, mode => 750,
    }


    define group( $id, $mode, $path) {
            exec { "$id$mode$path" :
                    command   => "/usr/local/bin/chuckacl -g $id -p $mode $path",
                    unless => "/usr/local/bin/chuckacl -c -g $id -p $mode $path",
                    logoutput => true,
            }
    }
     

    define user( $id, $mode, $path) {
            exec { "$id$mode$path" :
                    command   => "/usr/local/bin/chuckacl -u $id -p $mode $path",
                    unless => "/usr/local/bin/chuckacl -c -u $id -p $mode $path",           
                    logoutput => true,
            }
    }

}
