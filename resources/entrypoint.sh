#!/bin/bash
set -e

/usr/local/bin/ep /usr/local/etc/haproxy/haproxy.cfg /etc/ssl/private/cert.pem
exec "$@"