#!/bin/bash

location="eastus"
resource_group='aml-nfs-test'

# create Resource group

az group create -n $resource_group -l $location

