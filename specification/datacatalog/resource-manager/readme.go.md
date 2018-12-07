## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: datacatalog
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2016-03-30
```

### Tag: package-2016-03-30 and go

These settings apply only when `--tag=package-2016-03-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-03-30' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-30/$(namespace)
```