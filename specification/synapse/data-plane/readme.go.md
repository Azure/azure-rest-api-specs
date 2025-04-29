## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-access-control-2020-08-01-preview
  - tag: package-spark-2019-11-01-preview
  - tag: package-artifacts-2019-06-01-preview
  - tag: package-access-control-2020-02-01-preview
  - tag: package-monitoring-2019-11-01-preview
  - tag: package-vnet-2019-06-01-preview
```

### Tag:  package-spark-2019-11-01-preview and go

These settings apply only when `--tag=package-spark-2019-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-spark-2019-11-01-preview' && $(go)
namespace: spark
output-folder: $(go-sdk-folder)/services/preview/synapse/2019-11-01-preview/$(namespace)
```

### Tag:  package-artifacts-2019-06-01-preview and go

These settings apply only when `--tag=package-artifacts-2019-06-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-artifacts-2019-06-01-preview' && $(go)
namespace: artifacts
output-folder: $(go-sdk-folder)/services/preview/synapse/2019-06-01-preview/$(namespace)
```

### Tag:  package-artifacts-2021-06-01-preview and go

These settings apply only when `--tag=package-artifacts-2021-06-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-artifacts-2021-06-01-preview' && $(go)
namespace: artifacts
output-folder: $(go-sdk-folder)/services/preview/synapse/2021-06-01-preview/$(namespace)
```

### Tag:  package-access-control-2020-02-01-preview and go

These settings apply only when `--tag=package-access-control-2020-02-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-access-control-2020-02-01-preview' && $(go)
namespace: accesscontrol
output-folder: $(go-sdk-folder)/services/preview/synapse/2020-02-01-preview/$(namespace)
```

### Tag:  package-access-control-2020-08-01-preview and go

These settings apply only when `--tag=package-access-control-2020-08-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-access-control-2020-08-01-preview' && $(go)
namespace: accesscontrol
output-folder: $(go-sdk-folder)/services/preview/synapse/2020-08-01-preview/$(namespace)
```

### Tag: package-monitoring-2019-11-01-preview and go

These settings apply only when `--tag=package-monitoring-2019-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-monitoring-2019-11-01-preview' && $(go)
namespace: monitoring
output-folder: $(go-sdk-folder)/services/preview/synapse/2019-11-01-preview/$(namespace)
```

### Tag:  package-vnet-2019-06-01-preview and go

These settings apply only when `--tag=package-vnet-2019-06-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-vnet-2019-06-01-preview' && $(go)
namespace: managedvirtualnetwork
output-folder: $(go-sdk-folder)/services/preview/synapse/2019-06-01-preview/$(namespace)
```
