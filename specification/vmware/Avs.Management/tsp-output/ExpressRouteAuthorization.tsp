import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("ExpressRoute Circuit Authorization")
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is ProxyResource<ExpressRouteAuthorizationProperties> {
  @doc("Name of the ExpressRoute Circuit Authorization in the private cloud")
  @path
  @key("authorizationName")
  @segment("authorizations")
  name: string;
}

@armResourceOperations
interface ExpressRouteAuthorizations {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an ExpressRoute Circuit Authorization by name in a private cloud")
  @operationId("Authorizations_Get")
  get is ArmResourceRead<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update an ExpressRoute Circuit Authorization in a private cloud")
  @operationId("Authorizations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an ExpressRoute Circuit Authorization in a private cloud")
  @operationId("Authorizations_Delete")
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List ExpressRoute Circuit Authorizations in a private cloud")
  @operationId("Authorizations_List")
  list is ArmResourceListByParent<ExpressRouteAuthorization>;
}

@@projectedName(ExpressRouteAuthorizations.createOrUpdate::parameters.resource,
  "json",
  "authorization"
);
@@extension(ExpressRouteAuthorizations.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "authorization"
);
@@doc(ExpressRouteAuthorizations.createOrUpdate::parameters.resource,
  "An ExpressRoute Circuit Authorization"
);
