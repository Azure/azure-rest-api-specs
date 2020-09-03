## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-windowsiot-2019-06-01
  - tag: schema-windowsiot-2018-02-16-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-windowsiot-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-windowsiot-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.WindowsIoT/stable/2019-06-01/WindowsIotServices.json

```

### Tag: schema-windowsiot-2018-02-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-windowsiot-2018-02-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.WindowsIoT/preview/2018-02-16-preview/WindowsIotServices.json

```
