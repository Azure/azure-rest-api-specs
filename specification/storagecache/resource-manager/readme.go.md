## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: storagecache
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/storagecache/armstoragecache
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - from: swagger-document
    where: $.definitions.CacheIdentity.properties
    transform: >
      $['userAssignedIdentities']['$ref'] = "amlfilesystem.json#/definitions/UserAssignedIdentities";
  - from:
      - constants.go
    where: $
    transform: return $.replaceAll(/\tProvisioningStateTypeCanceled/g, "\tProvisioningStateTypeCancelled");
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-01
  - tag: package-2021-09
  - tag: package-2021-05
  - tag: package-2021-03
  - tag: package-2020-10-01
  - tag: package-2020-03-01
  - tag: package-2019-11-01
  - tag: package-2019-08
```

### Tag: package-2022-01 and go

These settings apply only when `--tag=package-2022-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2022-01-01/$(namespace)
```

### Tag: package-2021-09 and go

These settings apply only when `--tag=package-2021-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-09-01/$(namespace)
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

### Tag: package-2020-10-01 and go

These settings apply only when `--tag=package-2020-10-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-10-01/$(namespace)
```

### Tag: package-2020-03-01 and go

These settings apply only when `--tag=package-2020-03-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-01/$(namespace)
```

### Tag: package-2019-11-01 and go

These settings apply only when `--tag=package-2019-11-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-11-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-11-01/$(namespace)
```

### Tag: package-2019-08 and go

These settings apply only when `--tag=package-2019-08 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2019-08' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-08-01-preview/$(namespace)
```
