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
@summary("ExpressRoute Port Authorization")
model ExpressRoutePortAuthorization
  is Azure.ResourceManager.ProxyResource<ExpressRoutePortAuthorizationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = ExpressRoutePortAuthorization,
    KeyName = "authorizationName",
    SegmentName = "authorizations",
    NamePattern = ""
  >;

  /** A unique read-only string that changes whenever the resource is updated. */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
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
