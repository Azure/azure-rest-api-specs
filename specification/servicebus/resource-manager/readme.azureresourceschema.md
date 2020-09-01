## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-servicebus-2018-01-01-preview
  - tag: schema-servicebus-2017-04-01
  - tag: schema-servicebus-2015-08-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-servicebus-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/preview/2018-01-01-preview/servicebus-preview.json

```

### Tag: schema-servicebus-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/stable/2017-04-01/servicebus.json

```

### Tag: schema-servicebus-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/stable/2015-08-01/servicebus.json

```
