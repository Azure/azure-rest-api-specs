// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProtectionIntentOperationGroup {
  /**
   * It will validate followings
   * 1. Vault capacity
   * 2. VM is already protected
   * 3. Any VM related configuration passed in properties.
   */
  @summary("""
    It will validate followings
    1. Vault capacity
    2. VM is already protected
    3. Any VM related configuration passed in properties.
    """)
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupPreValidateProtection")
  @post
  @tag("ProtectionIntent")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupStatus {
  /**
   * Get the container backup status
   */
  @summary("Get the container backup status")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupStatus")
  @post
  @tag("BackupStatus")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FeatureSupport {
  /**
   * It will validate if given feature with resource properties is supported in service
   */
  @summary("It will validate if given feature with resource properties is supported in service")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupValidateFeatures")
  @post
  @tag("FeatureSupport")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupProtectionIntent {
  /**
   * Provides a pageable list of all intents that are present within a vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionIntents")
  @get
  @list
  @tag("BackupProtectionIntent")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupUsageSummaries {
  /**
   * Fetches the backup management usage summaries of the vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupUsageSummaries")
  @get
  @list
  @tag("BackupUsageSummaries")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface Jobs {
  /**
   * Triggers export of jobs specified by filters and returns an OperationID to track.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupJobsExport")
  @post
  @tag("Jobs")
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
  ): ArmAcceptedResponse<ExtraHeaders = {}> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupProtectedItems {
  /**
   * Provides a pageable list of all items that are backed up within a vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectedItems")
  @get
  @list
  @tag("BackupProtectedItems")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationOperationGroup {
  /**
   * Validate operation for specified backed up item. This is a synchronous operation.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperation")
  @post
  @tag("Operation")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ValidateOperation {
  /**
   * Validate operation for specified backed up item in the form of an asynchronous operation. Returns tracking headers which can be tracked using GetValidateOperationResult API.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTriggerValidateOperation")
  @post
  @tag("ValidateOperation")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ValidateOperationResults {
  /**
   * Fetches the result of a triggered validate operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationResults/{operationId}")
  @get
  @tag("ValidateOperationResults")
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
  ): ArmResponse<ValidateOperationsResponse> | ArmAcceptedResponse<ExtraHeaders = {}> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ValidateOperationStatuses {
  /**
   * Fetches the status of a triggered validate operation. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of the operation.
   * If operation has completed, this method returns the list of errors obtained while validating the operation.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupValidateOperationsStatuses/{operationId}")
  @get
  @tag("ValidateOperationStatuses")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProtectionContainerRefreshOperationResults {
  /**
   * Provides the result of the refresh operation triggered by the BeginRefresh operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/operationResults/{operationId}")
  @get
  @tag("ProtectionContainerRefreshOperationResults")
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
  ): ArmAcceptedResponse<ExtraHeaders = {}> | ArmNoContentResponse | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProtectableContainers {
  /**
   * Lists the containers that can be registered to Recovery Services Vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectableContainers")
  @get
  @list
  @tag("ProtectableContainers")
  list(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    fabricName: string,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<ProtectableContainerResourceList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ProtectionContainersOperationGroup {
  /**
   * Discovers all the containers in the subscription that can be backed up to Recovery Services Vault. This is an
   * asynchronous operation. To know the status of the operation, call GetRefreshOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/refreshContainers")
  @post
  @tag("ProtectionContainers")
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
  ): ArmAcceptedResponse<ExtraHeaders = {}> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupOperationResults {
  /**
   * Provides the status of the delete operations such as deleting backed up item. Once the operation has started, the
   * status code in the response would be Accepted. It will continue to be in this state till it reaches completion. On
   * successful completion, the status code will be OK. This method expects OperationID as an argument. OperationID is
   * part of the Location header of the operation response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperationResults/{operationId}")
  @get
  @tag("BackupOperationResults")
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
  ):
    | OkResponse
    | ArmAcceptedResponse<ExtraHeaders = {}>
    | ArmNoContentResponse
    | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupOperationStatuses {
  /**
   * Fetches the status of an operation such as triggering a backup, restore. The status can be in progress, completed
   * or failed. You can refer to the OperationStatus enum for all the possible states of an operation. Some operations
   * create jobs. This method returns the list of jobs when the operation is complete.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupOperations/{operationId}")
  @get
  @tag("BackupOperationStatuses")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupProtectableItems {
  /**
   * Provides a pageable list of protectable objects within your subscription according to the query filter and the
   * pagination parameters.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems")
  @get
  @list
  @tag("BackupProtectableItems")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupProtectionContainers {
  /**
   * Lists the containers registered to Recovery Services Vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectionContainers")
  @get
  @list
  @tag("BackupProtectionContainers")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DeletedProtectionContainers {
  /**
   * Lists the soft deleted containers registered to Recovery Services Vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupDeletedProtectionContainers")
  @get
  @list
  @tag("SoftDeletedContainers")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SecurityPINs {
  /**
   * Get the security PIN.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSecurityPIN")
  @post
  @tag("SecurityPINs")
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @header
    `x-ms-authorization-auxiliary`?: string,

    /**
     * security pin request
     */
    @bodyRoot
    parameters?: SecurityPinBase,
  ): ArmResponse<TokenInformation> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FetchTieringCost {
  /**
   * Provides the details of the tiering related sizes and cost.
   * Status of the operation can be fetched using GetTieringCostOperationStatus API and result using GetTieringCostOperationResult API.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/fetchTieringCost")
  @post
  @tag("FetchTieringCost")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface GetTieringCostOperationResult {
  /**
   * Gets the result of async operation for tiering cost
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationResults/{operationId}")
  @get
  @tag("GetTieringCostOperationResult")
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

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    operationId: string,
  ): ArmResponse<TieringCostInfo> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TieringCostOperationStatus {
  /**
   * Gets the status of async operations of tiering cost
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupTieringCost/default/operationsStatus/{operationId}")
  @get
  @tag("TieringCostOperationStatus")
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

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    operationId: string,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
