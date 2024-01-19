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
@doc("BackupInstance Resource")
@parentResource(BackupVaultResource)
model BackupInstanceResource is ProxyResource<BackupInstance> {
  @doc("The name of the backup instance.")
  @path
  @key("backupInstanceName")
  @segment("backupInstances")
  name: string;
}

@armResourceOperations
interface BackupInstanceResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a backup instance with name in a backup vault")
  @operationId("BackupInstances_Get")
  get is ArmResourceRead<BackupInstanceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a backup instance in a backup vault")
  @operationId("BackupInstances_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<BackupInstanceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a backup instance in a backup vault")
  @operationId("BackupInstances_Delete")
  delete is ArmResourceDeleteAsync<BackupInstanceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a backup instances belonging to a backup vault")
  @operationId("BackupInstances_List")
  list is ArmResourceListByParent<BackupInstanceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Trigger adhoc backup ")
  @operationId("BackupInstances_AdhocBackup")
  adhocBackup is ArmResourceActionAsync<
    BackupInstanceResource,
    TriggerBackupRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupInstanceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("rehydrate recovery point for restore for a BackupInstance")
  @operationId("BackupInstances_TriggerRehydrate")
  triggerRehydrate is ArmResourceActionNoResponseContentAsync<
    BackupInstanceResource,
    AzureBackupRehydrationRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Triggers restore for a BackupInstance")
  @operationId("BackupInstances_TriggerRestore")
  triggerRestore is ArmResourceActionAsync<
    BackupInstanceResource,
    AzureBackupRestoreRequest,
    OperationJobExtendedInfo,
    BaseParameters<BackupInstanceResource>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation will resume backups for backup instance")
  @operationId("BackupInstances_ResumeBackups")
  resumeBackups is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation will resume protection for a stopped backup instance")
  @operationId("BackupInstances_ResumeProtection")
  resumeProtection is ArmResourceActionAsync<
    BackupInstanceResource,
    void,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation will stop protection of a backup instance and data will be held forever")
  @operationId("BackupInstances_StopProtection")
  stopProtection is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("This operation will stop backup for a backup instance and retains the backup data as per the policy (except latest Recovery point, which will be retained forever)")
  @operationId("BackupInstances_SuspendBackups")
  suspendBackups is ArmResourceActionAsync<BackupInstanceResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("""
Sync backup instance again in case of failure
This action will retry last failed operation and will bring backup instance to valid state
""")
  @operationId("BackupInstances_SyncBackupInstance")
  syncBackupInstance is ArmResourceActionAsync<
    BackupInstanceResource,
    SyncBackupInstanceRequest,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Validates if Restore can be triggered for a DataSource")
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
