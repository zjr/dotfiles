set usage "Incorrect Usage: the required arguments `SERVICE_INSTANCE` and `SERVICE_KEY` were not provided

NAME:
   setawscreds - Set credentials for AWS service from cloud.gov service key

USAGE:
   setawscreds SERVICE_INSTANCE SERVICE_KEY [-c, --create]

EXAMPLES:
   setawscreds mydb mykey -c

OPTIONS:
   --create, -c      Creates the service key, remember to delete this manually later
"

function cg_to_aws_env -d "Set AWS credentials with a cloud.gov service-key" -a service key
    ck_cflogin

    if test -z $service; or test -z $key
        echo $usage
        if test -z $service
            cf services
        else
            cf service-keys $service
        end
        return
    end

    echo "Setting AWS credentials for $service with $key…"

    argparse c/create -- $argv
    or return

    if set -ql _flag_c
        cf create-service-key $service $key
    end

    set -l S3_CREDENTIALS (cf service-key $service $key | tail -n +2)

    set -gx AWS_ACCESS_KEY_ID (echo $S3_CREDENTIALS | jq -r '.credentials.access_key_id')
    set -gx AWS_SECRET_ACCESS_KEY (echo $S3_CREDENTIALS | jq -r '.credentials.secret_access_key')
    set -gx AWS_DEFAULT_REGION (echo $S3_CREDENTIALS | jq -r '.credentials.region')
    set -gx BUCKET_NAME (echo $S3_CREDENTIALS | jq -r '.credentials.bucket')
end
