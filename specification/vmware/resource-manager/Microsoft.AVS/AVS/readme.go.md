## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/avs/armavs
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
- from: managedidentity.json
  where: definitions.SystemAssignedServiceIdentity
  transform: $["x-ms-client-name"] = "PrivateCloudIdentity"
- from: managedidentity.json
  where: definitions.SystemAssignedServiceIdentityType
  transform: $["x-ms-enum"].name = "ResourceIdentityType"
```
