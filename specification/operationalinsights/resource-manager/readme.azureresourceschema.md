## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-operationalinsights-2020-08-01
  - tag: schema-operationalinsights-2020-10-01-preview
  - tag: schema-operationalinsights-2020-03-01-preview
  - tag: schema-operationalinsights-2019-08-01-preview
  - tag: schema-operationalinsights-2015-11-01-preview
  - tag: schema-operationalinsights-2015-03-20

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-operationalinsights-2020-08-01 and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2020-08-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/stable/2020-08-01/DataExports.json
  - Microsoft.OperationalInsights/stable/2020-08-01/DataSources.json
  - Microsoft.OperationalInsights/stable/2020-08-01/IntelligencePacks.json
  - Microsoft.OperationalInsights/stable/2020-08-01/LinkedServices.json
  - Microsoft.OperationalInsights/stable/2020-08-01/LinkedStorageAccounts.json
  - Microsoft.OperationalInsights/stable/2020-08-01/ManagementGroups.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Operations.json
  - Microsoft.OperationalInsights/stable/2020-08-01/OperationStatuses.json
  - Microsoft.OperationalInsights/stable/2020-08-01/SharedKeys.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Usages.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Workspaces.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Clusters.json
  - Microsoft.OperationalInsights/stable/2020-08-01/StorageInsightConfigs.json
  - Microsoft.OperationalInsights/stable/2020-08-01/SavedSearches.json
  - Microsoft.OperationalInsights/stable/2020-08-01/AvailableServiceTiers.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Gateways.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Schema.json
  - Microsoft.OperationalInsights/stable/2020-08-01/WorkspacePurge.json
  - Microsoft.OperationalInsights/stable/2020-08-01/Tables.json

```

### Tag: schema-operationalinsights-2020-10-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2020-10-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/preview/2020-10-01-preview/Clusters.json

```

### Tag: schema-operationalinsights-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/DataExports.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/DataSources.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/DataCollectorLogs.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/IntelligencePacks.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/LinkedServices.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/LinkedStorageAccounts.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/ManagementGroups.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Operations.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/OperationStatuses.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/SharedKeys.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Usages.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Workspaces.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Clusters.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/StorageInsightConfigs.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/SavedSearches.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/AvailableServiceTiers.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Gateways.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Schema.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/WorkspacePurge.json
  - Microsoft.OperationalInsights/preview/2020-03-01-preview/Tables.json

```

### Tag: schema-operationalinsights-2019-08-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2019-08-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/preview/2019-08-01-preview/Clusters.json
  - Microsoft.OperationalInsights/preview/2019-08-01-preview/LinkedServices.json
  - Microsoft.OperationalInsights/preview/2019-08-01-preview/OperationalInsights.json

```

### Tag: schema-operationalinsights-2015-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2015-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/preview/2015-11-01-preview/LinkedServices.json
  - Microsoft.OperationalInsights/preview/2015-11-01-preview/OperationalInsights.json

```

### Tag: schema-operationalinsights-2015-03-20 and azureresourceschema

``` yaml $(tag) == 'schema-operationalinsights-2015-03-20' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.OperationalInsights/stable/2015-03-20/OperationalInsights.json

```
