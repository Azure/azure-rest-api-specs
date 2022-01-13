## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: cdn
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/cdn/armcdn
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'CdnEndpoint'
    to: 'EndpointModel'
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-09
  - tag: package-2020-04
  - tag: package-2019-06
  - tag: package-2019-04
  - tag: package-2017-10
  - tag: package-2017-04
  - tag: package-2016-10
  - tag: package-2016-04
  - tag: package-2015-06
```

### Tag: package-2020-09 and go

These settings apply only when `--tag=package-2020-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-09-01/$(namespace)
```

### Tag: package-2020-04 and go

These settings apply only when `--tag=package-2020-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-04-15/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-06-15/$(namespace)
```

### Tag: package-2019-04 and go

These settings apply only when `--tag=package-2019-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-04-15/$(namespace)
```

### Tag: package-2017-10 and go

These settings apply only when `--tag=package-2017-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-10-12/$(namespace)
```

### Tag: package-2017-04 and go

These settings apply only when `--tag=package-2017-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-04-02/$(namespace)
```

### Tag: package-2016-10 and go

These settings apply only when `--tag=package-2016-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-10'  && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-10-02/$(namespace)
```

### Tag: package-2016-04 and go

These settings apply only when `--tag=package-2016-04 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2016-04' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-04-02/$(namespace)
```

### Tag: package-2015-06 and go

These settings apply only when `--tag=package-2015-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-06' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-06-01/$(namespace)
```
