## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-12-20-privatepreview
  - tag: package-2020-10-01-preview
```


### Tag: package-2019-12-20-privatepreview and go

These settings apply only when `--tag=package-2019-12-20-privatepreview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-12-20-privatepreview' && $(go)
namespace: arcvmware
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-12-20-privatepreview/$(namespace)
```

### Tag: package-2020-10-01-preview and go

These settings apply only when `--tag=package-2020-10-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-10-01-preview' && $(go)
namespace: arcvmware
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01-preview/$(namespace)
```
