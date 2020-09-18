## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: dtl
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09
  - tag: package-2016-05
  - tag: package-2015-05-preview
```

### Tag: package-2018-09 and go

These settings apply only when `--tag=package-2018-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09' && $(go)
output-folder: $(go-sdk-folder)/services/devtestlabs/mgmt/2018-09-15/$(namespace)
```

### Tag: package-2016-05 and go

These settings apply only when `--tag=package-2016-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-05' && $(go)
output-folder: $(go-sdk-folder)/services/devtestlabs/mgmt/2016-05-15/$(namespace)
```

### Tag: package-2015-05-preview and go

These settings apply only when `--tag=package-2015-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/devtestlabs/mgmt/2015-05-21-preview/$(namespace)
```
