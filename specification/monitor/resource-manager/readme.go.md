## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/monitor/armmonitor
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
  - tag: package-2021-07
  - tag: package-2021-09
  - tag: package-2016-03-preview-monitorlegacy
  - tag: package-2021-05-preview-diagnostics
  - tag: package-2020-10-activityLogs
  - tag: package-2021-05-metrics
  - tag: package-2021-08-scheduledqueryrules
  - tag: package-2022-02-01-preview-only
```

### Tag: package-2017-09 and go

These settings apply only when `--tag=package-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-09' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2017-05-01-preview/$(namespace)
```

### Tag: package-2018-03 and go

These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-03' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-03-01/$(namespace)
```

### Tag: package-2018-09 and go

These settings apply only when `--tag=package-2018-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-09-01/$(namespace)
```

### Tag: package-2018-11-preview and go

These settings apply only when `--tag=package-2018-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11-preview' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2018-11-01-preview/$(namespace)
```

### Tag: package-2019-03 and go

These settings apply only when `--tag=package-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-03' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-03-01/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2019-11 and go

These settings apply only when `--tag=package-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2019-11-01-preview/$(namespace)
```

### Tag: package-2020-10-only and go

These settings apply only when `--tag=package-2020-10-only --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-only' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/monitor/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2021-07 and go

These settings apply only when `--tag=package-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-07' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-07-01-preview/$(namespace)
```

### Tag: package-2021-09 and go

These settings apply only when `--tag=package-2021-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-09' && $(go)
namespace: insights
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-09-01-preview/$(namespace)
```

### Tag: package-2022-02-01-preview-only and go

These settings apply only when `--tag=package-2022-02-01-preview-only --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-02-01-preview-only' && $(go)
namespace: datacollection
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-09-01-preview/$(namespace)
```

### Tag: package-2021-08-scheduledqueryrules and go

These settings apply only when `--tag=package-2021-08-scheduledqueryrules --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-08-scheduledqueryrules' && $(go)
namespace: scheduledqueryrules
output-folder: $(go-sdk-folder)/services/monitor/mgmt/2021-08-01/$(namespace)
```

### Tag: package-2021-05-metrics and go

These settings apply only when `--tag=package-2021-05-metrics --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-05-metrics' && $(go)
namespace: metrics
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-05-01-preview/$(namespace)
```

### Tag: package-2020-10-activityLogs and go

These settings apply only when `--tag=package-2020-10-activityLogs --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-activityLogs' && $(go)
namespace: activitylogs
output-folder: $(go-sdk-folder)/services/monitor/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2021-05-preview-diagnostics and go

These settings apply only when `--tag=package-2021-05-preview-diagnostics --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-05-preview-diagnostics' && $(go)
namespace: diagnostics
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2021-05-01-preview/$(namespace)
```

### Tag: package-2016-03-preview-monitorlegacy and go

These settings apply only when `--tag=package-2016-03-preview-monitorlegacy --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03-preview-monitorlegacy' && $(go)
namespace: monitorlegacy
output-folder: $(go-sdk-folder)/services/preview/monitor/mgmt/2016-03-01-preview/$(namespace)
```
