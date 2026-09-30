import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./fileshares.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.FileShares;

/**
 * A private link resource.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(FileShare)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@added(Versions.v2025_09_01_preview)
@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the private link resources that need to be created for a file share.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources that need to be created for a file share.
   */
  list is ArmResourceListByParent<
    PrivateLinkResource,
    Response = ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "Resource properties.");
