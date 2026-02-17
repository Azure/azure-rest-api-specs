import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// SafeguardsAvailableVersion resource and operations
// =============================================================================

/**
 * Available Safeguards Version
 */
@added(Versions.v2025_10_02_preview)
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

@@maxLength(SafeguardsAvailableVersion.name, 24);
@@minLength(SafeguardsAvailableVersion.name, 1);
@@doc(SafeguardsAvailableVersion.name, "Safeguards version");
@@doc(SafeguardsAvailableVersion.properties,
  "Whether the version is default or not and support info."
);

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface SafeguardsAvailableVersions {
  /**
   * Contains Safeguards version along with its support info and whether it is a default version.
   */
  @summary("Gets supported Safeguards version in the specified subscription and location.")
  getSafeguardsVersions is ArmResourceRead<
    SafeguardsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Contains list of Safeguards version along with its support info and whether it is a default version.
   */
  @summary("Gets a list of supported Safeguards versions in the specified subscription and location.")
  listSafeguardsVersions is ArmResourceListByParent<
    SafeguardsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<SafeguardsAvailableVersionsList>
  >;
}

// =============================================================================
// SafeguardsAvailableVersion models
// =============================================================================

/**
 * Whether the version is preview or stable.
 */
@added(Versions.v2025_10_02_preview)
union SafeguardsSupport {
  string,

  /**
   * The version is preview. It is not recommended to use preview versions on critical production clusters. The preview version may not support all use-cases.
   */
  Preview: "Preview",

  /**
   * The version is stable and can be used on critical production clusters.
   */
  Stable: "Stable",
}

/**
 * Whether the version is default or not and support info.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model SafeguardsAvailableVersionsProperties {
  /** Whether this is the default version. */
  @visibility(Lifecycle.Read)
  isDefaultVersion?: boolean;

  /**
   * Whether the version is preview or stable.
   */
  @visibility(Lifecycle.Read)
  support?: SafeguardsSupport;
}

/**
 * Hold values properties, which is array of SafeguardsVersions
 */
@added(Versions.v2025_10_02_preview)
model SafeguardsAvailableVersionsList
  is Azure.Core.Page<SafeguardsAvailableVersion>;
