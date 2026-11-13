import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace IntegrationRuntimes;
/**
 * Integration runtime resource type.
 */
model IntegrationRuntimeResource is Azure.ResourceManager.ProxyResource<
  IntegrationRuntime,
  false
> {
  ...ResourceNameParameter<
    Resource = IntegrationRuntimeResource,
    KeyName = "integrationRuntimeName",
    SegmentName = "integrationRuntimes",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "EntityTagProperty models the read-only etag that the published integration runtime resource already returns."
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias IntegrationRuntimeOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** Integration runtime name */
    @segment("integrationRuntimes")
    @key
    @path
    integrationRuntimeName: string;
  }
>;

alias IntegrationRuntimeNodeOps = Azure.ResourceManager.Legacy.LegacyOperations<
  IntegrationRuntimeParentParameters,
  {
    /** Integration runtime node name */
    @segment("nodes")
    @key
    @path
    nodeName: string;
  }
>;

alias IntegrationRuntimeRoutedOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    workspaceName: string;

    /** Integration runtime name */
    @path
    @segment("integrationRuntimes")
    @key
    integrationRuntimeName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface IntegrationRuntimeResources {
  /**
   * Get an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Get")
  get is IntegrationRuntimeOps.Read<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Parameter is named after the published header so the emitted OpenAPI keeps the exact If-None-Match parameter without a client-name override."
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<IntegrationRuntimeResource> | NotModifiedResponse
  >;

  /**
   * Create an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("IntegrationRuntimes_Create")
  create is IntegrationRuntimeOps.CreateOrUpdateAsync<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Parameter is named after the published header so the emitted OpenAPI keeps the exact If-Match parameter without a client-name override."
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | ArmResourceUpdatedResponse<IntegrationRuntimeResource>
      | ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmLroLocationHeader<FinalResult = IntegrationRuntimeResource> &
            Azure.Core.Foundations.RetryAfterHeader
        >,
    LroHeaders = ArmLroLocationHeader<FinalResult = IntegrationRuntimeResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "The published PATCH body (autoUpdate, updateDelayOffset) is a dedicated update request, not a subset of the resource."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Update")
  @patch(#{ implicitOptionality: false })
  update is IntegrationRuntimeOps.CustomPatchSync<
    IntegrationRuntimeResource,
    PatchModel = UpdateIntegrationRuntimeRequest
  >;

  /**
   * Delete an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("IntegrationRuntimes_Delete")
  delete is IntegrationRuntimeOps.DeleteWithoutOkAsync<
    IntegrationRuntimeResource,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * List all integration runtimes
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_ListByWorkspace")
  listByWorkspace is IntegrationRuntimeOps.List<
    IntegrationRuntimeResource,
    Response = ArmResponse<IntegrationRuntimeListResponse>
  >;

  /**
   * Upgrade an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Upgrade")
  upgrade is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse
  >;

  /**
   * Start an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The published operation polls via Azure-AsyncOperation (final-state-via: azure-async-operation); adding Location would change the polling metadata."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Start")
  start is IntegrationRuntimeOps.ActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = IntegrationRuntimeStatusResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stop an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Stop")
  stop is IntegrationRuntimeOps.ActionAsync<
    IntegrationRuntimeResource,
    void,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Gets the list of outbound network dependencies for a given Azure-SSIS integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_ListOutboundNetworkDependenciesEndpoints")
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse>
  >;

  /**
   * Enable interactive query in integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_EnableInteractiveQuery")
  enableInteractiveQuery is IntegrationRuntimeOps.ActionAsync<
    IntegrationRuntimeResource,
    void,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Disable interactive query in integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_DisableInteractiveQuery")
  disableInteractiveQuery is IntegrationRuntimeOps.ActionAsync<
    IntegrationRuntimeResource,
    void,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Get the IP address of an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeNodeIpAddress_Get")
  @action("ipAddress")
  integrationRuntimeNodeIpAddressGet is IntegrationRuntimeNodeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeNodeIpAddress>
  >;

  /**
   * Get object metadata from an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeObjectMetadata_List")
  @action("getObjectMetadata")
  list is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    GetSsisObjectMetadataRequest,
    ArmResponse<SsisObjectMetadataListResponse>,
    OptionalRequestBody = true
  >;

  /**
   * Refresh the object metadata in an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "The published operation polls via Azure-AsyncOperation (final-state-via: azure-async-operation); adding Location would change the polling metadata."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeObjectMetadata_Refresh")
  @action("refreshObjectMetadata")
  refresh is IntegrationRuntimeOps.ActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<SsisObjectMetadataStatusResponse>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = SsisObjectMetadataStatusResponse> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeNodes_Get")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  integrationRuntimeNodesGet is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<SelfHostedIntegrationRuntimeNode>,
    Parameters = {
      /**
       * Integration runtime node name
       */
      @path
      nodeName: string;
    }
  >;

  /**
   * Create an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeNodes_Update")
  @patch
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  integrationRuntimeNodesUpdate is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    UpdateIntegrationRuntimeNodeRequest,
    ArmResponse<SelfHostedIntegrationRuntimeNode>,
    Parameters = {
      /**
       * Integration runtime node name
       */
      @path
      nodeName: string;
    }
  >;

  /**
   * Delete an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeNodes_Delete")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  integrationRuntimeNodesDelete is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Integration runtime node name
       */
      @path
      nodeName: string;
    }
  >;

  /**
   * Force the integration runtime to synchronize credentials across integration runtime nodes, and this will override the credentials across all worker nodes with those available on the dispatcher node. If you already have the latest credential backup file, you should manually import it (preferred) on any self-hosted integration runtime node than using this API directly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeCredentials_Sync")
  @action("syncCredentials")
  sync is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse
  >;

  /**
   * Get connection info for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeConnectionInfos_Get")
  @action("getConnectionInfo")
  integrationRuntimeConnectionInfosGet is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeConnectionInfo>
  >;

  /**
   * Regenerate the authentication key for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeAuthKeys_Regenerate")
  @action("regenerateAuthKey")
  regenerate is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    IntegrationRuntimeRegenerateKeyParameters,
    ArmResponse<IntegrationRuntimeAuthKeys>
  >;

  /**
   * List authentication keys in an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeAuthKeys_List")
  @action("listAuthKeys")
  integrationRuntimeAuthKeysList is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeAuthKeys>
  >;

  /**
   * Get monitoring data for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeMonitoringData_List")
  @action("monitoringData")
  integrationRuntimeMonitoringDataList is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeMonitoringData>
  >;

  /**
   * Get the integration runtime status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimeStatus_Get")
  @action("getStatus")
  integrationRuntimeStatusGet is IntegrationRuntimeOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>
  >;

  /**
   * Get an integration runtime start operation status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Get_IntegrationRuntimeStart")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/start/operationstatuses/{integrationRuntimeOperationId}")
  integrationRuntimeStart is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeOperationStatus>,
    Parameters = {
      /**
       * Integration runtime Operation Id
       */
      @path
      integrationRuntimeOperationId: string;
    }
  >;

  /**
   * Get an integration runtime stop operation status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Get_IntegrationRuntimeStop")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/stop/operationstatuses/{integrationRuntimeOperationId}")
  integrationRuntimeStop is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStopOperationStatus>,
    Parameters = {
      /**
       * Integration runtime Operation Id
       */
      @path
      integrationRuntimeOperationId: string;
    }
  >;

  /**
   * Get an integration runtime enable interactivequery operation status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Get_IntegrationRuntimeEnableInteractivequery")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/integrationRuntimes/{integrationRuntimeName}/enableinteractivequery/operationstatuses/{integrationRuntimeOperationId}")
  integrationRuntimeEnableInteractivequery is IntegrationRuntimeRoutedOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeEnableinteractivequery>,
    Parameters = {
      /**
       * Integration runtime Operation Id
       */
      @path
      integrationRuntimeOperationId: string;
    }
  >;
}

@@doc(IntegrationRuntimeResource.name, "Integration runtime name");
@@doc(IntegrationRuntimeResource.properties, "Integration runtime properties.");
@@doc(
  IntegrationRuntimeResources.create::parameters.resource,
  "Integration runtime resource definition."
);
@@doc(
  IntegrationRuntimeResources.update::parameters.properties,
  "The parameters for updating an integration runtime."
);
@@doc(
  IntegrationRuntimeResources.list::parameters.body,
  "The parameters for getting a SSIS object metadata."
);
@@doc(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "The parameters for updating an integration runtime node."
);
@@doc(
  IntegrationRuntimeResources.regenerate::parameters.body,
  "The parameters for regenerating integration runtime authentication key."
);
