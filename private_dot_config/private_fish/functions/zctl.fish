function zctl
    switch (argv)
        case up
            sudo launchctl load /Library/LaunchDaemons/com.zscaler.service.plist /Library/LaunchDaemons/com.zscaler.tunnel.plist
        case down
            sudo launchctl unload /Library/LaunchDaemons/com.zscaler.service.plist /Library/LaunchDaemons/com.zscaler.tunnel.plist
    end
end
