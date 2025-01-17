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

function cg_to_aws_env -a service key -d "Set AWS credentials with a cloud.gov service-key"
    argparse c/create -- $argv
    or return

    ck_cg_auth

    if set -ql _flag_c
        cf create-service-key $service $key
    end

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

    set -l S3_CREDENTIALS (cf service-key $service $key | tail -n +2)

    set -gx AWS_ACCESS_KEY_ID (echo $S3_CREDENTIALS | jq -r '.credentials.access_key_id')
    set -gx AWS_SECRET_ACCESS_KEY (echo $S3_CREDENTIALS | jq -r '.credentials.secret_access_key')
    set -gx AWS_DEFAULT_REGION (echo $S3_CREDENTIALS | jq -r '.credentials.region')
    set -gx BUCKET_NAME (echo $S3_CREDENTIALS | jq -r '.credentials.bucket')

    echo "Done."
end
