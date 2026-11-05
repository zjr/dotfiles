set usage "cfenvjson — get services or app json from cf env

USAGE:
   cfenvjson [-s/--services | -a/--app] [APP_NAME]

EXAMPLES:
   cfenvjson -s myapp

OPTIONS:
   --services, -s  Gets VCAP_SERVICES (default)
   --app, -a       Gets VCAP_APPLICATION
"

function cfenvjson

    argparse s/services a/app -- $argv
    or return

    if set -q _flag_s
        set q VCAP_SERVICES
    else if set -q _flag_a
        set q VCAP_APPLICATION
    else
        echo help
    end

    cf env "$argv[1]" |
        sed -n -e '/${q}/,/^}$/{s/VCAP.*/{/;p;}'
end
