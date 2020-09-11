## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-storage-2019-06-01
  - tag: schema-storage-2019-04-01
  - tag: schema-storage-2018-11-01
  - tag: schema-storage-2018-07-01
  - tag: schema-storage-2018-03-01-preview
  - tag: schema-storage-2018-02-01
  - tag: schema-storage-2017-10-01
  - tag: schema-storage-2017-06-01
  - tag: schema-storage-2016-12-01
  - tag: schema-storage-2016-05-01
  - tag: schema-storage-2016-01-01
  - tag: schema-storage-2015-06-15
  - tag: schema-storage-2015-05-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-storage-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2019-06-01/storage.json
  - Microsoft.Storage/stable/2019-06-01/blob.json
  - Microsoft.Storage/stable/2019-06-01/file.json
  - Microsoft.Storage/stable/2019-06-01/queue.json
  - Microsoft.Storage/stable/2019-06-01/table.json

```

### Tag: schema-storage-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2019-04-01/storage.json
  - Microsoft.Storage/stable/2019-04-01/blob.json
  - Microsoft.Storage/stable/2019-04-01/file.json

```

### Tag: schema-storage-2018-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-11-01/storage.json
  - Microsoft.Storage/stable/2018-11-01/blob.json

```

### Tag: schema-storage-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-07-01/storage.json
  - Microsoft.Storage/stable/2018-07-01/blob.json

```

### Tag: schema-storage-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/preview/2018-03-01-preview/managementpolicy.json
  - Microsoft.Storage/preview/2018-03-01-preview/storage.json
  - Microsoft.Storage/preview/2018-03-01-preview/blob.json

```

### Tag: schema-storage-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2018-02-01/storage.json
  - Microsoft.Storage/stable/2018-02-01/blob.json

```

### Tag: schema-storage-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2017-10-01/storage.json

```

### Tag: schema-storage-2017-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2017-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2017-06-01/storage.json

```

### Tag: schema-storage-2016-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-12-01/storage.json

```

### Tag: schema-storage-2016-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-05-01/storage.json

```

### Tag: schema-storage-2016-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2016-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2016-01-01/storage.json

```

### Tag: schema-storage-2015-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-storage-2015-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/stable/2015-06-15/storage.json

```

### Tag: schema-storage-2015-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-storage-2015-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Storage/preview/2015-05-01-preview/storage.json

```
