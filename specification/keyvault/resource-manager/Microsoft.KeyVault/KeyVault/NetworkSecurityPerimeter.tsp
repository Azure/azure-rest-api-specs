import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.KeyVault;

/** The key vault parent scope for network security perimeter configuration operations. */
@added(Versions.v2026_10_01_preview)
@armVirtualResource
@resourceGroupResource
model NetworkSecurityPerimeterVault {
  /** The name of the key vault. */
  @path
  @key("vaultName")
  @segment("vaults")
  @pattern("^[A-Za-z]([A-Za-z0-9]|-[A-Za-z0-9])+$")
  @minLength(3)
  @maxLength(24)
  name: string;
}

/** A network security perimeter configuration associated with a key vault. */
@added(Versions.v2026_10_01_preview)
@parentResource(NetworkSecurityPerimeterVault)
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing NSP common-types v5 response contract while ARM parameters use v6; explicit common-schema references currently require this legacy decorator."
@@Azure.ResourceManager.Legacy.externalTypeRef(
  CommonTypes.NetworkSecurityPerimeterConfiguration,
  "../../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing NSP common-types v5 list response contract while ARM parameters use v6; explicit common-schema references currently require this legacy decorator."
@@Azure.ResourceManager.Legacy.externalTypeRef(
  CommonTypes.NetworkSecurityPerimeterConfigurationListResult,
  "../../../../../../common-types/resource-management/v5/networksecurityperimeter.json#/definitions/NetworkSecurityPerimeterConfigurationListResult"
);
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(
  CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
