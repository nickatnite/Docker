#!/bin/bash

set -e

## SETUP THE MONGO CONNECTION IN HOSTS BECAUSE WE DONT HAVE DNS RESOLVING YET : NKA

# echo "10.7.6.193 qa4.mongo.xxxxxxxxxx.net" >> /etc/hosts
# echo "10.7.6.28 prod.mongo.xxxxxxxxxx.com" >> /etc/hosts

cd /var/www/web/xxxxxxxxxx_webapp/
yarn gulp-production
cd /

if [ "$CREATE_USER_UID" -a "$CREATE_USER_GID" ]; then
    echo "Create 'site-owner' group with GID=$CREATE_USER_GID"
    groupadd -g $CREATE_USER_GID site-owner
    echo "Add 'www-data' user to group 'site-owner'"
    usermod -a -G site-owner www-data
    echo "Create 'site-owner' user with UID=$CREATE_USER_UID, GID=$CREATE_USER_GID"
    useradd -d /var/www -g $CREATE_USER_GID -s /bin/false -M -N -u $CREATE_USER_UID site-owner
fi

if [ -n "$CREATE_SYMLINKS" ]; then
    for link in ${CREATE_SYMLINKS//,/ }; do
        TARGET=${link%>*}
        TARGET_DIR=${TARGET%/*}
        FROM=${link#*>}
        echo "Creating symlink from '${FROM}' to '${TARGET}'"
        if [ ! -d $TARGET_DIR ]; then
            echo -e "\tcreating directory '${TARGET_DIR}'"
            mkdir -p $TARGET_DIR
        fi
        ln -sf $FROM $TARGET
    done
fi


export APACHE_SERVER_NAME="${APACHE_SERVER_NAME:-$(hostname)}"
export APACHE_DOCUMENT_ROOT="${APACHE_DOCUMENT_ROOT:-/var/www/html}"


if [ "$1" == 'apache2' ]; then
    if [ -n "$APACHE_COREDUMP" ]; then
        a2enconf coredump
    fi

    for mod in $( echo $APACHE_MODS | tr ',' ' '); do
        a2enmod -q $mod
    done
    if [ "$2" == '--log-to-file' ]; then
        echo "Logging to /var/log/apache2/error.log and /var/log/apache2/access.log"
    else
        ln -sf /dev/stdout /var/log/apache2/error.log
        ln -sf /dev/stdout /var/log/apache2/access.log
    fi
    echo "Starting Apache 2.x in foreground."
    exec /usr/sbin/apache2 -D FOREGROUND
elif [ "$1" == 'cron' ]; then
    echo "Starting web cron..."
    # Start cron in foreground
    exec cron -f
fi

exec "$@"
