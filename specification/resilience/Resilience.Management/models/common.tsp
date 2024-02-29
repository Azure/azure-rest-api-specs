import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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

scalar ARMResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "string",
    }
  ]>;

@doc("Availability Zones Resilience state enum")
enum ZoneResilienceState {
  @doc("The resource is zone-aligned.")
  ZoneAligned,

  @doc("The resource is zone-redundant.")
  ZoneRedundant,

  @doc("The resource is always-available.")
  AlwaysAvailable,

  @doc("The zone resilience state is not-applicable.")
  NotApplicable,

  @doc("The resource is non-resilient.")
  NonResilient,
}
