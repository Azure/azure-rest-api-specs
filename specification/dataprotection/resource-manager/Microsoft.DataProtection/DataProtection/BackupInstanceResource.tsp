import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Proxy Resource tags.")
  tags?: Record<string>;
}

@armResourceOperations
interface BackupInstanceResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of the backup vault.
         */
        @path
        @segment("backupVaults")
        @pattern("^[A-Za-z][-A-Za-z0-9]*[A-Za-z0-9]$")
        @minLength(2)
        @maxLength(50)
        vaultName: string,
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
  get is BackupInstanceResourceOps.Read<
    Resource = BackupInstanceResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Create or update a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is BackupInstanceResourceOps.CreateOrUpdateAsync<
    BackupInstanceResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<BackupInstanceResource> | ArmResourceCreatedResponse<
      BackupInstanceResource,
      ArmLroLocationHeader<FinalResult = BackupInstanceResource> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    OverrideErrorType = CloudError
  >;

  /**
   * Delete a backup instance in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is BackupInstanceResourceOps.DeleteWithoutOkAsync<
    BackupInstanceResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Trigger adhoc backup
   */
  @action("backup")
  adhocBackup is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    TriggerBackupRequest,
    OperationJobExtendedInfo,
    Response = OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    OverrideErrorType = CloudError
  >;

  /**
   * Validate whether update for backup instance will be successful or not
   */
  validateForModifyBackup is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    ValidateForModifyBackupRequest,
    OperationJobExtendedInfo,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | ErrorResponse
  >;

  /**
   * rehydrate recovery point for restore for a BackupInstance
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("rehydrate")
  triggerRehydrate is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    AzureBackupRehydrationRequest,
    NoContentResponse,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Triggers restore for a BackupInstance
   */
  @action("restore")
  triggerRestore is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    AzureBackupRestoreRequest,
    OperationJobExtendedInfo,
    Response = OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * This operation will resume backups for backup instance
   */
  resumeBackups is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    void,
    OkResponse,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    OverrideErrorType = CloudError
  >;

  /**
   * This operation will resume protection for a stopped backup instance
   */
  resumeProtection is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    void,
    OkResponse,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    OverrideErrorType = CloudError
  >;

  /**
   * This operation will stop protection of a backup instance and data will be held forever
   */
  stopProtection is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    StopProtectionRequest,
    OkResponse,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    OverrideErrorType = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * This operation will stop backup for a backup instance and retains the backup data as per the policy (except latest Recovery point, which will be retained forever)
   */
  suspendBackups is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    SuspendBackupRequest,
    OkResponse,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    OverrideErrorType = CloudError,
    OptionalRequestBody = true
  >;

  /**
   * Sync backup instance again in case of failure
   * This action will retry last failed operation and will bring backup instance to valid state
   */
  @action("sync")
  syncBackupInstance is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    SyncBackupInstanceRequest,
    OkResponse,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders>,
    OverrideErrorType = CloudError
  >;

  /**
   * Validates if Restore can be triggered for a DataSource
   */
  @action("validateRestore")
  validateForRestore is BackupInstanceResourceOps.ActionAsync<
    BackupInstanceResource,
    ValidateRestoreRequestObject,
    OperationJobExtendedInfo,
    Response = OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    OverrideErrorType = CloudError
  >;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("findRestorableTimeRanges")
  find is BackupInstanceResourceOps.ActionSync<
    BackupInstanceResource,
    AzureBackupFindRestorableTimeRangesRequest,
    ArmResponse<AzureBackupFindRestorableTimeRangesResponseResource>,
    OverrideErrorType = CloudError
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getBackupInstanceOperationResult is BackupInstanceOps.Read<
    BackupInstanceResource,
    Response = ArmResponse<BackupInstanceResource> | AcceptedResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets a backup instances belonging to a backup vault
   */
  @list
  list is ArmResourceListByParent<
    BackupInstanceResource,
    Response = ArmResponse<BackupInstanceResourceList>,
    Error = CloudError
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
