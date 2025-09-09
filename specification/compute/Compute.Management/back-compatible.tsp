import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetNetworkConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetIPConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetPublicIPAddressConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetUpdateNetworkConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetUpdateIPConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetUpdatePublicIPAddressConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetExtensionUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkInterfaceReference.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineNetworkInterfaceConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineNetworkInterfaceIPConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachinePublicIPAddressConfiguration.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetVMExtensionUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineExtensionUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineImage.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvailabilitySetUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedHostGroupUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedHostUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SshPublicKeyUpdateResource.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ImageUpdate.properties);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RestorePointCollectionUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapacityReservationGroupUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapacityReservationUpdate.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineRunCommandUpdate.properties
);

@@clientName(VirtualMachineScaleSets.update::parameters.properties,
  "parameters"
);
@@clientName(VirtualMachineScaleSets.approveRollingUpgrade::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.convertToSinglePlacementGroup::parameters.body,
  "parameters"
);
@@clientName(VirtualMachineScaleSets.deallocate::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.deleteInstances::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.updateInstances::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.performMaintenance::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.powerOff::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.redeploy::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.reimage::parameters.body,
  "vmScaleSetReimageInput"
);
@@clientName(VirtualMachineScaleSets.reimageAll::parameters.body,
  "vmInstanceIDs"
);
@@clientName(VirtualMachineScaleSets.restart::parameters.body, "vmInstanceIDs");
@@clientName(VirtualMachineScaleSets.setOrchestrationServiceState::parameters.body,
  "parameters"
);
@@clientName(VirtualMachineScaleSets.start::parameters.body, "vmInstanceIDs");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSet.properties
);

@@clientName(VirtualMachineScaleSetExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetExtension.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RollingUpgradeStatusInfo.properties
);

@@clientName(VirtualMachineScaleSetVMS.reimage::parameters.body,
  "vmScaleSetVMReimageInput"
);
@@clientName(VirtualMachineScaleSetVMS.attachDetachDataDisks::parameters.body,
  "parameters"
);
@@clientName(VirtualMachineScaleSetVMS.runCommand::parameters.body,
  "parameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetVM.properties
);

@@clientName(VirtualMachineExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineExtension.properties
);

@@clientName(VirtualMachineScaleSetVMExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineScaleSetVMExtension.properties
);

@@clientName(VirtualMachines.update::parameters.properties, "parameters");
@@clientName(VirtualMachines.attachDetachDataDisks::parameters.body,
  "parameters"
);
@@clientName(VirtualMachines.capture::parameters.body, "parameters");
@@clientName(VirtualMachines.installPatches::parameters.body,
  "installPatchesInput"
);
@@clientName(VirtualMachines.reimage::parameters.body, "parameters");
@@clientName(VirtualMachines.runCommand::parameters.body, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachine.properties);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineExtensionImage.properties
);

@@clientName(AvailabilitySets.update::parameters.properties, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AvailabilitySet.properties);

@@clientName(AvailabilitySets.validateMigrationToVirtualMachineScaleSet::parameters.body,
  "parameters"
);
@@clientName(AvailabilitySets.startMigrationToVirtualMachineScaleSet::parameters.body,
  "parameters"
);

@@clientName(ProximityPlacementGroups.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ProximityPlacementGroup.properties
);

@@clientName(DedicatedHostGroups.update::parameters.properties, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedHostGroup.properties
);

@@clientName(DedicatedHosts.update::parameters.properties, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedHost.properties);

@@clientName(SshPublicKeyResources.update::parameters.properties, "parameters");
@@clientName(SshPublicKeyResources.generateKeyPair::parameters.body,
  "parameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SshPublicKeyResource.properties
);

@@clientName(Images.update::parameters.properties, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Image.properties);

@@clientName(RestorePointCollections.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RestorePointCollection.properties
);

#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RestorePoint.properties);

@@clientName(CapacityReservationGroups.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapacityReservationGroup.properties
);

@@clientName(CapacityReservations.update::parameters.properties, "parameters");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CapacityReservation.properties
);

@@clientName(VirtualMachineRunCommands.update::parameters.body, "runCommand");
#suppress "deprecated" "@Azure.ClientGenerator.Core.Legacy.flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(VirtualMachineRunCommand.properties
);

@@clientName(LogAnalyticsOperationGroup.exportRequestRateByInterval::parameters.body,
  "parameters"
);

@@clientName(VirtualMachineScaleSetVMRunCommands.update::parameters.body,
  "runCommand"
);
@@clientName(AvailabilitySets.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CapacityReservationGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CapacityReservations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DedicatedHostGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(DedicatedHosts.createOrUpdate::parameters.resource, "parameters");
@@clientName(Images.createOrUpdate::parameters.resource, "parameters");
@@clientName(ProximityPlacementGroups.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(RestorePointCollections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(RestorePoints.create::parameters.resource, "parameters");
@@clientName(SshPublicKeyResources.create::parameters.resource, "parameters");
@@clientName(VirtualMachineScaleSets.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VirtualMachineScaleSetExtensions.createOrUpdate::parameters.resource,
  "extensionParameters"
);
@@clientName(VirtualMachineScaleSetVMS.update::parameters.resource,
  "parameters"
);
@@clientName(AvailabilitySetSkuTypes, "AvailabilitySetSkuType", "java");
@@clientName(VirtualMachineExtensions.createOrUpdate::parameters.resource,
  "extensionParameters"
);
@@clientName(VirtualMachineScaleSetVMExtensions.createOrUpdate::parameters.resource,
  "extensionParameters"
);
@@clientName(VirtualMachineScaleSetVMRunCommands.createOrUpdate::parameters.body,
  "runCommand"
);
@@clientName(VirtualMachineRunCommands.createOrUpdate::parameters.body,
  "runCommand"
);
@@clientName(VirtualMachines.createOrUpdate::parameters.resource, "parameters");

@@clientName(LogAnalyticsOperationGroup.exportThrottledRequests::parameters.body,
  "parameters"
);

// @@clientName(VirtualMachineScaleSetExtension.vmName, "name");
@@clientName(VirtualMachineScaleSetExtension.vmType, "type");

// @@clientName(VirtualMachineScaleSetVMExtension.vmName, "name");
@@clientName(VirtualMachineScaleSetVMExtension.vmType, "type");
