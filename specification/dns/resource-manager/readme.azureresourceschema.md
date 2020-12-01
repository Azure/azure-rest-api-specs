## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-network-2018-05-01
  - tag: schema-network-2018-03-01-preview
  - tag: schema-network-2017-10-01
  - tag: schema-network-2017-09-01
  - tag: schema-network-2016-04-01
  - tag: schema-network-2015-05-04-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-network-2018-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2018-05-01/dns.json

```

### Tag: schema-network-2018-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2018-03-01-preview/dns.json

```

### Tag: schema-network-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-10-01/dns.json

```

### Tag: schema-network-2017-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2017-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2017-09-01/dns.json

```

### Tag: schema-network-2016-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2016-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2016-04-01/dns.json

```

### Tag: schema-network-2015-05-04-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2015-05-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2015-05-04-preview/dns.json

```
