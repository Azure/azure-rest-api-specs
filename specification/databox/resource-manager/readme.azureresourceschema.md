## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-databox-2020-11-01
  - tag: schema-databox-2020-04-01
  - tag: schema-databox-2019-09-01
  - tag: schema-databox-2018-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-databox-2020-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-databox-2020-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBox/stable/2020-11-01/databox.json

```

### Tag: schema-databox-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-databox-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBox/stable/2020-04-01/databox.json

```

### Tag: schema-databox-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-databox-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBox/stable/2019-09-01/databox.json

```

### Tag: schema-databox-2018-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-databox-2018-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DataBox/stable/2018-01-01/databox.json

```
