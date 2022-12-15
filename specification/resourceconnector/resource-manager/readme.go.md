## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resourceconnector/armresourceconnector
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-10-27 
```

### Tag: package-2021-10-31-preview and go

These settings apply only when `--tag=package-2021-10-31-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-10-31-preview' && $(go)
namespace: resourceconnector
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-10-31-preview/$(namespace)
```

### Tag: package-2022-04-15-preview and go

These settings apply only when `--tag=package-2022-04-15-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-04-15-preview' && $(go)
namespace: resourceconnector
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-04-15-preview/$(namespace)
```

### Tag: package-2022-10-27 and go

These settings apply only when `--tag=package-2022-10-27 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-10-27' && $(go)
namespace: resourceconnector
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-10-27/$(namespace)
```