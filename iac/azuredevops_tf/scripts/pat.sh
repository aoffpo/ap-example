#!/usr/bin/env bash

# USAGE:
# . ./pat.sh

account_name=*****
tenant_id=*****
access_token=$(az account get-access-token --tenant $tenant_id | jq '.accessToken') 

authority="https://login.microsoftonline.com/$tenant_id" 
redirect_path="/getAToken"
endpoint="https://vssps.dev.azure.com/$account_name/_apis/Tokens/Pats?api-version=6.1-preview"
scope=["499b84ac-1321-427f-aa17-267ca6975798/.default"]
session_type="filesystem" 
