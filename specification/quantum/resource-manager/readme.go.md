## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Tag: package-2019-11-04-preview and go

These settings apply only when `--tag=package-2019-11-04-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-11-04-preview' && $(go)
namespace: Microsoft.Quantum
output-folder: $(go-sdks-folder)/quantum/Generated
```
