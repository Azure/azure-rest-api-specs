// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

/** The Location header contains the URL where the status of the long running operation can be checked. */
alias CrrLroLocationHeader = {
  /** The Location header contains the URL where the status of the long running operation can be checked. */
  @header("Location") location?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "Faithful migration: the interface name preserves the existing BackupUsageSummariesCRR operation group and operation ID casing."
@tag("BackupUsageSummaries_CRR")
@armResourceOperations(#{ omitTags: true })
interface BackupUsageSummariesCRR {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @get
  @action("backupUsageSummaries")
  list is ArmProviderActionSync<
    Response = BackupManagementUsageList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      vaultName: string;

      ...ArmFilterParameter;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

@tag("AadProperties")
@armResourceOperations(#{ omitTags: true })
interface AadProperties {
  /**
   * Fetches the AAD properties from target region BCM stamp.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Fetches the AAD properties from target region BCM stamp.")
  @get
  @action("backupAadProperties")
  get is ArmProviderActionSync<
    Response = AadPropertiesResource,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Azure region to hit Api
       */
      @path
      @segment("locations")
      azureRegion: string;

      ...ArmFilterParameter;
    },
    Error = NewErrorResponse
  >;
}

@tag("CrossRegionRestore")
@armResourceOperations(#{ omitTags: true })
interface CrossRegionRestore {
  /**
   * Restores the specified backed up data in a different region as compared to where the data is backed up.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Restores the specified backed up data in a different region as compared to where the data is backed up.")
  @action("backupCrossRegionRestore")
  trigger is ArmProviderActionAsync<
    Request = CrossRegionRestoreRequest,
    Response = OkResponse,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Azure region to hit Api
       */
      @path
      @segment("locations")
      azureRegion: string;
    },
    LroHeaders = CrrLroLocationHeader &
      ArmAsyncOperationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = NewErrorResponse
  >;
}

@tag("CrrJobDetails")
@armResourceOperations(#{ omitTags: true })
interface BackupCrrJobDetails {
  /**
   * Get CRR job details from target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Get CRR job details from target region.")
  @action("backupCrrJob")
  get is ArmProviderActionSync<
    Request = CrrJobRequest,
    Response = JobResource,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Azure region to hit Api
       */
      @path
      @segment("locations")
      azureRegion: string;
    },
    Error = NewErrorResponse
  >;
}

@tag("BackupCrrJobs")
@armResourceOperations(#{ omitTags: true })
interface BackupCrrJobs {
  /**
   * Gets the list of CRR jobs from the target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Gets the list of CRR jobs from the target region.")
  @action("backupCrrJobs")
  list is ArmProviderActionSync<
    Request = CrrJobRequest,
    Response = JobResourceList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Azure region to hit Api
       */
      @path
      @segment("locations")
      azureRegion: string;

      ...ArmFilterParameter;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

@tag("CrrOperationResults")
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface CrrOperationResults {
  /**
   * Gets the operation result of a cross-region-restore operation for the given operation ID and Azure region.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Faithful migration: the original CrrOperationResults_Get success response is body-less, matching the frozen stable/2023-01-15 contract."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * The operation ID.
     */
    @path
    operationId: string,
  ):
    | OkResponse
    | ArmAcceptedLroResponse<
        "Accepted",
        LroHeaders = CrrLroLocationHeader &
          ArmAsyncOperationHeader<FinalResult = void> &
          Azure.Core.Foundations.RetryAfterHeader
      >
    | NewErrorResponse;
}

@tag("CrrOperationStatus")
@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface CrrOperationStatus {
  /**
   * Gets the status of a cross-region-restore operation for the given operation ID and Azure region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrOperationsStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * The operation ID.
     */
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | NewErrorResponse;
}

@tag("BackupProtectedItems_Crr")
@armResourceOperations(#{ omitTags: true })
interface BackupProtectedItemsCrr {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @get
  @action("backupProtectedItems/")
  list is ArmProviderActionSync<
    Response = ProtectedItemResourceList,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the recovery services vault.
       */
      @path
      @segment("vaults")
      vaultName: string;

      ...ArmFilterParameter;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

@@doc(
  CrossRegionRestore.trigger::parameters.body,
  "resource cross region restore request"
);
@@doc(BackupCrrJobDetails.get::parameters.body, "CRR Job request");
@@doc(BackupCrrJobs.list::parameters.body, "Backup CRR Job request");
@@doc(Azure.ResourceManager.ArmAcceptedLroResponse, "Accepted");
@@doc(TypeSpec.Http.OkResponse, "OK");
@@TypeSpec.list(BackupUsageSummariesCRR.list);

@@TypeSpec.nextLink(ResourceList.nextLink);

@@TypeSpec.list(BackupCrrJobs.list);

@@TypeSpec.list(BackupProtectedItemsCrr.list);
