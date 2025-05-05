## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/connectedvmware/armconnectedvmware
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-10-01-preview
  - tag: package-2022-01-10-preview
  - tag: package-2022-07-15-preview
```

### Tag: package-2020-10-01-preview and go

These settings apply only when `--tag=package-2020-10-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(go)
namespace: connectedvmware
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01-preview/$(namespace)
```

### Tag: package-2022-01-10-preview and go

These settings apply only when `--tag=package-2022-01-10-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-01-10-preview' && $(go)
namespace: connectedvmware
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-01-10-preview/$(namespace)
```

### Tag: package-2022-07-15-preview and go

These settings apply only when `--tag=package-2022-07-15-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-07-15-preview' && $(go)
namespace: connectedvmware
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-07-15-preview/$(namespace)
```
