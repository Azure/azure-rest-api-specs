## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: confidentialledger
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/confidentialledger/armconfidentialledger
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-12-01-preview
  - tag: package-2021-05-13-preview
  - tag: package-2022-05-13
```

### Tag: package-2020-12-01-preview and go

These settings apply only when `--tag=package-2020-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2020-12-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2020-12-01-preview/$(namespace)
```

### Tag: package-2021-05-13-preview and go

These settings apply only when `--tag=package-2021-05-13-preview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-05-13-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2021-05-13-preview/$(namespace)
```

### Tag: package-2022-05-13 and go

These settings apply only when `--tag=package-2022-05-13 --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-05-13-preview' && $(go)
output-folder: $(go-sdk-folder)/services/stable/$(namespace)/mgmt/2022-05-13/$(namespace)
```