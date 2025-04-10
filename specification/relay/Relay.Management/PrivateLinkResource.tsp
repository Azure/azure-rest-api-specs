import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Information of the private link resource.
 */
@parentResource(RelayNamespace)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a description for the specified Private Endpoint Connection name.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets lists of resources that supports Privatelinks.
   */
  list is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The PrivateLinkResource name");
@@doc(PrivateLinkResource.properties,
  "Properties of the private link resource."
);
