## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-softwareplan-2019-12-01
  - tag: schema-softwareplan-2019-06-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-softwareplan-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-softwareplan-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SoftwarePlan/stable/2019-12-01/softwareplan.json

```

### Tag: schema-softwareplan-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-softwareplan-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SoftwarePlan/preview/2019-06-01-preview/softwareplan.json

```
