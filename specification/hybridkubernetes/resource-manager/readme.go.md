## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/hybridkubernetes/armhybridkubernetes
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-01-01-preview
  - tag: package-2021-04-01-preview
  - tag: package-2021-03-01
  - tag: package-2021-10-01
```

### Tag: package-2020-01-01-preview and go

These settings apply only when `--tag=package-2020-01-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-01-01-preview' && $(go)
namespace: hybridkubernetes
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-01-01-preview/$(namespace)
```
### Tag: package-2021-04-01-preview and go

These settings apply only when `--tag=package-2021-04-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-04-01-preview' && $(go)
namespace: hybridkubernetes
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-04-01-preview/$(namespace)
```
### Tag: package-2021-03-01 and go

These settings apply only when `--tag=package-2021-03-01 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-03-01' && $(go)
namespace: hybridkubernetes
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```
### Tag: package-2021-10-01 and go

These settings apply only when `--tag=package-2021-10-01 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-10-01' && $(go)
namespace: hybridkubernetes
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-10-01/$(namespace)
```