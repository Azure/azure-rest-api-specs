## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-devices-2020-09-01-preview
  - tag: schema-devices-2020-03-01
  - tag: schema-devices-2020-01-01
  - tag: schema-devices-2018-01-22
  - tag: schema-devices-2017-11-15
  - tag: schema-devices-2017-08-21-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-devices-2020-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2020-09-01-preview/iotdps.json

```

### Tag: schema-devices-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-03-01/iotdps.json

```

### Tag: schema-devices-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-01-01/iotdps.json

```

### Tag: schema-devices-2018-01-22 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2018-01-22' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2018-01-22/iotdps.json

```

### Tag: schema-devices-2017-11-15 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2017-11-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2017-11-15/iotdps.json

```

### Tag: schema-devices-2017-08-21-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2017-08-21-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2017-08-21-preview/iotdps.json

```
