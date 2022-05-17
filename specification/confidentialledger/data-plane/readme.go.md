## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: confidentialledger
```

### Tag: package-2022-04-20-preview and go

These settings apply only when `--tag=package-2022-04-20-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-20-04-preview' && $(go)
output-folder: $(go-sdks-folder)/confidentialledger/Generated
```
