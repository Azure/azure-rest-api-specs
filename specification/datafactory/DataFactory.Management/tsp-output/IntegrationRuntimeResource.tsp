import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataFactory;
@doc("Integration runtime resource type.")
@parentResource(Factory)
model IntegrationRuntimeResource is ProxyResource<IntegrationRuntime> {
  @doc("The integration runtime name.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @key("integrationRuntimeName")
  @segment("integrationRuntimes")
  name: string;
}

@armResourceOperations
interface IntegrationRuntimes {
  @doc("Gets an integration runtime.")
  get is ArmResourceRead<
    IntegrationRuntimeResource,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      @doc("ETag of the integration runtime entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.")
      @header
      `If-None-Match`?: string;
    }
  >;
  @doc("Creates or updates an integration runtime.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IntegrationRuntimeResource,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      @doc("ETag of the integration runtime entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.")
      @header
      `If-Match`?: string;
    }
  >;
  @doc("Updates an integration runtime.")
  update is ArmCustomPatchSync<
    IntegrationRuntimeResource,
    UpdateIntegrationRuntimeRequest
  >;
  @doc("Deletes an integration runtime.")
  delete is ArmResourceDeleteSync<IntegrationRuntimeResource>;
  @doc("Lists integration runtimes.")
  listByFactory is ArmResourceListByParent<IntegrationRuntimeResource>;
  @doc("Gets detailed status information for an integration runtime.")
  getStatus is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeStatusResponse
  >;
  @doc("Gets the on-premises integration runtime connection information for encrypting the on-premises data source credentials.")
  getConnectionInfo is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeConnectionInfo
  >;
  @doc("Regenerates the authentication key for an integration runtime.")
  regenerateAuthKey is ArmResourceActionSync<
    IntegrationRuntimeResource,
    IntegrationRuntimeRegenerateKeyParameters,
    IntegrationRuntimeAuthKeys
  >;
  @doc("Retrieves the authentication keys for an integration runtime.")
  listAuthKeys is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeAuthKeys
  >;
  @doc("Starts a ManagedReserved type integration runtime.")
  start is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeStatusResponse
  >;
  @doc("Stops a ManagedReserved type integration runtime.")
  stop is ArmResourceActionAsync<IntegrationRuntimeResource, void, void>;
  @doc("Force the integration runtime to synchronize credentials across integration runtime nodes, and this will override the credentials across all worker nodes with those available on the dispatcher node. If you already have the latest credential backup file, you should manually import it (preferred) on any self-hosted integration runtime node than using this API directly.")
  syncCredentials is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    void
  >;
  @doc("Get the integration runtime monitoring data, which includes the monitor data for all the nodes under this integration runtime.")
  getMonitoringData is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeMonitoringData
  >;
  @doc("Upgrade self-hosted integration runtime to latest version if availability.")
  upgrade is ArmResourceActionSync<IntegrationRuntimeResource, void, void>;
  @doc("Remove all linked integration runtimes under specific data factory in a self-hosted integration runtime.")
  removeLinks is ArmResourceActionSync<
    IntegrationRuntimeResource,
    LinkedIntegrationRuntimeRequest,
    void
  >;
  @doc("Create a linked integration runtime entry in a shared integration runtime.")
  createLinkedIntegrationRuntime is ArmResourceActionSync<
    IntegrationRuntimeResource,
    CreateLinkedIntegrationRuntimeRequest,
    IntegrationRuntimeStatusResponse
  >;
  @doc("Gets the list of outbound network dependencies for a given Azure-SSIS integration runtime.")
  // FIXME: IntegrationRuntimes_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The factory name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      @doc("The integration runtime name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      integrationRuntimeName: string;
    },
    IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse
  >;
}

@armResourceOperations
interface IntegrationRuntimeObjectMetadata {
  @doc("Refresh a SSIS integration runtime object metadata.")
  refresh is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    SsisObjectMetadataStatusResponse
  >;
  @doc("Get a SSIS integration runtime object metadata by specified path. The return is pageable metadata list.")
  get is ArmResourceActionSync<
    IntegrationRuntimeResource,
    GetSsisObjectMetadataRequest,
    SsisObjectMetadataListResponse
  >;
}

@armResourceOperations
interface IntegrationRuntimeNodes {
  @doc("Get the IP address of self-hosted integration runtime node.")
  getIpAddress is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeNodeIpAddress,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      @doc("The integration runtime node name.")
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    }
  >;
  @doc("Gets a self-hosted integration runtime node.")
  // FIXME: IntegrationRuntimeNodes_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The resource group name.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      @doc("The factory name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      @doc("The integration runtime name.")
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      integrationRuntimeName: string;

      @doc("The integration runtime node name.")
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    SelfHostedIntegrationRuntimeNode
  >;
}
