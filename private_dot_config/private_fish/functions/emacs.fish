set emacsPath '/opt/homebrew/opt/emacs-mac/Emacs.app/Contents/MacOS/Emacs.sh'

function emacs --wraps="$emacsPath" --description "shortcut to the buried emacs shell script"
  $emacsPath $argv
end
