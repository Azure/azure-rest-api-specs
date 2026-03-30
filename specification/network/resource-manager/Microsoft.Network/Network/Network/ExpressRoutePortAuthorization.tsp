import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * ExpressRoutePort Authorization resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@summary("ExpressRoute Port Authorization")
@Http.Private.includeInapplicableMetadataInPayload(false)
model ExpressRoutePortAuthorization extends SubResourceModel {
  properties?: ExpressRoutePortAuthorizationPropertiesFormat;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
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

alias ExpressRoutePortAuthorizationOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the express route port. */
    @path
    @segment("expressRoutePorts")
    @key
    expressRoutePortName: string;
  },
  {
    /** The name of the authorization. */
    @path
    @segment("authorizations")
    @key
    authorizationName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.expressRoute)
@armResourceOperations
interface ExpressRoutePortAuthorizations {
  /**
   * Gets the specified authorization from the specified express route port.
   */
  get is ExpressRoutePortAuthorizationOps.Read<
    ExpressRoutePortAuthorization,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates an authorization in the specified express route port.
   */
  createOrUpdate is ExpressRoutePortAuthorizationOps.CreateOrUpdateAsync<
    ExpressRoutePortAuthorization,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified authorization from the specified express route port.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  delete is ExpressRoutePortAuthorizationOps.DeleteWithoutOkAsync<
    ExpressRoutePortAuthorization,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all authorizations in an express route port.
   */
  list is ExpressRoutePortAuthorizationOps.List<
    ExpressRoutePortAuthorization,
    Response = ExpressRoutePortAuthorizationListResult,
    OverrideErrorType = CloudError
  >;
}

@@doc(ExpressRoutePortAuthorization.name, "The name of the authorization.");
@@doc(ExpressRoutePortAuthorization.properties, "ExpressRoutePort properties.");
@@doc(ExpressRoutePortAuthorizations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update express route port authorization operation."
);
