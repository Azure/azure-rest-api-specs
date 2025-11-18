import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Frontdoor;

@doc("Provisioning state enum")
union ProvisioningState {
  string,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource action is successful.")
  Succeeded: "Succeeded",

  @doc("The resource action has failed.")
  Failed: "Failed",

  @doc("The resource action has been cancelled.")
  Canceled: "Canceled",

  @doc("The resource provisioning has been accepted.")
  Accepted: "Accepted",

  @doc("The resource is being created.")
  Creating: "Creating",

  @doc("The resource is being updated.")
  Updating: "Updating",

  @doc("The resource is being deleted.")
  Deleting: "Deleting",

  @doc("The resource has been deleted.")
  Deleted: "Deleted",

  @doc("The resource status is unspecified.")
  NotSpecified: "NotSpecified",
}

scalar DatacenterResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

@doc("OsType enum")
union OsType {
  string,

  @doc("OsType enum Windows")
  Windows: "Windows",

  @doc("OsType enum Windows")
  Linux: "Linux",
}

@doc("Environment enum")
union Environment {
  string,

  @doc("Environment enum Prod")
  Prod: "Prod",

  @doc("Environment enum PPE (known 1st party customer data managed pre-prod traffic/canary)")
  PPE: "PPE",

  @doc("Environment enum Test")
  Test: "Test",
}

@doc("AssetTypeVM enum")
union AssetTypeVM {
  string,

  @doc("AssetType enum BaremetalVM")
  BaremetalVM: "BaremetalVM",

  @doc("AssetType enum NonAzureVM")
  @added(Versions.v2025_08_01_preview)
  NonAzureVM: "NonAzureVM",

  @doc("AssetType enum PilotFishVM")
  @added(Versions.v2025_08_01_preview)
  PilotFishVM: "PilotFishVM",
}

@doc("Cloud enum")
union Cloud {
  string,

  @doc("Cloud enum Public")
  Public: "Public",
}

@doc("Status enum")
union Status {
  string,

  @doc("Status enum Alive")
  Alive: "Alive",

  @doc("Status enum Suspended")
  Suspended: "Suspended",

  @doc("Status enum Decommissioned")
  Decommissioned: "Decommissioned",

  @doc("Status enum Provisioned")
  Provisioned: "Provisioned",

  @doc("Status enum Not Provisioned")
  notProvisioned: "Not Provisioned",
}

@added(Versions.v2025_08_01_preview)
@doc("Enum for the IP Version")
union IpVersion {
  string,

  @doc("Internet Protocol version 4 address")
  IPv4: "IPv4",

  @doc("Internet Protocol version 6 address")
  IPv6: "IPv6",
}

@added(Versions.v2025_08_01_preview)
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

@added(Versions.v2025_08_01_preview)
@doc("Enum for AssetType")
union AssetType {
  string,

  @doc("Physical AssetType")
  Physical: "Physical",

  @doc("Logical AssetType")
  Logical: "Logical",
}

@added(Versions.v2025_08_01_preview)
@doc("Metadata that describes the asset to which the resource is assigned")
model AssignedResource {
  @doc("The type of the resource")
  resourceType: AssetType;

  @doc("Unique identifier for the asset")
  resourceId: string;
}

@added(Versions.v2025_08_01_preview)
@doc("Metadata that describes the ownership of the resource")
model Ownership {
  @doc("The owning service tree ID")
  serviceTreeId?: string;

  @doc("The owning subscription ID")
  subscriptionId?: string;
}
