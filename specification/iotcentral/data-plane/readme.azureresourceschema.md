## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-iotcentral-2021-04-30-preview
  - tag: schema-iotcentral-1.0

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-iotcentral-2021-04-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-iotcentral-2021-04-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.IoTCentral/preview/2021-04-30-preview/iotcentral.json

```

### Tag: schema-iotcentral-1.0 and azureresourceschema

``` yaml $(tag) == 'schema-iotcentral-1.0' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.IoTCentral/stable/1.0/iotcentral.json

```