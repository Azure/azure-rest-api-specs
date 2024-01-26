import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServicesDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HealthcareApis;
// FIXME: PrivateLinkResourceDescription has no properties property
/**
 * The Private Endpoint Connection resource.
 */
@parentResource(ServicesDescription)
model PrivateLinkResourceDescription is ProxyResource<{}> {
  /**
   * The name of the private link resource group.
   */
  @path
  @key("groupName")
  @segment("privateLinkResources")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PrivateLinkResourceDescriptions {
  /**
   * Gets a private link resource that need to be created for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  get is ArmResourceRead<PrivateLinkResourceDescription>;

  /**
   * Gets the private link resources that need to be created for a service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByService")
  listByService is ArmResourceListByParent<PrivateLinkResourceDescription>;
}
