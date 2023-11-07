import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Impact;

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

@doc("Insight resource")
@parentResource(WorkloadImpact)
@subscriptionResource
model Insight is ProxyResource<InsightProperties> {
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.]*[a-zA-Z0-9]{3,180}$")
  @key("insightName")
  @segment("insights")
  @doc("Name of the insight")
  @visibility("Read")
  @path
  name: string;
}

@doc("Insight resource")
@subscriptionResource
model InsightUnderSubscription is ProxyResource<InsightProperties> {
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.]*[a-zA-Z0-9]{3,180}$")
  @key("insightName")
  @segment("insights")
  @doc("Name of the insight")
  @visibility("Read")
  @path
  name: string;
}

@doc("Impact category properties.")
model InsightProperties is ResourceProperties {
  @doc("summary of the insight.")
  summary?: string;

  @doc("category of the insight.")
  category?: string;

  @doc("status of the impact. example resolved, repaired, other.")
  status?: string;

  @doc("time at which insight has been generated.")
  createdTime: utcDateTime;

  @doc("time at which insight has been updated.")
  updatedTime: utcDateTime;

  @doc("list of actions performed to or for the azure resource.")
  @extension("x-ms-identifiers", [])
  actions: Action[];

  @doc("details of of the impact for which insight has been generated.")
  impactDetails: ImpactDetails;
}

@doc("details of the action performed to or for the azure resource.")
model Action {
  @doc("summary of the action performed to or for the resource.")
  summary?: string;

  @doc("time at which action was performed.")
  time?: utcDateTime;
}

@doc("details of of the impact for which insight has been generated.")
model ImpactDetails {
  @doc("List of impacted Azure resources.")
  @extension("x-ms-identifiers", [])
  impactedResources: ImpactedResource[];

  @doc("Time at which impact was started according to reported impact.")
  impactStartTime: utcDateTime;

  @doc("azure Id of the impact.")
  impactId: string;

  @doc("unique (guid) id of the impact generated during impact creation.")
  impactUniqueId: string;
}

@doc("impacted azure resource id.")
model ImpactedResource {
  @doc("impacted azure resource id")
  impactedResourceId: string;
}

@doc("context of post call for insight")
model InsightCustomResourceCommonParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ProviderNamespace<InsightUnderSubscription>;

  /** impact information */
  @body impactInfo: InsightDetails;
}

@doc("Body of the get all insights")
model InsightDetails {
  @doc("The ID of the azure resource.")
  azureResourceId?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-uses-templates" "Using subscription scope building blocks"
@armResourceOperations
interface Insights {
  @doc("Get Insight resources by workloadImpactName and insightName")
  get is ArmResourceRead<Insight>;

  @doc("List Insight resources by workloadImpactName")
  listBySubscription is ArmListBySubscription<Insight>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Using subscription level action"
  @post
  @doc("get all insights under subscription")
  @segment("getAllInsights")
  getAll(
    ...InsightCustomResourceCommonParameters,
  ): ArmResponse<ResourceListResult<Insight>> | ErrorResponse;

  /* @doc("get all insights under subscription")
  @segment("getAllInsights")
  getAll2 is ResourceAct<InsightUnderSubscription,insightDetails,ResourceListResult<Insight>>;
  */
}
