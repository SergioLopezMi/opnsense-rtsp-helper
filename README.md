# OPNsense RTSP Helper
This plugin allows RTSP streams to work behind an OPNsense router. Some ISPs use RTSP streams for the TV service. The plugin intercepts RTSP TCP connections, and then creates a redirection of these ports, allowing the video to pass.

### Installation
1. Enable SSH access on the web admin panel
2. Enter option 8 (Shell)
3. Create a file called ``rtsphelper.sh``
4. Paste on that file the content of the ``install.sh`` file that you will find on this repo
5. Enter ``chmod +x rtsphelper.sh && ./rtsphelper.sh`` to run the script
6. Reboot OPNsense
7. You will find a new menu on Services > RTSP Helper

### Managing the service
The service can be managed with standard FreeBSD rc commands:
```bash
# Start the service
/usr/local/etc/rc.d/rtsphelper start

# Stop the service
/usr/local/etc/rc.d/rtsphelper stop

# Restart the service
/usr/local/etc/rc.d/rtsphelper restart

# Check service status
/usr/local/etc/rc.d/rtsphelper status
```

The service can still be controlled with `/usr/local/etc/rc.d/rtsphelper`, but the installer also creates a watchdog cron entry that checks the service every 2 minutes and starts it again using the plugin's native PHP logic if it is down. This is needed because on some OPNsense systems the process may be terminated later during boot even though manual start works correctly.

### Disclaimer
This software is provided "as is", and without warranty of any kind. I am not responsible for any damage or malfunction that may occur in your OPNsense installation.

This plugin was originally created by [QuentinC](https://github.com/QuentinC). All thanks to his work. I fixed some bugs that it had but I am in no way maintaining this plugin.