## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-scom-2021-06-30-preview
  - tag: schema-scom-2022-04-30-preview
  - tag: schema-scom-2022-09-13-preview
  - tag: schema-scom-2023-07-07-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-scom-2021-06-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2021-06-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCOM/preview/2021-06-30-preview/scom.json
  
```
### Tag: schema-scom-2022-04-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2022-04-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCOM/preview/2022-04-30-preview/scom.json
  
```
### Tag: schema-scom-2022-09-13-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2022-09-13-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCOM/preview/2022-09-13-preview/scom.json
  
```
### Tag: schema-scom-2023-07-07-preview and azureresourceschema

``` yaml $(tag) == 'schema-scom-2023-07-07-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCOM/preview/2023-07-07-preview/scom.json
  - Microsoft.SCOM/preview/2023-07-07-preview/monitoredResources.json
  - Microsoft.SCOM/preview/2023-07-07-preview/managedGateways.json
  - Microsoft.SCOM/preview/2023-07-07-preview/commonTypes.json

```