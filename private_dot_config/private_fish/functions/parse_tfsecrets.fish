function parse_tfsecrets --description 'Parse secrets.auto.tfvars or credentials file for value'
    set -f file secrets.auto.tfvars
    if test "$argv[2]" != ""
        set file $argv[2]
    end
    sed -nE "s/$argv[1] *= *\"?([^\"]+)\"?/\1/pi" $file
end
