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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(SearchService)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<{}> {
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
  get is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /**
   * Gets a list of network security perimeter configurations for a search service.
   */
  listByService is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /**
   * Reconcile network security perimeter configuration for the Azure AI Search resource provider. This triggers a manual resync with network security perimeter configurations by ensuring the search service carries the latest configuration.
   */
  reconcile is ArmResourceActionAsyncBase<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<NetworkSecurityPerimeterConfiguration>,
    Error = CloudError
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
