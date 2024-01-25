import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Backup Vault Resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(BackupVault)
model BackupVaultResource extends TrackedResourceBase {
  /**
   * The name of the backup vault.
   */
  @path
  @key("vaultName")
  @segment("backupVaults")
  @visibility("read")
  name: string;

  /**
   * BackupVaultResource properties
   */
  @extension("x-ms-client-flatten", true)
  properties: BackupVault;
}

@armResourceOperations
interface BackupVaultResources {
  /**
   * Returns a resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupVaults_Get")
  get is ArmResourceRead<BackupVaultResource>;

  /**
   * Creates or updates a BackupVault resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupVaults_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BackupVaultResource>;

  /**
   * Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("BackupVaults_Update")
  update is ArmCustomPatchAsync<BackupVaultResource, PatchResourceRequestInput>;

  /**
   * Deletes a BackupVault resource from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupVaults_Delete")
  delete is ArmResourceDeleteAsync<BackupVaultResource>;

  /**
   * Returns resource collection belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupVaults_GetInResourceGroup")
  getInResourceGroup is ArmResourceListByParent<BackupVaultResource>;

  /**
   * Returns resource collection belonging to a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupVaults_GetInSubscription")
  getInSubscription is ArmListBySubscription<BackupVaultResource>;

  /**
   * Validate whether adhoc backup will be successful or not
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_ValidateForBackup")
  validateForBackup is ArmResourceActionAsync<
    BackupVaultResource,
    ValidateForBackupRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupVaultResource>,
    ArmLroLocationHeader
  >;

  /**
   * Triggers export of jobs and returns an OperationID to track.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ExportJobs_Trigger")
  trigger is ArmResourceActionNoResponseContentAsync<
    BackupVaultResource,
    void,
    BaseParameters<BackupVaultResource>,
    ArmLroLocationHeader
  >;
}

@@projectedName(BackupVaultResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@projectedName(BackupVaultResources.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.update::parameters.properties,
  "Request body for operation"
);
@@projectedName(BackupVaultResources.validateForBackup::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupVaultResources.validateForBackup::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupVaultResources.validateForBackup::parameters.body,
  "Request body for operation"
);
