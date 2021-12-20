## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/oep/armoep
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-06-01-preview
```