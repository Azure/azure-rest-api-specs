## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-aadiam-2020-07-01-preview
  - tag: schema-aadiam-2020-03-01-preview
  - tag: schema-aadiam-2017-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-aadiam-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-aadiam-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Aadiam/preview/2020-07-01-preview/azureADMetrics.json

```

### Tag: schema-aadiam-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-aadiam-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Aadiam/preview/2020-03-01-preview/privateLinkForAzureAD.json
  - Microsoft.Aadiam/preview/2020-03-01-preview/privateLinkResources.json

```

### Tag: schema-aadiam-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-aadiam-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Aadiam/stable/2017-04-01/azureactivedirectory.json

```
