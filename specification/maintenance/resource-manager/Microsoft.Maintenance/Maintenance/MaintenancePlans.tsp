import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./maintenancePlans.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.Maintenance;

/**
 * Maintenance plan extension/proxy resource
 */
model MaintenancePlan
  is Azure.ResourceManager.ProxyResource<MaintenancePlanProperties> {
  ...ResourceNameParameter<
    Resource = MaintenancePlan,
    KeyName = "maintenancePlanName",
    SegmentName = "maintenancePlans",
    NamePattern = ""
  >;
}

@armResourceOperations
interface MaintenancePlanOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * Resource provider name for the target resource (e.g., Microsoft.Compute)
         */
        @path
        @key
        @segment("providers")
        providerName: string,

        /**
         * Target resource type (e.g., supercomputer)
         */
        @path
        @key
        resourceType: string,

        /**
         * Target resource name
         */
        @path
        @key
        resourceName: string,
      },
      {},
      {
        ...Extension.ExtensionProviderNamespace<MaintenancePlan>,
        ...KeysOf<ResourceNameParameter<
          Resource = MaintenancePlan,
          KeyName = "maintenancePlanName",
          SegmentName = "maintenancePlans",
          NamePattern = ""
        >>,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "DELETE operations are not supported for MaintenancePlan resource. Expected error suppression."
@armResourceOperations
interface MaintenancePlans {
  /**
   * Create Maintenance Plan for a resource
   */
  createOrUpdate is MaintenancePlanOps.CreateOrUpdateSync<
    MaintenancePlan,
    ErrorType = MaintenanceError,
    OptionalRequestBody = false,
    Response = ArmResponse<MaintenancePlansResponse> | ArmCreatedResponse<MaintenancePlansResponse>
  >;

  /**
   * Get Maintenance Plan for a resource
   */
  get is MaintenancePlanOps.Read<
    MaintenancePlan,
    ErrorType = MaintenanceError,
    Response = ArmResponse<MaintenancePlansResponse>
  >;
}

/**
 * List operation for MaintenancePlans with custom query parameters.
 * Kept as an explicit route to avoid ARM route composition producing a malformed path.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This interface intentionally uses an explicit @route instead of @armResourceOperations templates."
interface MaintenancePlansCollectionRoutes {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Explicit @route list operation (custom query parameter)."
  @tag("MaintenancePlans")
  @summary("List Maintenance Plans for a resource")
  @doc("Lists all Maintenance Plans for a resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceName}/providers/Microsoft.Maintenance/maintenancePlans")
  @get
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** Resource provider name for the target resource (e.g., Microsoft.Compute). */
    @path
    providerName: string,

    /** Target resource type (e.g., supercomputer). */
    @path
    resourceType: string,

    /** Target resource name. */
    @path
    resourceName: string,

    /** Whether to return inactive maintenance plans as well. Default: active only. */
    @query
    includeInactive?: boolean,
  ): ArmResponse<ListMaintenancePlansResult> | MaintenanceError;
}

@@doc(MaintenancePlan.name, "Maintenance plan.");
@@doc(MaintenancePlan.properties, "Properties of the maintenance plan.");
