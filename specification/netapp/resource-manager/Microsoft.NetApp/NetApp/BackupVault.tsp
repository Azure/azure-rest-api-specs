import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetAppAccount.tsp";

using Rest;
using Azure.ResourceManager;
using Http;

namespace Microsoft.NetApp;
/**
 * Backup Vault information
 */
@parentResource(NetAppAccount)
model BackupVault
  is Azure.ResourceManager.TrackedResource<BackupVaultProperties> {
  ...ResourceNameParameter<
    Resource = BackupVault,
    KeyName = "backupVaultName",
    SegmentName = "backupVaults",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,63}$"
  >;
}

/**
 * List of Backup Vaults
 */
model BackupVaultsList is Azure.Core.Page<BackupVault>;

/**
 * Backup Vault properties
 */
model BackupVaultProperties {
  /**
   * Azure lifecycle management
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Backup Vault information
 */
model BackupVaultPatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface BackupVaults {
  /**
   * Get the Backup Vault
   */
  get is ArmResourceRead<BackupVault>;

  /**
   * Create or update the specified Backup Vault in the NetApp account
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BackupVault>;

  /**
   * Patch the specified NetApp Backup Vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BackupVault,
    PatchModel = BackupVaultPatch,
    Response = ArmResponse<BackupVault> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BackupVault> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BackupVault;
    })
  >;

  /**
   * Delete the specified Backup Vault
   */
  delete is ArmResourceDeleteWithoutOkAsync<BackupVault>;

  /**
   * List and describe all Backup Vaults in the NetApp account.
   */
  listByNetAppAccount is ArmResourceListByParent<
    BackupVault,
    Response = ArmResponse<BackupVaultsList>
  >;
}

@@doc(BackupVault.name, "The name of the Backup Vault");
@@doc(BackupVault.properties, "Backup Vault Properties");
@@doc(BackupVaults.createOrUpdate::parameters.resource,
  "BackupVault object supplied in the body of the operation."
);
@@doc(BackupVaults.update::parameters.properties,
  "Backup Vault object supplied in the body of the operation."
);
