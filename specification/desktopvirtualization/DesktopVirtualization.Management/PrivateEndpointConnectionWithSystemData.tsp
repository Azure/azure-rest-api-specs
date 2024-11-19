import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HostPool.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
// FIXME: PrivateEndpointConnectionWithSystemData has no properties property
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(HostPool)
@parentResource(Workspace)
model PrivateEndpointConnectionWithSystemData
  is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnectionWithSystemData,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateEndpointConnectionWithSystemDataOperationGroup {
  /**
   * Get a private endpoint connection.
   */
  get is ArmResourceRead<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  update is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * Remove a connection.
   */
  delete is ArmResourceDeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections associated with hostpool.
   */
  list is ArmResourceListByParent<
    PrivateEndpointConnectionWithSystemData,
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
    Response = PrivateEndpointConnectionListResultWithSystemData
  >;

  /**
   * Get a private endpoint connection.
   */
  getByWorkspace is ArmResourceRead<PrivateEndpointConnectionWithSystemData>;

  /**
   * Approve or reject a private endpoint connection.
   */
  updateByWorkspace is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * Remove a connection.
   */
  deleteByWorkspace is ArmResourceDeleteSync<PrivateEndpointConnectionWithSystemData>;

  /**
   * List private endpoint connections associated with workspace.
   */
  listByWorkspace is ArmResourceListByParent<
    PrivateEndpointConnectionWithSystemData,
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
    Response = PrivateEndpointConnectionListResultWithSystemData
  >;
}

@@doc(PrivateEndpointConnectionWithSystemData.name,
  "The name of the private endpoint connection associated with the Azure resource."
);
@@doc(PrivateEndpointConnectionWithSystemDataOperationGroup.updateByHostPool::parameters.resource,
  "Object containing the updated connection."
);
