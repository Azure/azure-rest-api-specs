import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Represents private link resource.
 */
@parentResource(VaultModel)
model PrivateLinkResource
  is Azure.ResourceManager.ProxyResource<PrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkResourceName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[a-zA-Z0-9-.]*$"
  >;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets the details of site recovery private link resource.
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets the list of private link resources.
   */
  list is ArmResourceListByParent<PrivateLinkResource>;
}

@@doc(PrivateLinkResource.name, "The private link name.");
