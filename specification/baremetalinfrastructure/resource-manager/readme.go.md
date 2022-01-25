## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: baremetalinfrastructure
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/baremetalinfrastructure/armbaremetalinfrastructure
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-08-09
  - tag: package-2020-08-06-preview
```

### Tag: package-2021-08-09 and go

These settings apply only when `--tag=package-2021-08-09 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-08-09' && $(go)
namespace: baremetalinfrastructure
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-08-09/$(namespace)
```

### Tag: package-2020-08-06-preview and go

These settings apply only when `--tag=package-2020-08-06-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-08-06-preview' && $(go)
namespace: baremetalinfrastructure
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-08-06-preview/$(namespace)
```
