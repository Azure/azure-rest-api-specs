## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-analysisservices-2017-08-01
  - tag: schema-analysisservices-2017-07-14
  - tag: schema-analysisservices-2016-05-16

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-analysisservices-2017-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-analysisservices-2017-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AnalysisServices/stable/2017-08-01/analysisservices.json

```

### Tag: schema-analysisservices-2017-07-14 and azureresourceschema

``` yaml $(tag) == 'schema-analysisservices-2017-07-14' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AnalysisServices/stable/2017-07-14/analysisservices.json

```

### Tag: schema-analysisservices-2016-05-16 and azureresourceschema

``` yaml $(tag) == 'schema-analysisservices-2016-05-16' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AnalysisServices/stable/2016-05-16/analysisservices.json

```
