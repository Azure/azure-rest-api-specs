import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./OnlineExperimentationWorkspace.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.OnlineExperimentation;

/**
 * A private link resource.
 */
@parentResource(OnlineExperimentationWorkspace)
@added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[a-zA-Z0-9-.]*$"
  >;
}

@armResourceOperations
@added(Microsoft.OnlineExperimentation.Versions.v2025_08_01_preview)
interface PrivateLinkResources {
  /**
   * Gets a private link resource for an online experimentation workspace resource.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the list of private link resources for an online experimentation workspace resource.
   */
  list is ArmResourceListByParent<PrivateLinkResource>;
}
