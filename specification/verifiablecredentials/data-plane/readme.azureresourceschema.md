## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-verifiablecredentials-2021-04-05-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-verifiablecredentials-2021-04-05-preview and azureresourceschema

``` yaml $(tag) == 'schema-verifiablecredentials-2021-04-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.VerifiableCredentials/preview/2021-04-05-preview/verifiablecredentials.json
  - Microsoft.VerifiableCredentials/preview/2021-04-05-preview/picsissuance.json
```
