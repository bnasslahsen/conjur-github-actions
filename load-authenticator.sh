#!/bin/bash

set -a
source ".env"
set +a

# Create Gitlab Branch
conjur policy update -b root -f <(envsubst < github-branch.yml)

#Load Github authenticator policy
conjur policy update -b root -f <(envsubst < authn-jwt-github.yml)

#We populate the jwks-uri variable with the JWT provider URL:
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/token-app-property -v "$GITHUB_TOKEN_APP"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/identity-path -v "$APP_GROUP"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/issuer -v "$GITHUB_ISSUER"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/jwks-uri -v "$GITHUB_JWKS_URI"
conjur variable set -i conjur/authn-jwt/$CONJUR_AUTHENTICATOR_ID/enforced-claims -v "$GITHUB_CLAIMS"
