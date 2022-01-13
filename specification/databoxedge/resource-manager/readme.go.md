## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: databoxedge
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/databoxedge/armdataboxedge
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'DataBoxEdgeSku'
    to: 'SkuForDataBoxEdge'
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-02-01
  - tag: package-2021-02-01-preview
  - tag: package-2020-12-01
  - tag: package-2020-09-01-preview
  - tag: package-2020-09-01
  - tag: package-2020-05-preview
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-03  
```
### Tag: package-2021-02-01 and go

These settings apply only when `--tag=package-2021-02-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-02-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-02-01/$(namespace)
```

### Tag: package-2021-02-01-preview and go

These settings apply only when `--tag=package-2021-02-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-02-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-02-01-preview/$(namespace)
```

### Tag: package-2020-12-01 and go

These settings apply only when `--tag=package-2020-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-12-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-12-01/$(namespace)
```

### Tag: package-2020-09-01-preview and go

These settings apply only when `--tag=package-2020-09-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-09-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-09-01-preview/$(namespace)

```
### Tag: package-2020-09-01 and go

These settings apply only when `--tag=package-2020-09-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-09-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-09-01/$(namespace)
```

### Tag: package-2020-05-preview and go

These settings apply only when `--tag=package-2020-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-05-01-preview/$(namespace)
```

### Tag: package-2019-08 and go

These settings apply only when `--tag=package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-08-01/$(namespace)
```

### Tag: package-2019-07 and go

These settings apply only when `--tag=package-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-07-01/$(namespace)
```

### Tag: package-2019-03 and go

These settings apply only when `--tag=package-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-03-01/$(namespace)
```