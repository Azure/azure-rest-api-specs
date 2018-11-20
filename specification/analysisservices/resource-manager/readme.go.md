## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: analysisservices
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-08
  - tag: package-2017-07
  - tag: package-2016-05
```

### Tag: package-2017-08 and go

These settings apply only when `--tag=package-2017-08 --go` is specifined on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-08-01/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-07-14/$(namespace)
```

### Tag: package-2016-05 and go

These settings apply only when `--tag=package-2016-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-05-16/$(namespace)
```
