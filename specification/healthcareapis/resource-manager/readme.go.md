## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: healthcareapis
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/healthcareapis/armhealthcareapis
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-11
  - tag: package-preview-2021-06
  - tag: package-2020-03-30
  - tag: package-2020-03
  - tag: package-2019-09
  - tag: package-2018-08-preview
```

### Tag: package-2021-11 and go

These settings apply only when `--tag=package-2021-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-11-01/$(namespace)
```

### Tag: package-preview-2021-06 and go

These settings apply only when `--tag=package-preview-2021-06 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-preview-2021-06' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-06-01-preview/$(namespace)

directive:
  - from: healthcare-apis.json
    where: $.definitions.ServicesProperties.properties.provisioningState
    transform: >-
      return {
              "description": "The provisioning state.",
              "$ref": "#/definitions/ProvisioningState"
            }
```

### Tag: package-2020-03-30 and go

These settings apply only when `--tag=package-2020-03-30 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-30' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-30/$(namespace)
```

### Tag: package-2020-03 and go

These settings apply only when `--tag=package-2020-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-03-15/$(namespace)
```

### Tag: package-2019-09 and go

These settings apply only when `--tag=package-2019-09 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2019-09' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2019-09-16/$(namespace)
```

### Tag: package-2018-08-preview and go

These settings apply only when `--tag=package-2018-08-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2018-08-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-08-20-preview/$(namespace)
```
