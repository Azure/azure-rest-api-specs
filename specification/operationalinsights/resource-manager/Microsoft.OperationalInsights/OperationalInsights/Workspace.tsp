import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * The top level Workspace resource container.
 */
model Workspace is Azure.ResourceManager.TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  /**
   * The etag of the workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

alias SchemaOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * The name of the schema.
     */
    @path
    @segment("schema")
    @key("schemaName")
    schemaName: string;
  }
>;

alias GatewayOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * The Log Analytics gateway Id.
     */
    @path
    @segment("gateways")
    @key("gatewayId")
    gatewayId: string;
  }
>;

alias PurgeOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * In a purge status request, this is the Id of the operation the status of which is returned.
     */
    @path
    @segment("operations")
    @key("purgeId")
    purgeId: string;
  }
>;

alias IntelligencePackOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * The name of the intelligence pack.
     */
    @path
    @segment("intelligencePacks")
    @key("intelligencePackName")
    intelligencePackName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks/{intelligencePackName}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface Workspaces {
  /**
   * Gets a workspace instance.
   */
  @tag("Workspaces")
  @autoRoute
  get is ArmResourceRead<Workspace>;

  /**
   * Create or update a workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Workspaces")
  @autoRoute
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Workspace,
    Response =
      | ArmResourceUpdatedResponse<Workspace>
      | ArmResourceCreatedResponse<
          Workspace,
          ArmLroLocationHeader<FinalResult = Workspace> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Updates a workspace.
   */
  @tag("Workspaces")
  @autoRoute
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Workspace, PatchModel = WorkspacePatch>;

  /**
   * Deletes a workspace resource. To recover the workspace, create it again with the same name, in the same subscription, resource group and location. The name is kept for 14 days and cannot be used for another workspace. To remove the workspace completely and release the name, use the force flag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Workspaces")
  @autoRoute
  delete is ArmResourceDeleteWithoutOkAsync<
    Workspace,
    Parameters = {
      /**
       * Deletes the workspace without the recovery option. A workspace that was deleted with this flag cannot be recovered.
       */
      @query("force")
      force?: boolean;
    },
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Gets workspaces in a resource group.
   */
  @tag("Workspaces")
  @autoRoute
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Response = ArmResponse<WorkspaceListResult>
  >;

  /**
   * Gets the workspaces in a subscription.
   */
  @tag("Workspaces")
  @autoRoute
  list is ArmListBySubscription<
    Workspace,
    Response = ArmResponse<WorkspaceListResult>
  >;

  /**
   * Gets the available service tiers for the workspace.
   */
  @tag("AvailableServiceTiers")
  @get
  @action("availableServiceTiers")
  @autoRoute
  listByWorkspace is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<AvailableServiceTier[]>
  >;

  /**
   * Delete a Log Analytics gateway.
   */
  @tag("Workspaces")
  @autoRoute
  gatewaysDelete is GatewayOps.DeleteSync<Workspace, Response = OkResponse>;

  /**
   * Disables an intelligence pack for a given workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Workspaces")
  @tag("IntelligencePacks")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks/{intelligencePackName}/Disable")
  disable is IntelligencePackOps.ActionSync<
    Workspace,
    void,
    Response = OkResponse | ErrorResponse
  >;

  /**
   * Enables an intelligence pack for a given workspace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Workspaces")
  @tag("IntelligencePacks")
  @post
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/intelligencePacks/{intelligencePackName}/Enable")
  enable is IntelligencePackOps.ActionSync<
    Workspace,
    void,
    Response = OkResponse | ErrorResponse
  >;

  /**
   * Lists all the intelligence packs possible and whether they are enabled or disabled for a given workspace.
   */
  @tag("Workspaces")
  @tag("IntelligencePacks")
  @get
  @action("intelligencePacks")
  @autoRoute
  intelligencePacksList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<IntelligencePack[]>
  >;

  /**
   * Gets a list of management groups connected to a workspace.
   */
  @tag("Workspaces")
  @list
  @get
  @action("managementGroups")
  @autoRoute
  managementGroupsList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<WorkspaceListManagementGroupsResult>
  >;

  /**
   * Gets the schema for a given workspace.
   */
  @tag("Workspaces")
  @post
  @autoRoute
  schemaGet is SchemaOps.ListSinglePage<
    Workspace,
    Response = ArmResponse<SearchGetSchemaResponse>
  >;

  /**
   * Gets the shared keys for a workspace.
   */
  @tag("Workspaces")
  @action("sharedKeys")
  @autoRoute
  getSharedKeys is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<SharedKeys>
  >;

  /**
   * Regenerates the shared keys for a Log Analytics Workspace. These keys are used to connect Microsoft Operational Insights agents to the workspace.
   */
  @tag("Workspaces")
  @action("regenerateSharedKey")
  @autoRoute
  regenerate is ArmResourceActionSync<Workspace, void, ArmResponse<SharedKeys>>;

  /**
   * Gets a list of usage metrics for a workspace.
   */
  @tag("Workspaces")
  @list
  @get
  @action("usages")
  @autoRoute
  usagesList is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<WorkspaceListUsagesResult>
  >;

  /**
   * Purges data in an Log Analytics workspace by a set of user-defined filters.
   *
   * In order to manage system resources, purge requests are throttled at 50 requests per hour. You should batch the execution of purge requests by sending a single command whose predicate includes all user identities that require purging. Use the in operator to specify multiple identities. You should run the query prior to using for a purge request to verify that the results are expected.
   * Log Analytics only supports purge operations required for compliance with GDPR. The Log Analytics product team reserves the right to reject requests for purge operations that are not for the purpose of GDPR compliance. In the event of a dispute, please create a support ticket
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("Workspaces")
  @autoRoute
  purge is ArmResourceActionSync<
    Workspace,
    WorkspacePurgeBody,
    AcceptedResponse & {
      /** The location from which to request the operation status. */
      @header("x-ms-status-location")
      xMsStatusLocation: string;

      @bodyRoot
      _: WorkspacePurgeResponse;
    }
  >;

  /**
   * Gets status of an ongoing purge operation.
   */
  @tag("Workspaces")
  @autoRoute
  getPurgeStatus is PurgeOps.Read<
    Workspace,
    Response = ArmResponse<WorkspacePurgeStatusResponse>
  >;

  /**
   * Deactivates failover for the specified workspace.
   *
   * The failback operation is asynchronous and can take up to 30 minutes to complete. The status of the operation can be checked using the operationId returned in the response.
   */
  @tag("Workspaces")
  @autoRoute
  failback is ArmResourceActionAsyncBase<
    Workspace,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<Workspace>
  >;
}

@@maxLength(Workspace.name, 63);
@@minLength(Workspace.name, 4);
@@doc(Workspace.name, "The name of the workspace.");
@@doc(Workspace.properties, "Workspace properties.");
@@doc(
  Workspaces.createOrUpdate::parameters.resource,
  "The parameters required to create or update a workspace."
);
@@doc(
  Workspaces.update::parameters.properties,
  "The parameters required to patch a workspace."
);
@@doc(
  Workspaces.purge::parameters.body,
  "Describes the body of a request to purge data in a single table of an Log Analytics Workspace"
);
