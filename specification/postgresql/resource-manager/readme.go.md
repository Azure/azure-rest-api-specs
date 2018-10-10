## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: postgresql
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-12-01
```

### Tag: package-2017-04-preview and go

These settings apply only when `--tag=package-2017-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/postgresql/mgmt/2017-04-30-preview/postgresql
```

### Tag: package-2017-12-01-preview and go

These settings apply only when `--tag=package-2017-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/postgresql/mgmt/2017-12-01-preview/postgresql
```

### Tag: package-2017-12-01 and go

These settings apply only when `--tag=package-2017-12-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-12-01' && $(go)
output-folder: $(go-sdk-folder)/services/postgresql/mgmt/2017-12-01/postgresql
```