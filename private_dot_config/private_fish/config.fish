set -x LANG en_US.UTF-8

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[ -f /Users/zjr/.config/yarn/global/node_modules/tabtab/.completions/yarn.fish ]; and . /Users/zjr/.config/yarn/global/node_modules/tabtab/.completions/yarn.fish

# function fish_user_key_bindings
#   bind --preset \x20 forward-char
#   # bind -M default \$ end-of-line accept-autosuggestion
# end

# Filesystem jumper via `j`
status --is-interactive; and source (jump shell fish | psub)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/zjr/Downloads/google-cloud-sdk/path.fish.inc' ]
    source '/Users/zjr/Downloads/google-cloud-sdk/path.fish.inc'
end

set -eg fish_user_paths

set -g fish_user_paths /usr/local/bin $fish_user_paths
set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths /opt/homebrew/bin $fish_user_paths
set -g fish_user_paths /opt/homebrew/sbin $fish_user_paths
set -g fish_user_paths /opt/homebrew/opt/grep/libexec/gnubin $fish_user_paths
set -g fish_user_paths "(brew --prefix)/opt/llvm/bin" $fish_user_paths
set -g fish_user_paths "$HOME/go/bin:$PATH" $fish_user_paths
set -g fish_user_paths "$HOME/.cargo/bin:$PATH" $fish_user_paths
set -g fish_user_paths "$HOME/.emacs.d/bin" $fish_user_paths
set -g fish_user_paths "$HOME/Library/Python/3.9/bin" $fish_user_paths

# pnpm
set -gx PNPM_HOME /Users/zjr/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end

# Load all saved ssh keys
/usr/bin/ssh-add --apple-load-keychain ^/dev/null

abbr -a -- l ls
abbr -a -- la ls -al
abbr -a -- g git
abbr -a -- gs git status

# Fish syntax highlighting
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape bryellow --bold
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match bryellow '--background=brblack'
set -g fish_color_selection white --bold '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# This is a user function, expands `..`'s
# See https://github.com/fish-shell/fish-shell/issues/1891#issuecomment-71141210
bind -M insert . expand-dot-to-parent-directory-path

# Starship.rs prompt
function starship_transient_prompt_func
    starship module character
end
starship init fish | source
enable_transience

# Return to 'default' VI mode after executing command 
# See https://github.com/fish-shell/fish-shell/issues/6046
# Note: `transient_execute` stops the shell from reprinting the prompt
#        use `execute` if you don't want that
# for mode in default insert visual
#   bind -M $mode \r -m default transient_execute
# end

# Set VI mode key bindings
set -g fish_key_bindings fish_vi_key_bindings

# FZF integration
fzf --fish | source

###
# Emacs VTerm Stuff
###

function vterm_printf
    if begin
            [ -n "$TMUX" ]; and string match -q -r "screen|tmux" "$TERM"
        end
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

function vterm_prompt_end
    vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
end

functions --copy fish_prompt vterm_old_fish_prompt
function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
    # Remove the trailing newline from the original prompt. This is done
    # using the string builtin from fish, but to make sure any escape codes
    # are correctly interpreted, use %b for printf.
    printf "%b" (string join "\n" (vterm_old_fish_prompt))
    vterm_prompt_end
end

if [ "$INSIDE_EMACS" = vterm ]
    function clear
        vterm_printf "51;Evterm-clear-scrollback"
        tput clear
    end
end

