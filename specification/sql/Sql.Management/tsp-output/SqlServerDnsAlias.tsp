import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server DNS alias.")
@parentResource(SqlServer)
model SqlServerDnsAlias is ProxyResource<ServerDnsAliasProperties> {
  @doc("The name of the server dns alias.")
  @path
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;
}

@armResourceOperations
interface SqlServerDnsAliases {
  @doc("Gets a server DNS alias.")
  get is ArmResourceRead<SqlServerDnsAlias>;
  @doc("Creates a server DNS alias.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerDnsAlias>;
  @doc("Deletes the server DNS alias with the given name.")
  delete is ArmResourceDeleteAsync<SqlServerDnsAlias>;
  @doc("Gets a list of server DNS aliases for a server.")
  listByServer is ArmResourceListByParent<SqlServerDnsAlias>;
  @doc("Acquires server DNS alias from another server.")
  acquire is ArmResourceActionAsync<
    SqlServerDnsAlias,
    ServerDnsAliasAcquisition,
    SqlServerDnsAlias
  >;
}
