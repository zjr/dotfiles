# Do not reformat this, because you'll probably delete a character.
function font_test -d "Run some echos to test font function"
    set -f tests "Normal
\033[1mBold\033[22m
\033[3mItalic\033[23m
\033[3;1mBold Italic\033[0m
\033[4mUnderline\033[24m
== === !== >= <= =>
Nerdfont
         󰾆      󰢻   󱑥   󰒲   󰗼
Fontawesome Free
                        
"
    printf "%b" "$tests"
end
