function tf_to_gh_env --description 'Set GitHub environment secrets from backend and cicd tfvars files' --argument env_name
    if test -z $env_name
        echo "env_name must be set"
        return 1
    end

    if ! test -f secrets.backend.tfvars
        echo "secrets.backend.tfvars must be in current working directory"
        return 1
    end

    if ! test -f secrets.cicd.tfvars
        echo "secrets.cicd.tfvars must be in current working directory"
        return 1
    end

    echo "Setting GH credentials for $env_name"

    if test "$env_name" = production
        gh secret set RAILS_MASTER_KEY -e $env_name <../config/credentials/production.key
    else
        gh secret set RAILS_MASTER_KEY -e $env_name <../config/master.key
    end

    parse_tfsecrets access_key secrets.backend.tfvars | gh secret set TERRAFORM_STATE_ACCESS_KEY -e $env_name
    parse_tfsecrets secret_key secrets.backend.tfvars | gh secret set TERRAFORM_STATE_SECRET_ACCESS_KEY -e $env_name
    parse_tfsecrets bucket secrets.backend.tfvars | gh secret set TERRAFORM_STATE_BUCKET_NAME -e $env_name

    parse_tfsecrets cf_user secrets.cicd.tfvars | gh secret set CF_USERNAME -e $env_name
    parse_tfsecrets cf_password secrets.cicd.tfvars | gh secret set CF_PASSWORD -e $env_name
end
