## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: insights
  clear-output-folder: true
```

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/applicationinsights/armapplicationinsights
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
# Duplicate OperationId Operations_List is detected in Microsoft.Insights/stable/2015-05-01/aiOperations_API.json and Microsoft.Insights/preview/2020-06-02-preview/livetoken_API.json
  from: aiOperations_API.json
  where: $.paths
  transform: delete $["/providers/Microsoft.Insights/operations"]
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-05
  - tag: package-2020-02-02
  - tag: package-2021-11-01
  - tag: package-2022-01-11
  - tag: package-2022-02-01
```

### Tag: package-2015-05 and go

These settings apply only when `--tag=package-2015-05 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2015-05-01/$(namespace)
```

### Tag: package-2020-02-02 and go

These settings apply only when `--tag=package-2020-02-02 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02-02' && $(go)
output-folder: $(go-sdk-folder)/services/appinsights/mgmt/2020-02-02/$(namespace)
```

### Tag: package-2021-11-01 and go

These settings apply only when `--tag=package-2021-11-01 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-11-01' && $(go)
output-folder: $(go-sdk-folder)/services/preview/appinsights/mgmt/2021-11-01-preview/$(namespace)
```

### Tag: package-2022-01-11 and go

These settings apply only when `--tag=package-2022-01-11 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-01-11' && $(go)
output-folder: $(go-sdk-folder)/services/preview/appinsights/mgmt/2022-01-11-preview/$(namespace)
```

### Tag: package-2022-02-01 and go

These settings apply only when `--tag=package-2022-02-01 --go` is specified on he command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-02-01' && $(go)
output-folder: $(go-sdk-folder)/services/preview/appinsights/mgmt/2022-02-01-preview/$(namespace)
```