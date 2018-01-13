#!/bin/sh

# An asustor NAS Let's Encrypt certificate renewal deploy shell script.
#
# Dependencies: 
#   A certbot --config-dir/renewal-hooks/deploy directory to host this script
#
# When this shell script is present in the certbot --config-dir/renewal-hooks/deploy, it will be called 
# by certbot upon successful renewal only
# This script can be used to automate actions that need to be performed upon post renewal success 
# i.e. certificate copy / service restart etc
#
# certbot docs are here: https://certbot.eff.org/docs/using.html

CONFIG_DIR=/volume0/usr/builtin/etc/letsencrypt     # the certbot --config-dir
SOURCE_CERT=/live/your-cert-domain.net              # a source letsencrypt certificate to perform actions with
ADM_TARGET=/volume0/usr/etc/lighttpd                # the ADM lighttpd web server ssl cert target directory
ADM_WEB_SERVICE=/etc/init.d/S41lighttpd             # the ADM lighttpd service control script

#create a lighttpd "compatible" cert by combining the private key and the cert together and 
#then update the lighttpd ssl cert with that
cat $CONFIG_DIR$SOURCE_CERT/privkey.pem $CONFIG_DIR$SOURCE_CERT/cert.pem > $CONFIG_DIR$SOURCE_CERT/lighttpd.pem
cp -L -f $CONFIG_DIR$SOURCE_CERT/lighttpd.pem $ADM_TARGET/lighttpd.pem

#restart lighttpd
$ADM_WEB_SERVICE restart