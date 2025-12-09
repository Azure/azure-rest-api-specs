import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A frontend endpoint used for routing.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(FrontDoor)
@Azure.ResourceManager.Legacy.customAzureResource
model FrontendEndpoint is SubResource {
  /**
   * Resource name.
   */
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  properties?: FrontendEndpointProperties;
}

alias FrontendEndpointsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<FrontendEndpoint>;
    ...ParentKeysOf<FrontendEndpoint>;
  },
  {
    /**
     * Name of the Frontend endpoint which is unique within the Front Door.
     */
    @path
    @segment("frontendEndpoints")
    @key("frontendEndpointName")
    @minLength(1)
    @maxLength(255)
    @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
    frontendEndpointName: string;
  },
  ErrorType = ErrorResponse
>;

@armResourceOperations
interface FrontendEndpoints {
  /**
   * Gets a Frontend endpoint with the specified name within the specified Front Door.
   */
  get is FrontendEndpointsOps.Read<FrontendEndpoint>;

  /**
   * Lists all of the frontend endpoints within a Front Door.
   */
  listByFrontDoor is FrontendEndpointsOps.List<
    FrontendEndpoint,
    Response = FrontendEndpointsListResult
  >;

  /**
   * Enables a frontendEndpoint for HTTPS traffic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableHttps is FrontendEndpointsOps.ActionAsync<
    FrontendEndpoint,
    CustomHttpsConfiguration,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Disables a frontendEndpoint for HTTPS traffic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableHttps is FrontendEndpointsOps.ActionAsync<
    FrontendEndpoint,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

// @@maxLength(FrontendEndpoint.name, 255);
// @@minLength(FrontendEndpoint.name, 1);
// @@doc(FrontendEndpoint.name,
//   "Name of the Frontend endpoint which is unique within the Front Door."
// );
@@doc(FrontendEndpoint.properties, "Properties of the Frontend endpoint");
@@doc(FrontendEndpoints.enableHttps::parameters.body,
  "The configuration specifying how to enable HTTPS"
);
