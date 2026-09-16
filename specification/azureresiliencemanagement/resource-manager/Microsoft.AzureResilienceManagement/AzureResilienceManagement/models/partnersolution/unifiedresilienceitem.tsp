import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("enum for Resilience health status.")
@removed(Versions.v2026_09_30_preview)
union ResilienceHealthStatus {
  @doc("Resource is not evaluated.")
  NotEvaluated: "NotEvaluated",

  string,

  @doc("Resource is Unhealthy.")
  Unhealthy: "Unhealthy",

  string,

  @doc("Resource is Healthy.")
  Healthy: "Healthy",

  string,
}

@doc("Enum for the requirement status of the resource in the goal.")
@removed(Versions.v2026_09_30_preview)
union UnifiedResilienceItemRequirementSelected {
  string,

  @doc("The resource is not required for the specified goal.")
  NotRequired: "NotRequired",

  @doc("The resource is required for the specified goal.")
  Required: "Required",

  @doc("The resource is not selected for the specified goal.")
  NotSelected: "NotSelected",
}

@added(Versions.v2026_09_30_preview)
@doc("Definition of a resilience goal requirement copied from the goal assignment.")
model UnifiedResilienceItemGoalRequirement {
  @doc("Whether the goal is required for the service group.")
  required: boolean;
}

