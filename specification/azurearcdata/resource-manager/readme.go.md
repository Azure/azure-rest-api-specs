## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: azurearcdata
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2020-09-08
```

### Tag: package-preview-2020-09-08 and go

These settings apply only when `--tag=package-preview-2020-09-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2020-09-08' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/package-preview-2020-09-08/$(namespace)
```