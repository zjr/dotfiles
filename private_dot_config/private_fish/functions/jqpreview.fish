function jqpreview
    if set -q argv[1]
        echo wo
        set input "$argv[1]"
    else if not isatty stdin
        set input (mktemp)
        trap 'rm -f "$input"; rm -f "$res"' EXIT
        cat /dev/stdin >"$input"
    else
        echo "Couldn't figure out input"
        exit 1
    end

    set outFile (mktemp)

    cat $input | fzf --disabled \
        --read0 \
        --query '.' \
        --preview "echo {} | jq -r -C {q} 2>&1" \
        --bind "enter:execute(echo {q} > $outFile; echo {} | jq -r -C {q} >> $outFile)+abort"

    set out "$(cat $outFile)"
    rm $outFile
    rm $input
    echo "$out"
end
