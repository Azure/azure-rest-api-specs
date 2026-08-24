import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("ISO 8601 duration formats.")
union IsoDuration {
  @doc("15 minutes.")
  PT15M: "PT15M",

  string,

  @doc("1 hour.")
  PT1H: "PT1H",

  string,

  @doc("4 hours.")
  PT4H: "PT4H",

  string,

  @doc("24 hours.")
  PT24H: "PT24H",

  string,
}

@doc("enum for Resilience health status.")
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
union UnifiedResilienceItemRequirementSelected {
  string,

  @doc("The resource is not required for the specified goal.")
  NotRequired: "NotRequired",

  @doc("The resource is required for the specified goal.")
  Required: "Required",

  @doc("The resource is not selected for the specified goal.")
  NotSelected: "NotSelected",
}

@doc("Definition of goals data in unified resilience item.")
model GoalsData {
  @doc("Arm id of the goal template.")
  templateId: armResourceIdentifier;

  @doc("Arm id of the goal assignment.")
  assignmentId: armResourceIdentifier;

  @doc("Regional RPO set in resilience goal in minutes.")
  regionalRecoveryPointObjectiveInMinutes?: IsoDuration;

  @doc("Computed recovery point estimated for the service group in minutes.")
  regionalRecoveryPointEstimatedInMinutes?: IsoDuration;

  @doc("Regional RPO status of the service group.")
  regionalRecoveryPointObjectiveStatus: ResilienceHealthStatus;

  @doc("Regional RTO set in resilience goal in minutes.")
  regionalRecoveryTimeObjectiveInMinutes?: IsoDuration;

  @doc("Computed RTA for the service group in minutes.")
  regionalRecoveryTimeActualInMinutes?: IsoDuration;

  @doc("Regional RTO status of the service group.")
  regionalRecoveryTimeObjectiveStatus: ResilienceHealthStatus;

  @doc("Whether the resource is required for high availability.")
  requireHighAvailability?: UnifiedResilienceItemRequirementSelected;

  @doc("Whether the resource is required for disaster recovery.")
  requireDisasterRecovery?: UnifiedResilienceItemRequirementSelected;
}

@doc("Definition of recommendation data related to high availability in unified resilience item.")
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
model RecommendationsData {
  @doc("The high availability section of resilience recommendation.")
  highAvailability: RecommendationsHighAvailabilityData;
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
  recommendations: RecommendationsData;

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
