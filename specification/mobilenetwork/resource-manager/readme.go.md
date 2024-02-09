## Go

These settings apply only when `--go` is specified on the command line.

``` yaml $(go) && $(track2)
license-header: MICROSOFT_MIT_NO_VERSION
module-name: sdk/resourcemanager/mobilenetwork/armmobilenetwork
module: github.com/Azure/azure-sdk-for-go/$(module-name)
output-folder: $(go-sdk-folder)/$(module-name)
azure-arm: true
directive:
  - where-operation: PacketCoreControlPlaneVersions_GetBySubscription
    transform: >
      $.parameters[1] = {
        "name": "subscriptionId",
        "in": "path",
        "required": true,
        "type": "string",
        "format": "uuid",
        "description": "The ID of the target subscription. The value must be an UUID."
      };
  - where-operation: PacketCoreControlPlaneVersions_ListBySubscription
    transform: > 
      $.parameters[0] = {
        "name": "subscriptionId",
        "in": "path",
        "required": true,
        "type": "string",
        "format": "uuid",
        "description": "The ID of the target subscription. The value must be an UUID."
      };
```
