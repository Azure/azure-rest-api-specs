## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-servicebus-2018-01-01-preview
  - tag: schema-servicebus-2017-04-01
  - tag: schema-servicebus-2015-08-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-servicebus-2018-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2018-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/preview/2018-01-01-preview/IPFilterRules-preview.json
  - Microsoft.ServiceBus/preview/2018-01-01-preview/namespace-preview.json
  - Microsoft.ServiceBus/preview/2018-01-01-preview/NetworkRuleSet-preview.json
  - Microsoft.ServiceBus/preview/2018-01-01-preview/VirtualNetworkRules-preview.json
  - Microsoft.ServiceBus/preview/2018-01-01-preview/operationlist-preview.json

```

### Tag: schema-servicebus-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/stable/2017-04-01/AuthorizationRules.json
  - Microsoft.ServiceBus/stable/2017-04-01/CheckNameAvailability.json
  - Microsoft.ServiceBus/stable/2017-04-01/DisasterRecoveryConfig.json
  - Microsoft.ServiceBus/stable/2017-04-01/eventhubs.json
  - Microsoft.ServiceBus/stable/2017-04-01/migrate.json
  - Microsoft.ServiceBus/stable/2017-04-01/migrationconfigs.json
  - Microsoft.ServiceBus/stable/2017-04-01/namespaces.json
  - Microsoft.ServiceBus/stable/2017-04-01/networksets.json
  - Microsoft.ServiceBus/stable/2017-04-01/operations.json
  - Microsoft.ServiceBus/stable/2017-04-01/PremiumMessagingRegions.json
  - Microsoft.ServiceBus/stable/2017-04-01/Queue.json
  - Microsoft.ServiceBus/stable/2017-04-01/Rules.json
  - Microsoft.ServiceBus/stable/2017-04-01/sku.json
  - Microsoft.ServiceBus/stable/2017-04-01/subscriptions.json
  - Microsoft.ServiceBus/stable/2017-04-01/topics.json

```

### Tag: schema-servicebus-2015-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-servicebus-2015-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.ServiceBus/stable/2015-08-01/servicebus.json

```
