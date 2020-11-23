## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: providerhub
  clear-output-folder: true
```

### Tag: package-2020-11-20 and go

These settings apply only when `--tag=package-2020-11-20 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-11-20' && $(go)
output-folder: $(go-sdks-folder)/$(namespace)/Generated
```
