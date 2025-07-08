import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

/**
 * Vault virtual resource.
 */
@armVirtualResource
model VaultResource {
  ...ResourceNameParameter<VaultResource, "vaultName", "vaults", "">;
}

/**
 * Backup Fabric virtual resource.
 */
@parentResource(VaultResource)
@armVirtualResource
model BackupFabricResource {
  ...ResourceNameParameter<
    BackupFabricResource,
    "fabricName",
    "backupFabrics",
    ""
  >;
}
