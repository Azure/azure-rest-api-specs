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

@doc("Model that describes a generic ARM object")
model ComplexArmObject {
  @doc("The display name of the object")
  displayName: string;

  @doc("The id of the object")
  id: string;

  @doc("The ARM resource ID of the object")
  resourceId: string;
}

scalar ClusterResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar ServerResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar DatacenterResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar AvailabilityZoneResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar FacilityResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar AzureRegionResourceId
  extends armResourceIdentifier<[
    {
      type: "string",
    }
  ]>;
