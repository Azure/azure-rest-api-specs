## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: servicefabric
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2019-03
  - tag: package-2019-03-preview
  - tag: package-2018-02
  - tag: package-2017-07
  - tag: package-2016-09
```

### Tag: package-2019-03 and go

These settings apply only when `--tag=package-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-03-01/$(namespace)
```

### Tag: package-2019-03-preview and go

These settings apply only when `--tag=package-2019-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-03-01-preview/$(namespace)
```

### Tag: package-2018-02 and go

These settings apply only when `--tag=package-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-02' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-02-01-preview/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-07-01-preview/$(namespace)
```

### Tag: package-2016-09 and go

These settings apply only when `--tag=package-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-09-01/$(namespace)
```