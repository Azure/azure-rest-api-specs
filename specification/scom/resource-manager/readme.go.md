## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: scom
  clear-output-folder: true
```
``` yaml $(go) && $(track2)
license-header: MICROSOFT_APACHE_NO_VERSION
module-name: sdk/resourcemanager/scom/armscom
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2023-07-07-preview
```


### Tag: package-2023-07-07-preview and go

These settings apply only when `--tag=package-2023-07-07-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2023-07-07-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2023-07-07-preview/$(namespace)
```

