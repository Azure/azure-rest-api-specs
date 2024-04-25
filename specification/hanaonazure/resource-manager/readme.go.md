## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: hanaonazure
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/hanaonazure/armhanaonazure
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-11
```

### Tag: package-2017-11

These settings apply only when `--tag=package-2017-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2017-11' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-11-03-preview/$(namespace)
```