import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

/**
 * Vault resource in Recovery Service.
 */
alias VaultResource = Extension.ExternalResource<
  "Microsoft.RecoveryServices",
  "vaults",
  "vaultName",
  NamePattern = "",
  Description = "The name of the recovery services vault."
>;

/**
 * Backup Fabric virtual resource.
 */
alias BackupFabricResource = Extension.ExternalChildResource<
  VaultResource,
  "backupFabrics",
  "fabricName",
  NamePattern = "",
  Description = "Fabric name associated with the container."
>;

/**
 * Protection Container virtual resource.
 */
alias ProtectionContainerResource = Extension.ExternalChildResource<
  BackupFabricResource,
  "protectionContainers",
  "containerName",
  NamePattern = "",
  Description = "Name of the container."
>;

/**
 * Protected Item virtual resource. Routing parent for recovery points.
 */
alias ProtectedItemVirtualResource = Extension.ExternalChildResource<
  ProtectionContainerResource,
  "protectedItems",
  "protectedItemName",
  NamePattern = "",
  Description = "Name of the Protected Item."
>;
