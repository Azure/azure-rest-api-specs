## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-2020-01-01-preview and go

These settings apply only when `--tag=package-2020-01-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-01-01-preview' && $(go)
namespace: Microsoft.HybridNetwork
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/management/2020-01-01-preview/$(namespace)
```