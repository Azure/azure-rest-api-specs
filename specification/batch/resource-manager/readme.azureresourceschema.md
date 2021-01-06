## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-batch-2020-09-01
  - tag: schema-batch-2020-05-01
  - tag: schema-batch-2020-03-01
  - tag: schema-batch-2019-08-01
  - tag: schema-batch-2019-04-01
  - tag: schema-batch-2018-12-01
  - tag: schema-batch-2017-09-01
  - tag: schema-batch-2017-05-01
  - tag: schema-batch-2017-01-01
  - tag: schema-batch-2015-12-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-batch-2020-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2020-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2020-09-01/BatchManagement.json

```

### Tag: schema-batch-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2020-05-01/BatchManagement.json

```

### Tag: schema-batch-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2020-03-01/BatchManagement.json

```

### Tag: schema-batch-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2019-08-01/BatchManagement.json

```

### Tag: schema-batch-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2019-04-01/BatchManagement.json

```

### Tag: schema-batch-2018-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2018-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2018-12-01/BatchManagement.json

```

### Tag: schema-batch-2017-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2017-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2017-09-01/BatchManagement.json

```

### Tag: schema-batch-2017-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2017-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2017-05-01/BatchManagement.json

```

### Tag: schema-batch-2017-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2017-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2017-01-01/BatchManagement.json

```

### Tag: schema-batch-2015-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-batch-2015-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Batch/stable/2015-12-01/BatchManagement.json

```
