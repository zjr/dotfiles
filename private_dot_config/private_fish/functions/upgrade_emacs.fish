function upgrade_emacs
    echo "Rebuilding Emacs…"
    brew reinstall emacs-plus

    # NOTE: don't need @[version] I think, base goes to current
    # …but I'm leaving this here in case I'm wrong
    #
    # set name (brew info --json emacs-plus | jq -r '.[].name')

    echo "Copying *.apps for Spotlight…"
    cp -R "$HOMEBREW_PREFIX/opt/emacs-plus/Emacs.app" /Applications/
    cp -R "$HOMEBREW_PREFIX/opt/emacs-plus/Emacs Client.app" /Applications/

    echo "Restarting Emacs service…"
    brew services restart emacs-plus
end
