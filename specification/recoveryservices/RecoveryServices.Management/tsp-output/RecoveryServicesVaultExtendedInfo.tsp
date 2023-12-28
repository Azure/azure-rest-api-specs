import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServices;
@doc("Vault extended information.")
@singleton("vaultExtendedInfo")
@parentResource(Vault)
model RecoveryServicesVaultExtendedInfo
  is ProxyResource<VaultExtendedInfoProperties> {
  @key("vaultExtendedInfo")
  @segment("extendedInformation")
  name: string;
}

@armResourceOperations
interface VaultExtendedInfo {
  @doc("Get the vault extended info.")
  get is ArmResourceRead<RecoveryServicesVaultExtendedInfo>;
  @doc("Create vault extended info.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<RecoveryServicesVaultExtendedInfo>;
  @doc("Update vault extended info.")
  update is ArmCustomPatchSync<
    RecoveryServicesVaultExtendedInfo,
    RecoveryServicesVaultExtendedInfo
  >;
}
