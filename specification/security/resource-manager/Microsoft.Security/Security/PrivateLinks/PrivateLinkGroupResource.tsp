import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateLinkResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PrivateLinksAPI;
/**
 * A private link group resource that describes a grouping for the private link.
 */
@parentResource(PrivateLinkResource)
model PrivateLinkGroupResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkGroupResource,
    KeyName = "groupId",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PrivateLinkGroupResources {
  /**
   * Get the specified private link resource associated with the private link.
   */
  @tag("PrivateLinkResources")
  get is ArmResourceRead<PrivateLinkGroupResource>;

  /**
   * List all private link resources in a private link.
   */
  @tag("PrivateLinkResources")
  list is ArmResourceListByParent<PrivateLinkGroupResource>;
}

@@doc(PrivateLinkGroupResource.name,
  "The group ID of the private link resource."
);
@@doc(PrivateLinkGroupResource.properties, "Resource properties.");
