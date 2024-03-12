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

scalar ClusterResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar ServerResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar DatacenterResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar AvailabilityZoneResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar FacilityResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

scalar AzureRegionResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;
