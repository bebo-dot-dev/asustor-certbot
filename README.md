# asustor-certbot
Automated let's encrypt certificate renewal via certbot on an Asustor NAS box

Why does this even exist when there's a certificate management built into ADM? There are a few reasons.

#### Here are the cons of doing certificate management the Asustor way: ####

1. The ceritificate manager built into ADM provided by Asustor is lacking. It's functionality is dependent on this Asustor supplied binary: `/usr/builtin/bin/certificate`. For automated certificate renewal, this is setup in a crontab job that looks like this: `0 0 * * * TAG=CERTIFICATE /usr/builtin/bin/certificate update-cert` so that this is run continually every minute.
- What does this do? It's supposed to renew certificates.
- What happens when it fails? Who knows, not even Asustor support were able to describe what happens when certificate renewal fails other than to say _"logging of SSL certificate renewal errors is not enabled"_. This appears to be an undocumented asustor binary that has unknown behaviour other than it being known that nothing is logged anywhere when certificate renewal fails.

2. Successful certificate renewal via `/usr/builtin/bin/certificate` is dependent on a web service listening on the NAS on port 80. Yes port 80 needs to be permanently open to the NAS and a web server needs to be running on the NAS listening on port 80 at all times (typically apache on an Asustor NAS).

3. There's lack of flexiblity when relying on `/usr/builtin/bin/certificate` to perform certificate renewal. Since this binary is undocumented, there's no known way to perform any additional required actions when certificates fail to renew or do actually renew successfully.

#### Here are the pros of doing certificate management the [certbot](https://certbot.eff.org/docs/) way: ####

1. certbot is [well documented](https://certbot.eff.org/docs/)
2. certbot logs everything it does including renewal failure and success
3. certbot is chainable / extendable. It is possible to perform additional required actions when certificates fail to renew or renew successfully via regular shell scripts
4. certbot running in 'standalone' mode spins up a temporary webserver on demand and it can be configured to listen on a custom user defined port. The Lets Encrypt acme server will always make callbacks on port 80 however this can be mapped to the custom internal custom user defined port that the certbot standalone temporary webserver listens on.
5. certbot support ssl
6. certbot is open: https://github.com/certbot/certbot

#### Installing certbot on the NAS ####
1. certbot is written in python, install python from App Central and verify the install `python --version`
2. once you have python installed check you have pip installed i.e. `pip --version`
3. install certbot with pip i.e. `pip install cryptography` && `pip install certbot`

On my AS-202TE certbot is here after installation: `/usr/local/AppCentral/python/bin/certbot`
