## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2021-01
  - tag: package-2020-10
  - tag: package-2020-03-01-preview
```

### Tag: package-preview-2021-01 and go

These settings apply only when `--tag=package-preview-2021-01 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2021-01' && $(go)
namespace: azurestackhci
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-01-01-preview/$(namespace)
```

### Tag: package-2020-10 and go

These settings apply only when `--tag=package-2020-10 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-10' && $(go)
namespace: azurestackhci
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2020-03-01-preview and go

These settings apply only when `--tag=package-2020-03-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-03-01-preview' && $(go)
namespace: azurestackhci
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-03-01-preview/$(namespace)
```
