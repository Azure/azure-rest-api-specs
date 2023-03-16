## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/solutions/armmanagedapplications
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-managedapplications-2021-07
  - tag: package-managedapplications-2021-02
  - tag: package-managedapplications-2020-08
  - tag: package-managedapplications-2019-07
  - tag: package-managedapplications-2018-09
  - tag: package-managedapplications-2018-06
  - tag: package-managedapplications-2018-03
  - tag: package-managedapplications-2018-02
  - tag: package-managedapplications-2017-12
  - tag: package-managedapplications-2017-09
```

### Tag: package-managedapplications-2021-07 and go

These settings apply only when `--tag=package-managedapplications-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-07-01/managedapplications
```

### Tag: package-managedapplications-2021-02 and go

These settings apply only when `--tag=package-managedapplications-2021-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-02' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-02-01-preview/managedapplications
```

### Tag: package-managedapplications-2020-08 and go

These settings apply only when `--tag=package-managedapplications-2020-08 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2020-08' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2020-08-21-preview/managedapplications
```

### Tag: package-managedapplications-2019-07 and go

These settings apply only when `--tag=package-managedapplications-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2019-07' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2019-07-01/managedapplications
```


### Tag: package-managedapplications-2018-09 and go

These settings apply only when `--tag=package-managedapplications-2018-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-09' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-09-01-preview/managedapplications
```

### Tag: package-managedapplications-2018-06 and go

These settings apply only when `--tag=package-managedapplications-2018-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-06' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-06-01/managedapplications
```


### Tag: package-managedapplications-2018-03 and go

These settings apply only when `--tag=package-managedapplications-2018-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-03' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-03-01/managedapplications
```


### Tag: package-managedapplications-2018-02 and go

These settings apply only when `--tag=package-managedapplications-2018-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2018-02' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2018-02-01/managedapplications
```

### Tag: package-managedapplications-2017-12 and go

These settings apply only when `--tag=package-managedapplications-2017-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-12' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-12-01/managedapplications
```

### Tag: package-managedapplications-2017-09 and go

These settings apply only when `--tag=package-managedapplications-2017-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2017-09' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2017-09-01/managedapplications
```
