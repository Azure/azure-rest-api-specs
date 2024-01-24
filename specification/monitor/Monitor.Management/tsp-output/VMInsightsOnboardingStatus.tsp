import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * VM Insights onboarding status for a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@Azure.ResourceManager.Private.armResourceInternal(
  VMInsightsOnboardingStatusProperties
)
@includeInapplicableMetadataInPayload(false)
model VMInsightsOnboardingStatus extends ExtensionResourceBase {
  @key("vmInsightsOnboardingStatus")
  @segment("vmInsightsOnboardingStatuses")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VMInsightsOnboardingStatusProperties;
}

@armResourceOperations
interface VMInsightsOnboardingStatuses {
  /**
   * Retrieves the VM Insights onboarding status for the specified resource or resource scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VMInsights_GetOnboardingStatus")
  getOnboardingStatus is ArmResourceRead<VMInsightsOnboardingStatus>;
}
