import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * A Log Analytics QueryPack-Query definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(LogAnalyticsQueryPack)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  LogAnalyticsQueryPackQueryProperties
)
model LogAnalyticsQueryPackQuery extends ProxyResourceBase {
  /**
   * The id of a specific query defined in the Log Analytics QueryPack
   */
  @path
  @key("id")
  @segment("queries")
  @visibility("read")
  name: string;

  /**
   * Properties that define an Log Analytics QueryPack-Query resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LogAnalyticsQueryPackQueryProperties;
}

@armResourceOperations
interface LogAnalyticsQueryPackQueries {
  /**
   * Gets a specific Log Analytics Query defined within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Queries_Get")
  get is ArmResourceRead<LogAnalyticsQueryPackQuery>;

  /**
   * Adds or Updates a specific Query within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Queries_Put")
  put is ArmResourceCreateOrReplaceSync<LogAnalyticsQueryPackQuery>;

  /**
   * Adds or Updates a specific Query within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Queries_Update")
  update is ArmCustomPatchSync<
    LogAnalyticsQueryPackQuery,
    LogAnalyticsQueryPackQuery
  >;

  /**
   * Deletes a specific Query defined within an Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Queries_Delete")
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPackQuery>;

  /**
   * Gets a list of Queries defined within a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Queries_List")
  list is ArmResourceListByParent<
    LogAnalyticsQueryPackQuery,
    {
      ...BaseParameters<LogAnalyticsQueryPackQuery>;

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

@@projectedName(LogAnalyticsQueryPackQueries.put::parameters.resource,
  "json",
  "QueryPayload"
);
@@extension(LogAnalyticsQueryPackQueries.put::parameters.resource,
  "x-ms-client-name",
  "QueryPayload"
);
@@doc(LogAnalyticsQueryPackQueries.put::parameters.resource,
  "Properties that need to be specified to create a new query and add it to a Log Analytics QueryPack."
);
@@projectedName(LogAnalyticsQueryPackQueries.update::parameters.properties,
  "json",
  "QueryPayload"
);
@@extension(LogAnalyticsQueryPackQueries.update::parameters.properties,
  "x-ms-client-name",
  "QueryPayload"
);
@@doc(LogAnalyticsQueryPackQueries.update::parameters.properties,
  "Properties that need to be specified to create a new query and add it to a Log Analytics QueryPack."
);
