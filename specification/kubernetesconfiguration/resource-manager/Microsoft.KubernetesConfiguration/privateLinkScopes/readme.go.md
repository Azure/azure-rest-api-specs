## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: kubernetesconfiguration
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/kubernetesconfiguration/armprivatelinkscopes
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Tag: package-preview-2024-11 and go

These settings apply only when `--tag=package-preview-2024-11 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2024-11' && $(go)
namespace: kubernetesconfigurationpls
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2024-11-01-preview/$(namespace)
```