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
  - tag: package-2021-03-15-preview
  - tag: package-2020-07-15-privatepreview
```

### Tag: package-2020-07-15-privatepreview and go

These settings apply only when `--tag=package-2020-07-15-privatepreview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-07-15-privatepreview' && $(go)
namespace: extendedlocation
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-07-15-privatepreview/$(namespace)
```

### Tag: package-2021-03-15-preview and go

These settings apply only when `--tag=package-2021-03-15-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-03-15-preview' && $(go)
namespace: extendedlocation
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-15-preview/$(namespace)
```
