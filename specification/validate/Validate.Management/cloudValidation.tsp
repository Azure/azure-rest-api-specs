import "./common.tsp";
import "@typespec/rest";
import "@typespec/openapi3";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("Cloud Validation Resource")
model CloudValidation is TrackedResource<CloudValidationProperties> {
  ...ResourceNameParameter<CloudValidation>;
}

@doc("Cloud Validation properties")
model CloudValidationProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The overall state of the resource.")
  overallState?: CloudValidationOverallState;

  @visibility(Lifecycle.Read)
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;
}

@doc("The resource provisioning state.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is updating.")
  Updating: "Updating",

  @doc("The resource is being disabled.")
  Disabling: "Disabling",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  @doc("The resource create request has been accepted")
  Accepted: "Accepted",

  string,
}

@doc("The Overall states of the validation resource.")
union CloudValidationOverallState {
  @doc("The resource is in enabled state.")
  Enabled: "Enabled",

  string,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
@tag("Cloud Validation Interfaces")
interface CloudValidations {
  @doc("Get a cloud validation")
  get is ArmResourceRead<CloudValidation>;

  @doc("Create or update a cloud validation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CloudValidation>;

  @doc("Update a cloud validation")
  @parameterVisibility(Lifecycle.Update)
  update is ArmResourcePatchAsync<CloudValidation, CloudValidationProperties>;

  @doc("Delete a cloud validation")
  delete is ArmResourceDeleteWithoutOkAsync<CloudValidation>;

  @doc("List cloud validations by resource group")
  listByResourceGroup is ArmResourceListByParent<
    CloudValidation,
    Parameters = StandardListQueryParameters &
      OrderByQueryParameter &
      FilterQueryParameter
  >;

  @doc("List cloud validations by subscription")
  listBySubscription is ArmListBySubscription<
    CloudValidation,
    StandardListQueryParameters & OrderByQueryParameter & FilterQueryParameter
  >;
}
