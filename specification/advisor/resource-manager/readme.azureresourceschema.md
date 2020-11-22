## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-advisor-2020-07-01-preview
  - tag: schema-advisor-2020-01-01
  - tag: schema-advisor-2017-04-19
  - tag: schema-advisor-2017-03-31
  - tag: schema-advisor-2016-07-12-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-advisor-2020-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-advisor-2020-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Advisor/preview/2020-07-01-preview/advisor.json

```

### Tag: schema-advisor-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-advisor-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Advisor/stable/2020-01-01/advisor.json

```

### Tag: schema-advisor-2017-04-19 and azureresourceschema

``` yaml $(tag) == 'schema-advisor-2017-04-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Advisor/stable/2017-04-19/advisor.json

```

### Tag: schema-advisor-2017-03-31 and azureresourceschema

``` yaml $(tag) == 'schema-advisor-2017-03-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Advisor/stable/2017-03-31/advisor.json

```

### Tag: schema-advisor-2016-07-12-preview and azureresourceschema

``` yaml $(tag) == 'schema-advisor-2016-07-12-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Advisor/preview/2016-07-12-preview/advisor.json

```
