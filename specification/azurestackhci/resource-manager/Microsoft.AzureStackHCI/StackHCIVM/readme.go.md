## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  module-name: sdk/resourcemanager/azuresatckhci/armazurestackhci
  module: github.com/Azure/azure-sdk-for-go/$(module-name)
  output-folder: $(go-sdk-folder)/$(module-name)
  azure-arm: true
  package-name: armstackhcivm
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-11-01-preview
  - tag: package-preview-2021-01
```

### Tag: package-preview-2021-01 and go

These settings apply only when `--tag=package-preview-2021-01 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2021-01' && $(go)
namespace: azurestackhci
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-01-01-preview/$(namespace)
```

### Tag: package-2020-11-01-preview and go

These settings apply only when `--tag=package-2020-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-11-01-preview' && $(go)
namespace: azurestackhci
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-11-01-preview/$(namespace)
```
