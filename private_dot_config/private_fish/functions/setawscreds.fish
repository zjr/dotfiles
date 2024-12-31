function setawscreds -a service key -d "Set AWS credentials with a cloud.gov service-key"
    if test -z $service; or test -z $key
        echo "setawscreds [service] [key]"
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
    set -gx BUCKET_NAME (echo $S3_CREDENTIALS | jq -r '.credentials.bucket')
    set -gx AWS_DEFAULT_REGION (echo $S3_CREDENTIALS | jq -r '.credentials.region')

    echo "Done."
end
