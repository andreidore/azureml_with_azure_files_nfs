# azureml_with_azure_files_nfs

A repo that shows how to use Azure Machine Learning with Azure Files.



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

Create resources

```sh
./create.sh
```


## Submit job






Inspiration from : https://github.com/csiebler/azureml-with-azure-netapp-files
