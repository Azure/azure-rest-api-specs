import "@typespec/openapi";
import "@typespec/rest";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Impact;

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

@doc("Workload Impact properties")
@subscriptionResource
model WorkloadImpact is ProxyResource<WorkloadImpactProperties> {
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-:]*[a-zA-Z0-9]{3,120}$")
  @key("workloadImpactName")
  @segment("workloadImpacts")
  @doc("workloadImpact resource ")
  @visibility("Read")
  @path
  name: string;
}

@doc("Workload impact properties")
model WorkloadImpactProperties is ResourceProperties {
  @doc("Time at which impact was observed ")
  startDateTime: utcDateTime;

  @doc("Time at which impact has ended ")
  endDateTime?: utcDateTime;

  @doc("Azure resource id of the impacted resource")
  impactedResourceId: string;

  @doc("Unique ID of the impact (UUID)")
  @visibility("read")
  @pattern("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
  impactUniqueId?: string;

  @doc("Time at which impact is reported")
  @visibility("read")
  reportedTimeUtc?: utcDateTime;

  @doc("Category of the impact,  details can found from /impactCategories API")
  impactCategory: string;

  @doc("A detailed description of the impact")
  impactDescription?: string;

  @doc("The ARM correlation ids, this is important field for control plane related impacts")
  @extension("x-ms-identifiers", [])
  armCorrelationIds?: string[];

  @doc("Details about performance issue. Applicable for performance impacts.")
  @extension("x-ms-identifiers", [])
  performance?: Performance[];

  @doc("Details about connectivity issue. Applicable when root resource causing the issue is not identified. For example, when a VM is impacted due to a network issue, the impacted resource is identified as the VM, but the root cause is the network. In such cases, the connectivity field will have the details about the network issue")
  connectivity?: Connectivity;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing use case"
  @doc("Additional fields related to impact, applicable fields per resource type are list under /impactCategories API")
  additionalProperties?: {};

  @doc("ARM error code and error message associated with the impact")
  errorDetails?: ErrorDetailProperties;

  @doc("Information about the impacted workload")
  workload?: Workload;

  @doc("Use this field to group impacts")
  impactGroupId?: string;

  @doc("Degree of confidence on the impact being a platform issue")
  confidenceLevel?: ConfidenceLevel;

  @doc("Client incident details ex: incidentId , incident source")
  clientIncidentDetails?: ClientIncidentDetails;
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-uses-templates" "Using subscription scope building blocks"
@armResourceOperations
interface WorkloadImpacts {
  create is ArmResourceCreateOrUpdateAsync<WorkloadImpact>;
  get is ArmResourceRead<WorkloadImpact>;
  delete is ArmResourceDeleteSync<WorkloadImpact>;
  listBySubscription is ArmListBySubscription<WorkloadImpact>;
}
