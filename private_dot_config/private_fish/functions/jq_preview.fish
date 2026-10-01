function jq_preview
    printf '' | fzf --print-query \
        --preview "jq -r -C {q} '$argv[1]' 2>&1" \
        --preview-window=up:80%
end
