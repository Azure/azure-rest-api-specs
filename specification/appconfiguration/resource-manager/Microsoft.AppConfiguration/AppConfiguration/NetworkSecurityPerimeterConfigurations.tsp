import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./ConfigurationStore.tsp";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.AppConfiguration;
@parentResource(ConfigurationStore)
@added(Versions.v2025_08_01_preview)
model NetworkSecurityPerimeterConfiguration
  is CommonTypes.NetworkSecurityPerimeterConfiguration {
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

  /**
   * Lists all network security perimeter configurations for a configuration store.
   */
  listByConfigurationStore is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Forces a refresh of the specified network security perimeter configuration.
   */
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    NetworkSecurityPerimeterConfiguration,
    LroHeaders = Azure.ResourceManager.ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader &
      Azure.ResourceManager.ArmAsyncOperationHeader,
    Error = ErrorResponse
  >;
}
