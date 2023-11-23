import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Sentinel onboarding state")
model SentinelOnboardingState
  is ProxyResource<SentinelOnboardingStateProperties> {
  @doc("The Sentinel onboarding state name. Supports - default")
  @path
  @key("sentinelOnboardingStateName")
  @segment("onboardingStates")
  name: string;
}

@armResourceOperations
interface SentinelOnboardingStates {
  @doc("Get Sentinel onboarding state")
  get is ArmResourceRead<SentinelOnboardingState>;
  @doc("Create Sentinel onboarding state")
  create is ArmResourceCreateOrReplaceSync<SentinelOnboardingState>;
  @doc("Delete Sentinel onboarding state")
  delete is ArmResourceDeleteSync<SentinelOnboardingState>;
  @doc("Gets all Sentinel onboarding states")
  list is ArmResourceListByParent<SentinelOnboardingState>;
}
