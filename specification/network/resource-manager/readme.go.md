## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: network
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/network/armnetwork
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-08
  - tag: package-2021-05
  - tag: package-2021-03
  - tag: package-2021-02-preview
  - tag: package-2021-03-preview
  - tag: package-2021-02
  - tag: package-2020-11
  - tag: package-2020-08
  - tag: package-2020-07
  - tag: package-2020-06
  - tag: package-2020-05
  - tag: package-2020-04
  - tag: package-2020-03
  - tag: package-2019-12
  - tag: package-2019-11
  - tag: package-2019-09
  - tag: package-2019-08
  - tag: package-2019-07
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2019-02
  - tag: package-2018-12
  - tag: package-2018-11
  - tag: package-2018-10
  - tag: package-2018-08
  - tag: package-2018-07
  - tag: package-2018-06
  - tag: package-2018-04
  - tag: package-2018-02
  - tag: package-2018-01
  - tag: package-2017-11
  - tag: package-2017-10
  - tag: package-2015-06split
```

### Tag: package-2021-08 and go

These settings apply only when `--tag=package-2021-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-08-01/$(namespace)
```

### Tag: package-2021-05 and go

These settings apply only when `--tag=package-2021-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-05-01/$(namespace)
```

### Tag: package-2021-03 and go

These settings apply only when `--tag=package-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-03-01/$(namespace)
```

### Tag: package-2021-03-preview and go

These settings apply only when `--tag=package-2021-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-03-01-preview/$(namespace)
```

### Tag: package-2021-02-preview and go

These settings apply only when `--tag=package-2021-02-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-02-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-02-01-preview/$(namespace)
```

### Tag: package-2021-02 and go

These settings apply only when `--tag=package-2021-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-02-01/$(namespace)
```

### Tag: package-2020-11 and go

These settings apply only when `--tag=package-2020-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-11-01/$(namespace)
```

### Tag: package-2020-08 and go

These settings apply only when `--tag=package-2020-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-08-01/$(namespace)
```

### Tag: package-2020-07 and go

These settings apply only when `--tag=package-2020-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-07-01/$(namespace)
```

### Tag: package-2020-06 and go

These settings apply only when `--tag=package-2020-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-01/$(namespace)
```

### Tag: package-2020-05 and go

These settings apply only when `--tag=package-2020-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-05' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-05-01/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-01/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2019-12 and go

These settings apply only when `--tag=package-2019-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-12-01/$(namespace)
```

### Tag: package-2019-11 and go

These settings apply only when `--tag=package-2019-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-01/$(namespace)
```

### Tag: package-2019-09 and go

These settings apply only when `--tag=package-2019-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-01/$(namespace)
```

### Tag: package-2019-08 and go

These settings apply only when `--tag=package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-08-01/$(namespace)
```

### Tag: package-2019-07 and go

These settings apply only when `--tag=package-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-07-01/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-01/$(namespace)
```

### Tag: package-2019-04 and go

These settings apply only when `--tag=package-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-04-01/$(namespace)
```

### Tag: package-2019-02 and go

These settings apply only when `--tag=package-2019-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-02-01/$(namespace)
```

### Tag: package-2018-12 and go

These settings apply only when `--tag=package-2018-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-12-01/$(namespace)
```

### Tag: package-2018-11 and go

These settings apply only when `--tag=package-2018-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-11-01/$(namespace)
```

### Tag: package-2018-10 and go

These settings apply only when `--tag=package-2018-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-10-01/$(namespace)
```

### Tag: package-2018-08 and go

These settings apply only when `--tag=package-2018-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-08-01/$(namespace)
```

### Tag: package-2018-07 and go

These settings apply only when `--tag=package-2018-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-07-01/$(namespace)
```

### Tag: package-2018-06 and go

These settings apply only when `--tag=package-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-06-01/$(namespace)
```

### Tag: package-2018-04 and go

These settings apply only when `--tag=package-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-04-01/$(namespace)
```

### Tag: package-2018-02 and go

These settings apply only when `--tag=package-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-02' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-02-01/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2018-01-01/$(namespace)
```

### Tag: package-2017-11 and go

These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-11-01/$(namespace)
```

### Tag: package-2017-10 and go

These settings apply only when `--tag=package-2017-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-10-01/$(namespace)
```

### Tag: package-2017-09 and go

These settings apply only when `--tag=package-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-09-01/$(namespace)
```

### Tag: package-2017-08 and go

These settings apply only when `--tag=package-2017-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-08' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-08-01/$(namespace)
```

### Tag: package-2017-06 and go

These settings apply only when `--tag=package-2017-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-06-01/$(namespace)
```

### Tag: package-2017-03 and go

These settings apply only when `--tag=package-2017-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-03-01/$(namespace)
```

### Tag: package-2016-12 and go

These settings apply only when `--tag=package-2016-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-12' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-12-01/$(namespace)
```

### Tag: package-2016-09 and go

These settings apply only when `--tag=package-2016-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-09-01/$(namespace)
```

### Tag: package-2016-06 and go

These settings apply only when `--tag=package-2016-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-06-01/$(namespace)
```

### Tag: package-2016-03 and go

These settings apply only when `--tag=package-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-30/$(namespace)
```

### Tag: package-2015-06split and go

These settings apply only when `--tag=package-2015-06split --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-06split' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-06-15/$(namespace)
```

### Tag: package-2015-05-preview and go

These settings apply only when `--tag=package-2015-05-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-05-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2015-05-01-preview/$(namespace)
```
