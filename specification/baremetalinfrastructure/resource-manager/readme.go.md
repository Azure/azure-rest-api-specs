## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

### Tag: package-2020-08-06-preview and go

These settings apply only when `--tag=package-2020-08-06-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-08-06-preview' && $(go)
namespace: baremetalinfrastructure
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-08-06-preview/$(namespace)
```
