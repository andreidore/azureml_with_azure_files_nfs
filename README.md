# azureml_with_azure_files_nfs

A repo that shows how to use Azure Machine Learning with Azure Files NFS share.



## Azure CLI

Install the Azure CLI : https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

## Configuration

Modify create.sh with your configuration:

```console

location="eastus"
resource_group='aml-nfs-test'
workspace_name='aml-nfs-test'

vnet_name='vnet'
vnet_address_range='10.0.0.0/16'
vnet_aml_subnet='10.0.1.0/24'
vnet_nfs_subnet='10.0.2.0/24'


```

## Resources

Create all of the resources ( Azure ML , Storage, NFS, VNET , etc)

```sh
./create.sh
```


## Submit job

Submit the Azure ML job. This will start a dummy script and then will measure the speed between Azure ML Compute instance and NFS stoarge

```sh
az ml job create -f train.yml --web
```


## Clean

Delete all resources

```sh
./delete.sh
```







Inspiration from : https://github.com/csiebler/azureml-with-azure-netapp-files
