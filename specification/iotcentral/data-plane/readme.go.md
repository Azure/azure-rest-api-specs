## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: iotcentral
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-04-30-preview
```

### Tag: package-2021-04-30-preview and go

These settings apply only when `--tag=package-2021-04-30-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-04-30-preview' && $(go)
output-folder: $(go-sdks-folder)/services/preview/$(namespace)/2021-04-30-preview/$(namespace)
```