import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * NSP Configuration for an Cognitive Services account.
 */
@parentResource(Account)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "nspConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets the specified NSP configurations for an account.
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of NSP configurations for an account.
   */
  list is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Response = ArmResponse<NetworkSecurityPerimeterConfigurationList>
  >;

  /**
   * Reconcile the NSP configuration for an account.
   */
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    Response = NetworkSecurityPerimeterConfiguration
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The name of the NSP Configuration."
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "NSP Configuration properties."
);
