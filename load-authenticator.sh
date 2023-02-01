#!/bin/bash

set -a
source ".env"
set +a

#Load Github root policy
envsubst < authn-jwt-github.yml > authn-jwt-github.yml.tmp
conjur policy update -f authn-jwt-github.yml.tmp -b root
rm authn-jwt-github.yml.tmp

#We populate the jwks-uri variable with the JWT provider URL:
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/token-app-property -v "$GITHUB_TOKEN_APP"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/identity-path -v "$GITHUB_IDENTITY"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/issuer -v "$GITHUB_ISSUER"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/jwks-uri -v "$GITHUB_JWKS_URI"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/enforced-claims -v "$GITHUB_CLAIMS"
