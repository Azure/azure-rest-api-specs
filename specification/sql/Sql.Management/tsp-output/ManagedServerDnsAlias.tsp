import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed server DNS alias.")
@parentResource(ManagedInstance)
model ManagedServerDnsAlias is ProxyResource<ManagedServerDnsAliasProperties> {
  @key("dnsAliasName")
  @segment("dnsAliases")
  name: string;
}

@armResourceOperations
interface ManagedServerDnsAliases {
  @doc("Gets a server DNS alias.")
  get is ArmResourceRead<ManagedServerDnsAlias>;
  @doc("Creates a managed server DNS alias.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedServerDnsAlias>;
  @doc("Deletes the managed server DNS alias with the given name.")
  delete is ArmResourceDeleteAsync<ManagedServerDnsAlias>;
  @doc("Gets a list of managed server DNS aliases for a managed server.")
  listByManagedInstance is ArmResourceListByParent<ManagedServerDnsAlias>;
  @doc("Acquires managed server DNS alias from another managed server.")
  acquire is ArmResourceActionAsync<
    ManagedServerDnsAlias,
    ManagedServerDnsAliasAcquisition,
    ManagedServerDnsAlias
  >;
}
