## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-eventhub-2018-01-01-preview
  - tag: schema-eventhub-2017-04-01
  - tag: schema-eventhub-2015-08-01
  - tag: schema-eventhub-2014-09-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-eventhub-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-eventhub-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventHub/preview/2018-01-01-preview/AvailableClusterRegions-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/Clusters-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/ipfilterrules-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/namespaces-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/quotaConfiguration-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/virtualnetworkrules-preview.json
  - Microsoft.EventHub/preview/2018-01-01-preview/networkrulessets-preview.json

```

### Tag: schema-eventhub-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventhub-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventHub/stable/2017-04-01/AuthorizationRules.json
  - Microsoft.EventHub/stable/2017-04-01/CheckNameAvailability.json
  - Microsoft.EventHub/stable/2017-04-01/consumergroups.json
  - Microsoft.EventHub/stable/2017-04-01/disasterRecoveryConfigs.json
  - Microsoft.EventHub/stable/2017-04-01/eventhubs.json
  - Microsoft.EventHub/stable/2017-04-01/namespaces.json
  - Microsoft.EventHub/stable/2017-04-01/networkRuleSets.json
  - Microsoft.EventHub/stable/2017-04-01/operations.json
  - Microsoft.EventHub/stable/2017-04-01/sku.json

```

### Tag: schema-eventhub-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventhub-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventHub/stable/2015-08-01/EventHub.json

```

### Tag: schema-eventhub-2014-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-eventhub-2014-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.EventHub/stable/2014-09-01/EventHub.json

```
