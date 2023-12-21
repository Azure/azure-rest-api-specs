import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("An Log Analytics QueryPack definition.")
model LogAnalyticsQueryPack
  is TrackedResource<LogAnalyticsQueryPackProperties> {
  @doc("The name of the Log Analytics QueryPack resource.")
  @path
  @key("queryPackName")
  @segment("queryPacks")
  name: string;
}

@armResourceOperations
interface QueryPacks {
  @doc("Returns a Log Analytics QueryPack.")
  get is ArmResourceRead<LogAnalyticsQueryPack>;
  @doc("Creates (or updates) a Log Analytics QueryPack. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogAnalyticsQueryPack>;
  @doc("Updates an existing QueryPack's tags. To update other fields use the CreateOrUpdate method.")
  updateTags is ArmTagsPatchSync<LogAnalyticsQueryPack>;
  @doc("Deletes a Log Analytics QueryPack.")
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPack>;
  @doc("Gets a list of Log Analytics QueryPacks within a resource group.")
  listByResourceGroup is ArmResourceListByParent<LogAnalyticsQueryPack>;
  @doc("Gets a list of all Log Analytics QueryPacks within a subscription.")
  list is ArmListBySubscription<LogAnalyticsQueryPack>;
}

@armResourceOperations
interface Queries {
  @doc("Search a list of Queries defined within a Log Analytics QueryPack according to given search properties.")
  search is ArmResourceActionSync<
    LogAnalyticsQueryPack,
    LogAnalyticsQueryPackQuerySearchProperties,
    ResourceListResult<LogAnalyticsQueryPackQuery>,
    {
      ...BaseParameters<LogAnalyticsQueryPack>;

      @doc("Maximum items returned in page.")
      @query("$top")
      $top?: int32;

      @doc("Flag indicating whether or not to return the body of each applicable query. If false, only return the query information.")
      @query("includeBody")
      includeBody?: boolean;

      @doc("Base64 encoded token used to fetch the next page of items. Default is null.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
