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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupUsageSummariesCRROperationGroup {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupUsageSummariesCRR_List")
  @extension("x-ms-odata", "#/definitions/BMSBackupSummariesQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
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
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AadPropertiesOperationGroup {
  /**
   * Fetches the AAD properties from target region BCM stamp.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Fetches the AAD properties from target region BCM stamp.")
  @operationId("AadProperties_Get")
  @extension("x-ms-odata", "#/definitions/BMSAADPropertiesQueryObject")
  @autoRoute
  @get
  @action("backupAadProperties")
  get is ArmProviderActionSync<
    Response = AADPropertiesResource,
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
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CrossRegionRestoreOperationGroup {
  /**
   * Restores the specified backed up data in a different region as compared to where the data is backed up.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Restores the specified backed up data in a different region as compared to where the data is backed up.")
  @operationId("CrossRegionRestore_Trigger")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrossRegionRestore")
  @post
  trigger(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * resource cross region restore request
     */
    @body
    parameters: CrossRegionRestoreRequest,
  ): OkResponse | CrossRegionRestoreAcceptedResponse | ErrorResponse;
}

/**
 * Accepted (202) response for the cross region restore trigger operation.
 */
model CrossRegionRestoreAcceptedResponse {
  @statusCode
  statusCode: 202;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupCrrJobDetailsOperationGroup {
  /**
   * Get CRR job details from target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get CRR job details from target region.")
  @operationId("BackupCrrJobDetails_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrJob")
  @post
  get(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * CRR job request
     */
    @body
    parameters: CrrJobRequest,
  ): ArmResponse<JobResource> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupCrrJobsOperationGroup {
  /**
   * Gets the list of CRR jobs from the target region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the list of CRR jobs from the target region.")
  @operationId("BackupCrrJobs_List")
  @extension("x-ms-odata", "#/definitions/JobQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupCrrJobs")
  @post
  list(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,

    /**
     * skipToken Filter.
     */
    @query("$skipToken")
    $skipToken?: string,

    /**
     * CRR job request
     */
    @body
    parameters: CrrJobRequest,
  ): ArmResponse<JobResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CrrOperationResultsOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): OkResponse | ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CrrOperationStatusOperationGroup {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupProtectedItemsCrrOperationGroup {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupProtectedItemsCrr_List")
  @extension("x-ms-odata", "#/definitions/ProtectedItemQueryObject")
  @extension("x-ms-pageable", #{ nextLinkName: "nextLink" })
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
    }
  >;
}
