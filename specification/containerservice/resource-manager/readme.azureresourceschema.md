## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-containerservice-2020-07-01
  - tag: schema-containerservice-2020-06-01
  - tag: schema-containerservice-2020-04-01
  - tag: schema-containerservice-2020-03-01
  - tag: schema-containerservice-2020-02-01
  - tag: schema-containerservice-2020-01-01
  - tag: schema-containerservice-2019-11-01
  - tag: schema-containerservice-2019-10-27-preview
  - tag: schema-containerservice-2019-10-01
  - tag: schema-containerservice-2019-09-30
  - tag: schema-containerservice-2019-08-01
  - tag: schema-containerservice-2019-06-01
  - tag: schema-containerservice-2019-04-30
  - tag: schema-containerservice-2019-04-01
  - tag: schema-containerservice-2019-02-01
  - tag: schema-containerservice-2018-09-30-preview
  - tag: schema-containerservice-2018-08-01-preview
  - tag: schema-containerservice-2018-03-31
  - tag: schema-containerservice-2017-09-30
  - tag: schema-containerservice-2017-08-31
  - tag: schema-containerservice-2017-07-01
  - tag: schema-containerservice-2017-01-31
  - tag: schema-containerservice-2016-09-30
  - tag: schema-containerservice-2016-03-30

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-containerservice-2020-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-07-01/managedClusters.json

```

### Tag: schema-containerservice-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-06-01/managedClusters.json

```

### Tag: schema-containerservice-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-04-01/managedClusters.json

```

### Tag: schema-containerservice-2020-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-03-01/managedClusters.json

```

### Tag: schema-containerservice-2020-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-02-01/managedClusters.json

```

### Tag: schema-containerservice-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2020-01-01/managedClusters.json

```

### Tag: schema-containerservice-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-11-01/managedClusters.json

```

### Tag: schema-containerservice-2019-10-27-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-10-27-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/preview/2019-10-27-preview/openShiftManagedClusters.json

```

### Tag: schema-containerservice-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-10-01/managedClusters.json

```

### Tag: schema-containerservice-2019-09-30 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-09-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/preview/2019-09-30/openShiftManagedClusters.json

```

### Tag: schema-containerservice-2019-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-08-01/location.json
  - Microsoft.ContainerService/stable/2019-08-01/managedClusters.json

```

### Tag: schema-containerservice-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-06-01/location.json
  - Microsoft.ContainerService/stable/2019-06-01/managedClusters.json

```

### Tag: schema-containerservice-2019-04-30 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-04-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-04-30/openShiftManagedClusters.json

```

### Tag: schema-containerservice-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-04-01/managedClusters.json
  - Microsoft.ContainerService/stable/2019-04-01/location.json

```

### Tag: schema-containerservice-2019-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2019-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2019-02-01/managedClusters.json

```

### Tag: schema-containerservice-2018-09-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2018-09-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/preview/2018-09-30-preview/openShiftManagedClusters.json

```

### Tag: schema-containerservice-2018-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2018-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/preview/2018-08-01-preview/managedClusters.json

```

### Tag: schema-containerservice-2018-03-31 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2018-03-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2018-03-31/managedClusters.json

```

### Tag: schema-containerservice-2017-09-30 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2017-09-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2017-09-30/location.json

```

### Tag: schema-containerservice-2017-08-31 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2017-08-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2017-08-31/managedClusters.json

```

### Tag: schema-containerservice-2017-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2017-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2017-07-01/containerService.json

```

### Tag: schema-containerservice-2017-01-31 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2017-01-31' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2017-01-31/containerService.json

```

### Tag: schema-containerservice-2016-09-30 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2016-09-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2016-09-30/containerService.json

```

### Tag: schema-containerservice-2016-03-30 and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2016-03-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/stable/2016-03-30/containerService.json

```
