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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Bookmarks {
  /**
   * Gets a bookmark.
   */
  get is Extension.Read<OperationalInsights, Bookmark, Error = CloudError>;

  /**
   * Creates or updates the bookmark.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    Bookmark,
    Error = CloudError
  >;

  /**
   * Delete the bookmark.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    Bookmark,
    Error = CloudError
  >;

  /**
   * Gets all bookmarks.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    Bookmark,
    Response = ArmResponse<BookmarkList>,
    Error = CloudError
  >;

  /**
   * Expand an bookmark
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Bookmark_Expand")
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
