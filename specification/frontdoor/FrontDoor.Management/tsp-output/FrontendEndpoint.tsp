import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./FrontDoor.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Network;
@doc("A frontend endpoint used for routing.")
@parentResource(FrontDoor)
model FrontendEndpoint is ProxyResource<FrontendEndpointProperties> {
  @doc("Name of the Frontend endpoint which is unique within the Front Door.")
  @maxLength(255)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$")
  @key("frontendEndpointName")
  @segment("frontendEndpoints")
  name: string;
}

@armResourceOperations
interface FrontendEndpoints {
  @doc("Gets a Frontend endpoint with the specified name within the specified Front Door.")
  get is ArmResourceRead<FrontendEndpoint>;

  @doc("Lists all of the frontend endpoints within a Front Door.")
  listByFrontDoor is ArmResourceListByParent<FrontendEndpoint>;

  @doc("Enables a frontendEndpoint for HTTPS traffic")
  enableHttps is ArmResourceActionAsync<
    FrontendEndpoint,
    CustomHttpsConfiguration,
    void
  >;

  @doc("Disables a frontendEndpoint for HTTPS traffic")
  disableHttps is ArmResourceActionAsync<FrontendEndpoint, void, void>;
}
