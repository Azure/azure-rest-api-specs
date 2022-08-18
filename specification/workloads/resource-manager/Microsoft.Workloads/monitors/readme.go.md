## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: workloads
  clear-output-folder: true
```

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/workloads/armmonitors
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2022-10
```

### Tag: package-preview-2022-10 and go

These settings apply only when `--tag=package-preview-2022-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2022-10' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-10-01-preview/armmonitors
```