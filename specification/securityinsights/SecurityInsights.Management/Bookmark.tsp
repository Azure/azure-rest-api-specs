import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

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

alias BookmarkWorkspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Bookmarks {
  /**
   * Gets a bookmark.
   */
  get is ArmResourceRead<Bookmark>;

  /**
   * Creates or updates the bookmark.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Bookmark>;

  /**
   * Delete the bookmark.
   */
  delete is ArmResourceDeleteSync<Bookmark>;

  /**
   * Gets all bookmarks.
   */
  list is ArmResourceListByParent<
    Bookmark,
    Response = ArmResponse<BookmarkList>
  >;
}

@@doc(Bookmark.name, "Bookmark ID");
@@doc(Bookmark.properties, "Bookmark properties");
@@doc(Bookmarks.createOrUpdate::parameters.resource, "The bookmark");
