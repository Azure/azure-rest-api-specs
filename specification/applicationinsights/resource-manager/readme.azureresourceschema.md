## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-insights-2020-06-02-preview
  - tag: schema-insights-2020-03-01-preview
  - tag: schema-insights-2020-02-10-preview
  - tag: schema-insights-2020-02-02-preview
  - tag: schema-insights-2019-10-17-preview
  - tag: schema-insights-2019-09-01-preview
  - tag: schema-insights-2018-06-17-preview
  - tag: schema-insights-2018-05-01-preview
  - tag: schema-insights-2017-10-01
  - tag: schema-insights-2015-05-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-insights-2020-06-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-06-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json

```

### Tag: schema-insights-2020-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-03-01-preview/componentLinkedStorageAccounts_API.json

```

### Tag: schema-insights-2020-02-10-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-02-10-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-02-10-preview/WebTestResults_API.json

```

### Tag: schema-insights-2020-02-02-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-02-02-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-02-02-preview/components_API.json

```

### Tag: schema-insights-2019-10-17-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-10-17-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2019-10-17-preview/workbookTemplates_API.json

```

### Tag: schema-insights-2019-09-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-09-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2019-09-01-preview/QueryPackQueries_API.json
  - Microsoft.Insights/preview/2019-09-01-preview/QueryPacks_API.json

```

### Tag: schema-insights-2018-06-17-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-06-17-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2018-06-17-preview/workbooks_API.json

```

### Tag: schema-insights-2018-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2018-05-01-preview/components_API.json
  - Microsoft.Insights/preview/2018-05-01-preview/componentProactiveDetection_API.json

```

### Tag: schema-insights-2017-10-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-10-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2017-10-01/eaSubscriptionMigration_API.json
  - Microsoft.Insights/preview/2017-10-01/componentFeaturesAndPricing_API.json

```

### Tag: schema-insights-2015-05-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2015-05-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2015-05-01/aiOperations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentAnnotations_API.json
  - Microsoft.Insights/stable/2015-05-01/componentApiKeys_API.json
  - Microsoft.Insights/stable/2015-05-01/componentContinuousExport_API.json
  - Microsoft.Insights/stable/2015-05-01/componentFeaturesAndPricing_API.json
  - Microsoft.Insights/stable/2015-05-01/componentProactiveDetection_API.json
  - Microsoft.Insights/stable/2015-05-01/componentWorkItemConfigs_API.json
  - Microsoft.Insights/stable/2015-05-01/favorites_API.json
  - Microsoft.Insights/stable/2015-05-01/webTestLocations_API.json
  - Microsoft.Insights/stable/2015-05-01/webTests_API.json
  - Microsoft.Insights/stable/2015-05-01/analyticsItems_API.json
  - Microsoft.Insights/stable/2015-05-01/workbooks_API.json
  - Microsoft.Insights/stable/2015-05-01/myworkbooks_API.json
  - Microsoft.Insights/stable/2015-05-01/components_API.json

```
