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
  @doc("category of the insight.")
  category: string;

  @doc("status of the insight. example resolved, repaired, other.")
  status?: string;

  @doc("Identifier of the event that has been correlated with this insight. This can be used to aggregate insights for the same event.")
  eventId?: string;

  @doc("Identifier that can be used to group similar insights.")
  groupId?: string;

  @doc("Contains title & description for the insight")
  content: Content;

  @doc("Time of the event, which has been correlated the impact.")
  eventTime?: utcDateTime;

  @doc("unique id of the insight.")
  insightUniqueId: string;

  @doc("details of of the impact for which insight has been generated.")
  impact: ImpactDetails;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing use case"
  @doc("additional details of the insight.")
  additionalDetails?: {};
}

@doc("details of of the impact for which insight has been generated.")
model ImpactDetails {
  @doc("List of impacted Azure resources.")
  impactedResourceId: string;

  @doc("Time at which impact was started according to reported impact.")
  startTime: utcDateTime;

  @doc("Time at which impact was ended according to reported impact.")
  endTime?: utcDateTime;

  @doc("Azure Id of the impact.")
  impactId: string;
}

@doc("Article details of the insight like title, description etc")
model Content {
  @doc("Title of the insight")
  title: string;

  @doc("Description of the insight")
  description: string;
}

@doc("impacted azure resource id.")
model ImpactedResource {
  @doc("impacted azure resource id")
  impactedResourceId: string;
}

@doc("additional user defined field.")
model AdditionalField {
  @doc("name of the field.")
  name: string;

  @doc("value of the field.")
  value: string;
}

@doc("context of post call for insight")
model InsightCustomResourceCommonParameters {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ProviderNamespace<InsightUnderSubscription>;

  /** impact information */
  @query
  @minLength(1)
  @doc("Filter by resource type")
  azureResourceId?: string;
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

  @doc("Create Insight resource, This is Admin only operation")
  create is ArmResourceCreateOrReplaceSync<Insight>;

  @doc("Delete Insight resource, This is Admin only operation")
  delete is ArmResourceDeleteSync<Insight>;
}
