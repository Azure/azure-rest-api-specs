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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@parentResource(ExpressRouteCircuit)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRouteCircuitAuthorization extends SubResourceModel {
  properties?: AuthorizationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("authorizationName")
  @segment("authorizations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
