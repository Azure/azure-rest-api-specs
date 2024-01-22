import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./RelayNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Relay;
/**
 * Information of the private link resource.
 */
@parentResource(RelayNamespace)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  /**
   * The PrivateLinkResource name
   */
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_List")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
