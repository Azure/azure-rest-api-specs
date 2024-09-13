## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/computefleet/armcomputefleet
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/computefleet/armcomputefleet
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2024-10-01
  - tag: package-2023-06-01-preview
```

### Tag: package-package-2024-10-01 and go

These settings apply only when `--tag=package-package-2024-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2023-02-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2024-10-01/$(namespace)
```

### Tag: package-preview-2024-05 and go

These settings apply only when `--tag=package-2023-06-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2024-05' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/package-preview-2024-05/$(namespace)
```
