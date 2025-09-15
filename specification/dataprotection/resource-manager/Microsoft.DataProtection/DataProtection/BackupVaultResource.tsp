import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Input Managed Identity Details")
  identity?: DppIdentityDetails;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Optional ETag.")
  eTag?: string;
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
  get is BackupVaultResourceOps.Read<
    Resource = BackupVaultResource,
    OverrideErrorType = CloudError
  >;

  /**
   * Creates or updates a BackupVault resource belonging to a resource group.
   */
  createOrUpdate is BackupVaultResourceOps.CreateOrUpdateAsync<
    BackupVaultResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = BackupVaultResource> &
      Azure.Core.Foundations.RetryAfterHeader,
    OverrideErrorType = CloudError
  >;

  /**
   * Updates a BackupVault resource belonging to a resource group. For example, updating tags for a resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is BackupVaultResourceOps.CustomPatchAsync<
    BackupVaultResource,
    PatchModel = PatchResourceRequestInput,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes a BackupVault resource from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is BackupVaultResourceOps.DeleteWithoutOkAsync<
    BackupVaultResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Returns resource collection belonging to a subscription.
   */
  @list
  getInSubscription is ArmListBySubscription<
    BackupVaultResource,
    Response = ArmResponse<BackupVaultResourceList>,
    Error = CloudError
  >;

  /**
   * Gets the operation status for an operation over a BackupVault's context.
   */
  @get
  operationStatusBackupVaultContextGet is BackupVaultResourceOps.Read<
    BackupVaultResource,
    Response = ArmResponse<OperationResource>,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @segment("operationStatus")
      @path
      operationId: string;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Validate whether adhoc backup will be successful or not
   */
  validateForBackup is BackupVaultResourceOps.ActionAsync<
    BackupVaultResource,
    ValidateForBackupRequest,
    OperationJobExtendedInfo,
    Response = OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    OverrideErrorType = CloudError
  >;

  /**
   * Triggers export of jobs and returns an OperationID to track.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("exportBackupJobs")
  trigger is BackupVaultResourceOps.ActionAsync<
    BackupVaultResource,
    void,
    NoContentResponse,
    Response = ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | NoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets the operation result of operation triggered by Export Jobs API. If the operation is successful, then it also contains URL of a Blob and a SAS key to access the same. The blob contains exported jobs in JSON serialized format.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
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
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is BackupVaultOperationResultOps.Read<
    BackupVaultResource,
    Response = ArmResponse<BackupVaultResource> | {
      @statusCode _: 202;

      @header("Azure-AsyncOperation")
      azureAsyncOperation?: string;

      @header("Location")
      location?: string;

      @header("Retry-After")
      retryAfter?: int32;
    },
    OverrideErrorType = CloudError
  >;

  /**
   * Returns resource collection belonging to a resource group.
   */
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
