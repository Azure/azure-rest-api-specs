import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Factory.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataFactory;
/**
 * Integration runtime resource type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Factory)
@includeInapplicableMetadataInPayload(false)
model IntegrationRuntimeResource extends SubResource {
  /**
   * The integration runtime name.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("integrationRuntimeName")
  @segment("integrationRuntimes")
  @visibility("read")
  name: string;

  /**
   * Integration runtime properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IntegrationRuntime;
}

@armResourceOperations
interface IntegrationRuntimeResources {
  /**
   * Gets an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_Get")
  get is ArmResourceRead<
    IntegrationRuntimeResource,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      /**
       * ETag of the integration runtime entity. Should only be specified for get. If the ETag matches the existing entity tag, or if * was provided, then no content will be returned.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Creates or updates an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    IntegrationRuntimeResource,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      /**
       * ETag of the integration runtime entity. Should only be specified for update, for which it should match existing entity or can be * for unconditional update.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Updates an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("IntegrationRuntimes_Update")
  update is ArmCustomPatchSync<
    IntegrationRuntimeResource,
    UpdateIntegrationRuntimeRequest
  >;

  /**
   * Deletes an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_Delete")
  delete is ArmResourceDeleteSync<IntegrationRuntimeResource>;

  /**
   * Lists integration runtimes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_ListByFactory")
  listByFactory is ArmResourceListByParent<IntegrationRuntimeResource>;

  /**
   * Gets detailed status information for an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_GetStatus")
  getStatus is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeStatusResponse
  >;

  /**
   * Gets the on-premises integration runtime connection information for encrypting the on-premises data source credentials.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_GetConnectionInfo")
  getConnectionInfo is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeConnectionInfo
  >;

  /**
   * Regenerates the authentication key for an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_RegenerateAuthKey")
  regenerateAuthKey is ArmResourceActionSync<
    IntegrationRuntimeResource,
    IntegrationRuntimeRegenerateKeyParameters,
    IntegrationRuntimeAuthKeys
  >;

  /**
   * Retrieves the authentication keys for an integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_ListAuthKeys")
  listAuthKeys is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeAuthKeys
  >;

  /**
   * Starts a ManagedReserved type integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_Start")
  start is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeStatusResponse
  >;

  /**
   * Stops a ManagedReserved type integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_Stop")
  stop is ArmResourceActionAsync<IntegrationRuntimeResource, void, void>;

  /**
   * Force the integration runtime to synchronize credentials across integration runtime nodes, and this will override the credentials across all worker nodes with those available on the dispatcher node. If you already have the latest credential backup file, you should manually import it (preferred) on any self-hosted integration runtime node than using this API directly.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_SyncCredentials")
  syncCredentials is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    void
  >;

  /**
   * Get the integration runtime monitoring data, which includes the monitor data for all the nodes under this integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_GetMonitoringData")
  getMonitoringData is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeMonitoringData
  >;

  /**
   * Upgrade self-hosted integration runtime to latest version if availability.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_Upgrade")
  upgrade is ArmResourceActionSync<IntegrationRuntimeResource, void, void>;

  /**
   * Remove all linked integration runtimes under specific data factory in a self-hosted integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_RemoveLinks")
  removeLinks is ArmResourceActionSync<
    IntegrationRuntimeResource,
    LinkedIntegrationRuntimeRequest,
    void
  >;

  /**
   * Create a linked integration runtime entry in a shared integration runtime.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_CreateLinkedIntegrationRuntime")
  createLinkedIntegrationRuntime is ArmResourceActionSync<
    IntegrationRuntimeResource,
    CreateLinkedIntegrationRuntimeRequest,
    IntegrationRuntimeStatusResponse
  >;

  /**
   * Refresh a SSIS integration runtime object metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimeObjectMetadata_Refresh")
  refresh is ArmResourceActionAsync<
    IntegrationRuntimeResource,
    void,
    SsisObjectMetadataStatusResponse
  >;

  /**
   * Get a SSIS integration runtime object metadata by specified path. The return is pageable metadata list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimeObjectMetadata_Get")
  get is ArmResourceActionSync<
    IntegrationRuntimeResource,
    GetSsisObjectMetadataRequest,
    SsisObjectMetadataListResponse
  >;

  /**
   * Get the IP address of self-hosted integration runtime node.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimeNodes_GetIpAddress")
  getIpAddress is ArmResourceActionSync<
    IntegrationRuntimeResource,
    void,
    IntegrationRuntimeNodeIpAddress,
    {
      ...BaseParameters<IntegrationRuntimeResource>;

      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    }
  >;

  /**
   * Gets the list of outbound network dependencies for a given Azure-SSIS integration runtime.
   */
  // FIXME: IntegrationRuntimes_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimes_ListOutboundNetworkDependenciesEndpoints")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The factory name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      /**
       * The integration runtime name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      integrationRuntimeName: string;
    },
    IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse
  >;

  /**
   * Gets a self-hosted integration runtime node.
   */
  // FIXME: IntegrationRuntimeNodes_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationRuntimeNodes_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataFactory/factories/{factoryName}/integrationRuntimes/{integrationRuntimeName}/nodes/{nodeName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription identifier.
       */
      @path
      subscriptionId: string;

      /**
       * The resource group name.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+$")
      @path
      resourceGroupName: string;

      /**
       * The factory name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      factoryName: string;

      /**
       * The integration runtime name.
       */
      @maxLength(63)
      @minLength(3)
      @pattern("^[A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
      @path
      integrationRuntimeName: string;

      /**
       * The integration runtime node name.
       */
      @maxLength(150)
      @minLength(1)
      @pattern("^[a-z0-9A-Z][a-z0-9A-Z_-]{0,149}$")
      @path
      nodeName: string;
    },
    SelfHostedIntegrationRuntimeNode
  >;
}

