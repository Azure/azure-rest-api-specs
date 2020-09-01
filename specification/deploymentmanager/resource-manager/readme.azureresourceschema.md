## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-deploymentmanager-2019-11-01-preview
  - tag: schema-deploymentmanager-2018-09-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-deploymentmanager-2019-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-deploymentmanager-2019-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DeploymentManager/preview/2019-11-01-preview/deploymentmanager.json

```

### Tag: schema-deploymentmanager-2018-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-deploymentmanager-2018-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DeploymentManager/preview/2018-09-01-preview/deploymentmanager.json

```
