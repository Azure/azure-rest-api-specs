## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: scheduler
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2016-03
  - tag: package-2016-01
  - tag: package-2014-08-preview
```

### Tag: package-2016-03 and go

These settings apply only when `--tag=package-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-01/$(namespace)
```

### Tag: package-2016-01 and go

These settings apply only when `--tag=package-2016-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-01-01/$(namespace)
```

### Tag: package-2014-08-preview and go

These settings apply only when `--tag=package-2014-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2014-08-01-preview/$(namespace)
```