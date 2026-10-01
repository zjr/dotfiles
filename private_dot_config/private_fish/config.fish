set -gx LANG en_US.UTF-8
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR (which nvim)
set -gx MANPAGER 'sh -c "col -bx | bat -plman"'

# Configure ripgrep (`rg`)
set -gx RIPGREP_CONFIG_PATH $HOME/.config/rg/ripgreprc

# Configure ZK notebook
set -gx ZK_NOTEBOOK_DIR $HOME/Developer/Notes

fish_add_path "$HOME/.local/bin"
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin

# Source Homebrew early so it can be overrode by version managers
/opt/homebrew/bin/brew shellenv | source

# Annoyingly complicated asdf sourcing
set -l asdf_dir $ASDF_DATA_DIR
[ -z "$asdf_dir" ] && set asdf_dir "$HOME/.asdf"
fish_add_path -m "$asdf_dir/shims"

# Go & Rust 
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"

# Node / pnpm
set -gx PNPM_HOME "$XDG_CONFIG_HOME/Library/pnpm"
fish_add_path $PNPM_HOME

# Doom Emacs path
if [ -d "$XDG_CONFIG_HOME/emacs/bin" ]
    fish_add_path "$XDG_CONFIG_HOME/emacs/bin"
else if [ -d ~/.emacs.d ]
    fish_add_path ~/.emacs.d/bin
end

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
if [ -f "$XDG_CONFIG_HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.fish" ]
    source "$XDG_CONFIG_HOME/.config/yarn/global/node_modules/tabtab/.completions/yarn.fish"
end

# 1Password plugins
if [ -f "$XDG_CONFIG_HOME/.config/op/plugins.sh" ]
    source "$XDG_CONFIG_HOME/.config/op/plugins.sh"
end

# Google Cloud SDK
if [ -f "$XDG_CONFIG_HOME/Downloads/google-cloud-sdk/path.fish.inc" ]
    source "$XDG_CONFIG_HOME/Downloads/google-cloud-sdk/path.fish.inc"
end

if not status is-interactive
    return
end

fzf --fish | source
zoxide init fish --cmd cd | source

# Ruby
if command -v rbenv 1>/dev/null
    rbenv init - --no-rehash fish | source
end

# Shadowenv, a lisp-ish automatic env switcher
if command -v shadowenv 1>/dev/null
    shadowenv init fish | source
end

# Packer & BT for buildpack things
if command -v pack 1>/dev/null
    source (pack completion --shell fish)
end
if command -v bt 1>/dev/null
    eval (bt init fish) # https://github.com/dmikusa/binding-tool
end

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

# Disable the annoying Docker "tips"
set -gx DOCKER_CLI_HINTS false

# Starship.rs prompt
function starship_transient_prompt_func
    starship module character
end
starship init fish --print-full-init | source

# @fish-lsp-disable-next-line 7001
enable_transience

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
