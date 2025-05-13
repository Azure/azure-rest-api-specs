## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/edgemarketplace/armedgemarketplace
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
module-version: 0.1.0
```