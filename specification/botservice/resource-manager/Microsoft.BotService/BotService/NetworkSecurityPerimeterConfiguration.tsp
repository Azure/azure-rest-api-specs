import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BotService;
/**
 * Network Security Perimeter configuration
 */
@parentResource(Bot)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ".*"
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets the specified Network Security Perimeter configuration associated with the Bot.
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration, Error = Error>;

  /**
   * List Network Security Perimeter configurations associated with the Bot.
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>,
    Error = Error
  >;

  /**
   * Reconcile the specified Network Security Perimeter configuration associated with the Bot.
   */
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    NetworkSecurityPerimeterConfiguration
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The resource association Name. Composed of parameter guid and association name."
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties of the Network Security Perimeter configuration"
);
