import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * Integration runtime resource type.
 */
@parentResource(Workspace)
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
}

@armResourceOperations
interface IntegrationRuntimeResources {
  /**
   * Get an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Get")
  get is ArmResourceRead<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Create an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("IntegrationRuntimes_Create")
  create is ArmResourceCreateOrReplaceAsync<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    },
    Response =
      | ArmResourceUpdatedResponse<IntegrationRuntimeResource>
      | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("IntegrationRuntimes_Update")
  update is ArmCustomPatchSync<
    IntegrationRuntimeResource,
    PatchModel = UpdateIntegrationRuntimeRequest
  >;

  /**
   * Delete an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("IntegrationRuntimes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
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
  listByWorkspace is ArmResourceListByParent<
    IntegrationRuntimeResource,
    Response = ArmResponse<IntegrationRuntimeListResponse>
  >;

  /**
   * Upgrade an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Upgrade")
  upgrade is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse
  >;

  /**
   * Start an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Start")
  start is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Stop an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_Stop")
  stop is ArmResourceActionAsync<IntegrationRuntimeResource, void, OkResponse>;

  /**
   * Gets the list of outbound network dependencies for a given Azure-SSIS integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("outboundNetworkDependenciesEndpoints")
  @operationId("IntegrationRuntimes_ListOutboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse>
  >;

  /**
   * Enable interactive query in integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_EnableInteractiveQuery")
  enableInteractiveQuery is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    OkResponse
  >;

  /**
   * Disable interactive query in integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IntegrationRuntimes_DisableInteractiveQuery")
  disableInteractiveQuery is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    OkResponse
  >;

  /**
   * Get the IP address of an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("ipAddress")
  @operationId("IntegrationRuntimeNodeIpAddress_Get")
  integrationRuntimeNodeIpAddressGet is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeNodeIpAddress>,
    Parameters = {
      /**
       * Integration runtime node name
       */
      @path
      nodeName: string;
    }
  >;

  /**
   * Get object metadata from an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getObjectMetadata")
  @operationId("IntegrationRuntimeObjectMetadata_List")
  list is ArmResourceActionSync<
    IntegrationRuntimeResource,
    {
      /**
       * The parameters for getting a SSIS object metadata.
       */
      @bodyRoot
      getMetadataRequest?: GetSsisObjectMetadataRequest;
    },
    ArmResponse<SsisObjectMetadataListResponse>
  >;

  /**
   * Refresh the object metadata in an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("refreshObjectMetadata")
  @operationId("IntegrationRuntimeObjectMetadata_Refresh")
  refresh is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<SsisObjectMetadataStatusResponse>,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get an integration runtime node
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{nodeName}")
  @operationId("IntegrationRuntimeNodes_Get")
  integrationRuntimeNodesGet is ArmResourceActionSync<
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
  @patch
  @action("{nodeName}")
  @operationId("IntegrationRuntimeNodes_Update")
  integrationRuntimeNodesUpdate is ArmResourceActionSync<
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
  @delete
  @action("{nodeName}")
  @operationId("IntegrationRuntimeNodes_Delete")
  integrationRuntimeNodesDelete is ArmResourceActionSync<
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
  @action("syncCredentials")
  @operationId("IntegrationRuntimeCredentials_Sync")
  sync is ArmResourceActionSync<IntegrationRuntimeResource, void, OkResponse>;

  /**
   * Get connection info for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getConnectionInfo")
  @operationId("IntegrationRuntimeConnectionInfos_Get")
  integrationRuntimeConnectionInfosGet is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeConnectionInfo>
  >;

  /**
   * Regenerate the authentication key for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("regenerateAuthKey")
  @operationId("IntegrationRuntimeAuthKeys_Regenerate")
  regenerate is ArmResourceActionSync<
    IntegrationRuntimeResource,
    IntegrationRuntimeRegenerateKeyParameters,
    ArmResponse<IntegrationRuntimeAuthKeys>
  >;

  /**
   * List authentication keys in an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("listAuthKeys")
  @operationId("IntegrationRuntimeAuthKeys_List")
  integrationRuntimeAuthKeysList is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeAuthKeys>
  >;

  /**
   * Get monitoring data for an integration runtime
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("monitoringData")
  @operationId("IntegrationRuntimeMonitoringData_List")
  integrationRuntimeMonitoringDataList is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeMonitoringData>
  >;

  /**
   * Get the integration runtime status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("getStatus")
  @operationId("IntegrationRuntimeStatus_Get")
  integrationRuntimeStatusGet is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>
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
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "The parameters for updating an integration runtime node."
);
@@doc(
  IntegrationRuntimeResources.regenerate::parameters.body,
  "The parameters for regenerating integration runtime authentication key."
);
