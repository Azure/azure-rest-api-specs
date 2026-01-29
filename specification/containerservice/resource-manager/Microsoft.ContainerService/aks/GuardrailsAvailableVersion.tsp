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

@@maxLength(GuardrailsAvailableVersion.name, 24);
@@minLength(GuardrailsAvailableVersion.name, 1);
@@doc(GuardrailsAvailableVersion.name, "Safeguards version");
@@doc(GuardrailsAvailableVersion.properties,
  "Whether the version is default or not and support info."
);