@doc("Definition of goals data in unified resilience item.")
model GoalsData {
  @doc("Arm id of the goal template.")
  @removed(Versions.v2026_09_30_preview)
  templateId: armResourceIdentifier;

  @doc("Arm id of the goal assignment.")
  assignmentId: armResourceIdentifier;

  @doc("Zonal resiliency goal copied from the goal assignment.")
  @added(Versions.v2026_09_30_preview)
  zonalResiliency?: UnifiedResilienceItemGoalRequirement;

  @doc("Regional resiliency goal copied from the goal assignment.")
  @added(Versions.v2026_09_30_preview)
  regionalResiliency?: UnifiedResilienceItemGoalRequirement;

  @doc("Regional RPO set in resilience goal in minutes.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryPointObjectiveInMinutes?: IsoDuration;

  @doc("Computed recovery point estimated for the service group in minutes.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryPointEstimatedInMinutes?: IsoDuration;

  @doc("Regional RPO status of the service group.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryPointObjectiveStatus: ResilienceHealthStatus;

  @doc("Regional RTO set in resilience goal in minutes.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryTimeObjectiveInMinutes?: IsoDuration;

  @doc("Computed RTA for the service group in minutes.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryTimeActualInMinutes?: IsoDuration;

  @doc("Regional RTO status of the service group.")
  @removed(Versions.v2026_09_30_preview)
  regionalRecoveryTimeObjectiveStatus: ResilienceHealthStatus;

  @doc("Whether the resource is required for high availability.")
  @removed(Versions.v2026_09_30_preview)
  requireHighAvailability?: UnifiedResilienceItemRequirementSelected;

  @doc("Whether the resource is required for disaster recovery.")
  @removed(Versions.v2026_09_30_preview)
  requireDisasterRecovery?: UnifiedResilienceItemRequirementSelected;
}

@doc("Definition of recommendation data related to high availability in unified resilience item.")
@removed(Versions.v2026_09_30_preview)
model RecommendationsHighAvailabilityData {
  @doc("Count of resources that have high availability enabled.")
  enabledResourceCount?: int64;

  @doc("Count of resources that do not have high availability enabled.")
  notEnabledResourceCount?: int64;

  @doc("Count of resources that have not been evaluated for high availability.")
  notEvaluatedResourceCount?: int64;

  @doc("The date and time when the high availability recommendations were last evaluated.")
  evaluationDateTime?: utcDateTime;
}

@doc("Definition of recommendations data in unified resilience item.")
@removed(Versions.v2026_09_30_preview)
model RecommendationsData {
  @doc("The high availability section of resilience recommendation.")
  highAvailability: RecommendationsHighAvailabilityData;
}

@added(Versions.v2026_09_30_preview)
@doc("Definition of the zonal resiliency assessment computed for the unified resilience item.")
model UnifiedResilienceItemZonalAssessment {
  @doc("Count of resources that have zonal resiliency enabled.")
  enabledResourceCount?: int64;

  @doc("Count of resources that do not have zonal resiliency enabled.")
  notEnabledResourceCount?: int64;

  @doc("Count of resources that have not been evaluated for zonal resiliency.")
  notEvaluatedResourceCount?: int64;

  @doc("Count of resources that require user confirmation for zonal resiliency.")
  userConfirmationNeededCount?: int64;

  @doc("The date and time when the zonal resiliency assessment was last evaluated.")
  evaluationDateTime?: utcDateTime;
}

@added(Versions.v2026_09_30_preview)
@doc("Definition of the regional resiliency assessment computed for the unified resilience item.")
model UnifiedResilienceItemRegionalAssessment {
  @doc("Count of resources that have regional resiliency enabled.")
  enabledResourceCount?: int64;

  @doc("Count of resources that do not have regional resiliency enabled.")
  notEnabledResourceCount?: int64;

  @doc("Count of resources that have not been evaluated for regional resiliency.")
  notEvaluatedResourceCount?: int64;

  @doc("Count of resources that require user confirmation for regional resiliency.")
  userConfirmationNeededCount?: int64;

  @doc("The date and time when the regional resiliency assessment was last evaluated.")
  evaluationDateTime?: utcDateTime;

  @doc("The estimated recovery point objective computed for the service group, expressed as an ISO 8601 duration.")
  estimatedRecoveryPointObjective?: IsoDuration;
}

@added(Versions.v2026_09_30_preview)
@doc("Definition of the resilience assessments computed for the unified resilience item.")
model UnifiedResilienceItemAssessments {
  @doc("The zonal resiliency section of the resilience assessment.")
  zonalResiliency: UnifiedResilienceItemZonalAssessment;

  @doc("The regional resiliency section of the resilience assessment.")
  regionalResiliency: UnifiedResilienceItemRegionalAssessment;
}

@added(Versions.v2026_09_30_preview)
@doc("Definition of billing information in unified resilience item.")
model UnifiedResilienceItemBillingInfo {
  @doc("Arm id of the usage plan applied to the service group.")
  usagePlanArmId?: armResourceIdentifier;

  @doc("Arm id of the usage plan enrollment that links the usage plan to the service group.")
  usagePlanEnrollmentArmId?: armResourceIdentifier;

  @doc("The date and time when the usage plan enrollment was created.")
  usagePlanEnrollmentCreatedOn?: utcDateTime;

  @doc("The date and time when the usage plan enrollment was last updated.")
  usagePlanEnrollmentLastUpdatedOn?: utcDateTime;

  @doc("Details of any errors encountered while resolving the billing information.")
  @visibility(Lifecycle.Read)
  errorDetails?: CommonTypes.ErrorDetail;
}

// Define the main model
@doc("Definition of unified resilience item property.")
model UnifiedResilienceItemProperties {
  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Computed and copied data of resilience goals.")
  goals: GoalsData;

  @doc("Computed and copied data of Azure recommendations.")
  @removed(Versions.v2026_09_30_preview)
  recommendations: RecommendationsData;

  @doc("Resilience assessments computed for the service group.")
  @added(Versions.v2026_09_30_preview)
  assessments: UnifiedResilienceItemAssessments;

  @doc("Usage plan and enrollment billing information for the service group.")
  @added(Versions.v2026_09_30_preview)
  billingInfo?: UnifiedResilienceItemBillingInfo;

  @doc("Last modified time of the unified resilience item.")
  lastModifiedTime: utcDateTime;
}

@tenantResource
@doc("A unified resilience item represents a computed and aggregated resilience information of Azure Applications.")
model UnifiedResilienceItem is ProxyResource<UnifiedResilienceItemProperties> {
  @doc("The name of the unified resilience item.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("unifiedResilienceItemName")
  @segment("unifiedResilienceItems")
  @path
  name: string;
}
