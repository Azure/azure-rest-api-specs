import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("A Log Analytics QueryPack-Query definition.")
@parentResource(LogAnalyticsQueryPack)
model LogAnalyticsQueryPackQuery
  is ProxyResource<LogAnalyticsQueryPackQueryProperties> {
  @doc("The id of a specific query defined in the Log Analytics QueryPack")
  @path
  @key("id")
  @segment("queries")
  name: string;
}

@armResourceOperations
interface Queries {
  @doc("Gets a specific Log Analytics Query defined within a Log Analytics QueryPack.")
  get is ArmResourceRead<LogAnalyticsQueryPackQuery>;
  @doc("Adds or Updates a specific Query within a Log Analytics QueryPack.")
  put is ArmResourceCreateOrReplaceSync<LogAnalyticsQueryPackQuery>;
  @doc("Adds or Updates a specific Query within a Log Analytics QueryPack.")
  update is ArmResourcePatchSync<
    LogAnalyticsQueryPackQuery,
    LogAnalyticsQueryPackQueryProperties
  >;
  @doc("Deletes a specific Query defined within an Log Analytics QueryPack.")
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPackQuery>;
  @doc("Gets a list of Queries defined within a Log Analytics QueryPack.")
  list is ArmResourceListByParent<
    LogAnalyticsQueryPackQuery,
    {
      ...BaseParameters<LogAnalyticsQueryPackQuery>;

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
