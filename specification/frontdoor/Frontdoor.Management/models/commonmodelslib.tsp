import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.Inventory.CommonTypes;

/** The available API versions. */
enum Versions {
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_01_01: "2024-01-01",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01: "2025-08-01",
}

@doc("Properties for IpAddress resources")
model PublicIpAddressPropertiesBase {
  @doc("IPv4 or IPv6 type")
  ipType: IpType;

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

@doc("Enum for IP Type")
union IpType {
  string,

  @doc("IPv4 type")
  IPv4: "IPv4",

  @doc("IPv6 type")
  IPv6: "IPv6",
}

@doc("Enum for cloud")
union Cloud {
  string,

  @doc("Public cloud")
  Public: "Public",

  @doc("USNat cloud")
  USNat: "USNat",

  @doc("Fairfax cloud")
  Fairfax: "Fairfax",

  @doc("Mooncake cloud")
  Mooncake: "Mooncake",
}

@doc("Enum for AllocationType")
union AllocationType {
  string,

  @doc("Unicast AllocationType")
  Unicast: "Unicast",

  @doc("Multicast AllocationType")
  Multicast: "Multicast",

  @doc("Anycast AllocationType")
  Anycast: "Anycast",
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

@added(Versions.v2025_08_01)
@doc("Metadata that describes the ownership of the resource")
model Ownership {
  @doc("The owning service tree ID")
  serviceTreeId?: string;

  @doc("The owning subscription ID")
  subscriptionId?: string;
}

@added(Versions.v2025_08_01)
@doc("Metadata that describes the asset to which the resource is assigned")
model AssignedResource {
  @doc("The type of the resource")
  resourceType: AssetType;

  @doc("Unique identifier for the asset")
  resourceId: string;
}

@doc("Describes an ARM resource")
model ArmResourceReference {
  @doc("The id of the object")
  id: string;

  @doc("The ARM resource ID of the object")
  resourceId: string;
}
