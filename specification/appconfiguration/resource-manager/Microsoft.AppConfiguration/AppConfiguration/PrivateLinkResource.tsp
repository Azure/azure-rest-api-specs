import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
/**
 * A resource that supports private link capabilities.
 */
@parentResource(ConfigurationStore)
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
   * Gets a private link resource that need to be created for a configuration store.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the private link resources that need to be created for a configuration store.
   */
  listByConfigurationStore is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The name of the private link resource group.");
@@doc(PrivateLinkResource.properties, "Private link resource properties.");
