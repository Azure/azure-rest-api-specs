import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Management;
/**
 * The management group details.
 */
@tenantResource
model ManagementGroup
  is Azure.ResourceManager.ProxyResource<ManagementGroupProperties> {
  ...ResourceNameParameter<
    Resource = ManagementGroup,
    KeyName = "groupId",
    SegmentName = "managementGroups",
    NamePattern = ""
  >;

  /**
   * The type of the resource.  For example, Microsoft.Management/managementGroups
   */
  @visibility("read")
  type?: string;
}

@armResourceOperations
interface ManagementGroups {
  /**
   * Get the details of the management group.
   *
   */
  get is ArmResourceRead<
    ManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.TenantBaseParameters;

      /**
       * The $expand=children query string parameter allows clients to request inclusion of children in the response payload.  $expand=path includes the path from the root group to the current group.  $expand=ancestors includes the ancestor Ids of the current group.
       */
      @query("$expand")
      $expand?: ManagementGroupExpandType;

      /**
       * The $recurse=true query string parameter allows clients to request inclusion of entire hierarchy in the response payload. Note that  $expand=children must be passed up if $recurse is set to true.
       */
      @query("$recurse")
      $recurse?: boolean;

      /**
       * A filter which allows the exclusion of subscriptions from results (i.e. '$filter=children.childType ne Subscription')
       */
      @query("$filter")
      $filter?: string;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Create or update a management group.
   * If a management group is already created and a subsequent create request is issued with different properties, the management group properties will be updated.
   *
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.TenantBaseParameters;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Update a management group.
   *
   */
  @parameterVisibility
  update is ArmCustomPatchSync<
    ManagementGroup,
    PatchManagementGroupRequest,
    {
      ...Azure.ResourceManager.Foundations.TenantBaseParameters;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * Delete management group.
   * If a management group contains child resources, the request will fail.
   *
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagementGroup,
    {
      ...Azure.ResourceManager.Foundations.TenantBaseParameters;

      /**
       * Indicates whether the request should utilize any caches. Populate the header with 'no-cache' value to bypass existing caches.
       */
      @header
      `Cache-Control`?: string = "no-cache";
    }
  >;

  /**
   * List management groups for the authenticated user.
   *
   */
  list is ArmListBySubscription<ManagementGroup>;

  /**
   * List all entities that descend from a management group.
   *
   */
  // FIXME: ManagementGroups_GetDescendants could not be converted to a resource operation
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/descendants")
  @get
  getDescendants(
    ...ApiVersionParameter,

    /**
     * Management Group ID.
     */
    @path
    groupId: string,

    /**
     * Page continuation token is only used if a previous operation returned a partial result.
     * If a previous response contains a nextLink element, the value of the nextLink element will include a token parameter that specifies a starting point to use for subsequent calls.
     *
     */
    @query("$skiptoken")
    $skiptoken?: string,

    /**
     * Number of elements to return when retrieving results. Passing this in will override $skipToken.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<DescendantListResult> | ErrorResponse;

  /**
   * Gets all the hierarchy settings defined at the Management Group level. Settings can only be set on the root Management Group of the hierarchy.
   *
   */
  // FIXME: HierarchySettings_List could not be converted to a resource operation
  @route("/providers/Microsoft.Management/managementGroups/{groupId}/settings")
  @get
  listSettings(
    ...ApiVersionParameter,

    /**
     * Management Group ID.
     */
    @path
    groupId: string,
  ): ArmResponse<ResourceListResult<HierarchySettings>> | ErrorResponse;
}

@@doc(ManagementGroup.name, "Management Group ID.");
@@doc(ManagementGroups.createOrUpdate::parameters.resource,
  "Management group creation parameters."
);
@@doc(ManagementGroups.update::parameters.properties,
  "Management group patch parameters."
);
