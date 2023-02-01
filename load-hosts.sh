#!/bin/bash

set -a
source ".env"
set +a

envsubst < github-hosts.yml > github-hosts.yml.tmp
conjur policy update -f github-hosts.yml.tmp -b github-team | tee -a github-hosts.log
rm github-hosts.yml.tmp

## set dummy secrets values for testing purspose only
conjur variable set -i github-team/github-apps/secrets1 -v "secret-value1"
conjur variable set -i github-team/github-apps/secrets2 -v "secret-value2"
