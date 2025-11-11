import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Sentinel onboarding state
 */
model SentinelOnboardingState
  is Azure.ResourceManager.ProxyResource<SentinelOnboardingStateProperties> {
  ...ResourceNameParameter<
    Resource = SentinelOnboardingState,
    KeyName = "sentinelOnboardingStateName",
    SegmentName = "onboardingStates",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias SentinelWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface SentinelOnboardingStates {
  /**
   * Get Sentinel onboarding state
   */
  get is ArmResourceRead<SentinelOnboardingState>;

  /**
   * Create Sentinel onboarding state
   */
  create is ArmResourceCreateOrReplaceSync<SentinelOnboardingState>;

  /**
   * Delete Sentinel onboarding state
   */
  delete is ArmResourceDeleteSync<SentinelOnboardingState>;

  /**
   * Gets all Sentinel onboarding states
   */
  list is ArmResourceListByParent<
    SentinelOnboardingState,
    Response = ArmResponse<SentinelOnboardingStatesList>
  >;
}

@@doc(SentinelOnboardingState.name,
  "The Sentinel onboarding state name. Supports - default"
);
@@doc(SentinelOnboardingState.properties,
  "The Sentinel onboarding state object"
);
@@doc(SentinelOnboardingStates.create::parameters.resource,
  "The Sentinel onboarding state parameter"
);
