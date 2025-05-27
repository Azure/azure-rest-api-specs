/**
 * This file is copied from specification\microsoftinventory\commonmodelslib\common.tsp.
 * Copy the file here to fix the "invalid folder structure" error of importing files
 * outside "specification/networkservicemanager".
 */
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commonipaddress.tsp";
import "./commonprivateipaddress.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@versioned(Versions)
namespace Microsoft.Inventory.CommonTypes;

/** The available API versions. */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_01_01: "2024-01-01",
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

@doc("Enum for the IP Version")
union IpVersion {
  string,

  @doc("IPv4 version")
  IPv4: "IPv4",

  @doc("IPv6 version")
  IPv6: "IPv6",
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

@doc("Metadata that describes the ownership of the resource")
model Ownership {
  @doc("The owning service tree ID")
  serviceTreeId?: string;

  @doc("The owning subscription ID")
  subscriptionId?: string;
}

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
