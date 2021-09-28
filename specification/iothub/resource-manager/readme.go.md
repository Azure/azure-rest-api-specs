## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: devices
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/iothub/armiothub
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-preview-2021-03
  - tag: package-2020-03
  - tag: package-preview-2019-07
  - tag: package-preview-2019-03
  - tag: package-2018-12-preview
  - tag: package-2018-04
  - tag: package-2018-01
  - tag: package-2017-07
  - tag: package-2017-01
  - tag: package-2016-02
```

### Tag: package-preview-2021-03 and go

These settings apply only when `--tag=package-preview-2021-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2021-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/iothub/mgmt/2021-03-03-preview/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2020-03-01/$(namespace)
```

### Tag:package-preview-2019-07 and go

These settings apply only when `--tag=package-preview-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/iothub/mgmt/2019-07-01-preview/$(namespace)
```

### Tag:package-preview-2019-03 and go

These settings apply only when `--tag=package-preview-2019-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2019-03' && $(go)
output-folder: $(go-sdk-folder)/services/preview/iothub/mgmt/2019-03-22-preview/$(namespace)
```

### Tag: package-2018-12-preview and go

These settings apply only when `--tag=package-2018-12-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-12-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/iothub/mgmt/2018-12-01-preview/$(namespace)
```

### Tag: package-2018-04 and go

These settings apply only when `--tag=package-2018-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-04' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2018-04-01/$(namespace)
```

### Tag: package-2018-01 and go

These settings apply only when `--tag=package-2018-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-01' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2018-01-22/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2017-07-01/$(namespace)
```

### Tag: package-2017-01 and go

These settings apply only when `--tag=package-2017-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-01' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2017-01-19/$(namespace)
```

### Tag: package-2016-02 and go

These settings apply only when `--tag=package-2016-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-02' && $(go)
output-folder: $(go-sdk-folder)/services/iothub/mgmt/2016-02-03/$(namespace)
```
