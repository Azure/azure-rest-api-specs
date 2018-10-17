## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: reservations
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-06
  - tag: package-2017-11
```

### Tag: package-2018-06 and go

These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-06-01/$(namespace)
```

### Tag: package-2017-11 and go

These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-11-01/$(namespace)
```