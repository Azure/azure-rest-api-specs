## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-redhatopenshift-2020-04-30

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-redhatopenshift-2020-04-30 and azureresourceschema

``` yaml $(tag) == 'schema-redhatopenshift-2020-04-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RedHatOpenShift/stable/2020-04-30/redhatopenshift.json

```
