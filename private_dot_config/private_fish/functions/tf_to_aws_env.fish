function tf_to_aws_env -d 'Set AWS credentials with a backend tfvars file' -a file
    if test -z $file
        set file secrets.backend.tfvars
    end

    echo "Setting AWS credentials for with $file…"

    set -gx AWS_ACCESS_KEY_ID (parse_tfsecrets access_key $file)
    set -gx AWS_SECRET_ACCESS_KEY (parse_tfsecrets secret_key $file)
    set -gx AWS_DEFAULT_REGION (parse_tfsecrets region $file)
    set -gx BUCKET_NAME (parse_tfsecrets bucket $file)
end
