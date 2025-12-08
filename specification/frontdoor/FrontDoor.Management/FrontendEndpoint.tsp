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
@parentResource(FrontDoor)
model FrontendEndpoint
  is Azure.ResourceManager.ProxyResource<FrontendEndpointProperties> {
  ...ResourceNameParameter<
    Resource = FrontendEndpoint,
    KeyName = "frontendEndpointName",
    SegmentName = "frontendEndpoints",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
}

@armResourceOperations
interface FrontendEndpoints {
  /**
   * Gets a Frontend endpoint with the specified name within the specified Front Door.
   */
  get is ArmResourceRead<FrontendEndpoint, Error = ErrorResponse>;

  /**
   * Lists all of the frontend endpoints within a Front Door.
   */
  listByFrontDoor is ArmResourceListByParent<
    FrontendEndpoint,
    Response = FrontendEndpointsListResult,
    Error = ErrorResponse
  >;

  /**
   * Enables a frontendEndpoint for HTTPS traffic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableHttps is ArmResourceActionAsync<
    FrontendEndpoint,
    CustomHttpsConfiguration,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Disables a frontendEndpoint for HTTPS traffic
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableHttps is ArmResourceActionAsync<
    FrontendEndpoint,
    void,
    OkResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;
}

@@maxLength(FrontendEndpoint.name, 255);
@@minLength(FrontendEndpoint.name, 1);
@@doc(FrontendEndpoint.name,
  "Name of the Frontend endpoint which is unique within the Front Door."
);
@@doc(FrontendEndpoint.properties, "Properties of the Frontend endpoint");
@@doc(FrontendEndpoints.enableHttps::parameters.body,
  "The configuration specifying how to enable HTTPS"
);
