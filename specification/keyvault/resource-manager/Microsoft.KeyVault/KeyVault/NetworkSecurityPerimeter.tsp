import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.KeyVault;

/** Scope parameters shared only by network security perimeter configuration operations. */
model NetworkSecurityPerimeterParameters {
  /** The API version to use for this operation. */
  @query("api-version")
  @minLength(1)
  apiVersion: string;

  /** The ID of the target subscription. */
  @path
  @segment("subscriptions")
  subscriptionId: Azure.Core.uuid;

  /** The name of the resource group. The name is case insensitive. */
  @path
  @segment("resourceGroups")
  @minLength(1)
  @maxLength(90)
  resourceGroupName: string;
}

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
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "NSP operations explicitly reference the canonical v6 ApiVersionParameter through local parameters; this rule only recognizes a direct library spread, which would inherit the service-wide v5 reference."
@added(Versions.v2026_10_01_preview)
@armResourceOperations
@tag("NetworkSecurityPerimeterConfigurations")
interface NetworkSecurityPerimeterConfigurations {
  /** Gets the specified network security perimeter configuration for a key vault. */
  @added(Versions.v2026_10_01_preview)
  getConfiguration is ArmResourceRead<
    NetworkSecurityPerimeterConfiguration,
    BaseParameters = NetworkSecurityPerimeterParameters,
    Response = CommonTypes.NetworkSecurityPerimeterConfiguration,
    Error = CloudError
  >;

  /** Lists the network security perimeter configurations associated with a key vault. */
  @added(Versions.v2026_10_01_preview)
  listConfigurations is ArmResourceListByParent<
    NetworkSecurityPerimeterConfiguration,
    BaseParameters = NetworkSecurityPerimeterParameters,
    Response = CommonTypes.NetworkSecurityPerimeterConfigurationListResult,
    Error = CloudError
  >;

  /** Reconciles the specified network security perimeter configuration for a key vault. */
  @added(Versions.v2026_10_01_preview)
  @action("reconcile")
  reconcileConfiguration is ArmResourceActionNoContentSync<
    NetworkSecurityPerimeterConfiguration,
    void,
    BaseParameters = NetworkSecurityPerimeterParameters,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Reference the v6 API-version parameter only on new NSP operations; changing the service-wide common-types version would alter existing APIs."
@@Azure.ResourceManager.Legacy.externalTypeRef(
  NetworkSecurityPerimeterParameters.apiVersion,
  "{arm-types-dir}/v6/types.json#/parameters/ApiVersionParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Reference the v6 subscription parameter only on new NSP operations; changing the service-wide common-types version would alter existing APIs."
@@Azure.ResourceManager.Legacy.externalTypeRef(
  NetworkSecurityPerimeterParameters.subscriptionId,
  "{arm-types-dir}/v6/types.json#/parameters/SubscriptionIdParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Reference the v6 resource-group parameter only on new NSP operations; changing the service-wide common-types version would alter existing APIs."
@@Azure.ResourceManager.Legacy.externalTypeRef(
  NetworkSecurityPerimeterParameters.resourceGroupName,
  "{arm-types-dir}/v6/types.json#/parameters/ResourceGroupNameParameter"
);

@@doc(
  NetworkSecurityPerimeterConfiguration.properties,
  "Network security perimeter configuration properties."
);
@@pageItems(CommonTypes.NetworkSecurityPerimeterConfigurationListResult.value);
@@nextLink(
  CommonTypes.NetworkSecurityPerimeterConfigurationListResult.nextLink
);
