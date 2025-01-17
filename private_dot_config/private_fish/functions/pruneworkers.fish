function pruneworkers --wraps=cf\ apps\ \|\ awk\ \"\\\$1\ \~\ /^glrw/\ \{print\ \\\$1\}\"\ \|\ xargs\ -n1\ cf\ d\ -fr --description alias\ pruneworkers=cf\ apps\ \|\ awk\ \"\\\$1\ \~\ /^glrw/\ \{print\ \\\$1\}\"\ \|\ xargs\ -n1\ cf\ d\ -fr
  cf apps | awk "\$1 ~ /^glrw/ {print \$1}" | xargs -n1 cf d -fr $argv
        
end
