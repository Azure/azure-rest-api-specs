import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Information of the private link resource.
 */
@parentResource(Vault)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  /**
   * Returns a specified private link resource that need to be created for Backup and SiteRecovery
   */
  get is ArmResourceRead<PrivateLinkResource>;

  /**
   * Returns the list of private link resources that need to be created for Backup and SiteRecovery
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_List")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
