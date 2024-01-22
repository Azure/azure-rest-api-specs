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
 * A server key.
 */
@parentResource(Server)
model ServerKey is ProxyResource<ServerKeyProperties> {
  /**
   * The name of the server key to be retrieved.
   */
  @path
  @key("keyName")
  @segment("keys")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerKeys {
  /**
   * Gets a server key.
   */
  get is ArmResourceRead<ServerKey>;

  /**
   * Creates or updates a server key.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerKey>;

  /**
   * Deletes the server key with the given name.
   */
  delete is ArmResourceDeleteAsync<ServerKey>;

  /**
   * Gets a list of server keys.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerKeys_ListByServer")
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
