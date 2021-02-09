## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go)
go:
  license-header: MICROSOFT_APACHE_NO_VERSION
  namespace: purview
  clear-output-folder: true
```
## Suppression

``` yaml
directive:
  - suppress: R3018  # EnumInsteadOfBoolean
    where:
      - $.definitions.CheckNameAvailabilityResult.properties.nameAvailable
      - $.definitions.DimensionProperties.properties.toBeExportedForCustomer
    reason:
      - Check name model is set by ARM team https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/proxy-api-reference.md#check-name-availability-requests  
  - suppress: R4009  # RequiredSystemDataInNewApiVersions
    reason:
      - We do not yet support systemdata
```

### Go multi-api

``` yaml $(go) && $(multiapi)
batch:
  - tag: package-2020-12-01-preview
```

### Tag: package-2020-12-01-preview and go

These settings apply only when `--tag=package-2020-12-01-preview --go` is specified on the command line.
Please also specify `--go-sdk-folder=<path to the root directory of your azure-sdk-for-go clone>`.

``` yaml $(tag) == 'package-2020-12-01-preview' && $(go)
output-folder: $(go-sdk-folder)/services/preview/purview/mgmt/2020-12-01-preview/$(namespace)
```