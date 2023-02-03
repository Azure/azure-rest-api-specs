## Go

These settings apply only when `--go` is specified on the command line.

```yaml $(go) && !$(track2)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  clear-output-folder: true
```

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/solutions/armmanagedapplications
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-managedapplications-2021-07
```

### Tag: package-managedapplications-2021-07 and go

These settings apply only when `--tag=package-managedapplications-2021-07 --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-managedapplications-2021-07' && $(go)
namespace: managedapplications
output-folder: $(go-sdk-folder)/services/resources/mgmt/2021-07-01/managedapplications
```