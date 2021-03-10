## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: kubernetesconfiguration
  clear-output-folder: true
```

### Go multi-api 

``` yaml $(go) && $(multiapi) 
batch: 
  - tag: package-source-control-configurations-2021-03
  - tag: package-source-control-configurations-preview-2020-10
  - tag: package-source-control-configurations-preview-2020-07
  - tag: package-source-control-configurations-preview-2019-11
  - tag: package-extensions-preview-2020-07
``` 

### Tag: package-source-control-configurations-2021-03 and go

These settings apply only when `--tag=package-source-control-configurations-2021-03 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-source-control-configurations-2021-03' && $(go)
namespace: source-control-configurations
output-folder: $(go-sdk-folder)/services/kubernetesconfiguration/mgmt/2021-03-01/$(namespace)
```

### Tag: package-source-control-configurations-preview-2020-10 and go

These settings apply only when `--tag=package-source-control-configurations-preview-2020-10 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-source-control-configurations-preview-2020-10' && $(go)
namespace: source-control-configurations
output-folder: $(go-sdk-folder)/services/kubernetesconfiguration/mgmt/2020-10-01-preview/$(namespace)
```

### Tag: package-source-control-configurations-preview-2020-07 and go

These settings apply only when `--tag=package-source-control-configurations-preview-2020-07 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-source-control-configurations-preview-2020-07' && $(go)
namespace: source-control-configurations
output-folder: $(go-sdk-folder)/services/kubernetesconfiguration/mgmt/2020-07-01-preview/$(namespace)
```

### Tag: package-source-control-configurations-preview-2019-11 and go

These settings apply only when `--tag=package-source-control-configurations-preview-2019-11 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-source-control-configurations-preview-2019-11' && $(go)
namespace: source-control-configurations
output-folder: $(go-sdk-folder)/services/kubernetesconfiguration/mgmt/2019-11-01-preview/$(namespace)
```

### Tag: package-extensions-preview-2020-07 and go

These settings apply only when `--tag=package-extensions-preview-2020-07 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-extensions-preview-2020-07' && $(go)
namespace: extensions
output-folder: $(go-sdk-folder)/services/kubernetesconfiguration/mgmt/2020-07-01-preview/$(namespace)
```
