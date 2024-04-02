@doc("Provisioning state enum")
enum ProvisioningState {
  @doc("The resource is being provisioned.")
  Provisioning,

  @doc("The resource action is successful.")
  Succeeded,

  @doc("The resource action has failed.")
  Failed,

  @doc("The resource action has been cancelled.")
  Canceled,

  @doc("The resource provisioning has been accepted.")
  Accepted,

  @doc("The resource is being created.")
  Creating,

  @doc("The resource is being updated.")
  Updating,

  @doc("The resource is being deleted.")
  Deleting,

  @doc("The resource has been deleted.")
  Deleted,

  @doc("The resource status is unspecified.")
  NotSpecified,
}

scalar DatacenterResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

@doc("OsType enum")
enum OsType {
  @doc("OsType enum Windows")
  Windows: "Windows",

  @doc("OsType enum Windows")
  Linux: "Linux",
}

@doc("Environment enum")
enum Environment {
  @doc("Environment enum Prod")
  Prod: "Prod",

  @doc("Environment enum PPE (known 1st party customer data managed pre-prod traffic/canary)")
  PPE: "PPE",

  @doc("Environment enum Test")
  Test: "Test",
}

@doc("AssetType enum")
enum AssetType {
  @doc("AssetType enum BaremetalVM")
  BaremetalVM: "BaremetalVM",
}

@doc("Cloud enum")
enum Cloud {
  @doc("Cloud enum Public")
  Public: "Public",
}

@doc("Status enum")
enum Status {
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
