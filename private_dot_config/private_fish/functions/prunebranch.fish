# Defined in - @ line 1
function prunebranch
    git branch --merged | rg -v "(^\W+(dev|stage|main|master|release))|^\*" | xargs -n 1 git branch -d $argv
end
