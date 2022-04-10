## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-confidentialledger-2020-12-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-confidentialledger-2020-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-confidentialledger-2020-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ConfidentialLedger/preview/2020-12-01-preview/confidentialledger.json

```
