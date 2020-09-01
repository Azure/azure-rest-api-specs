## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-importexport-2020-08-01
  - tag: schema-importexport-2016-11-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-importexport-2020-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-importexport-2020-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ImportExport/stable/2020-08-01/storageimportexport.json

```

### Tag: schema-importexport-2016-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-importexport-2016-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ImportExport/stable/2016-11-01/storageimportexport.json

```
