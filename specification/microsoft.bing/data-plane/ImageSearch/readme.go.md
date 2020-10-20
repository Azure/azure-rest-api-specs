## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: imagesearch
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: release_1_0
```

### Tag: release_1_0 and go

These settings apply only when `--tag=release_1_0 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'release_1_0' && $(go)
output-folder: $(go-sdk-folder)/services/bing/v1.0/$(namespace)
```