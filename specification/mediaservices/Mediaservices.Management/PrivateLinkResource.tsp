import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A private link resource
 */
@parentResource(MediaService)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "name",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Get details of a group ID.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * List supported group IDs.
   */
  list is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@doc(PrivateLinkResource.name, "");
@@doc(PrivateLinkResource.properties, "Resource properties.");
