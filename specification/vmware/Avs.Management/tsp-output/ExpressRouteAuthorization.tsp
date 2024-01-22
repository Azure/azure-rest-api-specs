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
/**
 * ExpressRoute Circuit Authorization
 */
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is ProxyResource<ExpressRouteAuthorizationProperties> {
  /**
   * Name of the ExpressRoute Circuit Authorization in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("authorizationName")
  @segment("authorizations")
  name: string;
}

@armResourceOperations
interface ExpressRouteAuthorizations {
  /**
   * Get an ExpressRoute Circuit Authorization by name in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Authorizations_Get")
  get is ArmResourceRead<ExpressRouteAuthorization>;

  /**
   * Create or update an ExpressRoute Circuit Authorization in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Authorizations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteAuthorization>;

  /**
   * Delete an ExpressRoute Circuit Authorization in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Authorizations_Delete")
  delete is ArmResourceDeleteAsync<ExpressRouteAuthorization>;

  /**
   * List ExpressRoute Circuit Authorizations in a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
