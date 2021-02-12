## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-relay-2018-01-01-preview
  - tag: schema-relay-2017-04-01
  - tag: schema-relay-2016-07-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-relay-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-relay-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Relay/preview/2018-01-01-preview/Namespaces-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/NetworkRuleSets-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/PrivateEndpointConnection-preview.json
  - Microsoft.Relay/preview/2018-01-01-preview/PrivateLinkResources-preview.json

```

### Tag: schema-relay-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-relay-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Relay/stable/2017-04-01/relay.json

```

### Tag: schema-relay-2016-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-relay-2016-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Relay/stable/2016-07-01/relay.json

```
