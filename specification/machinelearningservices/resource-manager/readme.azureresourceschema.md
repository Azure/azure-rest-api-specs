## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-machinelearningservices-2020-09-01-preview
  - tag: schema-machinelearningservices-2020-06-01
  - tag: schema-machinelearningservices-2020-05-15-preview
  - tag: schema-machinelearningservices-2020-05-01-preview
  - tag: schema-machinelearningservices-2020-04-01-preview
  - tag: schema-machinelearningservices-2020-04-01
  - tag: schema-machinelearningservices-2020-03-01
  - tag: schema-machinelearningservices-2020-02-18-preview
  - tag: schema-machinelearningservices-2020-01-01
  - tag: schema-machinelearningservices-2019-11-01
  - tag: schema-machinelearningservices-2019-06-01
  - tag: schema-machinelearningservices-2019-05-01
  - tag: schema-machinelearningservices-2018-11-19
  - tag: schema-machinelearningservices-2018-03-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-machinelearningservices-2020-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2020-09-01-preview/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2020-06-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-05-15-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-05-15-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2020-05-15-preview/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2020-05-01-preview/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-04-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-04-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2020-04-01-preview/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2020-04-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2020-03-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-02-18-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-02-18-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2020-02-18-preview/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2020-01-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2019-11-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2019-06-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2019-05-01/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2018-11-19 and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2018-11-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/stable/2018-11-19/machineLearningServices.json

```

### Tag: schema-machinelearningservices-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-machinelearningservices-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.MachineLearningServices/preview/2018-03-01-preview/machineLearningServices.json

```
