import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A deleted server.
 */
@locationResource
model DeletedServer is ProxyResource<DeletedServerProperties> {
  /**
   * The name of the deleted server.
   */
  @path
  @key("deletedServerName")
  @segment("deletedServers")
  name: string;
}

@armResourceOperations
interface DeletedServers {
  /**
   * Gets a deleted server.
   */
  get is ArmResourceRead<DeletedServer>;

  /**
   * Gets a list of deleted servers for a location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeletedServers_ListByLocation")
  listByLocation is ArmResourceListByParent<DeletedServer>;

  /**
   * Gets a list of all deleted servers in a subscription.
   */
  list is ArmListBySubscription<DeletedServer>;

  /**
   * Recovers a deleted server.
   */
  recover is ArmResourceActionAsync<DeletedServer, void, DeletedServer>;
}
