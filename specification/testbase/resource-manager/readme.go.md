## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/testbase/armtestbase
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-12-16-preview
  - tag: package-2022-04-01-preview
  - tag: package-2023-11-01-preview
```

### Tag: package-2020-12-16-preview and go

These settings apply only when `--tag=package-2020-12-16-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-12-16-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-12-16-preview/$(namespace)
```

### Tag: package-2022-04-01-preview and go

These settings apply only when `--tag=package-2022-04-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-04-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-04-01-preview/$(namespace)
```

### Tag: package-2023-11-01-preview and go

These settings apply only when `--tag=package-2023-11-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-11-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2023-11-01-preview/$(namespace)
```
