## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-subscription-2020-09-01
  - tag: schema-subscription-2020-01-01
  - tag: schema-subscription-2019-10-01-preview
  - tag: schema-subscription-2019-03-01-preview
  - tag: schema-subscription-2018-11-01-preview
  - tag: schema-subscription-2018-03-01-preview
  - tag: schema-subscription-2017-11-01-preview
  - tag: schema-subscription-2016-06-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-subscription-2020-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2020-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/stable/2020-09-01/subscriptions.json

```

### Tag: schema-subscription-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/stable/2020-01-01/subscriptions.json

```

### Tag: schema-subscription-2019-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2019-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/preview/2019-10-01-preview/subscriptions.json

```

### Tag: schema-subscription-2019-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2019-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/preview/2019-03-01-preview/subscriptions.json

```

### Tag: schema-subscription-2018-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2018-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/preview/2018-11-01-preview/subscriptions.json

```

### Tag: schema-subscription-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/preview/2018-03-01-preview/subscriptions.json
  - Microsoft.Subscription/preview/2018-03-01-preview/operations.json

```

### Tag: schema-subscription-2017-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2017-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/preview/2017-11-01-preview/subscriptionDefinitions.json

```

### Tag: schema-subscription-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-subscription-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Subscription/stable/2016-06-01/subscriptions.json

```
