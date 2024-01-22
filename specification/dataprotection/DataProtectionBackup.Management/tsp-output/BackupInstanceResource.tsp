import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * BackupInstance Resource
 */
@parentResource(BackupVaultResource)
model BackupInstanceResource is ProxyResource<BackupInstance> {
  /**
   * The name of the backup instance.
   */
  @path
  @key("backupInstanceName")
  @segment("backupInstances")
  name: string;
}

@armResourceOperations
interface BackupInstanceResources {
  /**
   * Gets a backup instance with name in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_Get")
  get is ArmResourceRead<BackupInstanceResource>;

  /**
   * Create or update a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BackupInstanceResource>;

  /**
   * Delete a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_Delete")
  delete is ArmResourceDeleteAsync<BackupInstanceResource>;

  /**
   * Gets a backup instances belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_List")
  list is ArmResourceListByParent<BackupInstanceResource>;

  /**
   * Trigger adhoc backup
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_AdhocBackup")
  adhocBackup is ArmResourceActionAsync<
    BackupInstanceResource,
    TriggerBackupRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupInstanceResource>,
    ArmLroLocationHeader
  >;

  /**
   * rehydrate recovery point for restore for a BackupInstance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_TriggerRehydrate")
  triggerRehydrate is ArmResourceActionNoResponseContentAsync<
    BackupInstanceResource,
    AzureBackupRehydrationRequest
  >;

  /**
   * Triggers restore for a BackupInstance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_TriggerRestore")
  triggerRestore is ArmResourceActionAsync<
    BackupInstanceResource,
    AzureBackupRestoreRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupInstanceResource>,
    ArmLroLocationHeader
  >;

  /**
   * This operation will resume backups for backup instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_ResumeBackups")
  resumeBackups is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  /**
   * This operation will resume protection for a stopped backup instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_ResumeProtection")
  resumeProtection is ArmResourceActionAsync<
    BackupInstanceResource,
    void,
    void
  >;

  /**
   * This operation will stop protection of a backup instance and data will be held forever
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_StopProtection")
  stopProtection is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  /**
   * This operation will stop backup for a backup instance and retains the backup data as per the policy (except latest Recovery point, which will be retained forever)
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_SuspendBackups")
  suspendBackups is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  /**
* Sync backup instance again in case of failure
This action will retry last failed operation and will bring backup instance to valid state
*/
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_SyncBackupInstance")
  syncBackupInstance is ArmResourceActionAsync<
    BackupInstanceResource,
    SyncBackupInstanceRequest,
    void
  >;

  /**
   * Validates if Restore can be triggered for a DataSource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupInstances_ValidateForRestore")
  validateForRestore is ArmResourceActionAsync<
    BackupInstanceResource,
    ValidateRestoreRequestObject,
    OperationJobExtendedInfo,
    BaseParameters<BackupInstanceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RestorableTimeRanges_Find")
  find is ArmResourceActionSync<
    BackupInstanceResource,
    AzureBackupFindRestorableTimeRangesRequest,
    AzureBackupFindRestorableTimeRangesResponseResource
  >;
}

@@projectedName(BackupInstanceResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.adhocBackup::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.adhocBackup::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.adhocBackup::parameters.body,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.triggerRehydrate::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.triggerRehydrate::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.triggerRehydrate::parameters.body,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.triggerRestore::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.triggerRestore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.triggerRestore::parameters.body,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.syncBackupInstance::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.syncBackupInstance::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.syncBackupInstance::parameters.body,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.validateForRestore::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.validateForRestore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.validateForRestore::parameters.body,
  "Request body for operation"
);
@@projectedName(BackupInstanceResources.find::parameters.body,
  "json",
  "parameters"
);
@@extension(BackupInstanceResources.find::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BackupInstanceResources.find::parameters.body,
  "Request body for operation"
);
