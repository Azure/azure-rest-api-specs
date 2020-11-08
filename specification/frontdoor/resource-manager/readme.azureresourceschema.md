## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-network-2020-05-01
  - tag: schema-network-2020-04-01
  - tag: schema-network-2020-01-01
  - tag: schema-network-2019-11-01
  - tag: schema-network-2019-10-01
  - tag: schema-network-2019-05-01
  - tag: schema-network-2019-04-01
  - tag: schema-network-2019-03-01-preview
  - tag: schema-network-2019-03-01
  - tag: schema-network-2018-08-01-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-network-2020-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-05-01/network.json
  - Microsoft.Network/stable/2020-05-01/frontdoor.json

```

### Tag: schema-network-2020-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-04-01/webapplicationfirewall.json
  - Microsoft.Network/stable/2020-04-01/network.json
  - Microsoft.Network/stable/2020-04-01/frontdoor.json

```

### Tag: schema-network-2020-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2020-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2020-01-01/network.json
  - Microsoft.Network/stable/2020-01-01/frontdoor.json

```

### Tag: schema-network-2019-11-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-11-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-11-01/networkexperiment.json
  - Microsoft.Network/stable/2019-11-01/network.json

```

### Tag: schema-network-2019-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-10-01/webapplicationfirewall.json

```

### Tag: schema-network-2019-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-05-01/frontdoor.json
  - Microsoft.Network/stable/2019-05-01/network.json

```

### Tag: schema-network-2019-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-04-01/frontdoor.json
  - Microsoft.Network/stable/2019-04-01/network.json

```

### Tag: schema-network-2019-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2019-03-01-preview/webapplicationfirewall.json

```

### Tag: schema-network-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-network-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/stable/2019-03-01/webapplicationfirewall.json

```

### Tag: schema-network-2018-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-network-2018-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Network/preview/2018-08-01-preview/frontdoor.json
  - Microsoft.Network/preview/2018-08-01-preview/network.json
  - Microsoft.Network/preview/2018-08-01-preview/webapplicationfirewall.json

```
