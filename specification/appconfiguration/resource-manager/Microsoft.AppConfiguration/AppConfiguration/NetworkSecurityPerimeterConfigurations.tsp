import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.AppConfiguration;
@parentResource(ConfigurationStore)
@added(Versions.v2025_08_01_preview)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<CommonTypes.NetworkSecurityPerimeterConfiguration> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
@added(Versions.v2025_08_01_preview)
interface NetworkSecurityPerimeterConfigurations {

  /**
   * Gets the specified network security perimeter configuration associated with the configuration store.
   */
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;
}
