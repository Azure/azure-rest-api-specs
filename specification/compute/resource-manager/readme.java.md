## Java

These settings apply only when `--java` is specified on the command line.

```yaml $(java)
modelerfor:
  lenient-model-deduplication: true
rename-model: UserAssignedIdentitiesValue:VirtualMachineIdentityUserAssignedIdentities,VirtualMachineScaleSetIdentityUserAssignedIdentitiesValue:VirtualMachineScaleSetIdentityUserAssignedIdentities
preserve-model: AvailabilitySetSkuTypes
remove-inner: StorageProfile
enable-sync-stack: false
directive:
  - from: virtualMachineScaleSet.json
    where: $.definitions.VirtualMachineScaleSetVMProperties.properties
    transform: >
      $['timeCreated'] = {
          "readOnly": true,
          "type": "string",
          "format": "date-time",
          "description": "Specifies the time at which the Virtual Machine resource was created."
        }
  - from: gallery.json
    where: $.definitions.GalleryTargetExtendedLocation.properties.storageAccountType
    transform: >
      $['x-ms-enum'].name = "StorageAccountType"
  - from: ComputeRP.json
    where: $.definitions
    transform: delete $["Expand"]
    reason: https://github.com/Azure/typespec-azure/issues/2499
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetVMProperties.properties
    transform: >
      $['timeCreated'] = {
          "readOnly": true,
          "type": "string",
          "format": "date-time",
          "description": "Specifies the time at which the Virtual Machine resource was created."
        }
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetVMExtension.properties.name
    transform: delete $["x-ms-client-name"]
    reason: https://github.com/Azure/typespec-azure/issues/2517
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineScaleSetExtension.properties.name
    transform: delete $["x-ms-client-name"]
    reason: https://github.com/Azure/typespec-azure/issues/2517
  - from: ComputeRP.json
    where: $.definitions.VirtualMachineInstallPatchesParameters.properties.maximumDuration
    transform: delete $["format"]
    reason: avoid breaking change
```
