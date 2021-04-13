## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-iotsecurity-2021-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-iotsecurity-2021-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-iotsecurity-2021-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/defenderSettings.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/operations.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/sites.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/sensors.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/onPremiseSensors.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/locations.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/deviceGroups.json
  - Microsoft.IoTSecurity/preview/2021-02-01-preview/devices.json

```
