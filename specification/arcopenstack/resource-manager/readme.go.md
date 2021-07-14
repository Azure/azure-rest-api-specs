## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_APACHE_NO_VERSION
namespace: arcopenstack
module-name: sdk/$(namespace)/arm$(namespace)
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```
