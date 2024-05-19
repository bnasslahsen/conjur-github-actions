# Demo project for Github Actions integration with CyberArk Conjur

## Pre-requisites
- OS Linux / MacOS
- conjur-cli
- Clone this repository: https://github.com/bnasslahsen/conjur-github-actions
- Adapt the **.env** file and replace the values with your GIITHUB Self Hosted setup

## GITHUB Branch Setup  - AS Security Admin

- Create GITHUB Branch
```shell
conjur policy update -b root -f github-branch.yml | tee -a github-branch.log
```

## GITHUB Authenticator Setup  - AS Security Admin

- Declare Github authenticator:
```shell
./load-authenticator.sh
```

## GITHUB Hosts Setup  - AS Projects Team

- Declare Your Apps 
```shell
./load-hosts.sh
```

## GITHUB WORKFLOW SETUP - AS Projects Team
- Add conjur-demo.yml to actions
- Set the following GITHUB Action secrets:
  - `CONJUR_AUTHN_ID`- For this demo, the Conjur authenticator ID is: **github**
  - `CONJUR_PUBLIC_KEY` - Add Conjur public key
  - `CONJUR_URL` - Add Conjur FQDN (Including schema and port)
  - `CONJUR_ACCOUNT` - Add Conjur Account
  - `CONJUR_SECRETS` - Add Conjur Secrets list to retrieve github-team/github-apps/secrets1|SECRET1;github-team/github-apps/secrets12|SECRET2
- Add `.github/workflows/conjur-demo.yml` to your repository actions
- In your repository web page, click on Actions and test the workflow