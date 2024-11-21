import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(HostPool)
model PrivateEndpointConnectionOnHostPoolWithSystemData
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionOnHostPoolWithSystemData,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionOnHostPoolWithSystemDataOperationGroup {
  /**
   * Get a private endpoint connection.
   */
  getByHostPool is ArmResourceRead<PrivateEndpointConnectionOnHostPoolWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  updateByHostPool is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionOnHostPoolWithSystemData>;

  /**
   * Remove a connection.
   */
  deleteByHostPool is ArmResourceDeleteSync<PrivateEndpointConnectionOnHostPoolWithSystemData>;

  /**
   * List private endpoint connections associated with hostpool.
   */
  listByHostPool is ArmResourceListByParent<
    PrivateEndpointConnectionOnHostPoolWithSystemData,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = PrivateEndpointConnectionOnHostPoolListResultWithSystemData
  >;
}

@@doc(PrivateEndpointConnectionOnHostPoolWithSystemData.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnectionOnHostPoolWithSystemDataOperationGroup.updateByHostPool::parameters.resource,
  "Object containing the updated connection."
);
