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
@doc("A server connection policy")
@parentResource(Server)
model ServerConnectionPolicy
  is ProxyResource<ServerConnectionPolicyProperties> {
  @doc("The name of the connection policy.")
  @path
  @key("connectionPolicyName")
  @segment("connectionPolicies")
  name: ConnectionPolicyName;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerConnectionPolicies {
  @doc("Gets a server connection policy")
  get is ArmResourceRead<ServerConnectionPolicy>;

  @doc("Updates a server connection policy")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerConnectionPolicy>;

  @doc("Lists connection policy")
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
