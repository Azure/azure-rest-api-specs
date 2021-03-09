## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-devtestlab-2018-09-15
  - tag: schema-devtestlab-2016-05-15
  - tag: schema-devtestlab-2015-05-21-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-devtestlab-2018-09-15 and azureresourceschema

``` yaml $(tag) == 'schema-devtestlab-2018-09-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DevTestLab/stable/2018-09-15/DTL.json

```

### Tag: schema-devtestlab-2016-05-15 and azureresourceschema

``` yaml $(tag) == 'schema-devtestlab-2016-05-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DevTestLab/stable/2016-05-15/DTL.json

```

### Tag: schema-devtestlab-2015-05-21-preview and azureresourceschema

``` yaml $(tag) == 'schema-devtestlab-2015-05-21-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DevTestLab/preview/2015-05-21-preview/DTL.json

```
