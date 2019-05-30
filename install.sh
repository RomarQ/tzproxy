#!/bin/bash
sudo apt-get update
sudo apt-get -y install nginx
sudo update-rc.d nginx enable
sudo rm -f /etc/nginx/nginx.conf
wget -O /etc/nginx/nginx.conf https://raw.githubusercontent.com/RomarQ/tzproxy/master/nginx.conf
sudo nginx -s reload

while test $# -gt 0; do
    case "$1" in
        --ssl)
            echo "|> Let's Encrypt's"
            sudo apt-get install software-properties-common
            sudo add-apt-repository universe
            sudo add-apt-repository ppa:certbot/certbot
            sudo apt-get update
            sudo apt-get install certbot python-certbot-nginx
            sudo certbot --nginx
            sudo certbot renew --dry-run
            exit;
            ;;
        *)
            echo "$1 is not a recognized flag!"
            exit;
            ;;
    esac
done

