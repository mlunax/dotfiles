#!/bin/bash
# git-connect.sh — portable for macOS + Linux
# Tries direct connection first, falls back to SOCKS proxy via netcat

HOST="$1"
PORT="$2"
VPN_CHECK_HOST="toshokan.tsuki.vpn"
VPN_CHECK_PORT=22
TIMEOUT=2

if nc -z -w "$TIMEOUT" "$VPN_CHECK_HOST" "$VPN_CHECK_PORT" >/dev/null 2>&1; then
    exec nc "$HOST" "$PORT"
else
    exec nc -v -x 127.0.0.1:4711 "$HOST" "$PORT"
fi
