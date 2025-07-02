import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * BackupInstance Resource
 */
@parentResource(BackupVaultResource)
model BackupInstanceResource
  is Azure.ResourceManager.ProxyResource<BackupInstance> {
  ...ResourceNameParameter<
    Resource = BackupInstanceResource,
    KeyName = "backupInstanceName",
    SegmentName = "backupInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BackupInstanceResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupInstanceResource,
        KeyName = "backupInstanceName",
        SegmentName = "backupInstances",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupInstanceResources {
  /**
   * Gets a backup instance with name in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_Get")
  get is BackupInstanceResourceOps.Read<BackupInstanceResource>;

  /**
   * Create or update a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupInstances_CreateOrUpdate")
  createOrUpdate is BackupInstanceResourceOps.CreateOrUpdateAsync<
    BackupInstanceResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<BackupInstanceResource> | ArmResourceCreatedResponse<
      BackupInstanceResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Delete a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("BackupInstances_Delete")
  delete is BackupInstanceResourceOps.DeleteWithoutOkAsync<
    BackupInstanceResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Trigger adhoc backup
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("backup")
  @operationId("BackupInstances_AdhocBackup")
  adhocBackup is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    TriggerBackupRequest,
    ArmResponse<OperationJobExtendedInfo>
  >;

  /**
   * Validate whether update for backup instance will be successful or not
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_ValidateForModifyBackup")
  validateForModifyBackup is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    ValidateForModifyBackupRequest,
    ArmResponse<OperationJobExtendedInfo>
  >;

  /**
   * rehydrate recovery point for restore for a BackupInstance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("rehydrate")
  @operationId("BackupInstances_TriggerRehydrate")
  triggerRehydrate is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    AzureBackupRehydrationRequest,
    NoContentResponse
  >;

  /**
   * Triggers restore for a BackupInstance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("restore")
  @operationId("BackupInstances_TriggerRestore")
  triggerRestore is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    AzureBackupRestoreRequest,
    ArmResponse<OperationJobExtendedInfo>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;

  /**
   * This operation will resume backups for backup instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_ResumeBackups")
  resumeBackups is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    void,
    OkResponse
  >;

  /**
   * This operation will resume protection for a stopped backup instance
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_ResumeProtection")
  resumeProtection is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    void,
    OkResponse
  >;

  /**
   * This operation will stop protection of a backup instance and data will be held forever
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_StopProtection")
  stopProtection is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    {
      /**
       * Request body for operation
       */
      @bodyRoot
      parameters?: StopProtectionRequest;
    },
    OkResponse,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;

  /**
   * This operation will stop backup for a backup instance and retains the backup data as per the policy (except latest Recovery point, which will be retained forever)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_SuspendBackups")
  suspendBackups is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    {
      /**
       * Request body for operation
       */
      @bodyRoot
      parameters?: SuspendBackupRequest;
    },
    OkResponse,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;

  /**
   * Sync backup instance again in case of failure
   * This action will retry last failed operation and will bring backup instance to valid state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("sync")
  @operationId("BackupInstances_SyncBackupInstance")
  syncBackupInstance is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    SyncBackupInstanceRequest,
    OkResponse
  >;

  /**
   * Validates if Restore can be triggered for a DataSource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("validateRestore")
  @operationId("BackupInstances_ValidateForRestore")
  validateForRestore is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    ValidateRestoreRequestObject,
    ArmResponse<OperationJobExtendedInfo>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("findRestorableTimeRanges")
  @operationId("RestorableTimeRanges_Find")
  find is BackupInstanceResourceOps.ActionSync<
    BackupInstanceResource,
    AzureBackupFindRestorableTimeRangesRequest,
    ArmResponse<AzureBackupFindRestorableTimeRangesResponseResource>
  >;
}
@armResourceOperations
interface BackupInstanceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupInstanceResource,
          KeyName = "backupInstanceName",
          SegmentName = "backupInstances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupInstanceResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupInstances {
  /**
   * Get result of backup instance creation operation
   */
  getBackupInstanceOperationResult is BackupInstanceOps.Read<
    BackupInstanceResource,
    Response = ArmResponse<BackupInstanceResource> | AcceptedResponse
  >;

  /**
   * Gets a backup instances belonging to a backup vault
   */
  list is BackupInstanceOps.List<
    BackupInstanceResource,
    Response = ArmResponse<BackupInstanceResourceList>
  >;
}

@@doc(BackupInstanceResource.name, "The name of the backup instance.");
@@doc(BackupInstanceResource.properties, "BackupInstanceResource properties");
@@doc(BackupInstanceResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(BackupInstanceResources.adhocBackup::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.validateForModifyBackup::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.triggerRehydrate::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.triggerRestore::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.syncBackupInstance::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.validateForRestore::parameters.body,
  "Request body for operation"
);
@@doc(BackupInstanceResources.find::parameters.body,
  "Request body for operation"
);
