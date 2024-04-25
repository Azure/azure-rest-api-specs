## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  namespace: azuredata
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/azuredata/armazuredata
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2017-03-01-preview
  - tag: package-preview-2019-07
```

### Tag: package-2017-03-01-preview and go

These settings apply only when `--tag=package-2017-03-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2017-03-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2017-03-01-preview/$(namespace)
```

### Tag: package-preview-2019-07 and go

These settings apply only when `--tag=package-preview-2019-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-preview-2019-07' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2019-07-24-preview/$(namespace)
```