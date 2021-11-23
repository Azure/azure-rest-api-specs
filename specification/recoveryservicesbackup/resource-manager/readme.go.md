## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```
``` yaml $(go) && $(track2) && $(package-activestamp)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/recoveryservices/armrecoveryservices
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

``` yaml $(go) && $(track2) && $(package-passivestamp)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/mysql/armrecoveryservicespassivestamp
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```


### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2018-12
  - tag: package-2021-10
  - tag: package-2021-01
  - tag: package-2020-12
  - tag: package-2020-02
  - tag: package-2019-06
  - tag: package-2019-05
  - tag: package-2017-07
  - tag: package-2016-12
  - tag: package-2016-06
```

### Tag: package-2021-10 and go

These settings apply only when `--tag=package-2021-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-10' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-01-01/$(namespace)
```

### Tag: package-passivestamp-2018-12-20 and go

These settings apply only when `--tag=passivestamp-2018-12-20 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'passivestamp-2018-12-20' && $(go)
rpname: mysql
namespace: backuppassivestamp
output-folder: $(go-sdk-folder)/services/$(rpname)/mgmt/2021-05-01/$(namespace)
```


### Tag: package-2021-01 and go

These settings apply only when `--tag=package-2021-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2021-01' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2021-01-01/$(namespace)
```

### Tag: package-2020-12 and go

These settings apply only when `--tag=package-2020-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-12' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2020-12-01/$(namespace)
```

### Tag: package-2020-02 and go

These settings apply only when `--tag=package-2020-02 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2020-02' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2020-02-02/$(namespace)
```

### Tag: package-2019-06 and go

These settings apply only when `--tag=package-2019-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-06' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2019-06-15/$(namespace)
```

### Tag: package-2019-05 and go

These settings apply only when `--tag=package-2019-05 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2019-05' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2019-05-13/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-07' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2017-07-01/$(namespace)
```

### Tag: package-2016-12 and go

These settings apply only when `--tag=package-2016-12 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-12' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-12-01/$(namespace)
```

### Tag: package-2016-06 and go

These settings apply only when `--tag=package-2016-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2016-06' && $(go)
namespace: backup
output-folder: $(go-sdk-folder)/services/recoveryservices/mgmt/2016-06-01/$(namespace)
```
