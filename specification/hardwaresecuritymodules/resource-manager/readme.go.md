## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: hardwaresecuritymodules
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/hardwaresecuritymodules/armhardwaresecuritymodules
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-11
  - tag: package-2018-10
```

### Tag: package-2021-11 and go

These settings apply only when `--tag=package-2021-11 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2021-11' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2021-11-30/$(namespace)
```

### Tag: package-2018-10 and go

These settings apply only when `--tag=package-2018-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag)=='package-2018-10' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2018-10-31-preview/$(namespace)
```