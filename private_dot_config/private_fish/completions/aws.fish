# Older from SO
# function __fish_complete_aws
#     env COMP_LINE=(commandline -pc) aws_completer | tr -d ' '
# end
#
# complete -c aws -f -a "(__fish_complete_aws)"

# Another attempt from GH Issue
# function __aws_complete
#     set -lx COMP_SHELL fish
#     set -lx COMP_LINE (commandline -opc)
#
#     if string match -q -- "-*" (commandline -opt)
#         set COMP_LINE $COMP_LINE -
#     end
#
#     aws_completer | command sed 's/ $//'
# end
#
# complete --command aws --no-files --arguments '(__aws_complete)'

# A final attempt from GH Issue
# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
