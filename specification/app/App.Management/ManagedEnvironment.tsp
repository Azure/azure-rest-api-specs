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

alias ManagedEnvironmentOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** Name of the managed environment. */
    @path
    @segment("managedEnvironments")
    @key
    @pattern("^[-\\w\\._\\(\\)]+$")
    environmentName: string;
  }
>;

@armResourceOperations
interface ManagedEnvironments {
  /**
   * Get the properties of a Managed Environment used to host container apps.
   */
  @summary("Get the properties of a Managed Environment.")
  get is ArmResourceRead<ManagedEnvironment>;

  /**
   * Creates or updates a Managed Environment used to host container apps.
   */
  @summary("Creates or updates a Managed Environment.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedEnvironment,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedEnvironment> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Patches a Managed Environment using JSON Merge Patch
   */
  @patch(#{ implicitOptionality: false })
  @summary("Update Managed Environment's properties.")
  update is ArmCustomPatchAsync<
    ManagedEnvironment,
    PatchModel = ManagedEnvironment
  >;

  /**
   * Delete a Managed Environment if it does not have any container apps.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Delete a Managed Environment.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedEnvironment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the Managed Environments in a resource group.
   */
  @summary("Get all the Managed Environments in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedEnvironment,
    Response = ArmResponse<ManagedEnvironmentsCollection>
  >;

  /**
   * Get all Managed Environments for a subscription.
   */
  @summary("Get all Environments for a subscription.")
  listBySubscription is ArmListBySubscription<
    ManagedEnvironment,
    Response = ArmResponse<ManagedEnvironmentsCollection>
  >;

  /**
   * Checks if resource name is available.
   */
  @action("getAuthtoken")
  @summary("Get auth token for a managed environment")
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
  @summary("Get all workload Profile States for a Managed Environment..")
  listWorkloadProfileStates is ArmResourceActionSync<
    ManagedEnvironment,
    void,
    ArmResponse<workloadProfileStatesCollection>
  >;

  /**
   * Checks if resource name is available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Namespaces_CheckNameAvailability")
  @summary("Checks the resource name availability.")
  checkNameAvailability is ArmResourceActionSync<
    ManagedEnvironment,
    Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
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
  @tag("PrivateLinkResources")
  @summary("List private link resources for a given managed environment.")
  list is ManagedEnvironmentOps.ActionSync<
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
