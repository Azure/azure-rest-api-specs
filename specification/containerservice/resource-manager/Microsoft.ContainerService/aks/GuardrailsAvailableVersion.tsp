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
// GuardrailsAvailableVersion resource and operations
// =============================================================================

/**
 * Available Guardrails Version
 */
@added(Versions.v2025_10_02_preview)
@parentResource(SubscriptionLocationResource)
model GuardrailsAvailableVersion
  is Azure.ResourceManager.ProxyResource<
    GuardrailsAvailableVersionsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = GuardrailsAvailableVersion,
    KeyName = "version",
    SegmentName = "guardrailsVersions",
    NamePattern = ""
  >;
}

@@maxLength(GuardrailsAvailableVersion.name, 24);
@@minLength(GuardrailsAvailableVersion.name, 1);
@@doc(GuardrailsAvailableVersion.name, "Safeguards version");
@@doc(GuardrailsAvailableVersion.properties,
  "Whether the version is default or not and support info."
);

@armResourceOperations
@added(Versions.v2025_10_02_preview)
interface GuardrailsAvailableVersions {
  /**
   * Contains Guardrails version along with its support info and whether it is a default version.
   */
  @summary("Gets supported Guardrails version in the specified subscription and location.")
  getGuardrailsVersions is ArmResourceRead<
    GuardrailsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Contains list of Guardrails version along with its support info and whether it is a default version.
   */
  @summary("Gets a list of supported Guardrails versions in the specified subscription and location.")
  listGuardrailsVersions is ArmResourceListByParent<
    GuardrailsAvailableVersion,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Response = ArmResponse<GuardrailsAvailableVersionsList>
  >;
}

// =============================================================================
// GuardrailsAvailableVersion models
// =============================================================================

/**
 * Whether the version is preview or stable.
 */
@added(Versions.v2025_10_02_preview)
union GuardrailsSupport {
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
model GuardrailsAvailableVersionsProperties {
  /** Whether this is the default version. */
  @visibility(Lifecycle.Read)
  isDefaultVersion?: boolean;

  /**
   * Whether the version is preview or stable.
   */
  @visibility(Lifecycle.Read)
  support?: GuardrailsSupport;
}

/**
 * Hold values properties, which is array of GuardrailsVersions
 */
@added(Versions.v2025_10_02_preview)
model GuardrailsAvailableVersionsList
  is Azure.Core.Page<GuardrailsAvailableVersion>;
