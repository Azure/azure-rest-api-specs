## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-containerservice-2017-01-31
  - tag: schema-containerservice-2016-09-30
  - tag: schema-containerservice-2016-03-30
  - tag: schema-containerservice-2015-11-01-preview
  - tag: schema-compute-2020-06-30
  - tag: schema-compute-2020-06-01
  - tag: schema-compute-2020-05-01
  - tag: schema-compute-2019-12-01
  - tag: schema-compute-2019-11-01
  - tag: schema-compute-2019-07-01
  - tag: schema-compute-2019-04-01
  - tag: schema-compute-2019-03-01
  - tag: schema-compute-2018-10-01
  - tag: schema-compute-2018-09-30
  - tag: schema-compute-2018-06-01
  - tag: schema-compute-2018-04-01
  - tag: schema-compute-2017-12-01
  - tag: schema-compute-2017-09-01
  - tag: schema-compute-2017-03-30
  - tag: schema-compute-2016-04-30-preview
  - tag: schema-compute-2016-03-30
  - tag: schema-compute-2015-06-15

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

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

### Tag: schema-containerservice-2015-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-containerservice-2015-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ContainerService/preview/2015-11-01-preview/containerService.json

```

### Tag: schema-compute-2020-06-30 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2020-06-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2020-06-30/disk.json

```

### Tag: schema-compute-2020-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2020-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2020-06-01/compute.json
  - Microsoft.Compute/stable/2020-06-01/runCommands.json

```

### Tag: schema-compute-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2020-05-01/disk.json

```

### Tag: schema-compute-2019-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2019-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2019-12-01/gallery.json
  - Microsoft.Compute/stable/2019-12-01/compute.json
  - Microsoft.Compute/stable/2019-12-01/runCommands.json

```

### Tag: schema-compute-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2019-11-01/disk.json

```

### Tag: schema-compute-2019-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2019-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2019-07-01/compute.json
  - Microsoft.Compute/stable/2019-07-01/runCommands.json
  - Microsoft.Compute/stable/2019-07-01/gallery.json
  - Microsoft.Compute/stable/2019-07-01/disk.json

```

### Tag: schema-compute-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2019-04-01/skus.json

```

### Tag: schema-compute-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2019-03-01/compute.json
  - Microsoft.Compute/stable/2019-03-01/runCommands.json
  - Microsoft.Compute/stable/2019-03-01/disk.json
  - Microsoft.Compute/stable/2019-03-01/gallery.json

```

### Tag: schema-compute-2018-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2018-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2018-10-01/compute.json
  - Microsoft.Compute/stable/2018-10-01/runCommands.json

```

### Tag: schema-compute-2018-09-30 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2018-09-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2018-09-30/disk.json

```

### Tag: schema-compute-2018-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2018-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2018-06-01/gallery.json
  - Microsoft.Compute/stable/2018-06-01/disk.json
  - Microsoft.Compute/stable/2018-06-01/compute.json
  - Microsoft.Compute/stable/2018-06-01/runCommands.json

```

### Tag: schema-compute-2018-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2018-04-01/compute.json
  - Microsoft.Compute/stable/2018-04-01/runCommands.json
  - Microsoft.Compute/stable/2018-04-01/disk.json

```

### Tag: schema-compute-2017-12-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2017-12-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2017-12-01/compute.json
  - Microsoft.Compute/stable/2017-12-01/runCommands.json

```

### Tag: schema-compute-2017-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2017-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2017-09-01/skus.json

```

### Tag: schema-compute-2017-03-30 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2017-03-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2017-03-30/disk.json
  - Microsoft.Compute/stable/2017-03-30/compute.json
  - Microsoft.Compute/stable/2017-03-30/runCommands.json

```

### Tag: schema-compute-2016-04-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-compute-2016-04-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/preview/2016-04-30-preview/compute.json
  - Microsoft.Compute/preview/2016-04-30-preview/disk.json

```

### Tag: schema-compute-2016-03-30 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2016-03-30' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2016-03-30/compute.json

```

### Tag: schema-compute-2015-06-15 and azureresourceschema

``` yaml $(tag) == 'schema-compute-2015-06-15' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Compute/stable/2015-06-15/compute.json

```
