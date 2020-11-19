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
  - tag: package-preview-2019-07-19
  - tag: package-preview-2019-04
  - tag: package-2018-06
  - tag: package-2017-11
```

### Tag: package-preview-2019-07-19 and go

These settings apply only when `--tag=package-preview-2019-07-19 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2019-07-19' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-07-19-preview/$(namespace)
```

### Tag: package-preview-2019-04 and go

These settings apply only when `--tag=package-preview-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-preview-2019-04' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-04-01/$(namespace)
```

### Tag: package-2018-06 and go

These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-06' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-01/$(namespace)
```

### Tag: package-2017-11 and go

These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-11-01/$(namespace)
```
