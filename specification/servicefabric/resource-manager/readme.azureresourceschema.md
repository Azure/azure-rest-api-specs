## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-servicefabric-2020-03-01
  - tag: schema-servicefabric-2020-01-01-preview
  - tag: schema-servicefabric-2019-11-01-preview
  - tag: schema-servicefabric-2019-06-01-preview
  - tag: schema-servicefabric-2019-03-01-preview
  - tag: schema-servicefabric-2019-03-01
  - tag: schema-servicefabric-2018-02-01
  - tag: schema-servicefabric-2017-07-01-preview
  - tag: schema-servicefabric-2016-09-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-servicefabric-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/stable/2020-03-01/cluster.json
  - Microsoft.ServiceFabric/stable/2020-03-01/application.json

```

### Tag: schema-servicefabric-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/preview/2020-01-01-preview/managedcluster.json
  - Microsoft.ServiceFabric/preview/2020-01-01-preview/nodetype.json

```

### Tag: schema-servicefabric-2019-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2019-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/preview/2019-11-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-11-01-preview/application.json

```

### Tag: schema-servicefabric-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/preview/2019-06-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-06-01-preview/application.json

```

### Tag: schema-servicefabric-2019-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2019-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/preview/2019-03-01-preview/cluster.json
  - Microsoft.ServiceFabric/preview/2019-03-01-preview/application.json

```

### Tag: schema-servicefabric-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/stable/2019-03-01/cluster.json
  - Microsoft.ServiceFabric/stable/2019-03-01/application.json

```

### Tag: schema-servicefabric-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/stable/2018-02-01/cluster.json

```

### Tag: schema-servicefabric-2017-07-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2017-07-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/preview/2017-07-01-preview/application.json
  - Microsoft.ServiceFabric/preview/2017-07-01-preview/servicefabric.json

```

### Tag: schema-servicefabric-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicefabric-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceFabric/stable/2016-09-01/servicefabric.json

```
