#!/bin/bash

location="eastus"
resource_group='aml-nfs-test'

workspace_name='aml-nfs-test'

# create Resource group

az group create -n $resource_group -l $location

az configure --defaults group=$resource_group workspace=$workspace_name location=$location

#az configure --defaults group=aml-nfs-test workspace=aml-nfs-test location=eastus


# create vnet

vnet_name='vnet'
vnet_address_range='10.0.0.0/16'
vnet_aml_subnet='10.0.1.0/24'
vnet_nfs_subnet='10.0.2.0/24'

az network vnet create -n $vnet_name --address-prefix $vnet_address_range
az network vnet subnet create --vnet-name $vnet_name -n aml --address-prefixes $vnet_aml_subnet
az network vnet subnet create --vnet-name $vnet_name -n amlnfs --address-prefixes $vnet_nfs_subnet --service-endpoints Microsoft.Storage


#az storage account create -n amlnfs --sku Premium_LRS --kind FileStorage --access-tier Premium --vnet_name $vnet_name --subnet $vnet_nfs_subnet --public-network-access Disabled

az storage account create -n amlnfs --sku Premium_LRS --kind FileStorage --access-tier Premium --vnet $vnet_name --subnet amlnfs --public-network-access Enabled  --default-action Deny --https-only false

az storage share-rm create --storage-account amlnfs --name amlnfsshare --quota 100 --enabled-protocol NFS

# create Azure ML workspace
az ml workspace create --name $workspace_name

# create Azure ML environment
az ml environment create --file environment.yml

# create Azure ML compute cluster

az ml compute create -n cpu-cluster --type amlcompute --min-instances 0 --max-instances 1 --size Standard_F16s_v2 --vnet-name $vnet_name --subnet aml --idle-time-before-scale-down 1800

###

storage_id=$(az storage account show -n amlnfs  --query "id" --output tsv)

az network private-endpoint create --connection-name amlnfs-connection --name amlnfs-private-endpoint --private-connection-resource-id $storage_id --subnet amlnfs --vnet $vnet_name --group-id file   --ip-config name=myIPconfig group-id=file member-name=file private-ip-address=10.0.2.4



# run job

#az ml job create -f train.yml --web



