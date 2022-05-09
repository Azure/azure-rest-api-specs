## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: managednetworkfabric
  clear-output-folder: true
```

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_APACHE_NO_VERSION
namespace: managednetworkfabric
module-name: sdk/$(namespace)/arm$(namespace)
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2022-01-15-privatepreview
```
### Tag: package-2022-01-15-privatepreview and go
These settings apply only when `--tag=package-2022-01-15-privatepreview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.
``` yaml $(tag) == 'package-2022-01-15-privatepreview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-01-15-privatepreview/$(namespace)
```
