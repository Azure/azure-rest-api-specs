## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-recoveryservices-2020-07-01
  - tag: schema-recoveryservices-2020-02-02
  - tag: schema-recoveryservices-2019-06-15
  - tag: schema-recoveryservices-2019-05-13
  - tag: schema-recoveryservices-2018-12-20
  - tag: schema-recoveryservices-2017-07-01
  - tag: schema-recoveryservices-2016-12-01
  - tag: schema-recoveryservices-2016-08-10
  - tag: schema-recoveryservices-2016-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-recoveryservices-2020-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2020-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2020-07-01/bms.json

```

### Tag: schema-recoveryservices-2020-02-02 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2020-02-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2020-02-02/bms.json

```

### Tag: schema-recoveryservices-2019-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2019-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2019-06-15/bms.json

```

### Tag: schema-recoveryservices-2019-05-13 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2019-05-13' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2019-05-13/bms.json

```

### Tag: schema-recoveryservices-2018-12-20 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2018-12-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2018-12-20/bms.json

```

### Tag: schema-recoveryservices-2017-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2017-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2017-07-01/bms.json

```

### Tag: schema-recoveryservices-2016-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2016-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2016-12-01/bms.json

```

### Tag: schema-recoveryservices-2016-08-10 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2016-08-10' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2016-08-10/operations.json

```

### Tag: schema-recoveryservices-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2016-06-01/recoveryservicesbackup.json
  - Microsoft.RecoveryServices/stable/2016-06-01/registeredIdentities.json

```
