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

namespace Microsoft.DataProtection;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupVaultsOperationGroup {
  /**
   * API to check for resource name availability
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("API to check for resource name availability")
  @operationId("BackupVaults_CheckNameAvailability")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationResultOperationGroup {
  /**
   * Gets the operation result for a resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the operation status for a resource.")
  @operationId("OperationResult_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/operationResults/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,

    ...LocationResourceParameter,
  ): ArmResponse<OperationJobExtendedInfo> | ArmAcceptedResponse | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusOperationGroup {
  /**
   * Gets the operation status for a resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the operation status for a resource.")
  @operationId("OperationStatus_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataProtection/locations/{location}/operationStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): ArmResponse<OperationResource> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface OperationStatusResourceGroupContextOperationGroup {
  /**
   * Gets the operation status for an operation over a ResourceGroup's context.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets the operation status for an operation over a ResourceGroup's context.")
  @operationId("OperationStatusResourceGroupContext_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/operationStatus/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
    @path
    operationId: string,
  ): ArmResponse<OperationResource> | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DataProtectionOperationGroup {
  /**
   * Validates if a feature is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Validates if a feature is supported")
  @operationId("DataProtection_CheckFeatureSupport")
  @autoRoute
  checkFeatureSupport is ArmProviderActionSync<
    Request = FeatureValidationRequestBase,
    Response = FeatureValidationResponseBase,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupInstancesOperationGroup {
  /**
   * Triggers Cross Region Restore for BackupInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_TriggerCrossRegionRestore")
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
  ): ArmResponse<OperationJobExtendedInfo> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ErrorResponse;

  /**
   * Validates whether Cross Region Restore can be triggered for DataSource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstances_ValidateCrossRegionRestore")
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
  ): ArmResponse<OperationJobExtendedInfo> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FetchSecondaryRecoveryPointsOperationGroup {
  /**
   * Returns a list of Secondary Recovery Points for a DataSource in a vault, that can be used for Cross Region Restore.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FetchSecondaryRecoveryPoints_List")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FetchCrossRegionRestoreJobOperationGroup {
  /**
   * Fetches the Cross Region Restore Job
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FetchCrossRegionRestoreJob_Get")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface FetchCrossRegionRestoreJobsOperationGroup {
  /**
   * Fetches list of Cross Region Restore job belonging to the vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("FetchCrossRegionRestoreJobs_List")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BackupInstancesExtensionRoutingOperationGroup {
  /**
   * Gets a list of backup instances associated with a tracked resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupInstancesExtensionRouting_List")
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
