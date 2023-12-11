import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./RecoveryServicesVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServices;
@doc("Information of the private link resource.")
@parentResource(RecoveryServicesVault)
model RecoveryServicesPrivateLinkResource
  is ProxyResource<PrivateLinkResourceProperties> {
  @path
  @key("privateLinkResourceName")
  @segment("privateLinkResources")
  name: string;
}

@armResourceOperations
interface RecoveryServicesPrivateLinkResources {
  @doc("Returns a specified private link resource that need to be created for Backup and SiteRecovery")
  get is ArmResourceRead<RecoveryServicesPrivateLinkResource>;
  @doc("Returns the list of private link resources that need to be created for Backup and SiteRecovery")
  list is ArmResourceListByParent<RecoveryServicesPrivateLinkResource>;
}
