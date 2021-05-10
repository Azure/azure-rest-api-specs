## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: azmaps
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-1.0-preview
  - tag: package-preview-2.0
```

### Tag: package-preview-2.0 and go

These settings apply only when `--tag=package-preview-2.0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2.0' && $(go)
output-folder: $(go-sdk-folder)/services/preview/maps/2.0/$(namespace)
```

### Tag: package-1.0-preview and go

These settings apply only when `--tag=package-1.0-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-1.0-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/maps/1.0/$(namespace)
```