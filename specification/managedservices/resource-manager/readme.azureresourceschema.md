## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-managedservices-2020-02-01-preview
  - tag: schema-managedservices-2019-09-01
  - tag: schema-managedservices-2019-06-01
  - tag: schema-managedservices-2019-04-01-preview
  - tag: schema-managedservices-2018-06-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-managedservices-2020-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-managedservices-2020-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedServices/preview/2020-02-01-preview/managedservices.json

```

### Tag: schema-managedservices-2019-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-managedservices-2019-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedServices/stable/2019-09-01/managedservices.json

```

### Tag: schema-managedservices-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-managedservices-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedServices/stable/2019-06-01/managedservices.json

```

### Tag: schema-managedservices-2019-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-managedservices-2019-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedServices/preview/2019-04-01-preview/managedservices.json

```

### Tag: schema-managedservices-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-managedservices-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ManagedServices/preview/2018-06-01-preview/managedservices.json

```
