#!/bin/sh

SOURCE="https://raw.githubusercontent.com/JGeek00/opnsense-rtsp-helper/master/src"

curl -o /usr/local/etc/inc/plugins.inc.d/rtsphelper.inc $SOURCE/etc/inc/plugins.inc.d/rtsphelper.inc

mkdir -p /usr/local/opnsense/mvc/app/models/OPNsense/RTSPHelper/ACL/
curl -o /usr/local/opnsense/mvc/app/models/OPNsense/RTSPHelper/ACL/ACL.xml $SOURCE/opnsense/mvc/app/models/Net/RTSPHelper/ACL/ACL.xml

mkdir -p /usr/local/opnsense/mvc/app/models/OPNsense/RTSPHelper/Menu/
curl -o /usr/local/opnsense/mvc/app/models/OPNsense/RTSPHelper/Menu/Menu.xml $SOURCE/opnsense/mvc/app/models/Net/RTSPHelper/Menu/Menu.xml

mkdir -p /usr/local/opnsense/scripts/net/rtsphelper/
curl -o /usr/local/opnsense/scripts/net/rtsphelper/rtsphelper.py $SOURCE/opnsense/scripts/net/rtsphelper/rtsphelper.py

# Install rc.d startup script
mkdir -p /usr/local/etc/rc.d/
curl -o /usr/local/etc/rc.d/rtsphelper $SOURCE/usr/local/etc/rc.d/rtsphelper
chmod +x /usr/local/etc/rc.d/rtsphelper

# Enable service in rc.conf
sysrc -f /etc/rc.conf.d/rtsphelper rtsphelper_enable=YES

# Install watchdog cron entry if it does not already exist
CRON_LINE='*/2 * * * * /usr/local/bin/php -r '\''require_once("/usr/local/etc/inc/config.inc"); require_once("/usr/local/etc/inc/util.inc"); require_once("/usr/local/etc/inc/interfaces.inc"); require_once("/usr/local/etc/inc/plugins.inc.d/rtsphelper.inc"); rtsphelper_configure_do();'\'''
TMP_CRON=$(mktemp)
crontab -l 2>/dev/null | grep -F -v "$CRON_LINE" > "$TMP_CRON" || true
printf '%s\n' "$CRON_LINE" >> "$TMP_CRON"
crontab "$TMP_CRON"
rm -f "$TMP_CRON"

curl -o /usr/local/www/services_rtsphelper.php $SOURCE/www/services_rtsphelper.php
curl -o /usr/local/www/status_rtsphelper.php $SOURCE/www/status_rtsphelper.php
