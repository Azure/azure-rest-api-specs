import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
@projectedName("client", "VMInsights")
interface VMInsightsOnboardingStatuses_VMInsights {
  @doc("Retrieves the VM Insights onboarding status for the specified resource or resource scope.")
  getOnboardingStatus is ArmResourceRead<VMInsightsOnboardingStatus>;
}
