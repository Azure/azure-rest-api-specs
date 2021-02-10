## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: support
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-04
  - tag: package-2019-05-preview
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/support/mgmt/2020-04-01/support
```

### Tag: package-2019-05-preview and go

These settings apply only when `--tag=package-2019-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/support/mgmt/2019-05-01-preview/support
```
