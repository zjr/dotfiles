# Set VI mode key bindings
set -g fish_key_bindings fish_vi_key_bindings

# accept autocomplete _word_
bind -M insert ctrl-d forward-bigword # kept using ctrl-d instinctively
bind -M insert ctrl-space forward-bigword

# accept full completion
bind -M insert ctrl-f accept-autosuggestion # just accept
bind -M insert ctrl-enter accept-autosuggestion execute # accept & run

# This is a user function, expands `..`'s
# See https://github.com/fish-shell/fish-shell/issues/1891#issuecomment-71141210
bind -M insert . expand-dot-to-parent-directory-path

# Return to 'default' VI mode after executing command 
# See https://github.com/fish-shell/fish-shell/issues/6046
#
# Note: transient_execute stops the shell from reprinting the prompt;
#       use `execute` if you don't want that
#
# for mode in default insert visual
#   bind -M $mode \r -m default transient_execute
# end
