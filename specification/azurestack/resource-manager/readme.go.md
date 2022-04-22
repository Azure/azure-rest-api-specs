## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: azurestack
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/azurestack/armazurestack
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-06-01
```

### Tag: package-2017-06-01 and go

These settings apply only when `--tag=package-2017-06-01 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag)=='package-2017-06-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2017-06-01/$(namespace)
```

## Python

These settings apply only when `--python` is specified on the command line.

``` yaml $(python)
python:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-azurestack
  no-namespace-folders: true
  clear-output-folder: true
```