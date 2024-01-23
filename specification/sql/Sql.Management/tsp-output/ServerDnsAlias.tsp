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
 * A server DNS alias.
 */
@parentResource(Server)
model ServerDnsAlias is ProxyResource<ServerDnsAliasProperties> {
  /**
   * The name of the server dns alias.
   */
  @path
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;
}

@armResourceOperations
interface ServerDnsAliases {
  /**
   * Gets a server DNS alias.
   */
  get is ArmResourceRead<ServerDnsAlias>;

  /**
   * Creates a server DNS alias.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerDnsAlias>;

  /**
   * Deletes the server DNS alias with the given name.
   */
  delete is ArmResourceDeleteAsync<ServerDnsAlias>;

  /**
   * Gets a list of server DNS aliases for a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerDnsAliases_ListByServer")
  listByServer is ArmResourceListByParent<ServerDnsAlias>;

  /**
   * Acquires server DNS alias from another server.
   */
  acquire is ArmResourceActionAsync<
    ServerDnsAlias,
    ServerDnsAliasAcquisition,
    ServerDnsAlias
  >;
}

@@projectedName(ServerDnsAliases.acquire::parameters.body,
  "json",
  "parameters"
);
@@extension(ServerDnsAliases.acquire::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerDnsAliases.acquire::parameters.body, "");
