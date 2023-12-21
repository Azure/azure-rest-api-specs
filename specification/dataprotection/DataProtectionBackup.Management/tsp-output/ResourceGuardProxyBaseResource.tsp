import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataProtectionBackup;
@doc("ResourceGuardProxyBaseResource object, used for response and request bodies for ResourceGuardProxy APIs")
@parentResource(BackupVaultResource)
model ResourceGuardProxyBaseResource is ProxyResource<ResourceGuardProxyBase> {
  @doc("name of the resource guard proxy")
  @pattern("^[A-Za-z0-9]*$")
  @path
  @key("resourceGuardProxyName")
  @segment("backupResourceGuardProxies")
  name: string;
}

@armResourceOperations
interface DppResourceGuardProxy {
  @doc("Returns the ResourceGuardProxy object associated with the vault, and that matches the name in the request")
  get is ArmResourceRead<ResourceGuardProxyBaseResource>;
  @doc("Creates or Updates a ResourceGuardProxy")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ResourceGuardProxyBaseResource>;
  @doc("Deletes the ResourceGuardProxy")
  delete is ArmResourceDeleteSync<ResourceGuardProxyBaseResource>;
  @doc("Returns the list of ResourceGuardProxies associated with the vault")
  list is ArmResourceListByParent<ResourceGuardProxyBaseResource>;
  @doc("UnlockDelete call for ResourceGuardProxy, executed before one can delete it")
  unlockDelete is ArmResourceActionSync<
    ResourceGuardProxyBaseResource,
    UnlockDeleteRequest,
    UnlockDeleteResponse
  >;
}
