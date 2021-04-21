## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-recoveryservices-2018-07-10
  - tag: schema-recoveryservices-2018-01-10
  - tag: schema-recoveryservices-2016-08-10

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-recoveryservices-2018-07-10 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2018-07-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2018-07-10/service.json

```

### Tag: schema-recoveryservices-2018-01-10 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2018-01-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2018-01-10/service.json

```

### Tag: schema-recoveryservices-2016-08-10 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2016-08-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2016-08-10/service.json

```
