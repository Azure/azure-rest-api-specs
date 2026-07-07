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

@armResourceOperations(#{ omitTags: true })
interface VMInsightsOnboardingStatuses {
  /**
   * Retrieves the VM Insights onboarding status for the specified resource or resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VMInsights_GetOnboardingStatus")
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
