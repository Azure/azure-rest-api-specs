## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: policyinsights
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-07
  - tag: package-2018-04
  - tag: package-2017-12
  - tag: package-2017-10
  - tag: package-2017-08
```
### Tag: package-2018-07 and go

These settings apply only when `--tag=package-2018-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-07-01-preview/$(namespace)
```

### Tag: package-2018-04 and go

These settings apply only when `--tag=package-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-04-04/$(namespace)
```

### Tag: package-2017-12 and go

These settings apply only when `--tag=package-2017-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-12-12-preview/$(namespace)
```

### Tag: package-2017-10 and go

These settings apply only when `--tag=package-2017-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-10-17-preview/$(namespace)
```

### Tag: package-2017-08 and go

These settings apply only when `--tag=package-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-08-09-preview/$(namespace)
```
