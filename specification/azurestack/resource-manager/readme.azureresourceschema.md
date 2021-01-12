## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azurestack-2017-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azurestack-2017-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-azurestack-2017-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureStack/stable/2017-06-01/AzureStack.json
  - Microsoft.AzureStack/stable/2017-06-01/Product.json
  - Microsoft.AzureStack/stable/2017-06-01/Registration.json
  - Microsoft.AzureStack/stable/2017-06-01/CustomerSubscription.json

```