@@projectedName(IntegrationRuntimeResources.createOrUpdate::parameters.resource,
  "json",
  "integrationRuntime"
);
@@extension(IntegrationRuntimeResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "integrationRuntime"
);
@@doc(IntegrationRuntimeResources.createOrUpdate::parameters.resource,
  "Integration runtime resource definition."
);
@@projectedName(IntegrationRuntimeResources.update::parameters.properties,
  "json",
  "updateIntegrationRuntimeRequest"
);
@@extension(IntegrationRuntimeResources.update::parameters.properties,
  "x-ms-client-name",
  "updateIntegrationRuntimeRequest"
);
@@doc(IntegrationRuntimeResources.update::parameters.properties,
  "The parameters for updating an integration runtime."
);
@@projectedName(IntegrationRuntimeResources.regenerateAuthKey::parameters.body,
  "json",
  "regenerateKeyParameters"
);
@@extension(IntegrationRuntimeResources.regenerateAuthKey::parameters.body,
  "x-ms-client-name",
  "regenerateKeyParameters"
);
@@doc(IntegrationRuntimeResources.regenerateAuthKey::parameters.body,
  "The parameters for regenerating integration runtime authentication key."
);
@@projectedName(IntegrationRuntimeResources.removeLinks::parameters.body,
  "json",
  "linkedIntegrationRuntimeRequest"
);
@@extension(IntegrationRuntimeResources.removeLinks::parameters.body,
  "x-ms-client-name",
  "linkedIntegrationRuntimeRequest"
);
@@doc(IntegrationRuntimeResources.removeLinks::parameters.body,
  "The data factory name for the linked integration runtime."
);
@@projectedName(IntegrationRuntimeResources.createLinkedIntegrationRuntime::parameters.body,
  "json",
  "createLinkedIntegrationRuntimeRequest"
);
@@extension(IntegrationRuntimeResources.createLinkedIntegrationRuntime::parameters.body,
  "x-ms-client-name",
  "createLinkedIntegrationRuntimeRequest"
);
@@doc(IntegrationRuntimeResources.createLinkedIntegrationRuntime::parameters.body,
  "The linked integration runtime properties."
);
@@projectedName(IntegrationRuntimeResources.get::parameters.body,
  "json",
  "getMetadataRequest"
);
@@extension(IntegrationRuntimeResources.get::parameters.body,
  "x-ms-client-name",
  "getMetadataRequest"
);
@@doc(IntegrationRuntimeResources.get::parameters.body,
  "The parameters for getting a SSIS object metadata."
);
