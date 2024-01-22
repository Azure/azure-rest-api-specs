import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * A frontend endpoint used for routing.
 */
@parentResource(FrontDoor)
model FrontendEndpoint is ProxyResource<FrontendEndpointProperties> {
  /**
   * Name of the Frontend endpoint which is unique within the Front Door.
   */
  @maxLength(255)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @path
  @key("frontendEndpointName")
  @segment("frontendEndpoints")
  name: string;
}

@armResourceOperations
interface FrontendEndpoints {
  /**
   * Gets a Frontend endpoint with the specified name within the specified Front Door.
   */
  get is ArmResourceRead<FrontendEndpoint>;

  /**
   * Lists all of the frontend endpoints within a Front Door.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FrontendEndpoints_ListByFrontDoor")
  listByFrontDoor is ArmResourceListByParent<FrontendEndpoint>;

  /**
   * Enables a frontendEndpoint for HTTPS traffic
   */
  enableHttps is ArmResourceActionAsync<
    FrontendEndpoint,
    CustomHttpsConfiguration,
    void,
    BaseParameters<FrontendEndpoint>,
    ArmAsyncOperationHeader
  >;

  /**
   * Disables a frontendEndpoint for HTTPS traffic
   */
  disableHttps is ArmResourceActionAsync<
    FrontendEndpoint,
    void,
    void,
    BaseParameters<FrontendEndpoint>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(FrontendEndpoints.enableHttps::parameters.body,
  "json",
  "customHttpsConfiguration"
);
@@extension(FrontendEndpoints.enableHttps::parameters.body,
  "x-ms-client-name",
  "customHttpsConfiguration"
);
@@doc(FrontendEndpoints.enableHttps::parameters.body,
  "The configuration specifying how to enable HTTPS"
);
