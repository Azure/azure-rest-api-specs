## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-delegatednetwork-2020-08-08-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-delegatednetwork-2020-08-08-preview and azureresourceschema

``` yaml $(tag) == 'schema-delegatednetwork-2020-08-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/DelegatedNetwork.json

```
