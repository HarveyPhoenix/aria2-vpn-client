#!/usr/bin/env bash

if [ ! -z "${RPC_TOKEN}" ]; then
    echo "${RPC_TOKEN}"
    aria2c --daemon=true --enable-rpc=true --rpc-listen-all=true --rpc-allow-origin-all=true --rpc-listen-port=26800 --rpc-secret=${RPC_TOKEN}
else
    aria2c --daemon=true --enable-rpc=true --rpc-listen-all=true --rpc-allow-origin-all=true --rpc-listen-port=26800
fi
## download vpn config
echo "$VPNCONFIG"
wget --output-document=/home/apprunner/running/client.ovpn --no-dns-cache --no-cache "${VPNCONFIG}"
mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
    mknod /dev/net/tun c 10 200
fi
openvpn client.ovpn
