import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./App.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTCentral;
/**
 * A private link resource.
 */
@parentResource(App)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  /**
   * The private link resource name.
   */
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Get a private link resource of a IoT Central Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinks_Get")
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Get all private link resources of a IoT Central Application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinks_List")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
