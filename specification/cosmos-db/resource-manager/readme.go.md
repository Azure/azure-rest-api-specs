## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: documentdb
  clear-output-folder: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-06-preview
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-08
  - tag: package-2019-08-preview
  - tag: package-2015-04
```
### Tag: package-2020-06-preview and go

These settings apply only when `--tag=package-2020-06-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-06-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2020-06-01-preview/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2020-04-01/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2019-12 and go

These settings apply only when `--tag=package-2019-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-12' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2019-12-12/$(namespace)
```

### Tag: package-2019-08 and go

These settings apply only when `--tag=package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-08' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2019-08-01/$(namespace)
```

### Tag: package-2019-08-preview and go

These settings apply only when `--tag=package-2019-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2019-08-01-preview/$(namespace)
```

### Tag: package-2015-04 and go

These settings apply only when `--tag=package-2015-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-04' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2015-04-08/$(namespace)
```

### Tag: package-2014-04 and go

These settings apply only when `--tag=package-2014-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2014-04' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2014-04/$(namespace)
```

### Tag: package-2015-11 and go

These settings apply only when `--tag=package-2015-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-11' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2015-11-06/$(namespace)
```

### Tag: package-2016-03-19 and go

These settings apply only when `--tag=package-2016-03-19 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03-19' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2016-03-19/$(namespace)
```

### Tag: package-2016-03-31 and go

These settings apply only when `--tag=package-2016-03-31 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03-31' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2016-03-31/$(namespace)
```
