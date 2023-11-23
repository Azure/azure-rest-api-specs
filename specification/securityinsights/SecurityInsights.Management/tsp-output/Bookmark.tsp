import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
@doc("Represents a bookmark in Azure Security Insights.")
model Bookmark is ProxyResource<BookmarkProperties> {
  @doc("Bookmark ID")
  @path
  @key("bookmarkId")
  @segment("bookmarks")
  name: string;
}

@armResourceOperations
interface Bookmarks {
  @doc("Gets a bookmark.")
  get is ArmResourceRead<Bookmark>;
  @doc("Creates or updates the bookmark.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Bookmark>;
  @doc("Delete the bookmark.")
  delete is ArmResourceDeleteSync<Bookmark>;
  @doc("Gets all bookmarks.")
  list is ArmResourceListByParent<Bookmark>;
  @doc("Expand an bookmark")
  expand is ArmResourceActionSync<
    Bookmark,
    BookmarkExpandParameters,
    BookmarkExpandResponse
  >;
}
