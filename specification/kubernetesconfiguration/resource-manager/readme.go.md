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
module-name: sdk/resourcemanager/kubernetesconfiguration/armkubernetesconfiguration
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api 

``` yaml $(go) && $(multiapi) 
batch: 
  - tag: package-2022-03
  - tag: package-preview-2022-01
  - tag: package-preview-2021-11
  - tag: package-2021-09
  - tag: package-preview-2021-05
  - tag: package-2021-03
  - tag: package-preview-2020-10
  - tag: package-2020-07-01-preview
  - tag: package-2019-11-01-preview 
``` 

### Tag: package-2022-03 and go

These settings apply only when `--tag=package-2022-03 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-03' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-03-01/$(namespace)
```

### Tag: package-preview-2022-01 and go

These settings apply only when `--tag=package-preview-2022-01 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2022-01' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-01-01-preview/$(namespace)
```

### Tag: package-preview-2021-11 and go

These settings apply only when `--tag=package-preview-2021-11 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2021-11' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-11-01-preview/$(namespace)
```

### Tag: package-2021-09 and go

These settings apply only when `--tag=package-2021-09 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-09' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-09-01/$(namespace)
```

### Tag: package-preview-2021-05 and go

These settings apply only when `--tag=package-preview-2021-05 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2021-05' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-05-01-preview/$(namespace)
```

### Tag: package-2021-03 and go

These settings apply only when `--tag=package-2021-03 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-03' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-preview-2020-10 and go
These settings apply only when `--tag=package-preview-2020-10 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.
```yaml $(tag) == 'package-preview-2020-10' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01-preview/$(namespace)
```

### Tag: package-2020-07-01-preview and go
These settings apply only when `--tag=package-2020-07-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.
```yaml $(tag) == 'package-2020-07-01-preview' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-07-01-preview/$(namespace)
```

### Tag: package-2019-11-01-preview and go

These settings apply only when `--tag=package-2019-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-11-01-preview' && $(go)
namespace: kubernetesconfiguration
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-11-01-preview/$(namespace)
```