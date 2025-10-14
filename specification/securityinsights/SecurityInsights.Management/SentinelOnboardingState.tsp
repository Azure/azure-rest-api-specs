import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

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

@armResourceOperations
interface SentinelOnboardingStates {
  /**
   * Get Sentinel onboarding state
   */
  get is Extension.Read<
    OperationalInsights,
    SentinelOnboardingState,
    Error = CloudError
  >;

  /**
   * Create Sentinel onboarding state
   */
  create is Extension.CreateOrReplaceSync<
    OperationalInsights,
    SentinelOnboardingState,
    Error = CloudError
  >;

  /**
   * Delete Sentinel onboarding state
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    SentinelOnboardingState,
    Error = CloudError
  >;

  /**
   * Gets all Sentinel onboarding states
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    SentinelOnboardingState,
    Response = ArmResponse<SentinelOnboardingStatesList>,
    Error = CloudError
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
