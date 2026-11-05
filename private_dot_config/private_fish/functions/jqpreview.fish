function jqpreview
    if set -q argv[1]
        echo wo
        set input "$argv[1]"
    else if not isatty stdin
        set input (mktemp)
        trap 'rm -f "$input"' EXIT
        cat /dev/stdin >"$input"
    else
        echo "Couldn't figure out input"
        exit 1
    end

    printf '' | fzf --disabled \
        --query '.' \
        --print-query \
        --preview-window='up:90%' \
        --preview "jq -r -C {q} '$input' 2>&1"
end
