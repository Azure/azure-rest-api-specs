import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DigitalTwinsDescription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * The group information for creating a private endpoint on Digital Twin.
 */
@parentResource(DigitalTwinsDescription)
model GroupIdInformation is ProxyResource<GroupIdInformationProperties> {
  /**
   * The name of the private link resource.
   */
  @path
  @key("resourceId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface GroupIdInformations {
  /**
   * Get the specified private link resource for the given Digital Twin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  get is ArmResourceRead<GroupIdInformation>;

  /**
   * List private link resources for given Digital Twin.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_List")
  list is ArmResourceListByParent<GroupIdInformation>;
}
