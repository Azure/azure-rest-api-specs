import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;
/**
 * Available Safeguards Version
 */
@added(Versions.v2025_09_02_preview)
@parentResource(SubscriptionLocationResource)
model SafeguardsAvailableVersion
  is Azure.ResourceManager.ProxyResource<
    SafeguardsAvailableVersionsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = SafeguardsAvailableVersion,
    KeyName = "version",
    SegmentName = "safeguardsVersions",
    NamePattern = ""
  >;
}

@armResourceOperations
@added(Versions.v2025_09_02_preview)
interface SafeguardsAvailableVersions {
  /**
   * Contains Safeguards version along with its support info and whether it is a default version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getSafeguardsVersions is ArmResourceRead<
    SafeguardsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Contains list of Safeguards version along with its support info and whether it is a default version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listSafeguardsVersions is ArmResourceListByParent<
    SafeguardsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SafeguardsAvailableVersionsList>
  >;
}

@@maxLength(SafeguardsAvailableVersion.name, 24);
@@minLength(SafeguardsAvailableVersion.name, 1);
@@doc(SafeguardsAvailableVersion.name, "Safeguards version");
@@doc(SafeguardsAvailableVersion.properties,
  "Whether the version is default or not and support info."
);
