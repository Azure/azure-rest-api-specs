import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

interface AadPropertiesOperationGroup {
  /**
   * Fetches the AAD properties from target region BCM stamp.
   */
  @tag("AadProperties")
  @summary("Fetches the AAD properties from target region BCM stamp.")
  @operationId("AadProperties_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupAadProperties")
  @get
  @extension("x-ms-odata", "#/definitions/BMSAADPropertiesQueryObject")
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter") $filter?: string,
  ): LegacyOkResponseBody<AADPropertiesResource> | NewErrorResponse;
}

interface CrossRegionRestoreOperationGroup {
  /**
   * Restores the specified backed up data in a different region as compared to where the data is backed up.
   */
  @tag("CrossRegionRestore")
  @summary("Restores the specified backed up data in a different region as compared to where the data is backed up.")
  @operationId("CrossRegionRestore_Trigger")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrossRegionRestore")
  @post
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  trigger(
    ...ApiVersionParameter,

    /**
     * Azure region to target.
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * resource cross region restore request
     */
    @body parameters: CrossRegionRestoreRequest,
  ):
    | TypeSpec.Http.OkResponse
    | TypeSpec.Http.AcceptedResponse
    | NewErrorResponse;
}

interface BackupCrrJobDetailsOperationGroup {
  /**
   * Get CRR job details from target region.
   */
  @tag("CrrJobDetails")
  @summary("Get CRR job details from target region.")
  @operationId("BackupCrrJobDetails_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrJob")
  @post
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * CRR Job request
     */
    @body parameters: CrrJobRequest,
  ): LegacyOkResponseBody<JobResource> | NewErrorResponse;
}

interface BackupCrrJobsOperationGroup {
  /**
   * Gets the list of CRR jobs from the target region.
   */
  @tag("BackupCrrJobs")
  @summary("Gets the list of CRR jobs from the target region.")
  @operationId("BackupCrrJobs_List")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrJobs")
  @post
  @extension("x-ms-odata", "#/definitions/JobQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  list(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * Backup CRR Job request
     */
    @body parameters: CrrJobRequest,

    /**
     * OData filter options.
     */
    @query("$filter") $filter?: string,

    /**
     * skipToken Filter.
     */
    @query("$skipToken") $skipToken?: string,
  ): LegacyOkResponseBody<JobResourceList> | NewErrorResponse;
}

interface CrrOperationResultsOperationGroup {
  @tag("CrrOperationResults")
  @operationId("CrrOperationResults_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to query.
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    @path operationId: string,
  ):
    | TypeSpec.Http.OkResponse
    | TypeSpec.Http.AcceptedResponse
    | NewErrorResponse;
}

interface CrrOperationStatusOperationGroup {
  @tag("CrrOperationStatus")
  @operationId("CrrOperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationsStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to query.
     */
    @path azureRegion: string,

    ...SubscriptionIdParameter,

    @path operationId: string,
  ): LegacyOkResponseBody<OperationStatus> | NewErrorResponse;
}

interface BackupProtectedItemsCrrOperationGroup {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  @tag("BackupProtectedItems_Crr")
  @operationId("BackupProtectedItemsCrr_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems/")
  @get
  @extension("x-ms-odata", "#/definitions/ProtectedItemQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter") $filter?: string,

    /**
     * skipToken Filter.
     */
    @query("$skipToken") $skipToken?: string,
  ): LegacyOkResponseBody<ProtectedItemResourceList> | NewErrorResponse;
}

interface BackupUsageSummariesCRROperationGroup {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  @tag("BackupUsageSummaries_CRR")
  @operationId("BackupUsageSummariesCRR_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries")
  @get
  @extension("x-ms-odata", "#/definitions/BMSBackupSummariesQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: null })
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter") $filter?: string,

    /**
     * skipToken Filter.
     */
    @query("$skipToken") $skipToken?: string,
  ): LegacyOkResponseBody<BackupManagementUsageList> | NewErrorResponse;
}
