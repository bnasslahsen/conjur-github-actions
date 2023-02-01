#!/bin/bash
# This script will enable the GitHub JWT Authn in Conjur.
# This script is meant to use at the Conjur Leader VM machine.

CONJUR_AUTHENTICATOR_ID=authn-jwt/github
# Using docker/podman
CONTAINER_MGR=docker
# Conjur Leader port
CONJUR_LEADER_PORT=443
# Conjur Leader container ID
CONTAINER_ID=$(curl -s -k "https://127.0.0.1:$CONJUR_LEADER_PORT/info" | awk '/container/ {print $2}' | tr -d '",')
# Name of the authn to enable, leave as is

#============ Script ===============
echo "Enabling $CONJUR_AUTHENTICATOR_ID authn for Conjur"
CONJUR_AUTHENTICATORS=$($SUDO $CONTAINER_MGR exec $CONTAINER_ID evoke variable list | grep CONJUR_AUTHENTICATORS)
CONJUR_AUTHENTICATORS=$(echo $CONJUR_AUTHENTICATORS | awk -F "=" '{print $2}')
CONJUR_AUTHENTICATORS=$(sed -e 's/^"//' -e 's/"$//' <<< "$CONJUR_AUTHENTICATORS")
IFS=','
read -a array <<< "$CONJUR_AUTHENTICATORS"
if [[ "${IFS}${array[*]}${IFS}" =~ "${IFS}$CONJUR_AUTHENTICATOR_ID${IFS}" ]]; then
    echo "Already Enabled"
    unset IFS
else
    unset IFS
    [ -z "$CONJUR_AUTHENTICATORS" ] && CONJUR_AUTHENTICATORS=authn
    $SUDO $CONTAINER_MGR exec -it $CONTAINER_ID evoke variable set CONJUR_AUTHENTICATORS $CONJUR_AUTHENTICATORS,$CONJUR_AUTHENTICATOR_ID
fi