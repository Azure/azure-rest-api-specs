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
@doc("A private link resource")
@parentResource(SqlServer)
model SqlPrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @doc("The name of the private link resource.")
  @path
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface SqlPrivateLinkResources {
  @doc("Gets a private link resource for SQL server.")
  get is ArmResourceRead<SqlPrivateLinkResource>;
  @doc("Gets the private link resources for SQL server.")
  listByServer is ArmResourceListByParent<SqlPrivateLinkResource>;
}
