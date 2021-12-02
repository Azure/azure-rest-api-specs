## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azureactivedirectory-2021-04-01
  - tag: schema-azureactivedirectory-2020-05-01-preview
  - tag: schema-azureactivedirectory-2019-01-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azureactivedirectory-2021-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-azureactivedirectory-2021-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureActiveDirectory/stable/2021-04-01/externalIdentities.json

```

### Tag: schema-azureactivedirectory-2020-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-azureactivedirectory-2020-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureActiveDirectory/preview/2020-05-01-preview/cpim.json

```

### Tag: schema-azureactivedirectory-2019-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-azureactivedirectory-2019-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureActiveDirectory/preview/2019-01-01-preview/cpimTenant.json

```
