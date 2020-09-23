## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-yourservicename-YYYY-MM-DD

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-yourservicename-YYYY-MM-DD and azureresourceschema

``` yaml $(tag) == 'schema-yourservicename-YYYY-MM-DD' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.YourServiceName/stable/YYYY-MM-DD/YourServiceName.json

```
