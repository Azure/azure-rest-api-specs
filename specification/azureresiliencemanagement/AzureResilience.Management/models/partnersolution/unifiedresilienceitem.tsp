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

@doc("Definition of goals data in unified resilience item.")
model GoalsData {
  @doc("Arm id of the goal template.")
  goalTemplateId: armResourceIdentifier;

  @doc("Arm id of the goal assignment.")
  goalAssignmentId: armResourceIdentifier;

  @doc("Regional RPO set in resilience goal in minutes.")
  regionalRpoInMinutes?: IsoDuration;

  @doc("Computed RPA for the service group in minutes.")
  regionalRpaInMinutes?: IsoDuration;

  @doc("Regional RPO status of the service group.")
  regionalRpoStatus: ResilienceHealthStatus;

  @doc("Regional RTO set in resilience goal in minutes.")
  regionalRtoInMinutes?: IsoDuration;

  @doc("Computed RTA for the service group in minutes.")
  regionalRtaInMinutes?: IsoDuration;

  @doc("Regional RPO status of the service group.")
  regionalRtoStatus: ResilienceHealthStatus;
}

@doc("Definition of recommendation data related to high availability in unified resilience item.")
model RecommendationsHighAvailabilityData {
  @doc("Included resources count for high availability recommendations.")
  includedResourceCount?: int64;

  @doc("Excluded resources count for high availability recommendations.")
  notIncludedResourceCount?: int64;

  @doc("Not evaluated resources count for high availability recommendations.")
  notEvaluatedResourceCount?: int64;

  @doc("Last evaluation date time of high availability recommendation.")
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
