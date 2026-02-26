// Cross-Tenant Restore (CTR) operations — added in v2026_03_01_preview

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.RecoveryServices;

// ============================================================
// SourceVaultMapping Resource (child of VaultResource)
// ============================================================

/**
 * Source vault mapping resource for cross-tenant restore.
 */
@added(Versions.v2026_03_01_preview)
@parentResource(VaultResource)
model SourceVaultMappingResource
  is ProxyResource<SourceVaultMapping> {
  ...ResourceNameParameter<
    Resource = SourceVaultMappingResource,
    KeyName = "sourceVaultMappingName",
    SegmentName = "backupSourceVaultMappings",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

// ============================================================
// CRUD operations on SourceVaultMappingResource
// ============================================================

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "CTR resource uses removeSourceVaultMapping action instead of standard DELETE"
@added(Versions.v2026_03_01_preview)
@armResourceOperations
interface CrossTenantSourceVaultMappings {
  /**
   * Gets a specific source vault mapping configuration for cross-tenant restore operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @operationId("CrossTenant_GetSourceVaultMapping")
  getSourceVaultMapping is ArmResourceRead<SourceVaultMappingResource>;

  /**
   * Configures the source vault for cross-tenant restore operations.
   * This API updates the target vault properties with source vault ID and creates catalog mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @operationId("CrossTenant_ConfigureSourceVault")
  configureSourceVault is ArmResourceCreateOrReplaceSync<SourceVaultMappingResource>;

  /**
   * Gets the vault mapping configuration for cross-tenant restore operations.
   * Retrieves the current cross-tenant vault mapping details including source vault mappings and mapping state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @operationId("CrossTenant_GetVaultMappingConfiguration")
  getVaultMappingConfiguration is ArmResourceListByParent<SourceVaultMappingResource>;

  /**
   * Removes the source vault configuration for cross-tenant restore operations.
   * This API removes the target vault properties associated with source vault ID and deletes catalog mapping.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "LRO POST requires 204 final response per OpenAPI lint-diff PostResponseCodes rule"
  @operationId("CrossTenant_RemoveSourceVaultMapping")
  removeSourceVaultMapping is ArmResourceActionAsyncBase<
    SourceVaultMappingResource,
    RemoveSourceVaultMappingRequest,
    ArmAcceptedLroResponse | ArmNoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SourceVaultMappingResource>
  >;
}

// ============================================================
// Cross-tenant operations (routes under sourceVaultMappings)
// ============================================================

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Non-standard routes for cross-tenant pass-through operations"
@added(Versions.v2026_03_01_preview)
interface CrossTenantOperations {
  /**
   * Gets the mapping status of the vault for cross-tenant restore operations.
   * Returns the mapping status that indicates whether the vault is properly configured for cross-tenant operations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappingStatus")
  @post
  @operationId("CheckVaultMappingStatus")
  @tag("CrossTenant")
  checkVaultMappingStatus(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    ...ApiVersionParameter,
  ): ArmResponse<SourceVaultMappingStatusResponse> | ErrorResponse;

  /**
   * Lists the protected items from the source vault in a different tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupProtectedItems")
  @get
  @list
  @operationId("CrossTenant_ListProtectedItems")
  @tag("CrossTenant")
  listCrossTenantProtectedItems(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    ...ApiVersionParameter,

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
  ): ArmResponse<CrossTenantProtectedItemResourceList> | ErrorResponse;

  /**
   * Lists recovery points from the source vault in a different tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints")
  @get
  @list
  @operationId("CrossTenant_GetRecoveryPoints")
  @tag("CrossTenant")
  getCrossTenantRecoveryPoints(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    /**
     * Fabric name associated with the container.
     */
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @path
    containerName: string,

    /**
     * Backed up item name whose recovery points are to be fetched.
     */
    @path
    protectedItemName: string,

    ...ApiVersionParameter,

    /**
     * OData filter options.
     */
    @query("$filter")
    $filter?: string,
  ): ArmResponse<CrossTenantRecoveryPointResourceList> | ErrorResponse;

  /**
   * Restores the specified backed up data from a source vault in a different tenant. This is an asynchronous operation.
   * To know the status of this API call, use GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/restore")
  @post
  @operationId("CrossTenant_TriggerRestore")
  @tag("CrossTenant")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "location" }
  )
  triggerCrossTenantRestore(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    /**
     * Fabric name associated with the backed up items.
     */
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @path
    containerName: string,

    /**
     * Backed up item to be restored.
     */
    @path
    protectedItemName: string,

    /**
     * Recovery point ID which represents the backed up data to be restored.
     */
    @path
    recoveryPointId: string,

    ...ApiVersionParameter,

    /**
     * resource restore request
     */
    @bodyRoot
    parameters: RestoreRequestResource,
  ): ArmAcceptedLroResponse | ArmNoContentResponse | ErrorResponse;

  /**
   * Fetches the result of any cross-tenant operation on the backup item.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationResults/{operationId}")
  @get
  @operationId("CrossTenant_GetProtectedItemOperationResult")
  @tag("CrossTenant")
  getCrossTenantProtectedItemOperationResult(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    /**
     * Fabric name associated with the backed up items.
     */
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @path
    containerName: string,

    /**
     * Backed up item name whose details are to be fetched.
     */
    @path
    protectedItemName: string,

    /**
     * OperationID which represents the operation whose result needs to be fetched.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ):
    | ArmResponse<ProtectedItemResource>
    | ArmAcceptedLroResponse
    | ErrorResponse;

  /**
   * Fetches the status of a cross-tenant operation such as triggering a restore.
   * The status can be in progress, completed or failed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationsStatus/{operationId}")
  @get
  @operationId("CrossTenant_GetProtectedItemOperationStatus")
  @tag("CrossTenant")
  getCrossTenantProtectedItemOperationStatus(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    /**
     * Fabric name associated with the backing up items.
     */
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @path
    containerName: string,

    /**
     * Backup item name whose details are to be fetched.
     */
    @path
    protectedItemName: string,

    /**
     * OperationID represents the operation whose status needs to be fetched.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;

  /**
   * Provides a pageable list of cross-tenant backup jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupJobs")
  @get
  @list
  @operationId("CrossTenant_ListJobs")
  @tag("CrossTenant")
  listCrossTenantJobs(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    ...ApiVersionParameter,

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
  ): ArmResponse<CrossTenantJobResourceList> | ErrorResponse;

  /**
   * Gets extended information associated with a cross-tenant backup job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for service contract compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupSourceVaultMappings/{sourceVaultMappingName}/backupJobs/{jobName}")
  @get
  @operationId("CrossTenant_GetJobDetails")
  @tag("CrossTenant")
  getCrossTenantJobDetails(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @path
    vaultName: string,

    /**
     * Source vault mapping name.
     */
    @path
    sourceVaultMappingName: string,

    /**
     * Name of the job whose details are to be fetched.
     */
    @path
    jobName: string,

    ...ApiVersionParameter,
  ): ArmResponse<JobResource> | ErrorResponse;
}

