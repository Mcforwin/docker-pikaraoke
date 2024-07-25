#!/bin/sh

set -e

umask 0002

if ! getent group "$PGROUP" &> /dev/null; then
	addgroup --gid $PGID --system $PGROUP
fi

if ! getent passwd "$PUSER" &> /dev/null; then
	adduser --uid $PUID --system --no-create-home $PUSER --ingroup $PGROUP
fi

if [ ! $(id -u $PUSER) == $PUID ]; then
	usermod -u $PUID $PUSER
fi

if [ ! $(id -g $PUSER) == $PGID ]; then
	groupmod -g $PGID $PGROUP
fi

chown -R $PUSER:$PGROUP $INSTALL_PATH $DOWNLOAD_PATH

exec su-exec $PUSER:$PGROUP "$@"
