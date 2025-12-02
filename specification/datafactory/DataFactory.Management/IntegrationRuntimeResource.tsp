import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Integration runtime resource type.
 */
@parentResource(Factory)
model IntegrationRuntimeResource
  is Azure.ResourceManager.ProxyResource<IntegrationRuntime, false> {
  ...ResourceNameParameter<
    Resource = IntegrationRuntimeResource,
    KeyName = "integrationRuntimeName",
    SegmentName = "integrationRuntimes",
    NamePattern = "^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$"
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias IntegrationRuntimesOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("factories")
    @key
    @maxLength(63)
    @minLength(3)
    @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
    factoryName: string;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("integrationRuntimes")
    @key
    @maxLength(63)
    @minLength(3)
    @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
    integrationRuntimeName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface IntegrationRuntimeResources {
  /**
   * Gets an integration runtime.
   */
  get is ArmResourceRead<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<IntegrationRuntimeResource> | NotModifiedResponse,
    Error = CloudError
  >;

  /**
   * Creates or updates an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IntegrationRuntimeResource,
    Parameters = {
      /**
       * ETag of the integration runtime entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;
    },
    Response = ArmResourceUpdatedResponse<IntegrationRuntimeResource>,
    Error = CloudError
  >;

  /**
   * Updates an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    IntegrationRuntimeResource,
    PatchModel = UpdateIntegrationRuntimeRequest,
    Error = CloudError
  >;

  /**
   * Deletes an integration runtime.
   */
  delete is ArmResourceDeleteSync<
    IntegrationRuntimeResource,
    Error = CloudError
  >;

  /**
   * Lists integration runtimes.
   */
  listByFactory is ArmResourceListByParent<
    IntegrationRuntimeResource,
    Response = ArmResponse<IntegrationRuntimeListResponse>,
    Error = CloudError
  >;

  /**
   * Gets detailed status information for an integration runtime.
   */
  getStatus is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>,
    Error = CloudError
  >;

  /**
   * Gets the list of outbound network dependencies for a given Azure-SSIS integration runtime.
   */
  @list
  @get
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse>,
    Error = CloudError
  >;

  /**
   * Gets the on-premises integration runtime connection information for encrypting the on-premises data source credentials.
   */
  getConnectionInfo is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeConnectionInfo>,
    Error = CloudError
  >;

  /**
   * Regenerates the authentication key for an integration runtime.
   */
  regenerateAuthKey is ArmResourceActionSync<
    IntegrationRuntimeResource,
    IntegrationRuntimeRegenerateKeyParameters,
    ArmResponse<IntegrationRuntimeAuthKeys>,
    Error = CloudError
  >;

  /**
   * Retrieves the authentication keys for an integration runtime.
   */
  listAuthKeys is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeAuthKeys>,
    Error = CloudError
  >;

  /**
   * Starts a ManagedReserved type integration runtime.
   */
  start is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeStatusResponse>,
    Error = CloudError
  >;

  /**
   * Stops a ManagedReserved type integration runtime.
   */
  stop is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Force the integration runtime to synchronize credentials across integration runtime nodes, and this will override the credentials across all worker nodes with those available on the dispatcher node. If you already have the latest credential backup file, you should manually import it (preferred) on any self-hosted integration runtime node than using this API directly.
   */
  syncCredentials is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Get the integration runtime monitoring data, which includes the monitor data for all the nodes under this integration runtime.
   */
  @action("monitoringData")
  getMonitoringData is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeMonitoringData>,
    Error = CloudError
  >;

  /**
   * Upgrade self-hosted integration runtime to latest version if availability.
   */
  upgrade is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Remove all linked integration runtimes under specific data factory in a self-hosted integration runtime.
   */
  removeLinks is ArmResourceActionSync<
    IntegrationRuntimeResource,
    LinkedIntegrationRuntimeRequest,
    OkResponse,
    Error = CloudError
  >;

  /**
   * Create a linked integration runtime entry in a shared integration runtime.
   */
  @action("linkedIntegrationRuntime")
  createLinkedIntegrationRuntime is ArmResourceActionSync<
    IntegrationRuntimeResource,
    CreateLinkedIntegrationRuntimeRequest,
    ArmResponse<IntegrationRuntimeStatusResponse>,
    Error = CloudError
  >;

  /**
   * Refresh a SSIS integration runtime object metadata.
   */
  @action("refreshObjectMetadata")
  refresh is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<SsisObjectMetadataStatusResponse>,
    Error = CloudError
  >;

  /**
   * Get a SSIS integration runtime object metadata by specified path. The return is pageable metadata list.
   */
  @action("getObjectMetadata")
  integrationRuntimeObjectMetadataGet is ArmResourceActionSync<
    IntegrationRuntimeResource,
    GetSsisObjectMetadataRequest,
    ArmResponse<SsisObjectMetadataListResponse>,
    Error = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * Gets a self-hosted integration runtime node.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  integrationRuntimeNodesGet is IntegrationRuntimesOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<SelfHostedIntegrationRuntimeNode>,
    Parameters = {
      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a self-hosted integration runtime node.
   */
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  integrationRuntimeNodesDelete is IntegrationRuntimesOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Updates a self-hosted integration runtime node.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  @patch(#{ implicitOptionality: false })
  integrationRuntimeNodesUpdate is IntegrationRuntimesOps.ActionSync<
    IntegrationRuntimeResource,
    UpdateIntegrationRuntimeNodeRequest,
    Response = ArmResponse<SelfHostedIntegrationRuntimeNode>,
    Parameters = {
      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Get the IP address of self-hosted integration runtime node.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}/ipAddress")
  getIpAddress is IntegrationRuntimesOps.ActionSync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeNodeIpAddress>,
    Parameters = {
      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Enable interactive authoring of Managed Virtual Network integration runtime.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  enableInteractiveQuery is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    EnableInteractiveQueryRequest,
    ArmResponse<IntegrationRuntimeResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = IntegrationRuntimeResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disable interactive authoring of Managed Virtual Network integration runtime.
   */
  @Azure.Core.useFinalStateVia("azure-async-operation")
  disableInteractiveQuery is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    ArmResponse<IntegrationRuntimeResource>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = IntegrationRuntimeResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@maxLength(IntegrationRuntimeResource.name, 63);
@@minLength(IntegrationRuntimeResource.name, 3);
@@doc(IntegrationRuntimeResource.name, "The integration runtime name.");
@@doc(IntegrationRuntimeResource.properties, "Integration runtime properties.");
@@doc(IntegrationRuntimeResources.createOrUpdate::parameters.resource,
  "Integration runtime resource definition."
);
@@doc(IntegrationRuntimeResources.update::parameters.properties,
  "The parameters for updating an integration runtime."
);
@@doc(IntegrationRuntimeResources.regenerateAuthKey::parameters.body,
  "The parameters for regenerating integration runtime authentication key."
);
@@doc(IntegrationRuntimeResources.removeLinks::parameters.body,
  "The data factory name for the linked integration runtime."
);
@@doc(IntegrationRuntimeResources.createLinkedIntegrationRuntime::parameters.body,
  "The linked integration runtime properties."
);
@@doc(IntegrationRuntimeResources.integrationRuntimeObjectMetadataGet::parameters.body,
  "The parameters for getting a SSIS object metadata."
);
@@doc(IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "The parameters for updating an integration runtime node."
);
@@doc(IntegrationRuntimeResources.enableInteractiveQuery::parameters.body,
  "The enable interactive authoring integration runtime properties."
);
