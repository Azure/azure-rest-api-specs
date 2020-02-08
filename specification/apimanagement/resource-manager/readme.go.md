## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: apimanagement
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2019-12
  - tag: package-2019-01
  - tag: package-2018-06-preview
  - tag: package-2018-01
  - tag: package-2017-03
  - tag: package-2016-10
  - tag: package-2016-07
```

### Tag: package-preview-2019-12 and go

These settings apply only when `--tag=package-preview-2019-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2019-12' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-12-01-preview/$(namespace)
```

### Tag: package-2019-01 and go

These settings apply only when `--tag=package-2019-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-01-01/$(namespace)
```

### Tag: package-2018-06-preview and go

These settings apply only when `--tag=package-2018-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-06-01-preview/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-01-01/$(namespace)
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-03-01/$(namespace)
```

### Tag: package-2016-10 and go

These settings apply only when `--tag=package-2016-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-10-10/$(namespace)
```

### Tag: package-2016-07 and go

These settings apply only when `--tag=package-2016-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-07-07/$(namespace)
```