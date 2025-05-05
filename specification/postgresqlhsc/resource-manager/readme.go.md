## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: cosmosdbforpostgresql
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/cosmosforpostgresql/armcosmosforpostgresql
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-11
  - tag: package-2020-10-05-privatepreview
```

### Tag: package-2022-11 and go

These settings apply only when `--tag=package-2020-10-05-privatepreview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2022-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/package-2022-11-08/$(namespace)
```
### Tag: package-2020-10-05-privatepreview

These settings apply only when `--tag=package-2020-10-05-privatepreview` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-10-05-privatepreview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/package-2020-10-05-privatepreview/$(namespace)
```
