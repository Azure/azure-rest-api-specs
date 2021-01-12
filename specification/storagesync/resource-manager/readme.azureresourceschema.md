## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-storagesync-2020-03-01
  - tag: schema-storagesync-2019-10-01
  - tag: schema-storagesync-2019-06-01
  - tag: schema-storagesync-2019-03-01
  - tag: schema-storagesync-2019-02-01
  - tag: schema-storagesync-2018-10-01
  - tag: schema-storagesync-2018-07-01
  - tag: schema-storagesync-2018-04-02
  - tag: schema-storagesync-2017-06-05-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-storagesync-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2020-03-01/storagesync.json

```

### Tag: schema-storagesync-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2019-10-01/storagesync.json

```

### Tag: schema-storagesync-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2019-06-01/storagesync.json

```

### Tag: schema-storagesync-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2019-03-01/storagesync.json

```

### Tag: schema-storagesync-2019-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2019-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2019-02-01/storagesync.json

```

### Tag: schema-storagesync-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2018-10-01/storagesync.json

```

### Tag: schema-storagesync-2018-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2018-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2018-07-01/storagesync.json

```

### Tag: schema-storagesync-2018-04-02 and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2018-04-02' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/stable/2018-04-02/storagesync.json

```

### Tag: schema-storagesync-2017-06-05-preview and azureresourceschema

``` yaml $(tag) == 'schema-storagesync-2017-06-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.StorageSync/preview/2017-06-05-preview/storagesync.json

```
