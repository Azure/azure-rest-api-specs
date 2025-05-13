## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
use-extension:
  "@autorest/modelerfour": 4.15.421
modelerfour:
    lenient-model-deduplication: true    
```

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
  namespace: azurearcdata
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/azurearcdata/armazurearcdata
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```
