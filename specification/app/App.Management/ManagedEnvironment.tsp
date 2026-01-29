import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * An environment for hosting container apps
 */
model ManagedEnvironment
  is Azure.ResourceManager.TrackedResource<ManagedEnvironmentProperties> {
  ...ResourceNameParameter<
    Resource = ManagedEnvironment,
    KeyName = "environmentName",
    SegmentName = "managedEnvironments",
    NamePattern = ""
  >;

  /**
   * Kind of the Environment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ManagedEnvironments {
  /**
   * Get the properties of a Managed Environment used to host container apps.
   */
  get is ArmResourceRead<ManagedEnvironment>;

  /**
   * Creates or updates a Managed Environment used to host container apps.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedEnvironment,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedEnvironment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patches a Managed Environment using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ManagedEnvironment,
    PatchModel = ManagedEnvironment
  >;

  /**
   * Delete a Managed Environment if it does not have any container apps.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the Managed Environments in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ManagedEnvironment,
    Response = ArmResponse<ManagedEnvironmentsCollection>
  >;

  /**
   * Get all Managed Environments for a subscription.
   */
  listBySubscription is ArmListBySubscription<
    ManagedEnvironment,
    Response = ArmResponse<ManagedEnvironmentsCollection>
  >;

  /**
   * Checks if resource name is available.
   */
  @action("getAuthtoken")
  getAuthToken is ArmResourceActionSync<
    ManagedEnvironment,
    void,
    ArmResponse<EnvironmentAuthToken>
  >;

  /**
   * Get all workload Profile States for a Managed Environment.
   */
  @list
  @get
  @action("workloadProfileStates")
  listWorkloadProfileStates is ArmResourceActionSync<
    ManagedEnvironment,
    void,
    ArmResponse<WorkloadProfileStatesCollection>
  >;

  /**
   * Checks if resource name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_CheckNameAvailability")
  checkNameAvailability is ArmResourceActionSync<
    ManagedEnvironment,
    CheckNameAvailabilityRequest,
    ArmResponse<Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse>
  >;

  /**
   * List private link resources for a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedEnvironmentPrivateLinkResources_List")
  @list
  @get
  @action("privateLinkResources")
  list is ArmResourceActionSync<
    ManagedEnvironment,
    void,
    ArmResponse<ResourceListResult<PrivateLinkResource>>
  >;
}

@@doc(ManagedEnvironment.name, "Name of the Environment.");
@@doc(ManagedEnvironment.properties,
  "Managed environment resource specific properties"
);
@@doc(ManagedEnvironments.createOrUpdate::parameters.resource,
  "Configuration details of the Environment."
);
@@doc(ManagedEnvironments.update::parameters.properties,
  "Configuration details of the Environment."
);
@@doc(ManagedEnvironments.checkNameAvailability::parameters.body,
  "The check name availability request."
);
