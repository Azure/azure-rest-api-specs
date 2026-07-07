import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * VM Insights onboarding status for a resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
@extensionResource
model VMInsightsOnboardingStatus
  is Azure.ResourceManager.ExtensionResource<VMInsightsOnboardingStatusProperties> {
  ...ResourceNameParameter<
    Resource = VMInsightsOnboardingStatus,
    KeyName = "vmInsightsOnboardingStatus",
    SegmentName = "vmInsightsOnboardingStatuses",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface VMInsightsOnboardingStatuses {
  /**
   * Retrieves the VM Insights onboarding status for the specified resource or resource scope.
   */
  @tag("VM Insights Onboarding")
  getOnboardingStatus is Extension.Read<
    Extension.ScopeParameter,
    VMInsightsOnboardingStatus,
    Error = ResponseWithError
  >;
}

@@doc(VMInsightsOnboardingStatus.name, "");
@@doc(VMInsightsOnboardingStatus.properties, "Resource properties.");
@@key(Extension.ScopeParameter.scope, "resourceUri");
