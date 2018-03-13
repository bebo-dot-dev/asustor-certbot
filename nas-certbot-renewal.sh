#!/bin/sh

# An asustor NAS Let's Encrypt certificate renewal shell script.
#
# Dependencies: 
#   * Python 2.6, 2.7, or 3.3+, installable from AppCentral
#   * pip 
#   * certbot, installable via pip i.e. pip install cryptography && pip install certbot
#   * At least one Let's Encrypt certificate present in the --config-dir path created
#     by a prior call to certbot i.e.
#     /usr/local/AppCentral/python/bin/certbot certonly --standalone -d mydomain.com --config-dir /volume0/usr/builtin/etc/letsencrypt
#
# This shell script simply calls certbot for Let's Encrypt certificate renewal. This script can be crontab scheduled for automated renewal.
# Certificate renewal progress / success / failure is logged to /var/log/letsencrypt/letsencrypt.log by default
#
# certbot docs are here: https://certbot.eff.org/docs/using.html

# CERTBOT_RENEW -> the certbot renewal command. 
# Note that calling certbot with the "renew" option causes certbot to use the renewal .conf configuration files present
# in the /etc/letsencrypt/renewal directory that are/were created at original cert creation time
CERTBOT_RENEW="/usr/local/AppCentral/python/bin/certbot renew --config-dir /volume0/usr/builtin/etc/letsencrypt --http-01-port 51080 --preferred-challenges=http --max-log-backups 30"
RENEWAL_SUCCESS="Congratulations, all renewals succeeded"

RENEW_RESULT=`$CERTBOT_RENEW`
RENEW_RESULT=`echo $RENEW_RESULT | grep -c "$RENEWAL_SUCCESS"`
if [[ $RENEW_RESULT == 1 ]]; then
    echo "certbot renewal success"
else
    echo "certbot renewal failure"
fi
