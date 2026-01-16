import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ConnectedVMwarevSphere;

@@scope(Operations.list, "!csharp");
@@clientName(InventoryItem, "VCenterInventoryItem", "csharp");
@@clientName(Cluster, "VMwareCluster", "csharp");
@@clientName(Datastore, "VMwareDatastore", "csharp");
@@clientName(Host, "VMwareHost", "csharp");
@@clientName(VirtualMachineTemplate, "VMwareVmTemplate", "csharp");
@@clientName(VirtualMachineInstance, "VMwareVmInstance", "csharp");
@@clientName(VirtualNetwork, "VMwareVirtualNetwork", "csharp");
@@clientName(VCenter, "VMwareVCenter", "csharp");
@@clientName(GuestAgent, "VmInstanceGuestAgent", "csharp");
@@clientName(ResourcePool, "VMwareResourcePool", "csharp");
@@clientName(VmInstanceHybridIdentityMetadata,
  "VmInstanceHybridIdentityMetadata",
  "csharp"
);

// Additional rename mappings from autorest.mdk (non-duplicates)
@@clientName(ClustersList, "VMwareClusterListResult", "csharp");
@@clientName(DatastoresList, "VMwareDatastoreListResult", "csharp");
@@clientName(DiskMode, "VMwareDiskMode", "csharp");
@@clientName(DiskType, "VMwareDiskType", "csharp");
@@clientName(FirmwareType, "VMwareFirmwareType", "csharp");
@@clientName(GuestAgentList, "VmInstanceGuestAgentListResult", "csharp");
@@clientName(GuestCredential, "VmInstanceGuestCredential", "csharp");
@@clientName(HardwareProfile, "VmInstanceHardwareProfile", "csharp");
@@clientName(HostsList, "VMwareHostListResult", "csharp");
@@clientName(InfrastructureProfile, "VCenterInfrastructureProfile", "csharp");
@@clientName(InventoryItemsList, "VCenterInventoryItemListResult", "csharp");
@@clientName(InventoryType, "VCenterInventoryType", "csharp");
@@clientName(NetworkInterface, "VMwareNetworkInterface", "csharp");
@@clientName(NetworkInterfaceUpdate, "VMwareNetworkInterfaceUpdate", "csharp");
@@clientName(NetworkProfile, "VMwareNetworkProfile", "csharp");
@@clientName(NetworkProfileUpdate, "VMwareNetworkProfileUpdate", "csharp");
@@clientName(NICType, "VMwareNicType", "csharp");
@@clientName(OsType, "VMwareOsType", "csharp");
@@clientName(ProvisioningAction, "GuestAgentProvisioningAction", "csharp");
@@clientName(ProvisioningState, "VMwareResourceProvisioningState", "csharp");
@@clientName(ResourcePatch, "VMwareResourcePatchContent", "csharp");
@@clientName(ResourcePoolsList, "VMwareResourcePoolListResult", "csharp");
@@clientName(ResourceStatus, "VMwareResourceStatus", "csharp");
@@clientName(StorageProfile, "VMwareStorageProfile", "csharp");
@@clientName(VCentersList, "VMwareVCenterListResult", "csharp");
@@clientName(VirtualDisk, "VMwareVirtualDisk", "csharp");
@@clientName(VirtualDiskUpdate, "VMwareVirtualDiskUpdate", "csharp");
@@clientName(VirtualMachineInstancesList,
  "VMwareVmInstanceListResult",
  "csharp"
);
@@clientName(VirtualMachineTemplatesList,
  "VMwareVmTemplateListResult",
  "csharp"
);
@@clientName(VirtualNetworksList, "VMwareVirtualNetworkListResult", "csharp");
@@clientName(WindowsConfiguration, "VMwareVmWindowsConfiguration", "csharp");
@@clientName(WindowsConfiguration.autoLogon, "isAutoLogon", "csharp");


// Java SDK configurations
@@clientName(NICType, "NicType", "java");
@@clientName(NicIPSettings, "NicIpSettings", "java");
@@clientName(NicIPAddressSettings, "NicIpAddressSettings", "java");
@@clientName(IPAddressAllocationMethod, "IpAddressAllocationMethod", "java");
@@clientName(VirtualSCSIController, "VirtualScsiController", "java");
@@clientName(SCSIControllerType, "ScsiControllerType", "java");
@@clientName(VirtualSCSISharing, "VirtualScsiSharing", "java");
