## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-devices-2020-08-01
  - tag: schema-devices-2020-07-10-preview
  - tag: schema-devices-2020-06-15
  - tag: schema-devices-2020-04-01
  - tag: schema-devices-2020-03-01
  - tag: schema-devices-2019-11-04
  - tag: schema-devices-2019-07-01-preview
  - tag: schema-devices-2019-03-22-preview
  - tag: schema-devices-2019-03-22
  - tag: schema-devices-2018-12-01-preview
  - tag: schema-devices-2018-04-01
  - tag: schema-devices-2018-01-22
  - tag: schema-devices-2017-07-01
  - tag: schema-devices-2017-01-19
  - tag: schema-devices-2016-02-03

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-devices-2020-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-08-01/iothub.json

```

### Tag: schema-devices-2020-07-10-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-07-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2020-07-10-preview/iothub.json

```

### Tag: schema-devices-2020-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-06-15/iothub.json

```

### Tag: schema-devices-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-04-01/iothub.json

```

### Tag: schema-devices-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2020-03-01/iothub.json

```

### Tag: schema-devices-2019-11-04 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2019-11-04' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2019-11-04/iothub.json

```

### Tag: schema-devices-2019-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2019-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2019-07-01-preview/iothub.json

```

### Tag: schema-devices-2019-03-22-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2019-03-22-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2019-03-22-preview/iothub.json

```

### Tag: schema-devices-2019-03-22 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2019-03-22' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2019-03-22/iothub.json

```

### Tag: schema-devices-2018-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-devices-2018-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/preview/2018-12-01-preview/iothub.json

```

### Tag: schema-devices-2018-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2018-04-01/iothub.json

```

### Tag: schema-devices-2018-01-22 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2018-01-22' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2018-01-22/iothub.json

```

### Tag: schema-devices-2017-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2017-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2017-07-01/iothub.json

```

### Tag: schema-devices-2017-01-19 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2017-01-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2017-01-19/iothub.json

```

### Tag: schema-devices-2016-02-03 and azureresourceschema

``` yaml $(tag) == 'schema-devices-2016-02-03' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Devices/stable/2016-02-03/iothub.json

```
