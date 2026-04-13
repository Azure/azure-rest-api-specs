import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * A Log Analytics QueryPack-Query definition.
 */
@parentResource(LogAnalyticsQueryPack)
model LogAnalyticsQueryPackQuery
  is Azure.ResourceManager.ProxyResource<LogAnalyticsQueryPackQueryProperties> {
  ...ResourceNameParameter<
    Resource = LogAnalyticsQueryPackQuery,
    KeyName = "id",
    SegmentName = "queries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LogAnalyticsQueryPackQueries {
  /**
   * Gets a specific Log Analytics Query defined within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Queries_Get")
  get is ArmResourceRead<LogAnalyticsQueryPackQuery>;

  /**
   * Adds or Updates a specific Query within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Queries_Put")
  put is ArmResourceCreateOrReplaceSync<
    LogAnalyticsQueryPackQuery,
    Response = ArmResourceUpdatedResponse<LogAnalyticsQueryPackQuery>
  >;

  /**
   * Adds or Updates a specific Query within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Queries_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    LogAnalyticsQueryPackQuery,
    PatchModel = LogAnalyticsQueryPackQuery
  >;

  /**
   * Deletes a specific Query defined within an Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Queries_Delete")
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPackQuery>;

  /**
   * Gets a list of Queries defined within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Queries_List")
  list is ArmResourceListByParent<
    LogAnalyticsQueryPackQuery,
    Parameters = {
      /**
       * Maximum items returned in page.
       */
      @query("$top")
      $top?: int64;

      /**
       * Flag indicating whether or not to return the body of each applicable query. If false, only return the query information.
       */
      @query("includeBody")
      includeBody?: boolean;

      /**
       * Base64 encoded token used to fetch the next page of items. Default is null.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@doc(LogAnalyticsQueryPackQuery.name,
  "The id of a specific query defined in the Log Analytics QueryPack"
);
@@doc(LogAnalyticsQueryPackQuery.properties,
  "Properties that define an Log Analytics QueryPack-Query resource."
);
@@doc(LogAnalyticsQueryPackQueries.put::parameters.resource,
  "Properties that need to be specified to create a new query and add it to a Log Analytics QueryPack."
);
@@doc(LogAnalyticsQueryPackQueries.update::parameters.properties,
  "Properties that need to be specified to create a new query and add it to a Log Analytics QueryPack."
);
