## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/storagecache/armstoragecache
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - from: swagger-document
    where: $.definitions.CacheIdentity.properties
    transform: >
      $['userAssignedIdentities']['$ref'] = "amlfilesystem.json#/definitions/UserAssignedIdentities";
  - from:
      - constants.go
    where: $
    transform: return $.replaceAll(/\tProvisioningStateTypeCanceled/g, "\tProvisioningStateTypeCancelled");
```
