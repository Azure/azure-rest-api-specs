## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-network-2018-04-01
  - tag: schema-network-2018-03-01
  - tag: schema-network-2018-02-01
  - tag: schema-network-2017-09-01-preview
  - tag: schema-network-2017-05-01
  - tag: schema-network-2017-03-01
  - tag: schema-network-2015-11-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-network-2018-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-04-01/trafficmanager.json

```

### Tag: schema-network-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-03-01/trafficmanager.json

```

### Tag: schema-network-2018-02-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-02-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-02-01/trafficmanager.json

```

### Tag: schema-network-2017-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2017-09-01-preview/trafficmanageranalytics.json

```

### Tag: schema-network-2017-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-05-01/trafficmanager.json

```

### Tag: schema-network-2017-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-03-01/trafficmanager.json

```

### Tag: schema-network-2015-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2015-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2015-11-01/trafficmanager.json

```
