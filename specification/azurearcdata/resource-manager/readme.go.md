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

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2023-12-01-preview
```

### Tag: package-2021-11-01 and go

These settings apply only when `--tag=package-package-2023-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-11-01' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/package-2023-12-01-preview/$(namespace)
```
