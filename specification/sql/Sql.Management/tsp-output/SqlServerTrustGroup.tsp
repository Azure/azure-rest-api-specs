import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A server trust group.")
model SqlServerTrustGroup is ProxyResource<ServerTrustGroupProperties> {
  @doc("The name of the server trust group.")
  @path
  @key("serverTrustGroupName")
  @segment("serverTrustGroups")
  name: string;
}

@armResourceOperations
interface SqlServerTrustGroups {
  @doc("Gets a server trust group.")
  get is ArmResourceRead<SqlServerTrustGroup>;
  @doc("Creates or updates a server trust group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerTrustGroup>;
  @doc("Deletes a server trust group.")
  delete is ArmResourceDeleteAsync<SqlServerTrustGroup>;
  @doc("Lists a server trust group.")
  listByLocation is ArmResourceListByParent<SqlServerTrustGroup>;
}
