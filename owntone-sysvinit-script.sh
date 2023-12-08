#!/bin/sh
### BEGIN INIT INFO
# Provides: owntone
# Required-Start: $local_fs $network $named $time $syslog
# Required-Stop: $local_fs $network $named $time $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Description: DAAP/DACP (iTunes), RSP, MPD server, with AirPlay and Remote
### END INIT INFO


NAME="owntone"
SCRIPT="/usr/sbin/$NAME"

CONFIGFILE="/etc/$NAME.conf"
PIDFILE="/var/run/$NAME.pid"

start() {
    if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
        echo 'OwnTone is already running!' >&2
        return 1
    fi
    echo 'Starting OwnTone...' >&2
    $SCRIPT -c $CONFIGFILE -P $PIDFILE
}

stop() {
    if [ ! -f $PIDFILE ] || ! kill -0 $(cat $PIDFILE); then
        echo 'OwnTone is not currently running.' >&2
        return 1
    fi
    echo 'OwnTone is coming in for a landing...' >&2
    kill -15 $(cat $PIDFILE) && rm -f $PIDFILE
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $0 (start|stop|restart)"
        ;;
esac

exit 0
