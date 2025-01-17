function ck_cg_auth -d "Checks cloud.gov login status, logs in if not already"
    cf spaces &>/dev/null || cf login -a api.fr.cloud.gov --sso
end
