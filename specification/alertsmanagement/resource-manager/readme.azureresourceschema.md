## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-alertsmanagement-2020-08-04-preview
  - tag: schema-alertsmanagement-2019-06-01
  - tag: schema-alertsmanagement-2019-05-05-preview
  - tag: schema-alertsmanagement-2019-03-01
  - tag: schema-alertsmanagement-2018-05-05-preview
  - tag: schema-alertsmanagement-2018-05-05

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-alertsmanagement-2020-08-04-preview and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2020-08-04-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/preview/2020-08-04-preview/AlertsManagement.json

```

### Tag: schema-alertsmanagement-2019-06-01 and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2019-06-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/stable/2019-06-01/SmartDetectorAlertRulesApi.json

```

### Tag: schema-alertsmanagement-2019-05-05-preview and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2019-05-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/ActionRules.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/AlertsManagement.json
  - Microsoft.AlertsManagement/preview/2019-05-05-preview/SmartGroups.json

```

### Tag: schema-alertsmanagement-2019-03-01 and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2019-03-01' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/stable/2019-03-01/AlertsManagement.json
  - Microsoft.AlertsManagement/stable/2019-03-01/SmartDetectorAlertRulesApi.json

```

### Tag: schema-alertsmanagement-2018-05-05-preview and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2018-05-05-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/preview/2018-05-05-preview/AlertsManagement.json

```

### Tag: schema-alertsmanagement-2018-05-05 and azureresourceschema

``` yaml $(tag) == 'schema-alertsmanagement-2018-05-05' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.AlertsManagement/stable/2018-05-05/AlertsManagement.json

```
