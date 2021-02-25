## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-azurestack-2020-06-01-preview
  - tag: schema-azurestack-2017-06-01
  - tag: schema-azurestack-2016-01-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-azurestack-2020-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-azurestack-2020-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureStack/preview/2020-06-01-preview/AzureStack.json
  - Microsoft.AzureStack/preview/2020-06-01-preview/CustomerSubscription.json
  - Microsoft.AzureStack/preview/2020-06-01-preview/Product.json
  - Microsoft.AzureStack/preview/2020-06-01-preview/Registration.json
  - Microsoft.AzureStack/preview/2020-06-01-preview/LinkedSubscription.json

```

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

### Tag: schema-azurestack-2016-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-azurestack-2016-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AzureStack/stable/2016-01-01/AzureStack.json
  - Microsoft.AzureStack/stable/2016-01-01/Product.json
  - Microsoft.AzureStack/stable/2016-01-01/Registration.json

```
