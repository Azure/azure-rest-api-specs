import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./KubernetesConfigurationPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KubernetesConfiguration;
/**
 * A private link resource
 */
@parentResource(KubernetesConfigurationPrivateLinkScope)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "groupName",
    SegmentName = "privateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources that need to be created for a Azure Monitor PrivateLinkScope.
   */
  listByPrivateLinkScope is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource.");
@@doc(PrivateLinkResource.properties, "Resource properties.");
