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

namespace Microsoft.Purview;
/**
 * A privately linkable resource.
 */
@parentResource(Account)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  /**
   * The group identifier.
   */
  @path
  @key("groupId")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Gets a privately linkable resources for an account with given group identifier
   */
  getByGroupId is ArmResourceRead<PrivateLinkResource>;

  /**
   * Gets a list of privately linkable resources for an account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByAccount")
  listByAccount is ArmResourceListByParent<PrivateLinkResource>;
}
