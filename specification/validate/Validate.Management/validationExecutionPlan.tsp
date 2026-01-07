import "./common.tsp";
import "./cloudValidation.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Validate;

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

  @doc("URI where the configuration of the execution plan is defined.")
  planConfigurationUri?: string;

  @doc("""
    Entire execution plan configuration/manifest json.
    Either of URI or this property is mandatory while creating.
    In get, always return the entire json configuration.
    """)
  planConfigurationJson?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationExecutionPlanProvisioningState;

  @doc("The overall state of the resource.")
  overallState?: ValidationExecutionPlanOverallState;
}

@doc("The execution plan resource provisioning state.")
@lroStatus
union ValidationExecutionPlanProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Creating: "Creating",

  @doc("The resource is updating.")
  Updating: "Updating",

  @doc("The resource is being disabled.")
  Disabling: "Disabling",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  string,
}

@doc("The Overall states of the validation execution plan.")
union ValidationExecutionPlanOverallState {
  @doc("The resource is in enabled state.")
  Enabled: "Enabled",

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
  @parameterVisibility(Lifecycle.Update)
  update is ArmResourcePatchAsync<
    ValidationExecutionPlan,
    ValidationExecutionPlanProperties
  >;

  @doc("Delete a validation test execution plan")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationExecutionPlan>;

  @doc("List validation test execution plans by resource group")
  listByResourceGroup is ArmResourceListByParent<
    ValidationExecutionPlan,
    Parameters = StandardListQueryParameters &
      OrderByQueryParameter &
      FilterQueryParameter
  >;

  @doc("List validation test execution plans by subscription")
  listBySubscription is ArmListBySubscription<
    ValidationExecutionPlan,
    StandardListQueryParameters & OrderByQueryParameter & FilterQueryParameter
  >;
}
