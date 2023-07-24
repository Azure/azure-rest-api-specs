## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/mobilepacketcore/armmobilepacketcore
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Tag: package-2023-05-15-preview and go

These settings apply only when `--tag=package-2023-05-15-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-05-15-preview' && $(go)
namespace: mpcnetworkfunction
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2023-05-15-preview/$(namespace)
```
