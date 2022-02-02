## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-03-12-preview
  - tag: package-2021-06-15-preview
```

### Tag: package-2021-03-12-preview and go

These settings apply only when `--tag=package-2021-03-12-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-03-12-preview' && $(go)
namespace: fluidrelay
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-12-preview/$(namespace)
```

### Tag: package-2021-06-15-preview and go

These settings apply only when `--tag=package-2021-06-15-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-06-15-preview' && $(go)
namespace: fluidrelay
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-06-15-preview/$(namespace)
```
