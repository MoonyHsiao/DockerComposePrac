#!/bin/bash

# Apply environment
# Set SSH password
echo root:${SSH_PASSWORD:-password} | chpasswd
echo "hello hello"

# Run ssh server
/usr/sbin/sshd
/usr/sbin/nginx -g "daemon off;"