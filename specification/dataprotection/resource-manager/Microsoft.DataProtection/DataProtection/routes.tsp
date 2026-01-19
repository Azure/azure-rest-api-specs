// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";

import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupVaultsOperationGroup {
  /**
   * API to check for resource name availability
   */
  @summary("API to check for resource name availability")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * Check name availability request
     */
    @bodyRoot
    parameters: CheckNameAvailabilityRequest,
  ): ArmResponse<CheckNameAvailabilityResult> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationResultOperationGroup {
  /**
   * Gets the operation result for a resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the operation status for a resource.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    operationId: string,

    ...LocationResourceParameter,
  ): OperationJobExtendedInfo | {
    @statusCode _: 202;

    @header("Azure-AsyncOperation")
    azureAsyncOperation?: string;

    @header("Location")
    location?: string;

    @header("Retry-After")
    retryAfter?: int32;
  } | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationStatusOperationGroup {
  /**
   * Gets the operation status for a resource.
   */
  @summary("Gets the operation status for a resource.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/operationStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    operationId: string,
  ): ArmResponse<OperationResource> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface OperationStatusResourceGroupContextOperationGroup {
  /**
   * Gets the operation status for an operation over a ResourceGroup's context.
   */
  @summary("Gets the operation status for an operation over a ResourceGroup's context.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/operationStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    operationId: string,
  ): ArmResponse<OperationResource> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DataProtectionOperationGroup {
  /**
   * Validates if a feature is supported
   */
  @summary("Validates if a feature is supported")
  @autoRoute
  checkFeatureSupport is ArmProviderActionSync<
    Request = FeatureValidationRequestBase,
    Response = FeatureValidationResponseBase,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupInstancesOperationGroup {
  /**
   * Triggers Cross Region Restore for BackupInstance.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/crossRegionRestore")
  @post
  triggerCrossRegionRestore(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Request body for trigger CRR operation
     */
    @bodyRoot
    parameters: CrossRegionRestoreRequestObject,
  ): OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>> | ErrorResponse;

  /**
   * Validates whether Cross Region Restore can be triggered for DataSource.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/validateCrossRegionRestore")
  @post
  validateCrossRegionRestore(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Request body for operation
     */
    @bodyRoot
    parameters: ValidateCrossRegionRestoreRequestObject,
  ): OperationJobExtendedInfo | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FetchSecondaryRecoveryPointsOperationGroup {
  /**
   * Returns a list of Secondary Recovery Points for a DataSource in a vault, that can be used for Cross Region Restore.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchSecondaryRecoveryPoints")
  @post
  @list
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

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
     * Request body for operation
     */
    @bodyRoot
    parameters: FetchSecondaryRPsRequestParameters,
  ): ArmResponse<AzureBackupRecoveryPointResourceList> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FetchCrossRegionRestoreJobOperationGroup {
  /**
   * Fetches the Cross Region Restore Job
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJob")
  @post
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * Request body for operation
     */
    @bodyRoot
    parameters: CrossRegionRestoreJobRequest,
  ): ArmResponse<AzureBackupJobResource> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface FetchCrossRegionRestoreJobsOperationGroup {
  /**
   * Fetches list of Cross Region Restore job belonging to the vault
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/locations/{location}/fetchCrossRegionRestoreJobs")
  @post
  @list
  list(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,

    /**
     * Request body for operation
     */
    @bodyRoot
    parameters: CrossRegionRestoreJobsRequest,
  ): ArmResponse<AzureBackupJobResourceList> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface BackupInstancesExtensionRoutingOperationGroup {
  /**
   * Gets a list of backup instances associated with a tracked resource
   */
  @route("/{+resourceId}/providers/Microsoft.DataProtection/backupInstances")
  @get
  @list
  list(
    ...ApiVersionParameter,

    /**
     * ARM path of the resource to be protected using Microsoft.DataProtection
     */
    @path
    resourceId: string,
  ): ArmResponse<BackupInstanceResourceList> | CloudError;
}
