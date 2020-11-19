## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-logic-2019-05-01
  - tag: schema-logic-2018-07-01-preview
  - tag: schema-logic-2016-06-01
  - tag: schema-logic-2015-08-01-preview
  - tag: schema-logic-2015-02-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-logic-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-logic-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Logic/stable/2019-05-01/logic.json

```

### Tag: schema-logic-2018-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-logic-2018-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Logic/preview/2018-07-01-preview/logic.json

```

### Tag: schema-logic-2016-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-logic-2016-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Logic/stable/2016-06-01/logic.json

```

### Tag: schema-logic-2015-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-logic-2015-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Logic/preview/2015-08-01-preview/logic.json

```

### Tag: schema-logic-2015-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-logic-2015-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Logic/preview/2015-02-01-preview/logic.json

```
