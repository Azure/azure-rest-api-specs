import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetNetworkConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetIPConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetPublicIPAddressConfiguration.properties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetUpdateNetworkConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetUpdateIPConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetUpdatePublicIPAddressConfiguration.properties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetExtensionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkInterfaceReference.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineNetworkInterfaceConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineNetworkInterfaceIPConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachinePublicIPAddressConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetVMExtensionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtensionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineImage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailabilitySetUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHostGroupUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHostUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SshPublicKeyUpdateResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ImageUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePointCollectionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservationGroupUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservationUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineRunCommandUpdate.properties);

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
@@clientName(VirtualMachineScaleSets.scaleOut::parameters.body, "parameters");
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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSet.properties);

@@clientName(VirtualMachineScaleSetExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RollingUpgradeStatusInfo.properties);

@@clientName(VirtualMachineScaleSetVMS.reimage::parameters.body,
  "vmScaleSetVMReimageInput"
);
@@clientName(VirtualMachineScaleSetVMS.attachDetachDataDisks::parameters.body,
  "parameters"
);
@@clientName(VirtualMachineScaleSetVMS.runCommand::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetVM.properties);

@@clientName(VirtualMachineExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtension.properties);

@@clientName(VirtualMachineScaleSetVMExtensions.update::parameters.properties,
  "extensionParameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetVMExtension.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachine.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtensionImage.properties);

@@clientName(AvailabilitySets.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailabilitySet.properties);

@@clientName(AvailabilitySets.validateMigrationToVirtualMachineScaleSet::parameters.body,
  "parameters"
);
@@clientName(AvailabilitySets.startMigrationToVirtualMachineScaleSet::parameters.body,
  "parameters"
);

@@clientName(ProximityPlacementGroups.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProximityPlacementGroup.properties);

@@clientName(DedicatedHostGroups.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHostGroup.properties);

@@clientName(DedicatedHosts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHost.properties);

@@clientName(SshPublicKeyResources.update::parameters.properties, "parameters");
@@clientName(SshPublicKeyResources.generateKeyPair::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SshPublicKeyResource.properties);

@@clientName(Images.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Image.properties);

@@clientName(RestorePointCollections.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePointCollection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePoint.properties);

@@clientName(CapacityReservationGroups.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservationGroup.properties);

@@clientName(CapacityReservations.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservation.properties);

@@clientName(VirtualMachineRunCommands.update::parameters.body, "runCommand");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineRunCommand.properties);

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
