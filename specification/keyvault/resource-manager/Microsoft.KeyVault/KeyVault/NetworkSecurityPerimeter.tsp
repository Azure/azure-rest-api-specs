import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Vault.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.KeyVault;

/** A network security perimeter configuration associated with a key vault. */
@added(Versions.v2026_10_01_preview)
@parentResource(Vault)
model NetworkSecurityPerimeterConfiguration
  is ProxyResource<CommonTypes.NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "networkSecurityPerimeterConfigurationName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = ""
  >;
}

/** Operations for network security perimeter configurations associated with a key vault. */
@added(Versions.v2026_10_01_preview)
@armResourceOperations
@tag("NetworkSecurityPerimeterConfigurations")
interface NetworkSecurityPerimeterConfigurations {
  /** Gets the specified network security perimeter configuration for a key vault. */
  @added(Versions.v2026_10_01_preview)
  getConfiguration is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /** Lists the network security perimeter configurations associated with a key vault. */
  @added(Versions.v2026_10_01_preview)
  listConfigurations is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult,
    Error = CloudError
  >;

  /** Reconciles the specified network security perimeter configuration for a key vault. */
  @added(Versions.v2026_10_01_preview)
  @action("reconcile")
  reconcileConfiguration is ArmResourceActionNoContentSync<
    NetworkSecurityPerimeterConfiguration,
    void,
    Error = CloudError
  >;
}

@@doc(
  NetworkSecurityPerimeterConfiguration.properties,
  "Network security perimeter configuration properties."
);
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(
  CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
