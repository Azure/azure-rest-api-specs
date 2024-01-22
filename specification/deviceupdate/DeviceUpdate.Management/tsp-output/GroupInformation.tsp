import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DeviceUpdate;
/**
 * The group information for creating a private endpoint on an Account
 */
@parentResource(Account)
model GroupInformation is ProxyResource<GroupInformationProperties> {
  /**
   * The group ID of the private link resource.
   */
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface GroupInformations {
  /**
   * Get the specified private link resource associated with the device update account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Get")
  get is ArmResourceRead<GroupInformation>;

  /**
   * List all private link resources in a device update account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByAccount")
  listByAccount is ArmResourceListByParent<GroupInformation>;
}
