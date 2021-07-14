## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/monitor/armmonitor
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true

directive:
  - from: scheduledQueryRule_API.json # this is to resolve the duplicated schema issue in this swagger
    where: "$.definitions.Resource"
    transform: >
      $["x-ms-client-name"] = "TrackedEntityResource";
      
modelerfour:
  lenient-model-deduplication: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-09
  - tag: package-2018-03
  - tag: package-2018-09
  - tag: package-2018-11-preview
  - tag: package-2019-03
  - tag: package-2019-06
  - tag: package-2019-11
  - tag: package-2020-10-only
  - tag: package-2021-04
```

### Tag: package-2017-09 and go

These settings apply only when `--tag=package-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-09' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2017-05-01-preview/$(namespace)
```

### Tag: package-2018-03 and go

These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-03-01/$(namespace)
```

### Tag: package-2018-09 and go

These settings apply only when `--tag=package-2018-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-09-01/$(namespace)
```

### Tag: package-2018-11-preview and go

These settings apply only when `--tag=package-2018-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-11-01-preview/$(namespace)
```

### Tag: package-2019-03 and go

These settings apply only when `--tag=package-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-03-01/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2019-11 and go

These settings apply only when `--tag=package-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-11-01-preview/$(namespace)
```

### Tag: package-2020-10-only and go

These settings apply only when `--tag=package-2020-10-only --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-only' && $(go)
output-folder: $(go-sdk-folder)/services/monitor/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2021-04 and go

These settings apply only when `--tag=package-2021-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-04' && $(go)
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-04-01-preview/$(namespace)
directive:
- from: activityLogAlerts_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: guestDiagnosticSettings_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: guestDiagnosticSettingsAssociation_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: privateLinkScopes_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: scheduledQueryRule_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: autoscale_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: alertRules_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: alertRulesIncidents_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: actionGroups_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
- from: metricAlert_API.json
  where: $.parameters
  transform: delete $["ResourceGroupNameParameter"]
  reason: ResourceGroupNameParameter is taken from v2/types.json
```