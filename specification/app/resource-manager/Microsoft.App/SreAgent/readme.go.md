## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
use-extension:
  "@autorest/modelerfour": 4.15.421
modelerfour:
    lenient-model-deduplication: true    
```

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/sreagent/armsreagent
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

