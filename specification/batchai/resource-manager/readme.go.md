## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: batchai
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-09-preview
  - tag: package-2018-03
  - tag: package-2018-05
```

### Tag: package-2017-09-preview and go

These settings apply only when `--tag=package-2017-09-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-09-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-09-01-preview/$(namespace)
```

### Tag: package-2018-03 and go

These settings apply only when `--tag=package-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-03-01/$(namespace)
```

### Tag: package-2018-05 and go

These settings apply only when `--tag=package-2018-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2018-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-05-01/$(namespace)
```