## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: resourcehealth
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/resourcehealth/armresourcehealth
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
v3: true
directive:
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.occuredTime
    transform:
      $["x-ms-client-name"] = "occurredTime"
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.recentlyResolved.properties.unavailableOccuredTime
    transform:
      $["x-ms-client-name"] = "unavailableOccurredTime"
  - from: ResourceHealth.json
    where: $.definitions.availabilityStatus.properties.properties.properties.recentlyResolved.properties.unavailableSummary
    transform:
      $["x-ms-client-name"] = "unavailabilitySummary"
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-05-01
  - tag: package-2017-07
  - tag: package-2015-01
```

### Tag: package-2020-05-01 and go

These settings apply only when `--tag=package-2020-05-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-05-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-05-01/$(namespace)
```

### Tag: package-2017-07 and go

These settings apply only when `--tag=package-2017-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-07' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-07-01/$(namespace)
```

### Tag: package-2015-01 and go

These settings apply only when `--tag=package-2015-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2015-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2015-01-01/$(namespace)
```
