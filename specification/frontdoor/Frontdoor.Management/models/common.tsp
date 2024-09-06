using Azure.Core;

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

@doc("AssetType enum")
union AssetType {
  string,

  @doc("AssetType enum BaremetalVM")
  BaremetalVM: "BaremetalVM",
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
