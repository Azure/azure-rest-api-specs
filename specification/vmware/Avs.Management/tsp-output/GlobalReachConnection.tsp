import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A global reach connection resource
 */
@parentResource(PrivateCloud)
model GlobalReachConnection is ProxyResource<GlobalReachConnectionProperties> {
  /**
   * Name of the global reach connection in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("globalReachConnectionName")
  @segment("globalReachConnections")
  name: string;
}

@armResourceOperations
interface GlobalReachConnections {
  /**
   * Get a global reach connection by name in a private cloud
   */
  get is ArmResourceRead<GlobalReachConnection>;

  /**
   * Create or update a global reach connection in a private cloud
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GlobalReachConnection>;

  /**
   * Delete a global reach connection in a private cloud
   */
  delete is ArmResourceDeleteAsync<GlobalReachConnection>;

  /**
   * List global reach connections in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GlobalReachConnections_List")
  list is ArmResourceListByParent<GlobalReachConnection>;
}

@@projectedName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "json",
  "globalReachConnection"
);
@@extension(GlobalReachConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "globalReachConnection"
);
@@doc(GlobalReachConnections.createOrUpdate::parameters.resource,
  "A global reach connection in the private cloud"
);
