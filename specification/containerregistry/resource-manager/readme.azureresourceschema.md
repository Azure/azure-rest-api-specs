## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-containerregistry-2019-12-01-preview
  - tag: schema-containerregistry-2019-06-01-preview
  - tag: schema-containerregistry-2019-05-01-preview
  - tag: schema-containerregistry-2019-05-01
  - tag: schema-containerregistry-2019-04-01
  - tag: schema-containerregistry-2018-09-01
  - tag: schema-containerregistry-2018-02-01-preview
  - tag: schema-containerregistry-2017-10-01
  - tag: schema-containerregistry-2017-06-01-preview
  - tag: schema-containerregistry-2017-03-01
  - tag: schema-containerregistry-2016-06-27-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-containerregistry-2019-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2019-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2019-12-01-preview/containerregistry.json

```

### Tag: schema-containerregistry-2019-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2019-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2019-06-01-preview/containerregistry_build.json

```

### Tag: schema-containerregistry-2019-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2019-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2019-05-01-preview/containerregistry_scopemap.json

```

### Tag: schema-containerregistry-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/stable/2019-05-01/containerregistry.json

```

### Tag: schema-containerregistry-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/stable/2019-04-01/containerregistry_build.json

```

### Tag: schema-containerregistry-2018-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2018-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/stable/2018-09-01/containerregistry_build.json

```

### Tag: schema-containerregistry-2018-02-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2018-02-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2018-02-01-preview/containerregistry_build.json

```

### Tag: schema-containerregistry-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/stable/2017-10-01/containerregistry.json

```

### Tag: schema-containerregistry-2017-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2017-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2017-06-01-preview/containerregistry.json

```

### Tag: schema-containerregistry-2017-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2017-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/stable/2017-03-01/containerregistry.json

```

### Tag: schema-containerregistry-2016-06-27-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerregistry-2016-06-27-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerRegistry/preview/2016-06-27-preview/containerregistry.json

```
