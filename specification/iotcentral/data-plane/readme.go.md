## Go

These settings apply only when `--go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: iotcentral
  clear-output-folder: true
  output-folder: $(go-sdks-folder)/services/preview/$(namespace)/1.1-preview/$(namespace)
```