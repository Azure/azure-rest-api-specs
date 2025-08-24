import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("ExpressRoute Circuit Authorization")
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is ProxyResource<ExpressRouteAuthorizationProperties> {
  @doc("Name of the ExpressRoute Circuit Authorization in the private cloud")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("authorizationName")
  @segment("authorizations")
  name: string;
}

@armResourceOperations
interface ExpressRouteAuthorizations {
  @doc("Get an ExpressRoute Circuit Authorization by name in a private cloud")
  get is ArmResourceRead<ExpressRouteAuthorization>;
  @doc("Create or update an ExpressRoute Circuit Authorization in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExpressRouteAuthorization>;
  @doc("Delete an ExpressRoute Circuit Authorization in a private cloud")
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;
  @doc("List ExpressRoute Circuit Authorizations in a private cloud")
  list is ArmResourceListByParent<ExpressRouteAuthorization>;
}
