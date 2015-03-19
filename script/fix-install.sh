#!/bin/sh
#
# Rsync'ing over a git clone is bobo... fix the permissions and add missing
# directories/links.

sudo mkdir -p !portal!/logs
touch /tmp/openid.socket
sudo chown !wwwuid!:!wwwgid! /tmp/openid.socket
sudo touch !portal!/logs/openid.log
sudo chown !wwwuid!:!wwwgid! !portal!/logs/openid.log
sudo ln -s !portal!/openid/lib/openid/root/ !portal!/openid/

exit

