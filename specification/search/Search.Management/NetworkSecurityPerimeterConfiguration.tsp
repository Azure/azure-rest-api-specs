import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Network security perimeter (NSP) configuration resource
 */
@parentResource(SearchService)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "nspConfigName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = "^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}\\.[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets a network security perimeter configuration.
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Gets a list of network security perimeter configurations for a search service.
   */
  listByService is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Reconcile network security perimeter configuration for the Azure AI Search resource provider. This triggers a manual resync with network security perimeter configurations by ensuring the search service carries the latest configuration.
   */
  reconcile is ArmResourceActionAsyncBase<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkSecurityPerimeterConfiguration>
  >;
}

@@maxLength(NetworkSecurityPerimeterConfiguration.name, 100);
@@minLength(NetworkSecurityPerimeterConfiguration.name, 38);
@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The network security perimeter configuration name."
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Network security configuration properties."
);
