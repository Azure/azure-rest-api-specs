import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A private link resource")
@parentResource(ManagedInstance)
model ManagedInstancePrivateLink
  is ProxyResource<ManagedInstancePrivateLinkProperties> {
  @doc("The name of the private link resource.")
  @key("groupName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
@projectedName("client", "ManagedInstancePrivateLinkResources")
interface ManagedInstancePrivateLinks_ManagedInstancePrivateLinkResources {
  @doc("Gets a private link resource for SQL server.")
  get is ArmResourceRead<ManagedInstancePrivateLink>;

  @doc("Gets the private link resources for SQL server.")
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateLink>;
}
