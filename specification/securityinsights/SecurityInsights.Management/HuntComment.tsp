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
 * Represents a Hunt Comment in Azure Security Insights
 */
@parentResource(Hunt)
model HuntComment
  is Azure.ResourceManager.ProxyResource<HuntCommentProperties> {
  ...ResourceNameParameter<
    Resource = HuntComment,
    KeyName = "huntCommentId",
    SegmentName = "comments",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface HuntComments {
  /**
   * Gets a hunt comment
   */
  get is ArmResourceRead<HuntComment>;

  /**
   * Creates or updates a hunt relation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HuntComment>;

  /**
   * Delete a hunt comment.
   */
  delete is ArmResourceDeleteSync<HuntComment>;

  /**
   * Gets all hunt comments
   */
  list is ArmResourceListByParent<
    HuntComment,
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
    Response = ArmResponse<HuntCommentList>
  >;
}

@@doc(HuntComment.name, "The hunt comment id (GUID)");
@@doc(HuntComment.properties, "Hunt Comment properties");
@@doc(HuntComments.createOrUpdate::parameters.resource, "The hunt  comment");
