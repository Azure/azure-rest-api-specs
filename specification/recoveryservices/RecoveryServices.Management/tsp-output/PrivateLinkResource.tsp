import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
@doc("Information of the private link resource.")
@parentResource(Vault)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Returns a specified private link resource that need to be created for Backup and SiteRecovery")
  get is ArmResourceRead<PrivateLinkResource>;

  @doc("Returns the list of private link resources that need to be created for Backup and SiteRecovery")
  list is ArmResourceListByParent<PrivateLinkResource>;
}
