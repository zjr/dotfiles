function cf_rds_creds -a app_name
    argparse e/env-output -- $argv
    or return

    set guid (cf app --guid $app_name)
    set app_env (cf curl /v2/apps/$guid/env)

    set creds (echo $app_env | jq -r '[
      .system_env_json.VCAP_SERVICES
      ."aws-rds"[0].credentials
      | .username, .password
    ] | join(":")')

    set dbname (echo $app_env | jq -r '
      .system_env_json.VCAP_SERVICES
      ."aws-rds"[0]
      .credentials | .name')

    echo "
    creds $creds
    dbname $dbname
    uri psql://$creds@localhost:5432/$dbname
    " | column -t

    if set -ql _flag_e
        echo $app_env | jq
    end
end
