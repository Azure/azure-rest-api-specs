## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2) && $(package-singleservers)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/postgresql/armpostgresql
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-flexibleservers)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/postgresql/armpostgresqlflexibleservers
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-flexibleserver-2021-06
  - tag: package-flexibleserver-2021-06-preview
  - tag: package-2020-11-05-preview
  - tag: package-2020-02-14-preview
  - tag: package-2020-01-01
  - tag: package-2017-12-01-preview
  - tag: package-2017-12-01
```

### Tag: package-flexibleserver-2021-06 and go

These settings apply only when `--tag=package-flexibleserver-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-06' && $(go)
rpname: postgresql
namespace: postgresqlflexibleservers
output-folder: $(go-sdk-folder)/services/$(rpname)/mgmt/2021-06-01/$(namespace)
```

### Tag: package-flexibleserver-2021-06-preview and go

These settings apply only when `--tag=package-flexibleserver-2021-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-flexibleserver-2021-06-preview' && $(go)
rpname: postgresql
namespace: postgresqlflexibleservers
output-folder: $(go-sdk-folder)/services/preview/$(rpname)/mgmt/2021-06-01-preview/$(namespace)
```

### Tag: package-2020-11-05 and go

These settings apply only when `--tag=package-2020-11-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-11-05-preview' && $(go)
rpname: postgresql
namespace: postgresqlflexibleservers
output-folder: $(go-sdk-folder)/services/preview/$(rpname)/mgmt/2020-11-05-preview/$(namespace)
```

### Tag: package-2020-02-14 and go

These settings apply only when `--tag=package-2020-02-14-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02-14-preview' && $(go)
rpname: postgresql
namespace: postgresqlflexibleservers
output-folder: $(go-sdk-folder)/services/preview/$(rpname)/mgmt/2020-02-14-preview/$(namespace)
```

### Tag: package-2020-01-01 and go

These settings apply only when `--tag=package-2020-01-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-01-01' && $(go)
namespace: postgresql
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-01-01/$(namespace)
```

### Tag: package-2017-12-01-preview and go

These settings apply only when `--tag=package-2017-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(go)
namespace: postgresql
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-12-01-preview/$(namespace)
```

### Tag: package-2017-12-01 and go

These settings apply only when `--tag=package-2017-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(go)
namespace: postgresql
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-12-01/$(namespace)
```