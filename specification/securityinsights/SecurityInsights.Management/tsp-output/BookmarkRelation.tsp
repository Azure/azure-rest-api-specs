import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bookmark.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a relation between two resources")
@parentResource(Bookmark)
model BookmarkRelation is ProxyResource<RelationProperties> {
  @doc("Relation Name")
  @path
  @key("relationName")
  @segment("relations")
  name: string;
}

@armResourceOperations
interface BookmarkRelations {
  @doc("Gets a bookmark relation.")
  get is ArmResourceRead<BookmarkRelation>;
  @doc("Creates the bookmark relation.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BookmarkRelation>;
  @doc("Delete the bookmark relation.")
  delete is ArmResourceDeleteSync<BookmarkRelation>;
  @doc("Gets all bookmark relations.")
  list is ArmResourceListByParent<
    BookmarkRelation,
    {
      ...BaseParameters<BookmarkRelation>;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
