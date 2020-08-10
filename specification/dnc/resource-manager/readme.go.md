## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: delegatednetwork
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-v2020_08_08-preview
```

### Tag: package-v2020_08_08-preview and go

These settings apply only when `--tag=package-v2020_08_08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-v2020_08_08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/v2020_08_08-preview/$(namespace)
```