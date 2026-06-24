import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.AzureResilienceManagement;
using Azure.Core;
using Azure.ResourceManager;

@@clientName(
  Microsoft.AzureResilienceManagement,
  "ResilienceManagementClient",
  "python"
);

@@clientName(DrillResource, "DrillTarget", "csharp");
@@clientName(DrillRunResource, "DrillRunTarget", "csharp");
@@clientName(RecoveryJobResource, "RecoveryJobTarget", "csharp");
@@clientName(ChaosJobResource, "ChaosJobTarget", "csharp");

// CSharp: AZC0030 — *Request -> *Content
@@clientName(DrillRunFailoverRequest, "DrillRunFailoverContent", "csharp");
@@clientName(DrillEndRequest, "DrillEndContent", "csharp");
@@clientName(FailoverRequest, "ResilienceManagementFailoverContent", "csharp");
@@clientName(
  AddOrUpdateResourcesRequest,
  "AddOrUpdateResourcesContent",
  "csharp"
);
@@clientName(DrillStartRequest, "DrillStartContent", "csharp");
@@clientName(DrillRunAddNotesRequest, "DrillRunAddNotesContent", "csharp");
@@clientName(RecommendCapacityRequest, "RecommendCapacityContent", "csharp");
@@clientName(RecoveryActionRequest, "RecoveryActionContent", "csharp");
@@clientName(
  TestFailoverCleanupRequest,
  "TestFailoverCleanupContent",
  "csharp"
);
@@clientName(ReprotectRequest, "ReprotectContent", "csharp");
@@clientName(
  ValidateForOperationRequest,
  "ValidateForOperationContent",
  "csharp"
);
@@clientName(UpdateGoalResourceRequest, "UpdateGoalResourceContent", "csharp");
@@clientName(MarkAsCompleteRequest, "MarkAsCompleteContent", "csharp");
@@clientName(
  UpdateRecoveryResourcesRequest,
  "UpdateRecoveryResourcesContent",
  "csharp"
);
@@clientName(
  ValidateForExecutionRequest,
  "ValidateForExecutionContent",
  "csharp"
);
@@clientName(
  DrillRunTestFailoverCleanupRequest,
  "DrillRunTestFailoverCleanupContent",
  "csharp"
);
@@clientName(
  DrillRunTestFailoverRequest,
  "DrillRunTestFailoverContent",
  "csharp"
);

// CSharp: AZC0030 — *Response -> *Result
@@clientName(
  RecoveryPlanActionBaseResponse,
  "RecoveryPlanActionBaseResult",
  "csharp"
);
@@clientName(
  ValidateForRecoveryOperationBaseResponse,
  "ValidateForRecoveryOperationBaseResult",
  "csharp"
);
@@clientName(
  UpdateRecoveryResourcesResponse,
  "UpdateRecoveryResourcesResult",
  "csharp"
);

// CSharp: AZC0032 — *Data is reserved (collides with auto-generated *Data POCOs)
@@clientName(GoalsData, "ResilienceManagementGoalsInfo", "csharp");
@@clientName(
  RecommendationsHighAvailabilityData,
  "RecommendationsHighAvailabilityInfo",
  "csharp"
);

// These three are reference/content models and must not use the *Resource suffix.
@@clientName(IncludeOrUpdateResource, "IncludeOrUpdateContent", "csharp");
@@clientName(MoboBrokerResource, "ManagedBrokerTarget", "csharp");
@@clientName(ServiceLevelResource, "ServiceLevelTarget", "csharp");

@@clientName(RBACState, "ResilienceManagementRbacState", "csharp");
@@clientName(RBACSetupMode, "ResilienceManagementRbacSetupMode", "csharp");
@@clientName(VMPresent, "VmPresent", "csharp");
@@clientName(HAStatus, "HighAvailabilityStatus", "csharp");
@@clientName(
  ProvisioningState,
  "ResilienceManagementProvisioningState",
  "csharp"
);
@@clientName(ErrorDetails, "ResilienceManagementErrorDetail", "csharp");
@@clientName(SystemMetadata, "DrillSystemMetadata", "csharp");
@@clientName(ActionTask, "ResilienceManagementActionTask", "csharp");
@@clientName(ResourceLists, "DrillResourcesList", "csharp");
@@clientName(
  SolutionDisplayName,
  "ResilienceManagementSolutionDisplayName",
  "csharp"
);
@@alternateType(MoboBrokerResource.id, armResourceIdentifier, "csharp");
@@clientName(
  RecoveryResourceProperties.needsAttention,
  "IsAttentionRequired",
  "csharp"
);
@@clientName(DrillRunAddNotesRequest.timestamp, "RecordedOn", "csharp");
@@alternateType(
  RecoveryResourceProperties.resourceLocation,
  azureLocation,
  "csharp"
);
@@alternateType(
  ResourceProtectionSolutionSettings.activeLocation,
  azureLocation,
  "csharp"
);
@@alternateType(
  ResourceProtectionSolutionSettings.activeLocations,
  azureLocation[],
  "csharp"
);
@@clientName(ForceInclusionAndUpdate, "ForceInclusionState", "csharp");
@@clientName(
  AssociatedIdentity,
  "ResilienceManagementAssociatedIdentity",
  "csharp"
);
@@clientName(GoalResource, "GoalMembers", "csharp");
@@clientName(RecoveryResource, "RecoveryMembers", "csharp");
@@clientName(Drill, "ResilienceManagementDrill", "csharp");
@@clientName(Enrollment, "UsagePlanEnrollment", "csharp");
@@clientName(GoalType, "ResilienceManagementGoalType", "csharp");
@@clientName(MembershipType, "ResilienceManagementMembershipType", "csharp");
@@clientName(JobStatus, "ResilienceManagementJobStatus", "csharp");

// JavaScript SDK: use an update-specific model for RecoveryPlans.update.
// RecoveryPlans.update is an ArmResourcePatch operation, but the modular JavaScript
// emitter surfaces the full RecoveryPlanProperties on the PATCH body, exposing
// server-side read-only and create-only fields (provisioningState, planType,
// planState, latestFailoverStatus, latestValidationStatus, errorDetails) that
// callers cannot set. The standalone models below mirror the generated PATCH body
// (RecoveryPlanUpdate / RecoveryPlanPropertiesUpdate) and are substituted only for
// JavaScript so the update payload contains just the updatable fields.
// TODO: Remove this once the template has been updated to CustomPatch.

@doc("Properties of the recovery orchestration plan that can be updated.")
model RecoveryPlanUpdateProperties {
  @doc("A description of the recovery orchestration plan.")
  @minLength(5)
  @maxLength(50)
  planDescription?: string;

  @doc("Settings for the recovery orchestration groups associated with the recovery orchestration plan.")
  recoveryGroupsSetting?: RecoveryGroupsSetting;
}

@doc("Represents a recovery orchestration plan resource in the Azure Resilience Management provider namespace.")
model RecoveryPlanUpdate {
  @doc("The managed service identities assigned to this resource.")
  identity?: CommonTypes.ManagedServiceIdentity;

  @doc("The resource-specific properties for this resource.")
  properties?: RecoveryPlanUpdateProperties;
}

@@alternateType(
  Microsoft.AzureResilienceManagement.RecoveryPlans.update::parameters.properties,
  RecoveryPlanUpdate,
  "javascript"
);
