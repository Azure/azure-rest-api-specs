## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-delegatednetwork-2021-03-15
  - tag: schema-delegatednetwork-2020-08-08-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-delegatednetwork-2021-03-15 and azureresourceschema

``` yaml $(tag) == 'schema-delegatednetwork-2021-03-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DelegatedNetwork/stable/2021-03-15/controller.json
  - Microsoft.DelegatedNetwork/stable/2021-03-15/orchestrators.json
  - Microsoft.DelegatedNetwork/stable/2021-03-15/delegatedSubnets.json
  - Microsoft.DelegatedNetwork/stable/2021-03-15/operations.json
  - Microsoft.DelegatedNetwork/stable/2021-03-15/common-types.json

```

### Tag: schema-delegatednetwork-2020-08-08-preview and azureresourceschema

``` yaml $(tag) == 'schema-delegatednetwork-2020-08-08-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/controller.json
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/orchestrators.json
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/delegatedSubnets.json
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/operations.json
  - Microsoft.DelegatedNetwork/preview/2020-08-08-preview/common-types.json

```
