import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a bookmark in Azure Security Insights.
 */
model Bookmark is Azure.ResourceManager.ProxyResource<BookmarkProperties> {
  ...ResourceNameParameter<
    Resource = Bookmark,
    KeyName = "bookmarkId",
    SegmentName = "bookmarks",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface Bookmarks {
  /**
   * Gets a bookmark.
   */
  @tag("Bookmarks")
  get is Extension.Read<OperationalInsights, Bookmark, Error = CloudError>;

  /**
   * Creates or updates the bookmark.
   */
  @tag("Bookmarks")
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    Bookmark,
    Error = CloudError
  >;

  /**
   * Delete the bookmark.
   */
  @tag("Bookmarks")
  delete is Extension.DeleteSync<
    OperationalInsights,
    Bookmark,
    Error = CloudError
  >;

  /**
   * Gets all bookmarks.
   */
  @tag("Bookmarks")
  list is Extension.ListByTarget<
    OperationalInsights,
    Bookmark,
    Response = ArmResponse<BookmarkList>,
    Error = CloudError
  >;

  /**
   * Expand an bookmark
   */
  @tag("Bookmark")
  expand is Extension.ActionSync<
    OperationalInsights,
    Bookmark,
    BookmarkExpandParameters,
    ArmResponse<BookmarkExpandResponse>,
    Error = CloudError
  >;
}

@@doc(Bookmark.name, "Bookmark ID");
@@doc(Bookmark.properties, "Bookmark properties");
@@doc(Bookmarks.createOrUpdate::parameters.resource, "The bookmark");
