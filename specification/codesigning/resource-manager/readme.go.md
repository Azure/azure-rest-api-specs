## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/codesigning/armcodesigning
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2024-02-05-preview
```

### Tag: package-2024-02-05-preview and go

These settings apply only when `--tag=package-2024-02-05-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2024-02-05-preview' && $(go)
namespace: codesigning
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2024-02-05-preview/$(namespace)
```