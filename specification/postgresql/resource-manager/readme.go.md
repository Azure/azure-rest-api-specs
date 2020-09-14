## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-02-14-privatepreview
  - tag: package-2020-01-01
  - tag: package-2017-12-01-preview
  - tag: package-2017-12-01
```

### Tag: package-2020-02-14 and go

These settings apply only when `--tag=package-2020-02-14-privatepreview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-02-14-privatepreview' && $(go)
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