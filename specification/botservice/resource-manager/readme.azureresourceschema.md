## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-botservice-2020-06-02
  - tag: schema-botservice-2018-07-12
  - tag: schema-botservice-2017-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-botservice-2020-06-02 and azureresourceschema

``` yaml $(tag) == 'schema-botservice-2020-06-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BotService/stable/2020-06-02/botservice.json

```

### Tag: schema-botservice-2018-07-12 and azureresourceschema

``` yaml $(tag) == 'schema-botservice-2018-07-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BotService/preview/2018-07-12/botservice.json

```

### Tag: schema-botservice-2017-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-botservice-2017-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.BotService/preview/2017-12-01/botservice.json

```
