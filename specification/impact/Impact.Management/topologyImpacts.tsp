import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Impact;

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@doc("Topology Impact properties")
@subscriptionResource
model TopologyImpact is ProxyResource<TopologyImpactProperties> {
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-:]*[a-zA-Z0-9]{3,120}$")
  @key("topologyImpactName")
  @segment("topologyImpacts")
  @doc("topologyImpact resource ")
  @visibility("Read")
  @path
  name: string;
}

@doc("Topology impact properties")
model TopologyImpactProperties is ResourceProperties {
  @doc("Time at which impact was observed ")
  startDateTime: utcDateTime;

  @doc("Time at which impact has ended ")
  endDateTime?: utcDateTime;

  @doc("list of impacted resources and associated arm correlation ids")
  @extension("x-ms-identifiers", [])
  impactedResources: ImpactedResources[];

  @doc("Unique ID of the impact (UUID)")
  @visibility("read")
  @pattern("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}")
  topologyImpactUniqueId?: string;

  @doc("Time at which impact is reported")
  @visibility("read")
  reportedTimeUtc?: utcDateTime;

  @doc("Category of the impact,  if not provided default category would be considered as dataplane impact")
  impactCategory?: ImpactCategoryEnum;

  @doc("A detailed description of the impact")
  impactDescription?: string;

  @doc("Additional fields related to impact, applicable fields per resource type are list under /impactCategories API")
  additionalProperties?: {};

  @doc("ARM error code and error message associated with the impact")
  errorDetails?: ErrorDetailProperties;

  @doc("Details about performance issue. Applicable for performance impacts.")
  @extension("x-ms-identifiers", [])
  performance?: Performance[];

  @doc("Information about the impacted workload")
  workload?: Workload;

  @doc("Use this field to group impacts")
  impactGroupId?: string;

  @doc("Degree of confidence on the impact being a platform issue")
  confidenceLevel?: ConfidenceLevel;

  @doc("Client incident details ex: incidentId , incident source")
  clientIncidentDetails?: ClientIncidentDetails;
}

@doc("resource and associated arm correlation ids")
model ImpactedResources {
  @doc("Azure resource id of the impacted resource")
  impactedResourceId: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-uses-templates" "Using subscription scope building blocks"
@armResourceOperations
interface TopologyImpacts {
  create is ArmResourceCreateOrUpdateAsync<TopologyImpact>;
  get is ArmResourceRead<TopologyImpact>;
  delete is ArmResourceDeleteSync<TopologyImpact>;
  listBySubscription is ArmListBySubscription<TopologyImpact>;
}
