## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: documentdb
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/cosmos/armcosmos
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-07-preview
  - tag: package-2021-06
  - tag: package-2021-05
  - tag: package-2021-04
  - tag: package-2021-04-preview
  - tag: package-2021-03
  - tag: package-2021-03-preview
  - tag: package-2021-01
  - tag: package-2020-09
  - tag: package-2020-06-preview
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-08
  - tag: package-2019-08-preview
  - tag: package-2015-04
```

### Tag: package-2021-07-preview and go

These settings apply only when `--tag=package-2021-07-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-07-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2021-07-01-preview/$(namespace)
```

### Tag: package-2021-06 and go

These settings apply only when `--tag=package-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-06' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2021-06-15/$(namespace)
```

### Tag: package-2021-05 and go

These settings apply only when `--tag=package-2021-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-05' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2021-05-15/$(namespace)
```

### Tag: package-2021-04 and go

These settings apply only when `--tag=package-2021-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-04' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2021-04-15/$(namespace)
```

### Tag: package-2021-04-preview and go

These settings apply only when `--tag=package-2021-04-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-04-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2021-04-01-preview/$(namespace)
```

### Tag: package-2021-03 and go

These settings apply only when `--tag=package-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2021-03-15/$(namespace)
```

### Tag: package-2021-03-preview and go

These settings apply only when `--tag=package-2021-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2021-03-01-preview/$(namespace)
```

### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01' && $(go)
output-folder: $(go-sdk-folder)/services/cosmos-db/mgmt/2021-01-15/$(namespace)
```

### Tag: package-2020-09 and go

These settings apply only when `--tag=package-2020-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2020-09-01-preview/$(namespace)
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
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2020-04-01-preview/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2020-03-01-preview/$(namespace)
```

### Tag: package-2019-12 and go

These settings apply only when `--tag=package-2019-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-12' && $(go)
output-folder: $(go-sdk-folder)/services/preview/cosmos-db/mgmt/2019-12-12-preview/$(namespace)
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
