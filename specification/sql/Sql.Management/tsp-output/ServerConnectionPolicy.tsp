import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server connection policy
 */
@parentResource(Server)
model ServerConnectionPolicy
  is ProxyResource<ServerConnectionPolicyProperties> {
  /**
   * The name of the connection policy.
   */
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  name: ConnectionPolicyName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerConnectionPolicies {
  /**
   * Gets a server connection policy
   */
  get is ArmResourceRead<ServerConnectionPolicy>;

  /**
   * Updates a server connection policy
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerConnectionPolicy>;

  /**
   * Lists connection policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerConnectionPolicies_ListByServer")
  listByServer is ArmResourceListByParent<ServerConnectionPolicy>;
}

@@projectedName(ServerConnectionPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerConnectionPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerConnectionPolicies.createOrUpdate::parameters.resource,
  "The required parameters for updating a server connection policy."
);
