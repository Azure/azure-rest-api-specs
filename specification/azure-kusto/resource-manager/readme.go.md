## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: kusto
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-09-07-preview
  - tag: package-2019-01-21
  - tag: package-2019-05-15
  - tag: package-2019-09-07
  - tag: package-2019-11-09
```

### Tag: package-2018-09-07-preview and go

These settings apply only when `--tag=package-2018-09-07-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-09-07-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-09-07-preview/$(namespace)
```

### Tag: package-2019-01-21 and go

These settings apply only when `--tag=package-2019-01-21 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01-21' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-01-21/$(namespace)
```

### Tag: package-2019-05-15 and go

These settings apply only when `--tag=package-2019-05-15 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-05-15' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-05-15/$(namespace)
```

### Tag: package-2019-09-07 and go

These settings apply only when `--tag=package-2019-09-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-07/$(namespace)
```

### Tag: package-2019-11-09 and go

These settings apply only when `--tag=package-2019-11-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-09/$(namespace)
```
