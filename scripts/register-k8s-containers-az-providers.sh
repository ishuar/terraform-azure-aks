#! /usr/bin/env bash

###* This script helps you to register azure resource providers (in variable PROVIDERS below.)
###* The script accepts a boolean argument to enable az cli upgrade or not.
###* Script will only work if az cli is installed and logged in to the correct directory.

PROVIDERS=("Microsoft.Kubernetes" "Microsoft.ContainerService" "Microsoft.KubernetesConfiguration")
UPGRADE_AZ_CLI=$1
### Check if az cli is installed or not ?

if ! az version &>/dev/null; then
  printf "please Install az cli using https://learn.microsoft.com/en-us/cli/azure/install-azure-cli \n"
else
  if $UPGRADE_AZ_CLI; then
    az upgrade --yes
  else

    for provider in "${PROVIDERS[@]}"; do
      printf '\e[1;32m%-6s\e[0m\n' "Registerring $provider namespace to azure provider ...."
      az provider register --namespace "$provider"
      for i in {1..3}; do
        echo "waiting for $provider namespace to be registered with azure provider......."
        sleep 1
      done
    done

    for provider in "${PROVIDERS[@]}"; do
      REGISTRATION_STATUS="$(az provider show --namespace "$provider" --output json --query "registrationState")"
      for i in {1..20}; do
        if [[ "${REGISTRATION_STATUS}" =~ "Registered" ]]; then
          echo "$provider Registered Successfully"
          break
        else
          echo "Attempt $i/20 for $provider"
          sleep 1
        fi
      done
    done
  fi
fi
