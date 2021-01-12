## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: healthcareapis
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-03-30
  - tag: package-2020-03
  - tag: package-2019-09
  - tag: package-2018-08-preview
```

### Tag: package-2020-03-30 and go

These settings apply only when `--tag=package-2020-03-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-30' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-30/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-15/$(namespace)
```

### Tag: package-2019-09 and go

These settings apply only when `--tag=package-2019-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-16/$(namespace)
```

### Tag: package-2018-08-preview and go

These settings apply only when `--tag=package-2018-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-08-20-preview/$(namespace)
```