## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  namespace: security
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/security/armsecurity
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Common Go settings

```yaml $(go) && $(multiapi)
batch:
  - tag: package-composite-v1
  - tag: package-composite-v2
  - tag: package-composite-v3
```

### Tag: package-composite-v1 and go

These settings apply only when `--tag=package-composite-v1 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v1' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v1.0/$(namespace)
```

### Tag: package-composite-v2 and go

These settings apply only when `--tag=package-composite-v2 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v2' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v2.0/$(namespace)
```

### Tag: package-composite-v3 and go

These settings apply only when `--tag=package-composite-v3 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-composite-v3' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/v3.0/$(namespace)
```
