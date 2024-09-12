import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Compute;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ComputeOperationValue.display);

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
@@flattenProperty(VirtualMachineScaleSetVMExtensionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkInterfaceReference.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineNetworkInterfaceConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineNetworkInterfaceIPConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachinePublicIPAddressConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtensionUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineUpdate.properties);

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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RollingUpgradeStatusInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetVMExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineScaleSetVM.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtension.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachine.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineExtensionImage.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AvailabilitySet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProximityPlacementGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHostGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHost.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SshPublicKeyResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Image.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePointCollection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestorePoint.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservationGroup.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CapacityReservation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(VirtualMachineRunCommand.properties);
