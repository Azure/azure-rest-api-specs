## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/arcopenstack/armarcopenstack
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2021-05-31-privatepreview
  - tag: package-2022-08-31-privatepreview
```


### Tag: package-2021-05-31-privatepreview and go

These settings apply only when `--tag=package-2021-05-31-privatepreview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2021-05-31-privatepreview' && $(go)
namespace: arcopenstack
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/package-2021-05-31-privatepreview/$(namespace)
```

### Tag: package-2022-08-31-privatepreview and go

These settings apply only when `--tag=package-2022-08-31-privatepreview --go` is specified on the command line.
Please also specify `--go-sdks-folder=<path to the root directory of your azure-sdk-for-go clone>`.

```yaml $(tag) == 'package-2022-08-31-privatepreview' && $(go)
namespace: arcopenstack
output-folder: $(go-sdk-folder)/services/preview/$(namespace)/mgmt/2022-08-31-privatepreview/$(namespace)
```