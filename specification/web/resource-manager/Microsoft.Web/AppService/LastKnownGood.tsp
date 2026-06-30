import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * Last known good singleton resource.
 */
@added(Versions.v2026_06_01)
@singleton("default")
@parentResource(Site)
model LastKnownGoodResource
  is Azure.ResourceManager.ProxyResource<LastKnownGoodProperties> {
  ...ResourceNameParameter<
    Resource = LastKnownGoodResource,
    KeyName = "lastKnownGoodName",
    SegmentName = "lastKnownGood",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "LastKnownGood does not support delete."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "LastKnownGood is read-only and updated via an explicit action."
@added(Versions.v2026_06_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface LastKnownGoodResources {
  /**
   * Gets the last known good revision state for a Web App.
   */
  getLastKnownGood is ArmResourceRead<
    LastKnownGoodResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Marks the current Web App state as last known good.
   */
  @post
  @action("mark")
  markLastKnownGood is ArmResourceActionSync<
    LastKnownGoodResource,
    void,
    ArmResponse<LastKnownGoodResource>,
    Error = DefaultErrorResponse
  >;
}
