## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: azuredata
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2019-07
```

### Tag: package-preview-2019-07 and go

These settings apply only when `--tag=package-preview-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-07-24-preview/$(namespace)
```