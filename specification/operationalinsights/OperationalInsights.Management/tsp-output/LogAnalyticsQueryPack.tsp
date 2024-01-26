import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * An Log Analytics QueryPack definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  LogAnalyticsQueryPackProperties
)
model LogAnalyticsQueryPack extends TrackedResourceBase {
  /**
   * The name of the Log Analytics QueryPack resource.
   */
  @path
  @key("queryPackName")
  @segment("queryPacks")
  @visibility("read")
  name: string;

  /**
   * Properties that define a Log Analytics QueryPack resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: LogAnalyticsQueryPackProperties;
}

@armResourceOperations
interface LogAnalyticsQueryPacks {
  /**
   * Returns a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryPacks_Get")
  get is ArmResourceRead<LogAnalyticsQueryPack>;

  /**
   * Creates (or updates) a Log Analytics QueryPack. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryPacks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LogAnalyticsQueryPack>;

  /**
   * Updates an existing QueryPack's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("QueryPacks_UpdateTags")
  updateTags is ArmCustomPatchSync<LogAnalyticsQueryPack, TagsResource>;

  /**
   * Deletes a Log Analytics QueryPack.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryPacks_Delete")
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPack>;

  /**
   * Gets a list of Log Analytics QueryPacks within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryPacks_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<LogAnalyticsQueryPack>;

  /**
   * Gets a list of all Log Analytics QueryPacks within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryPacks_List")
  list is ArmListBySubscription<LogAnalyticsQueryPack>;

  /**
   * Search a list of Queries defined within a Log Analytics QueryPack according to given search properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Queries_Search")
  search is ArmResourceActionSync<
    LogAnalyticsQueryPack,
    LogAnalyticsQueryPackQuerySearchProperties,
    ResourceListResult<LogAnalyticsQueryPackQuery>,
    {
      ...BaseParameters<LogAnalyticsQueryPack>;

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

@@projectedName(LogAnalyticsQueryPacks.createOrUpdate::parameters.resource,
  "json",
  "LogAnalyticsQueryPackPayload"
);
@@extension(LogAnalyticsQueryPacks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "LogAnalyticsQueryPackPayload"
);
@@doc(LogAnalyticsQueryPacks.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Log Analytics QueryPack."
);
@@projectedName(LogAnalyticsQueryPacks.updateTags::parameters.properties,
  "json",
  "QueryPackTags"
);
@@extension(LogAnalyticsQueryPacks.updateTags::parameters.properties,
  "x-ms-client-name",
  "QueryPackTags"
);
@@doc(LogAnalyticsQueryPacks.updateTags::parameters.properties,
  "Updated tag information to set into the QueryPack instance."
);
@@projectedName(LogAnalyticsQueryPacks.search::parameters.body,
  "json",
  "QuerySearchProperties"
);
@@extension(LogAnalyticsQueryPacks.search::parameters.body,
  "x-ms-client-name",
  "QuerySearchProperties"
);
@@doc(LogAnalyticsQueryPacks.search::parameters.body,
  "Properties by which to search queries in the given Log Analytics QueryPack."
);
