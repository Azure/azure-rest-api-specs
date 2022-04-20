## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: guestconfiguration
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/guestconfiguration/armguestconfiguration
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- rename-model:
    from: 'AssignmentReport'
    to: 'CommonAssignmentReport'
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-06-25
  - tag: package-2021-01-25
```
### Tag: package-2021-01-25 and go

These settings apply only when `--tag=package-2021-01-25 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2021-01-25' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-01-25/$(namespace)
```

### Tag: package-2020-06-25 and go

These settings apply only when `--tag=package-2020-06-25 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-06-25' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-25/$(namespace)
```