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
@doc("Vault extended information.")
@parentResource(RecoveryServicesVault)
@singleton("vaultExtendedInfo")
model RecoveryServicesVaultExtendedInfo
  is ProxyResource<VaultExtendedInfoProperties> {
  @key("vaultExtendedInfo")
  @segment("extendedInformation")
  name: string;
}

@armResourceOperations
interface RecoveryServicesVaultExtendedInfos {
  @doc("Get the vault extended info.")
  get is ArmResourceRead<RecoveryServicesVaultExtendedInfo>;
  @doc("Create vault extended info.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<RecoveryServicesVaultExtendedInfo>;
  @doc("Update vault extended info.")
  update is ArmResourcePatchSync<
    RecoveryServicesVaultExtendedInfo,
    VaultExtendedInfoProperties
  >;
}
