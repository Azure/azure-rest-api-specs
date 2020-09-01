## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-capacity-2019-07-19
  - tag: schema-capacity-2019-04-01
  - tag: schema-capacity-2018-06-01
  - tag: schema-capacity-2017-11-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-capacity-2019-07-19 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2019-07-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2019-07-19/quota.json

```

### Tag: schema-capacity-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2019-04-01/reservations.json

```

### Tag: schema-capacity-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/preview/2018-06-01/reservations.json

```

### Tag: schema-capacity-2017-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-capacity-2017-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Capacity/stable/2017-11-01/reservations.json

```
