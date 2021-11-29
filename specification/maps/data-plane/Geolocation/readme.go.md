## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
license-header: MICROSOFT_MIT_NO_VERSION
namespace: geolocation
clear-output-folder: true
export-clients: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: 1.0-preview
```

### Tag: 1.0-preview and go

These settings apply only when `--tag=1.0-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '1.0-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/maps/1.0/$(namespace)
```