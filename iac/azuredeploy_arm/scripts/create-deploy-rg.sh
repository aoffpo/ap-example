#!/usr/bin/env bash

az group create --name myResourceGroup --location "eastus" && \
az deployment group create --resource-group myResourceGroup --template-file ../azuredeploy.json && \
az lock create --name LockGroup --lock-type CanNotDelete --resource-group myResourceGroup


