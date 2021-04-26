## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-signalrservice-2020-07-01-preview
  - tag: schema-signalrservice-2020-05-01
  - tag: schema-signalrservice-2018-10-01
  - tag: schema-signalrservice-2018-03-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-signalrservice-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-signalrservice-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SignalRService/preview/2020-07-01-preview/signalr.json

```

### Tag: schema-signalrservice-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-signalrservice-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SignalRService/stable/2020-05-01/signalr.json

```

### Tag: schema-signalrservice-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-signalrservice-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SignalRService/stable/2018-10-01/signalr.json

```

### Tag: schema-signalrservice-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-signalrservice-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SignalRService/preview/2018-03-01-preview/signalr.json

```
