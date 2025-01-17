function piv --description 'add the piv card for ssh'
  set osxsc_lib "/usr/lib/ssh-keychain.dylib"
  ssh-add -e $osxsc_lib; ssh-add -s $osxsc_lib
end

