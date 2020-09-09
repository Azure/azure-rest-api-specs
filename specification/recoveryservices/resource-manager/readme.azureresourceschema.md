## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-recoveryservices-2016-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-recoveryservices-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-recoveryservices-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.RecoveryServices/stable/2016-06-01/registeredidentities.json
  - Microsoft.RecoveryServices/stable/2016-06-01/replicationusages.json
  - Microsoft.RecoveryServices/stable/2016-06-01/vaults.json
  - Microsoft.RecoveryServices/stable/2016-06-01/vaultusages.json

```
