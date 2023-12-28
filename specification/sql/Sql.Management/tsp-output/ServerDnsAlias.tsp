import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server DNS alias.")
@parentResource(Server)
model ServerDnsAlias is ProxyResource<ServerDnsAliasProperties> {
  @doc("The name of the server dns alias.")
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;
}

@armResourceOperations
interface ServerDnsAliases {
  @doc("Gets a server DNS alias.")
  get is ArmResourceRead<ServerDnsAlias>;
  @doc("Creates a server DNS alias.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerDnsAlias>;
  @doc("Deletes the server DNS alias with the given name.")
  delete is ArmResourceDeleteAsync<ServerDnsAlias>;
  @doc("Gets a list of server DNS aliases for a server.")
  listByServer is ArmResourceListByParent<ServerDnsAlias>;
  @doc("Acquires server DNS alias from another server.")
  acquire is ArmResourceActionAsync<
    ServerDnsAlias,
    ServerDnsAliasAcquisition,
    ServerDnsAlias
  >;
}
