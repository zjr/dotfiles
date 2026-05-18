function srce --description 'input bash-style .env, output fish `set` commands for eval'
    while read -l line
        # skip empty lines
        [ -z "$line" ] && continue

        # skip comments
        [ $(string match -r '^#' $line) ] && continue

        # output as text to allowing sourcing
        echo "set -gx $(string replace '=' ' ' $line)"
    end
end
