#!/bin/bash
#
# create rockmongo nginx virtual host config file
#
cd /www/projects
chown -R ubuntu:ubuntu rockmongo
if [ ! -e /etc/nginx/sites-available/rockmongo ]; then
echo '
server {
        listen 80;
        server_name dev-new.rockmongo.workivate.com;

        root /www/projects/rockmongo;
        index /index.php;
        try_files $uri $uri/ /index.php?$query_string;
        error_log /var/log/nginx/rockmongo-error.log;
        access_log /var/log/nginx/rockmongo-access.log;

        location ~ \.php$ {
            include        fastcgi_params;
            auth_basic "Restricted";
            auth_basic_user_file htpasswd;
        }
}
'| sudo tee /etc/nginx/sites-available/rockmongo
fi
sudo ln -sf /etc/nginx/sites-available/rockmongo /etc/nginx/sites-enabled/rockmongo
