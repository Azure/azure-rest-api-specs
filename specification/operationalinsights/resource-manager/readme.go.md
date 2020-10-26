## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: operationalinsights
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2015-03
  - tag: package-2015-11-preview
  - tag: package-2020-03-preview
  - tag: package-2020-10
  - tag: package-2020-08
```

### Tag: package-2015-03 and go

These settings apply only when `--tag=package-2015-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-03-20/$(namespace)
```

### Tag: package-2015-11-preview and go

These settings apply only when `--tag=package-2015-11-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-11-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-11-01-preview/$(namespace)
```

### Tag: package-2020-03-preview and go

These settings apply only when `--tag=package-2020-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-03-01-preview/$(namespace)
```

### Tag: package-2020-10 and go

These settings apply only when `--tag=package-2020-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2020-08 and go

These settings apply only when `--tag=package-2020-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-08-01/$(namespace)
```
