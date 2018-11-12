## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: timeseriesinsights
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-11-15
  - tag: package-2017-02-preview
```

### Tag: package-2017-11-15 and go

These settings apply only when `--tag=package-2017-11-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11-15' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-11-15/$(namespace)
```

### Tag: package-2017-02-preview and go

These settings apply only when `--tag=package-2017-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-02-28-preview/$(namespace)
```