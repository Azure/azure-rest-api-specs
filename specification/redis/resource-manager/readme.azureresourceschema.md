## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-cache-2019-07-01
  - tag: schema-cache-2018-03-01
  - tag: schema-cache-2017-10-01
  - tag: schema-cache-2017-02-01
  - tag: schema-cache-2016-04-01
  - tag: schema-cache-2015-08-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-cache-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/preview/2019-07-01/redis.json

```

### Tag: schema-cache-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2018-03-01/redis.json

```

### Tag: schema-cache-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2017-10-01/redis.json

```

### Tag: schema-cache-2017-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2017-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2017-02-01/redis.json

```

### Tag: schema-cache-2016-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2016-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2016-04-01/redis.json

```

### Tag: schema-cache-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-cache-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Cache/stable/2015-08-01/redis.json

```
