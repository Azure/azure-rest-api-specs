## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: storagecache
  clear-output-folder: true
```

### Tag: package-package-2019-08 and go

These settings apply only when `--tag=package-package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-package-2019-08' && $(go)
output-folder: $(go-sdks-folder)/services/preview/$(namespace)/mgmt/2019-08/$(namespace)
```
