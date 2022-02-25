## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/extendedlocation/armextendedlocation
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-03-15-preview
  - tag: package-2021-08-15
  - tag: package-2021-08-31-preview
```

### Tag: package-2021-03-15-preview and go

These settings apply only when `--tag=package-2021-03-15-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-03-15-preview' && $(go)
namespace: extendedlocation
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-15-preview/$(namespace)
```

### Tag: package-2021-08-15 and go

These settings apply only when `--tag=package-2021-08-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-08-15' && $(go)
namespace: extendedlocation
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-08-15/$(namespace)
```

### Tag: package-2021-08-31-preview and go

These settings apply only when `--tag=package-2021-08-31-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-08-31-preview' && $(go)
namespace: extendedlocation
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-08-31-preview/$(namespace)
```