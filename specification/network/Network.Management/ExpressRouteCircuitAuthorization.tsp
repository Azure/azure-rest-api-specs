import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ExpressRouteCircuit.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Authorization in an ExpressRouteCircuit resource.
 */
@parentResource(ExpressRouteCircuit)
model ExpressRouteCircuitAuthorization
  is Azure.ResourceManager.ProxyResource<AuthorizationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRouteCircuitAuthorization,
    KeyName = "authorizationName",
    SegmentName = "authorizations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface ExpressRouteCircuitAuthorizations {
  /**
   * Gets the specified authorization from the specified express route circuit.
   */
  get is ArmResourceRead<ExpressRouteCircuitAuthorization, Error = CloudError>;

  /**
   * Creates or updates an authorization in the specified express route circuit.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ExpressRouteCircuitAuthorization,
    Error = CloudError
  >;

  /**
   * Deletes the specified authorization from the specified express route circuit.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ExpressRouteCircuitAuthorization,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all authorizations in an express route circuit.
   */
  list is ArmResourceListByParent<
    ExpressRouteCircuitAuthorization,
    Response = AuthorizationListResult,
    Error = CloudError
  >;
}

@@doc(ExpressRouteCircuitAuthorization.name, "The name of the authorization.");
@@doc(ExpressRouteCircuitAuthorization.properties,
  "Properties of the express route circuit authorization."
);
@@doc(ExpressRouteCircuitAuthorizations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route circuit authorization operation."
);
