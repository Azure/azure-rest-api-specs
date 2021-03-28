## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: videoanalyzer
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-1.0.0-preview
```

### Tag: package-1.0.0-preview and go

These settings apply only when `--tag=package-1.0.0-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-1.0.0-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/1.0.0/$(namespace)
```
