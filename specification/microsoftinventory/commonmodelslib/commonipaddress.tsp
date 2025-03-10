import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./common.tsp";

using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Inventory.CommonTypes;

@doc("Properties for IpAddress resources")
model PublicIpAddressPropertiesBase {
  @doc("IPv4 or IPv6 type")
  ipType: IpVersion;

  @doc("IPv4 or IPv6 address (CIDR ranges OK)")
  ipAddress: string;

  @doc("Managed, Allocated, Active, Retired")
  state: IpAddressState;

  @doc("Whether the IP belongs to a 1P service")
  isFirstParty: IsFirstParty;

  @doc("Allocation type (Anycast, Multicast, ..)")
  allocationType: AllocationType;

  @doc("Source allocating this IP address (IPAM or sub-allocators)")
  allocationSourceServiceTreeId: string;

  @doc("Service responsible for this IP Address (e.g. sub-allocator, HOBO provider)")
  reportingServiceTreeId: string;

  @doc("Owner subscription Id")
  ownerSubscriptionId: string;

  @doc("The type of the resource to which this IP address belongs (Physical/Logical)")
  assetType: AssetType;

  @doc("The subtype of the resource to which this IP address belongs")
  assetSubType: AssetSubType;

  @doc("Unique identifier for the resource to which which this IP address belongs")
  assetId: string;

  @doc("Indicates the type of the assetId provided.")
  assetIdType: AssetIdType;

  @doc("Fully Qualified Domain Name of the asset")
  fullyQualifiedDomainName: string;

  @doc("Cloud where the asset exists")
  cloud: Cloud;

  @doc("The Data Center where this asset resides")
  dcCode: string;

  @doc("The provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Conditions for whether the resource is first party.")
union IsFirstParty {
  string,

  @doc("The resource is first party.")
  True: "true",

  @doc("The resource is not first party.")
  False: "false",
}

@doc("Enum for State")
union IpAddressState {
  string,

  @doc("Managed State")
  Managed: "Managed",

  @doc("Allocated State")
  Allocated: "Allocated",

  @doc("Active State")
  Active: "Active",

  @doc("Retired State")
  Retired: "Retired",
}

@doc("Enum for AssetType")
union AssetType {
  string,

  @doc("Physical AssetType")
  Physical: "Physical",

  @doc("Logical AssetType")
  Logical: "Logical",
}

@doc("Enum for AssetSubType")
union AssetSubType {
  string,

  @doc("VirtualMachine AssetSubType")
  VirtualMachine: "VirtualMachine",
}

@doc("Enum for AssetIdType")
union AssetIdType {
  string,

  @doc("ContainerId AssetIdType")
  ContainerId: "ContainerId",

  @doc("VirtualMachineUniqueId AssetIdType")
  VirtualMachineUniqueId: "VirtualMachineUniqueId",

  @doc("ArmId AssetIdType")
  ArmId: "ArmId",

  @doc("DeploymentId AssetIdType")
  DeploymentId: "DeploymentId",
}
