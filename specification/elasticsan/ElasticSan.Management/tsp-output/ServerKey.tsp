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
@doc("A server key.")
@parentResource(Server)
model ServerKey is ProxyResource<ServerKeyProperties> {
  @doc("The name of the server key to be retrieved.")
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerKeys {
  @doc("Gets a server key.")
  get is ArmResourceRead<ServerKey>;

  @doc("Creates or updates a server key.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerKey>;

  @doc("Deletes the server key with the given name.")
  delete is ArmResourceDeleteAsync<ServerKey>;

  @doc("Gets a list of server keys.")
  listByServer is ArmResourceListByParent<ServerKey>;
}

@@projectedName(ServerKeys.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerKeys.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerKeys.createOrUpdate::parameters.resource,
  "The requested server key resource state."
);
