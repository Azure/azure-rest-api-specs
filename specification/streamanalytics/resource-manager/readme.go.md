## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: streamanalytics
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/streamanalytics/armstreamanalytics
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-pure-2016-03
  - tag: package-2020-03-preview
```

### Tag: package-pure-2016-03 and go

These settings apply only when `--tag=package-pure-2016-03 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-pure-2016-03' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2016-03-01/$(namespace)
```

### Tag: package-2020-03-preview and go

These settings apply only when `--tag=package-2020-03-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-03-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-03-01-preview/$(namespace)
```
