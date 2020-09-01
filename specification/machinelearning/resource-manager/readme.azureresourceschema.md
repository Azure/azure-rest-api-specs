## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-machinelearning-2019-10-01
  - tag: schema-machinelearning-2017-01-01
  - tag: schema-machinelearning-2016-05-01-preview
  - tag: schema-machinelearning-2016-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-machinelearning-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearning-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearning/stable/2019-10-01/workspaces.json

```

### Tag: schema-machinelearning-2017-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearning-2017-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearning/stable/2017-01-01/webservices.json

```

### Tag: schema-machinelearning-2016-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearning-2016-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearning/preview/2016-05-01-preview/commitmentPlans.json
  - Microsoft.MachineLearning/preview/2016-05-01-preview/webservices.json

```

### Tag: schema-machinelearning-2016-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearning-2016-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearning/stable/2016-04-01/workspaces.json

```
