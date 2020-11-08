## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-insights-2020-05-01-preview
  - tag: schema-insights-2020-01-01-preview
  - tag: schema-insights-2019-11-01-preview
  - tag: schema-insights-2019-10-17-preview
  - tag: schema-insights-2019-06-01
  - tag: schema-insights-2019-03-01
  - tag: schema-insights-2018-11-27-preview
  - tag: schema-insights-2018-09-01
  - tag: schema-insights-2018-06-01-preview
  - tag: schema-insights-2018-04-16
  - tag: schema-insights-2018-03-01
  - tag: schema-insights-2018-01-01
  - tag: schema-insights-2017-12-01-preview
  - tag: schema-insights-2017-11-01-preview
  - tag: schema-insights-2017-05-01-preview
  - tag: schema-insights-2017-04-01
  - tag: schema-insights-2017-03-01-preview
  - tag: schema-insights-2016-09-01
  - tag: schema-insights-2016-03-01
  - tag: schema-insights-2015-07-01
  - tag: schema-insights-2015-04-01

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-insights-2020-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-05-01-preview/scheduledQueryRule_API.json

```

### Tag: schema-insights-2020-01-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2020-01-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2020-01-01-preview/managementGroupDiagnosticSettings_API.json

```

### Tag: schema-insights-2019-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2019-11-01-preview/dataCollectionRuleAssociations_API.json
  - Microsoft.Insights/preview/2019-11-01-preview/dataCollectionRules_API.json

```

### Tag: schema-insights-2019-10-17-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-10-17-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2019-10-17-preview/privateLinkScopes_API.json

```

### Tag: schema-insights-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2019-06-01/actionGroups_API.json

```

### Tag: schema-insights-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2019-03-01/metricBaselines_API.json
  - Microsoft.Insights/stable/2019-03-01/actionGroups_API.json

```

### Tag: schema-insights-2018-11-27-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-11-27-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2018-11-27-preview/vmInsightsOnboarding_API.json

```

### Tag: schema-insights-2018-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2018-09-01/actionGroups_API.json
  - Microsoft.Insights/stable/2018-09-01/baseline_API.json
  - Microsoft.Insights/stable/2018-09-01/calculateBaseline_API.json

```

### Tag: schema-insights-2018-06-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-06-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2018-06-01-preview/guestDiagnosticSettingsAssociation_API.json
  - Microsoft.Insights/preview/2018-06-01-preview/guestDiagnosticSettings_API.json

```

### Tag: schema-insights-2018-04-16 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-04-16' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2018-04-16/scheduledQueryRule_API.json

```

### Tag: schema-insights-2018-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2018-03-01/metricAlert_API.json
  - Microsoft.Insights/stable/2018-03-01/actionGroups_API.json

```

### Tag: schema-insights-2018-01-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2018-01-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2018-01-01/metricDefinitions_API.json
  - Microsoft.Insights/stable/2018-01-01/metrics_API.json

```

### Tag: schema-insights-2017-12-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-12-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2017-12-01-preview/metricNamespaces_API.json

```

### Tag: schema-insights-2017-11-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-11-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2017-11-01-preview/baseline_API.json
  - Microsoft.Insights/preview/2017-11-01-preview/calculateBaseline_API.json

```

### Tag: schema-insights-2017-05-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-05-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2017-05-01-preview/diagnosticsSettings_API.json
  - Microsoft.Insights/preview/2017-05-01-preview/diagnosticsSettingsCategories_API.json
  - Microsoft.Insights/preview/2017-05-01-preview/subscriptionDiagnosticsSettings_API.json
  - Microsoft.Insights/preview/2017-05-01-preview/metricDefinitions_API.json
  - Microsoft.Insights/preview/2017-05-01-preview/metrics_API.json

```

### Tag: schema-insights-2017-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2017-04-01/activityLogAlerts_API.json
  - Microsoft.Insights/stable/2017-04-01/actionGroups_API.json

```

### Tag: schema-insights-2017-03-01-preview and azureresourceschema

``` yaml $(tag) == 'schema-insights-2017-03-01-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/preview/2017-03-01-preview/activityLogAlerts_API.json

```

### Tag: schema-insights-2016-09-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2016-09-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2016-09-01/metrics_API.json
  - Microsoft.Insights/stable/2016-09-01/serviceDiagnosticsSettings_API.json

```

### Tag: schema-insights-2016-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2016-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2016-03-01/alertRulesIncidents_API.json
  - Microsoft.Insights/stable/2016-03-01/alertRules_API.json
  - Microsoft.Insights/stable/2016-03-01/logProfiles_API.json
  - Microsoft.Insights/stable/2016-03-01/metricDefinitions_API.json

```

### Tag: schema-insights-2015-07-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2015-07-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2015-07-01/serviceDiagnosticsSettings_API.json

```

### Tag: schema-insights-2015-04-01 and azureresourceschema

``` yaml $(tag) == 'schema-insights-2015-04-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.Insights/stable/2015-04-01/autoscale_API.json
  - Microsoft.Insights/stable/2015-04-01/operations_API.json
  - Microsoft.Insights/stable/2015-04-01/activityLogs_API.json
  - Microsoft.Insights/stable/2015-04-01/eventCategories_API.json
  - Microsoft.Insights/stable/2015-04-01/tenantActivityLogs_API.json

```
