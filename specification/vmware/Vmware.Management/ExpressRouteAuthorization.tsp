import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * ExpressRoute Circuit Authorization
 */
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is Azure.ResourceManager.ProxyResource<ExpressRouteAuthorizationProperties> {
  ...ResourceNameParameter<
    Resource = ExpressRouteAuthorization,
    KeyName = "authorizationName",
    SegmentName = "authorizations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface ExpressRouteAuthorizations {
  /**
   * Get a ExpressRouteAuthorization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorizations_Get")
  get is ArmResourceRead<ExpressRouteAuthorization>;

  /**
   * Create a ExpressRouteAuthorization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorizations_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExpressRouteAuthorization>;

  /**
   * Delete a ExpressRouteAuthorization
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Authorizations_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteAuthorization,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List ExpressRouteAuthorization resources by PrivateCloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Authorizations_List")
  list is ArmResourceListByParent<
    ExpressRouteAuthorization,
    Response = ArmResponse<ExpressRouteAuthorizationList>
  >;
}

@@doc(ExpressRouteAuthorization.name,
  "Name of the ExpressRoute Circuit Authorization"
);
@@doc(ExpressRouteAuthorization.properties,
  "The resource-specific properties for this resource."
);
