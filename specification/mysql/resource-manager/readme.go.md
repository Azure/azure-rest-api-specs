## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-flexibleserver-2021-05-01-preview
  - tag: package-2020-07-01-preview
  - tag: package-2020-01-01
  - tag: package-2017-12-01-preview
  - tag: package-2017-12-01
```

### Tag: package-flexibleserver-2021-05-01-preview and go

These settings apply only when `--tag=package-flexibleserver-2021-05-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-05-01-preview' && $(go)
rpname: mysql
namespace: mysqlflexibleservers
output-folder: $(go-sdk-folder)/services/preview/$(rpname)/mgmt/2021-05-01-preview/$(namespace)
```

### Tag: package-2020-07-01-preview and go

These settings apply only when `--tag=package-2020-07-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-07-01-preview' && $(go)
rpname: mysql
namespace: mysqlflexibleservers
output-folder: $(go-sdk-folder)/services/preview/$(rpname)/mgmt/2020-07-01-preview/$(namespace)
```

### Tag: package-2020-01-01 and go

These settings apply only when `--tag=package-2020-01-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(go)
namespace: mysql
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-01-01/$(namespace)
```

### Tag: package-2017-12-01-preview and go

These settings apply only when `--tag=package-2017-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(go)
namespace: mysql
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-12-01-preview/$(namespace)
```

### Tag: package-2017-12-01 and go

These settings apply only when `--tag=package-2017-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(go)
namespace: mysql
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-12-01/$(namespace)
```