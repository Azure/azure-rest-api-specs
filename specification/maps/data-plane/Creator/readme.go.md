## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
license-header: MICROSOFT_MIT_NO_VERSION
namespace: creator
clear-output-folder: true
export-clients: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: 2.0-preview
```

### Tag: 2.0-preview and go

These settings apply only when `--tag=2.0-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == '2.0-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/maps/2.0/$(namespace)
```