## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-documentdb-2020-06-01-preview
  - tag: schema-documentdb-2020-04-01
  - tag: schema-documentdb-2020-03-01
  - tag: schema-documentdb-2019-12-12
  - tag: schema-documentdb-2019-08-01-preview
  - tag: schema-documentdb-2019-08-01
  - tag: schema-documentdb-2016-03-31
  - tag: schema-documentdb-2016-03-19
  - tag: schema-documentdb-2015-11-06
  - tag: schema-documentdb-2015-04-08
  - tag: schema-documentdb-2014-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-documentdb-2020-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2020-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/preview/2020-06-01-preview/cosmos-db.json
  - Microsoft.DocumentDB/preview/2020-06-01-preview/notebook.json

```

### Tag: schema-documentdb-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2020-04-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2020-04-01/notebook.json

```

### Tag: schema-documentdb-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2020-03-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2020-03-01/notebook.json

```

### Tag: schema-documentdb-2019-12-12 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2019-12-12' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2019-12-12/cosmos-db.json
  - Microsoft.DocumentDB/stable/2019-12-12/notebook.json

```

### Tag: schema-documentdb-2019-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2019-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateLinkResources.json
  - Microsoft.DocumentDB/preview/2019-08-01-preview/privateEndpointConnection.json

```

### Tag: schema-documentdb-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2019-08-01/cosmos-db.json
  - Microsoft.DocumentDB/stable/2019-08-01/notebook.json

```

### Tag: schema-documentdb-2016-03-31 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2016-03-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2016-03-31/cosmos-db.json

```

### Tag: schema-documentdb-2016-03-19 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2016-03-19' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2016-03-19/cosmos-db.json

```

### Tag: schema-documentdb-2015-11-06 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2015-11-06' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2015-11-06/cosmos-db.json

```

### Tag: schema-documentdb-2015-04-08 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2015-04-08' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2015-04-08/cosmos-db.json

```

### Tag: schema-documentdb-2014-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-documentdb-2014-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.DocumentDB/stable/2014-04-01/cosmos-db.json

```
