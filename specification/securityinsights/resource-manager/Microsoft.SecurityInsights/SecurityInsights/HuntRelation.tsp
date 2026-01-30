import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Hunt.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a Hunt Relation in Azure Security Insights.
 */
@parentResource(Hunt)
model HuntRelation
  is Azure.ResourceManager.ProxyResource<HuntRelationProperties> {
  ...ResourceNameParameter<
    Resource = HuntRelation,
    KeyName = "huntRelationId",
    SegmentName = "relations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface HuntRelations {
  /**
   * Gets a hunt relation
   */
  get is Extension.Read<
    workspaceExternalResource,
    HuntRelation,
    Error = CloudError
  >;

  /**
   * Creates or updates a hunt relation.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    HuntRelation,
    Error = CloudError
  >;

  /**
   * Delete a hunt relation.
   */
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    HuntRelation,
    Error = CloudError
  >;

  /**
   * Gets all hunt relations
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    HuntRelation,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<HuntRelationList>,
    Error = CloudError
  >;
}

@@doc(HuntRelation.name, "The hunt relation id (GUID)");
@@doc(HuntRelation.properties, "Hunt Relation properties");
@@doc(HuntRelations.createOrUpdate::parameters.resource, "The hunt relation");
