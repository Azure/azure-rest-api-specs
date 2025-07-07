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
interface ProtectionIntentOperationGroup {
  /**
   * It will validate followings
   * 1. Vault capacity
   * 2. VM is already protected
   * 3. Any VM related configuration passed in properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("""
    It will validate followings
    1. Vault capacity
    2. VM is already protected
    3. Any VM related configuration passed in properties.
    """)
  @operationId("ProtectionIntent_Validate")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupPreValidateProtection")
  @post
  validate(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * Enable backup validation request on Virtual Machine
     */
    @bodyRoot
    parameters: PreValidateEnableBackupRequest,
  ): ArmResponse<PreValidateEnableBackupResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupStatusOperationGroup {
  /**
   * Get the container backup status
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get the container backup status")
  @operationId("BackupStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupStatus")
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
     * Container Backup Status Request
     */
    @bodyRoot
    parameters: BackupStatusRequest,
  ): ArmResponse<BackupStatusResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FeatureSupportOperationGroup {
  /**
   * It will validate if given feature with resource properties is supported in service
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("It will validate if given feature with resource properties is supported in service")
  @operationId("FeatureSupport_Validate")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupValidateFeatures")
  @post
  validate(
    ...ApiVersionParameter,

    /**
     * Azure region to hit Api
     */
    @path
    azureRegion: string,

    ...SubscriptionIdParameter,

    /**
     * Feature support request object
     */
    @bodyRoot
    parameters: FeatureSupportRequest,
  ): ArmResponse<AzureVMResourceFeatureSupportResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupProtectionIntentOperationGroup {
  /**
   * Provides a pageable list of all intents that are present within a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupProtectionIntent_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionIntents")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
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
  ): ArmResponse<ProtectionIntentResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupUsageSummariesOperationGroup {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupUsageSummaries_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
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
  ): ArmResponse<BackupManagementUsageList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface JobsOperationGroup {
  /**
   * Triggers export of jobs specified by filters and returns an OperationID to track.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Jobs_Export")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobsExport")
  @post
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  export(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupProtectedItemsOperationGroup {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupProtectedItems_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
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
  ): ArmResponse<ProtectedItemResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationOperationGroup {
  /**
   * Validate operation for specified backed up item. This is a synchronous operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Operation_Validate")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperation")
  @post
  validate(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * resource validate operation request
     */
    @bodyRoot
    parameters: ValidateOperationRequestResource,
  ): ArmResponse<ValidateOperationsResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ValidateOperationOperationGroup {
  /**
   * Validate operation for specified backed up item in the form of an asynchronous operation. Returns tracking headers which can be tracked using GetValidateOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ValidateOperation_Trigger")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTriggerValidateOperation")
  @post
  trigger(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * resource validate operation request
     */
    @bodyRoot
    parameters: ValidateOperationRequestResource,
  ): ArmAcceptedResponse<
    "Accepted",
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ValidateOperationResultsOperationGroup {
  /**
   * Fetches the result of a triggered validate operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ValidateOperationResults_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationResults/{operationId}")
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OperationID which represents the operation whose result needs to be fetched.
     */
    @path
    operationId: string,
  ): ArmResponse<ValidateOperationsResponse> | ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ValidateOperationStatusesOperationGroup {
  /**
   * Fetches the status of a triggered validate operation. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of the operation.
   * If operation has completed, this method returns the list of errors obtained while validating the operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ValidateOperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationsStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OperationID represents the operation whose status needs to be fetched.
     */
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProtectionContainerRefreshOperationResultsOperationGroup {
  /**
   * Provides the result of the refresh operation triggered by the BeginRefresh operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProtectionContainerRefreshOperationResults_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/operationResults/{operationId}")
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Fabric name associated with the container.
     */
    @path
    fabricName: string,

    /**
     * Operation ID associated with the operation whose result needs to be fetched.
     */
    @path
    operationId: string,
  ): ArmAcceptedResponse | ArmNoContentResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProtectableContainersOperationGroup {
  /**
   * Lists the containers that can be registered to Recovery Services Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProtectableContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectableContainers")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    fabricName: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ProtectableContainerResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ProtectionContainersOperationGroup {
  /**
   * Discovers all the containers in the subscription that can be backed up to Recovery Services Vault. This is an
   * asynchronous operation. To know the status of the operation, call GetRefreshOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProtectionContainers_Refresh")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/refreshContainers")
  @post
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  refresh(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Fabric name associated the container.
     */
    @path
    fabricName: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmAcceptedResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupOperationResultsOperationGroup {
  /**
   * Provides the status of the delete operations such as deleting backed up item. Once the operation has started, the
   * status code in the response would be Accepted. It will continue to be in this state till it reaches completion. On
   * successful completion, the status code will be OK. This method expects OperationID as an argument. OperationID is
   * part of the Location header of the operation response.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupOperationResults_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperationResults/{operationId}")
  @get
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OperationID which represents the operation.
     */
    @path
    operationId: string,
  ): OkResponse | ArmAcceptedResponse | ArmNoContentResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupOperationStatusesOperationGroup {
  /**
   * Fetches the status of an operation such as triggering a backup, restore. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of an operation. Some operations
   * create jobs. This method returns the list of jobs when the operation is complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupOperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperations/{operationId}")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OperationID which represents the operation.
     */
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupProtectableItemsOperationGroup {
  /**
   * Provides a pageable list of protectable objects within your subscription according to the query filter and the
   * pagination parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupProtectableItems_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
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
  ): ArmResponse<WorkloadProtectableItemResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupProtectionContainersOperationGroup {
  /**
   * Lists the containers registered to Recovery Services Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupProtectionContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionContainers")
  @get
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ProtectionContainerResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DeletedProtectionContainersOperationGroup {
  /**
   * Lists the soft deleted containers registered to Recovery Services Vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedProtectionContainers_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupDeletedProtectionContainers")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ProtectionContainerResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SecurityPINsOperationGroup {
  /**
   * Get the security PIN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecurityPINs_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSecurityPIN")
  @post
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @header
    `x-ms-authorization-auxiliary`?: string,

    /**
     * security pin request
     */
    @bodyRoot
    parameters?: SecurityPinBase,
  ): ArmResponse<TokenInformation> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FetchTieringCostOperationGroup {
  /**
   * Provides the details of the tiering related sizes and cost.
   * Status of the operation can be fetched using GetTieringCostOperationStatus API and result using GetTieringCostOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FetchTieringCost_Post")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/fetchTieringCost")
  @post
  post(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @maxLength(50)
    @minLength(2)
    @pattern("^[A-Za-z][-A-Za-z0-9]*[A-Za-z0-9]$")
    @path
    vaultName: string,

    /**
     * Fetch Tiering Cost Request
     */
    @bodyRoot
    parameters: FetchTieringCostInfoRequest,
  ): ArmResponse<TieringCostInfo> | ArmAcceptedResponse<
    "Accepted",
    ArmLroLocationHeader<
      Azure.Core.StatusMonitorPollingOptions<ArmOperationStatus>,
      TieringCostInfo,
      string
    > &
      Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface GetTieringCostOperationResultOperationGroup {
  /**
   * Gets the result of async operation for tiering cost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetTieringCostOperationResult_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @maxLength(50)
    @minLength(2)
    @pattern("^[A-Za-z][-A-Za-z0-9]*[A-Za-z0-9]$")
    @path
    vaultName: string,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): ArmResponse<TieringCostInfo> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TieringCostOperationStatusOperationGroup {
  /**
   * Gets the status of async operations of tiering cost
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TieringCostOperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationsStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @maxLength(50)
    @minLength(2)
    @pattern("^[A-Za-z][-A-Za-z0-9]*[A-Za-z0-9]$")
    @path
    vaultName: string,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
