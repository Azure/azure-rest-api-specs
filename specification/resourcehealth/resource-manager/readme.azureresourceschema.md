## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-resourcehealth-2018-08-01
  - tag: schema-resourcehealth-2018-07-01
  - tag: schema-resourcehealth-2017-07-01
  - tag: schema-resourcehealth-2015-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-resourcehealth-2018-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-resourcehealth-2018-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceHealth/preview/2018-08-01/ResourceHealth.json

```

### Tag: schema-resourcehealth-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-resourcehealth-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceHealth/stable/2018-07-01/ResourceHealth.json

```

### Tag: schema-resourcehealth-2017-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-resourcehealth-2017-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceHealth/stable/2017-07-01/resourcehealth.json

```

### Tag: schema-resourcehealth-2015-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-resourcehealth-2015-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ResourceHealth/stable/2015-01-01/resourcehealth.json

```
