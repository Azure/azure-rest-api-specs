## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-devops-2020-07-13-preview
  - tag: schema-devops-2019-07-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-devops-2020-07-13-preview and azureresourceschema

``` yaml $(tag) == 'schema-devops-2020-07-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DevOps/preview/2020-07-13-preview/devops.json

```

### Tag: schema-devops-2019-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-devops-2019-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DevOps/preview/2019-07-01-preview/devops.json

```