/**
 * List of protected items for cross-tenant restore operations.
 */
@added(Versions.v2026_03_01_preview)
model CrossTenantProtectedItemResourceList {
  /**
   * List of resources.
   */
  @pageItems
  @identifiers(#[])
  value?: ProtectedItemResource[];

  /**
   * The uri to fetch the next page of resources.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of recovery points for cross-tenant restore operations.
 */
@added(Versions.v2026_03_01_preview)
model CrossTenantRecoveryPointResourceList {
  /**
   * List of resources.
   */
  @pageItems
  @identifiers(#[])
  value?: RecoveryPointResource[];

  /**
   * The uri to fetch the next page of resources.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of jobs for cross-tenant restore operations.
 */
@added(Versions.v2026_03_01_preview)
model CrossTenantJobResourceList {
  /**
   * List of resources.
   */
  @pageItems
  @identifiers(#[])
  value?: JobResource[];

  /**
   * The uri to fetch the next page of resources.
   */
  @nextLink
  nextLink?: string;
}

@@doc(SourceVaultMappingResource.name, "Source vault mapping name.");
@@doc(SourceVaultMappingResource.properties,
  "SourceVaultMappingResource properties"
);
@@doc(CrossTenantSourceVaultMappings.configureSourceVault::parameters.resource,
  "Request body for operation"
);
@@doc(CrossTenantSourceVaultMappings.removeSourceVaultMapping::parameters.body,
  "Request body for operation"
);
