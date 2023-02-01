#!/bin/bash

set -a
source ".env"
set +a

envsubst < github-hosts-grants.yml > github-hosts-grants.yml.tmp
conjur policy update -f github-hosts-grants.yml.tmp -b vault-uat/LOB_UAT/bnl-github-safe
rm github-hosts-grants.yml.tmp