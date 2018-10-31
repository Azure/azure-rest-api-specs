## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: subscription
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-03-preview
  - tag: package-2017-11-preview
```

### Tag: package-2018-03-preview and go

These settings apply only when `--tag=package-2018-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-03-01-preview/$(namespace)
```

### Tag: package-2017-11-preview and go

These settings apply only when `--tag=package-2017-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-11-01-preview/$(namespace)
```