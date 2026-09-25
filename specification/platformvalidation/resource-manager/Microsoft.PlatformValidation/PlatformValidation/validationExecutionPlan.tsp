import "./common.tsp";
import "./cloudValidation.tsp";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.PlatformValidation;

@doc("Validation Test Execution Plan")
@parentResource(CloudValidation)
model ValidationExecutionPlan
  is TrackedResource<ValidationExecutionPlanProperties> {
  ...ResourceNameParameter<ValidationExecutionPlan>;
}

@doc("Validation Test Execution Plan properties")
model ValidationExecutionPlanProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("""
    URI where the configuration of the execution plan is defined.
    Either this property or `planConfigurationJson` is mandatory while creating; they are mutually exclusive.
    This must be a plain, non-SAS reference (no embedded credentials, tokens, or query-string secrets);
    the service reads the referenced content using its managed identity.
    This value is returned as-is in get responses, so it must not contain credentials or other secrets.
    """)
  planConfigurationUri?: string;

  @doc("""
    Entire execution plan configuration/manifest json.
    Either this property or `planConfigurationUri` is mandatory while creating; they are mutually exclusive.
    In get, always return the entire json configuration.
    This value is returned as-is in get responses, so it must not contain credentials or other secrets.
    """)
  planConfigurationJson?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationExecutionPlanProvisioningState;

  @doc("Error details. Populated when provisioningState is Failed or Canceled.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("The execution plan resource provisioning state.")
@lroStatus
union ValidationExecutionPlanProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Creating: "Creating",

  @doc("The resource is updating.")
  Updating: "Updating",

  string,
}

@armResourceOperations
@tag("Validation Test Execution Plan Interfaces")
interface ValidationExecutionPlans {
  @doc("Get a validation test execution plan")
  get is ArmResourceRead<ValidationExecutionPlan>;

  @doc("Create or update a validation test execution plan")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ValidationExecutionPlan>;

  @doc("Update a validation test execution plan")
  update is ArmCustomPatchAsync<
    ValidationExecutionPlan,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      ValidationExecutionPlan,
      ValidationExecutionPlanProperties
    >
  >;

  @doc("Delete a validation test execution plan")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationExecutionPlan>;

  @doc("List validation test execution plans by resource group")
  listByResourceGroup is ArmResourceListByParent<
    ValidationExecutionPlan,
    Parameters = OdataFilterQueryParameter
  >;
}
