## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: digitaltwins
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-12
  - tag: package-2020-10
  - tag: package-2020-03-01-preview
```

### Tag: package-2020-12 and go

These settings apply only when `--tag=package-2020-12 --go` is specified on the command line.
Please also specify `--go-sdks-folder=digitaltwins`.

```yaml $(tag) == 'package-2020-12' && $(go)
namespace: digitaltwins
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-12-01/$(namespace)
```

### Tag: package-2020-10 and go

These settings apply only when `--tag=package-2020-10 --go` is specified on the command line.
Please also specify `--go-sdks-folder=digitaltwins`.

```yaml $(tag) == 'package-2020-10' && $(go)
namespace: digitaltwins
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-31/$(namespace)
```

### Tag: package-2020-03-01-preview and go

These settings apply only when `--tag=package-2020-03-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=digitaltwins`.

```yaml $(tag) == 'package-2020-03-01-preview' && $(go)
namespace: digitaltwins
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-03-01-preview/$(namespace)
```
