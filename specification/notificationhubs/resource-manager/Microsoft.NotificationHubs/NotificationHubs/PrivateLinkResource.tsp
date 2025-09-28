import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NotificationHubs;
/**
 * A Private Link Arm Resource.
 */
@parentResource(NamespaceResource)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "subResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^namespace$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Even though this namespace requires subscription id, resource group and namespace name, it returns a constant payload (for a given namespacE) every time it's called.
   * That's why we don't send it to the sibling RP, but process it directly in the scale unit that received the request.
   */
  getGroupId is ArmResourceRead<PrivateLinkResource>;

  /**
   * Even though this namespace requires subscription id, resource group and namespace name, it returns a constant payload (for a given namespacE) every time it's called.
   * That's why we don't send it to the sibling RP, but process it directly in the scale unit that received the request.
   */
  listGroupIds is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name,
  "Name of the Private Link sub-resource. The only supported sub-resource is \"namespace\""
);
@@doc(PrivateLinkResource.properties,
  "Represents properties of Private Link Resource."
);
