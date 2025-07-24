import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Backup Vault Resource
 */
model BackupVaultResource
  is Azure.ResourceManager.TrackedResource<BackupVault, false> {
  ...ResourceNameParameter<
    Resource = BackupVaultResource,
    KeyName = "vaultName",
    SegmentName = "backupVaults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BackupVaultResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupVaultResource,
        KeyName = "vaultName",
        SegmentName = "backupVaults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupVaultResources {
  /**
   * Returns a resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupVaults_Get")
  get is BackupVaultResourceOps.Read<
    Resource = BackupVaultResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a BackupVault resource belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupVaults_CreateOrUpdate")
  createOrUpdate is BackupVaultResourceOps.CreateOrUpdateAsync<
    BackupVaultResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrortype = CloudError
  >;

  /**
   * Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("BackupVaults_Update")
  update is BackupVaultResourceOps.CustomPatchAsync<
    BackupVaultResource,
    PatchModel = PatchResourceRequestInput,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    OverrideErrortype = CloudError
  >;

  /**
   * Deletes a BackupVault resource from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("BackupVaults_Delete")
  delete is BackupVaultResourceOps.DeleteWithoutOkAsync<
    BackupVaultResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns resource collection belonging to a subscription.
   */
  // /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults
  // /subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/backupVaults
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupVaults_GetInSubscription")
  @list
  getInSubscription is ArmListBySubscription<
    BackupVaultResource,
    Response = ArmResponse<BackupVaultResourceList>,
    Error = CloudError
  >;

  /**
   * Gets the operation status for an operation over a BackupVault's context.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("OperationStatusBackupVaultContext_Get")
  operationStatusBackupVaultContextGet is BackupVaultResourceOps.Read<
    BackupVaultResource,
    Response = ArmResponse<OperationResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @segment("operationStatus")
      @path
      operationId: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Validate whether adhoc backup will be successful or not
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_ValidateForBackup")
  validateForBackup is BackupVaultResourceOps.ActionAsync<
    BackupVaultResource,
    ValidateForBackupRequest,
    ArmResponse<OperationJobExtendedInfo>,
    OverrideErrortype = CloudError
  >;

  /**
   * Triggers export of jobs and returns an OperationID to track.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("exportBackupJobs")
  @operationId("ExportJobs_Trigger")
  trigger is BackupVaultResourceOps.ActionAsync<
    BackupVaultResource,
    void,
    NoContentResponse,
    OverrideErrortype = CloudError
  >;

  /**
   * Gets the operation result of operation triggered by Export Jobs API. If the operation is successful, then it also contains URL of a Blob and a SAS key to access the same. The blob contains exported jobs in JSON serialized format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @operationId("ExportJobsOperationResult_Get")
  exportJobsOperationResultGet is BackupVaultResourceOps.Read<
    BackupVaultResource,
    Response = ArmResponse<ExportJobsResult> | AcceptedResponse,
    Parameters = {
      /**
       * OperationID which represents the export job.
       */
      @path
      @segment("backupJobs/operations")
      operationId: string;
    },
    OverrideErrorType = CloudError
  >;
}
@armResourceOperations
interface BackupVaultOperationResultOps
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
        Resource = BackupVaultResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BackupVaultOperationResults {
  get is BackupVaultOperationResultOps.Read<
    BackupVaultResource,
    Response = ArmResponse<BackupVaultResource> | AcceptedResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns resource collection belonging to a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupVaults_GetInResourceGroup")
  @list
  getInResourceGroup is ArmResourceListByParent<
    BackupVaultResource,
    Response = ArmResponse<BackupVaultResourceList>,
    Error = CloudError
  >;
}

@@doc(BackupVaultResource.name, "The name of the backup vault.");
@@doc(BackupVaultResource.properties, "BackupVaultResource properties");
@@doc(BackupVaultResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(BackupVaultResources.update::parameters.properties,
  "Request body for operation"
);
@@doc(BackupVaultResources.validateForBackup::parameters.body,
  "Request body for operation"
);
