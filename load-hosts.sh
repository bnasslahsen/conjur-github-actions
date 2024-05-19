#!/bin/bash

set -a
source ".env"
set +a


conjur policy update -b root -f <(envsubst < github-hosts.yml)
conjur policy update -b vault01/LOBUser1 -f <(envsubst < github-hosts-grants.yml)
