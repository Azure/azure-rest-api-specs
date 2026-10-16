// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

/** The Location header contains the URL where the status of the long running operation can be checked. */
alias CrrLroLocationHeader = {
  /** The Location header contains the URL where the status of the long running operation can be checked. */
  @header("Location") location?: string;
};

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupUsageSummaries_CRR")
interface BackupUsageSummariesCrrOperationGroup {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @operationId("BackupUsageSummariesCRR_List")
  @autoRoute
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

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("AadProperties")
interface AadPropertiesOperationGroup {
  /**
   * Fetches the AAD properties from target region BCM stamp.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Fetches the AAD properties from target region BCM stamp.")
  @operationId("AadProperties_Get")
  @autoRoute
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

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = NewErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrossRegionRestore")
interface CrossRegionRestoreOperationGroup {
  /**
   * Restores the specified backed up data in a different region as compared to where the data is backed up.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Restores the specified backed up data in a different region as compared to where the data is backed up.")
  @operationId("CrossRegionRestore_Trigger")
  @autoRoute
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrJobDetails")
interface BackupCrrJobDetailsOperationGroup {
  /**
   * Get CRR job details from target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Get CRR job details from target region.")
  @operationId("BackupCrrJobDetails_Get")
  @autoRoute
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupCrrJobs")
interface BackupCrrJobsOperationGroup {
  /**
   * Gets the list of CRR jobs from the target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @summary("Gets the list of CRR jobs from the target region.")
  @operationId("BackupCrrJobs_List")
  @autoRoute
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

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrOperationResults")
interface CrrOperationResultsOperationGroup {
  /**
   * Gets the operation result of a cross-region-restore operation for the given operation ID and Azure region.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Faithful migration: the original CrrOperationResults_Get success response is body-less, matching the frozen stable/2023-01-15 contract."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @operationId("CrrOperationResults_Get")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("CrrOperationStatus")
interface CrrOperationStatusOperationGroup {
  /**
   * Gets the status of a cross-region-restore operation for the given operation ID and Azure region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @operationId("CrrOperationStatus_Get")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@tag("BackupProtectedItems_Crr")
interface BackupProtectedItemsCrrOperationGroup {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @returnsDoc("OK")
  @errorsDoc("Error response describing why the operation failed.")
  @operationId("BackupProtectedItemsCrr_List")
  @autoRoute
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

      /**
       * OData filter options.
       */
      @query("$filter")
      $filter?: string;

      /**
       * skipToken Filter.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = NewErrorResponse
  >;
}

@@TypeSpec.OpenAPI.extension(
  BackupUsageSummariesCrrOperationGroup.list,
  "x-ms-odata",
  "#/definitions/BMSBackupSummariesQueryObject"
);
@@TypeSpec.OpenAPI.extension(
  AadPropertiesOperationGroup.get,
  "x-ms-odata",
  "#/definitions/BMSAADPropertiesQueryObject"
);
@@doc(
  CrossRegionRestoreOperationGroup.trigger::parameters.body,
  "resource cross region restore request"
);
@@doc(
  BackupCrrJobDetailsOperationGroup.get::parameters.body,
  "CRR Job request"
);
@@doc(
  BackupCrrJobsOperationGroup.list::parameters.body,
  "Backup CRR Job request"
);
@@doc(Azure.ResourceManager.ArmAcceptedLroResponse, "Accepted");
@@doc(TypeSpec.Http.OkResponse, "OK");
@@TypeSpec.list(BackupUsageSummariesCrrOperationGroup.list);

@@TypeSpec.nextLink(ResourceList.nextLink);

@@TypeSpec.list(BackupCrrJobsOperationGroup.list);
@@TypeSpec.OpenAPI.extension(
  BackupCrrJobsOperationGroup.list,
  "x-ms-odata",
  "#/definitions/JobQueryObject"
);

@@TypeSpec.list(BackupProtectedItemsCrrOperationGroup.list);
@@TypeSpec.OpenAPI.extension(
  BackupProtectedItemsCrrOperationGroup.list,
  "x-ms-odata",
  "#/definitions/ProtectedItemQueryObject"
);
