## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/carbonoptimization/armcarbonoptimization
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2023-04-01-preview
  - tag: package-2024-02-01-preview
  - tag: package-2025-04-01
```