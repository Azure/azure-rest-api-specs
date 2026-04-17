import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * An Log Analytics QueryPack definition.
 */
model LogAnalyticsQueryPack
  is Azure.ResourceManager.TrackedResource<
    LogAnalyticsQueryPackProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = LogAnalyticsQueryPack,
    KeyName = "queryPackName",
    SegmentName = "queryPacks",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface LogAnalyticsQueryPacks {
  /**
   * Returns a Log Analytics QueryPack.
   */
  get is ArmResourceRead<LogAnalyticsQueryPack>;

  /**
   * Creates (or updates) a Log Analytics QueryPack. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LogAnalyticsQueryPack,
    Response = ArmResourceUpdatedResponse<LogAnalyticsQueryPack>
  >;

  /**
   * Updates an existing QueryPack's tags. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    LogAnalyticsQueryPack,
    PatchModel = TagsResource
  >;

  /**
   * Deletes a Log Analytics QueryPack.
   */
  delete is ArmResourceDeleteSync<LogAnalyticsQueryPack>;

  /**
   * Gets a list of Log Analytics QueryPacks within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<LogAnalyticsQueryPack>;

  /**
   * Gets a list of all Log Analytics QueryPacks within a subscription.
   */
  list is ArmListBySubscription<LogAnalyticsQueryPack>;

  /**
   * Search a list of Queries defined within a Log Analytics QueryPack according to given search properties.
   */
  @list
  @action("queries/search")
  search is ArmResourceActionSync<
    LogAnalyticsQueryPack,
    LogAnalyticsQueryPackQuerySearchProperties,
    ArmResponse<ResourceListResult<LogAnalyticsQueryPackQuery>>,
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

@@doc(LogAnalyticsQueryPack.name,
  "The name of the Log Analytics QueryPack resource."
);
@@doc(LogAnalyticsQueryPack.properties,
  "Properties that define a Log Analytics QueryPack resource."
);
@@doc(LogAnalyticsQueryPacks.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Log Analytics QueryPack."
);
@@doc(LogAnalyticsQueryPacks.updateTags::parameters.properties,
  "Updated tag information to set into the QueryPack instance."
);
@@doc(LogAnalyticsQueryPacks.search::parameters.body,
  "Properties by which to search queries in the given Log Analytics QueryPack."
);
