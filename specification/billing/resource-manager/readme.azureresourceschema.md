## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-billing-2020-05-01
  - tag: schema-billing-2020-10-01-preview
  - tag: schema-billing-2019-10-01-preview
  - tag: schema-billing-2018-11-01-preview
  - tag: schema-billing-2018-03-01-preview
  - tag: schema-billing-2017-04-24-preview
  - tag: schema-billing-2017-02-27-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-billing-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-billing-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/stable/2020-05-01/billing.json

```

### Tag: schema-billing-2020-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2020-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2020-10-01-preview/billing.json

```

### Tag: schema-billing-2019-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2019-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2019-10-01-preview/billing.json

```

### Tag: schema-billing-2018-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2018-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2018-11-01-preview/billing.json

```

### Tag: schema-billing-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2018-03-01-preview/billingV2.json
  - Microsoft.Billing/preview/2018-03-01-preview/billing.json

```

### Tag: schema-billing-2017-04-24-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2017-04-24-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2017-04-24-preview/billing.json

```

### Tag: schema-billing-2017-02-27-preview and azureresourceschema

``` yaml $(tag) == 'schema-billing-2017-02-27-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Billing/preview/2017-02-27-preview/billing.json

```
