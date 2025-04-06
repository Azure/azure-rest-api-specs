## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: bing
  clear-output-folder: true
```

```yaml $(go) && $(track2)
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/bing/armbing
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
```

### Go multi-api

```yaml $(go) && $(multiapi)
batch:
  - tag: package-2025-05-01-preview
  - tag: package-2020-06-10
  - tag: package-2020-06-10-preview
```

### Tag: package-2025-05-01-preview and go

These settings apply only when `--tag=package-2025-05-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2025-05-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2025-05-01-preview/$(namespace)
```

### Tag: package-2020-06-10 and go

These settings apply only when `--tag=package-2020-06-10 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-06-10' && $(go)
output-folder: $(go-sdk-folder)/services/$(namespace)/mgmt/2020-06-10/$(namespace)
```

### Tag: package-2020-06-10-preview and go

These settings apply only when `--tag=package-2020-06-10-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-06-10-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-06-10-preview/$(namespace)
```
