# Demo project for Github

## Pre-requisites
- OS Linux / MacOS
- conjur-cli

## Conjur Initial Setup - AS Security Admin

- Initial conjur setup 
```shell
## During Conjur Initial Setup
conjur policy update -b root -f users.yml | tee -a users.log
```

## GITHUB Branch Setup  - AS Security Admin

- Create GITHUB Branch
```shell
conjur policy update -b root -f github-branch.yml | tee -a github-branch.log
```

- Delegation on the branch for the team (Only run this in case of an existing safe in the PAM)
```shell
conjur policy update -b vault-uat/LOB_UAT -f github-user-grants.yml | tee -a github-user-grants.yml 
```

## GITHUB Authenticator Setup  - AS Security Admin

- Declare Github authenticator:
```shell
./load-authenticator.sh
```

- Enable Github  JWT Authenticator in Conjur (This script runs only in the Conjur leader server)
```shell
./enable-authenticator.sh
```

## GITHUB Hosts Setup  - AS Projects Team

- Declare Your Apps 
```shell
./load-hosts.sh
```

- Grant Applications hosts access to the Safe - AS Projects Team (Only run this in case of an existing safe in the PAM)
```shell
./load-grants.sh
```

## GITHUB WORKFLOW SETUP - AS Projects Team

- Add conjur-demo.yml to actions
- Set the following GITHUB Action secrets:
  - `CONJUR_AUTHN_ID`- For this demo, the Conjur authenticator ID is: **github**
  - `CONJUR_PUBLIC_KEY` - Add Conjur public key
  - `CONJUR_URL` - Add Conjur FQDN (Including schema and port)
  - `CONJUR_ACCOUNT` - Add Conjur Account
  - `CONJUR_SECRETS` - Add Conjur Secrets list to retrieve github-team/github-apps/secrets1|SECRET1;github-team/github-apps/secrets12|SECRET2