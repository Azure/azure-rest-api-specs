## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-machinelearningcompute-2017-08-01-preview
  - tag: schema-machinelearningcompute-2017-06-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-machinelearningcompute-2017-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningcompute-2017-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningCompute/preview/2017-08-01-preview/machineLearningCompute.json

```

### Tag: schema-machinelearningcompute-2017-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningcompute-2017-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningCompute/preview/2017-06-01-preview/machineLearningCompute.json

```
