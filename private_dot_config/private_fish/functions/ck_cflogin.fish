function ck_cflogin -d "Checks CF login status, logs in if not already"
    cf spaces &>/dev/null || cf login -a api.fr.cloud.gov --sso
end
