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
@doc("VM Insights onboarding status for a resource.")
@singleton("default")
model VMInsightsOnboardingStatus
  is ExtensionResource<VMInsightsOnboardingStatusProperties> {
  @key("vmInsightsOnboardingStatus")
  @segment("vmInsightsOnboardingStatuses")
  name: string;
}

@armResourceOperations
interface VMInsightsOnboardingStatuses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieves the VM Insights onboarding status for the specified resource or resource scope.")
  @operationId("VMInsights_GetOnboardingStatus")
  getOnboardingStatus is ArmResourceRead<VMInsightsOnboardingStatus>;
}
