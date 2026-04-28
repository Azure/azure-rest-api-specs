// Cross-Tenant Vault Mapping operations — added in v2026_03_31_preview

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.RecoveryServices;

// ============================================================
// CrossTenantVaultMapping Resource (child of VaultResource)
// ============================================================

/**
 * Cross-tenant vault mapping resource for cross-tenant restore.
 */
@added(Versions.v2026_03_31_preview)
@parentResource(VaultResource)
model CrossTenantVaultMappingResource
  is ProxyResource<CrossTenantVaultMapping> {
  ...ResourceNameParameter<
    Resource = CrossTenantVaultMappingResource,
    KeyName = "crossTenantVaultMappingName",
    SegmentName = "backupCrossTenantVaultMappings",
    NamePattern = ".*"
  >;
}

// ============================================================
// CRUD operations on CrossTenantVaultMappingResource
// ============================================================

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "CTR resource uses remove action instead of standard DELETE"
@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface CrossTenantVaultMappings {
  /**
   * Creates or updates the cross-tenant vault mapping for cross-tenant restore operations.
   * This API updates the target vault properties with source vault ID and creates catalog mapping.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<CrossTenantVaultMappingResource>;

  /**
   * Lists the cross-tenant vault mapping configurations for cross-tenant restore operations.
   * Retrieves the current cross-tenant vault mapping details including source vault mappings and mapping state.
   */
  list is ArmResourceListByParent<CrossTenantVaultMappingResource>;

  /**
   * Removes the cross-tenant vault mapping for cross-tenant restore operations.
   * This API removes the target vault properties associated with source vault ID and deletes catalog mapping.
   */
  @action("removeCrossTenantVaultMapping")
  remove is ArmResourceActionAsync<
    CrossTenantVaultMappingResource,
    RemoveCrossTenantVaultMappingRequest,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

// ============================================================
// Cross-tenant operations (routes under crossTenantVaultMapping)
// ============================================================

// ============================================================
// CrossTenantVaultMappingStatus — vault-level status check action
// (Phase 4b spike: standard ARM template form per markcowl review)
// ============================================================

@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface CrossTenantVaultMappingStatus {
  /**
   * Gets the mapping status of the vault for cross-tenant restore operations.
   * Returns the mapping status that indicates whether the vault is properly configured for cross-tenant operations.
   */
  @action("backupCrossTenantVaultMappingStatus")
  @tag("CrossTenant")
  check is ArmResourceActionSync<
    VaultResource,
    void,
    CrossTenantVaultMappingStatusResponse
  >;
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantOperations {
  /**
   * Lists the protected items from the source vault in a different tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupProtectedItems")
  @get
  @list
  @operationId("BackupProtectedItemsFromCrossTenantVault_List")
  @tag("CrossTenant")
  listProtectedItemsFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

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
   * Gets the details of a protected item from a cross-tenant vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId and x-ms-examples required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}")
  @get
  @operationId("ProtectedItemFromCrossTenantVault_Get")
  @tag("CrossTenant")
  @extension(
    "x-ms-examples",
    #{
      `Get Protected Item From Cross-Tenant Vault`: #{
        $ref: "./examples/CrossTenantVaultMappingOperations/GetProtectedItemFromCrossTenantVault.json",
      },
    }
  )
  getProtectedItemFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the backed up items.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backed up item name whose details are to be fetched.
     */
    @pattern(".*")
    @path
    protectedItemName: string,

    ...ApiVersionParameter,
  ): ArmResponse<ProtectedItemResource> | ErrorResponse;

  /**
   * Lists recovery points from the source vault in a different tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints")
  @get
  @list
  @operationId("CrossTenantVaultRecoveryPoints_List")
  @tag("CrossTenant")
  listRecoveryPointsFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the container.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backed up item name whose recovery points are to be fetched.
     */
    @pattern(".*")
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
   * Provides the information of the backed up data identified using RecoveryPointID from the source
   * vault in a different tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId and x-ms-examples required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}")
  @get
  @operationId("CrossTenantVaultRecoveryPoint_Get")
  @tag("CrossTenant")
  @extension(
    "x-ms-examples",
    #{
      `Get Recovery Point From Cross-Tenant Vault`: #{
        $ref: "./examples/CrossTenantVaultMappingOperations/GetRecoveryPointFromCrossTenantVault.json",
      },
    }
  )
  getRecoveryPointFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the backed up item.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up item.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backed up item name whose recovery point details are to be fetched.
     */
    @pattern(".*")
    @path
    protectedItemName: string,

    /**
     * RecoveryPointID represents the backed up data to be fetched.
     */
    @path
    recoveryPointId: string,

    ...ApiVersionParameter,
  ): ArmResponse<RecoveryPointResource> | ErrorResponse;

  /**
   * Restores the specified backed up data from a source vault in a different tenant. This is an asynchronous operation.
   * To know the status of this API call, use GetProtectedItemOperationResult API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/restore")
  @post
  @operationId("RestoresFromCrossTenantVault_Trigger")
  @tag("CrossTenant")
  triggerRestoreFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the backed up items.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backed up item to be restored.
     */
    @pattern(".*")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId and x-ms-examples required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationResults/{operationId}")
  @get
  @operationId("ProtectedItemOperationResultsFromCrossTenantVault_Get")
  @tag("CrossTenant")
  @extension(
    "x-ms-examples",
    #{
      `Get Cross-Tenant Operation Result`: #{
        $ref: "./examples/CrossTenantVaultMappingOperations/GetCrossTenantOperationResult.json",
      },
    }
  )
  getProtectedItemOperationResultFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the backed up items.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backed up item name whose details are to be fetched.
     */
    @pattern(".*")
    @path
    protectedItemName: string,

    /**
     * OperationID which represents the operation whose result needs to be fetched.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<ProtectedItemResource> | ArmAcceptedLroResponse | ErrorResponse;

  /**
   * Fetches the status of a cross-tenant operation such as triggering a restore.
   * The status can be in progress, completed or failed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId and x-ms-examples required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationsStatus/{operationId}")
  @get
  @operationId("ProtectedItemOperationStatusesFromCrossTenantVault_Get")
  @tag("CrossTenant")
  @extension(
    "x-ms-examples",
    #{
      `Get Cross-Tenant Operation Status`: #{
        $ref: "./examples/CrossTenantVaultMappingOperations/GetCrossTenantOperationStatus.json",
      },
    }
  )
  getProtectedItemOperationStatusFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Fabric name associated with the backing up items.
     */
    @pattern(".*")
    @path
    fabricName: string,

    /**
     * Container name associated with the backed up items.
     */
    @pattern(".*")
    @path
    containerName: string,

    /**
     * Backup item name whose details are to be fetched.
     */
    @pattern(".*")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupJobs")
  @get
  @list
  @operationId("BackupJobsFromCrossTenantVault_List")
  @tag("CrossTenant")
  listJobsFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupJobs/{jobName}")
  @get
  @operationId("JobDetailsFromCrossTenantVault_Get")
  @tag("CrossTenant")
  getJobDetailsFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Name of the job whose details are to be fetched.
     */
    @pattern(".*")
    @path
    jobName: string,

    ...ApiVersionParameter,
  ): ArmResponse<JobResource> | ErrorResponse;

  /**
   * Validates a backup operation for cross-tenant restore scenarios.
   * This API performs validation checks before executing a backup operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupValidateOperation")
  @post
  @operationId("OperationFromCrossTenantVault_Validate")
  @tag("CrossTenant")
  validateOperationFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    ...ApiVersionParameter,

    /**
     * Validate operation request
     */
    @bodyRoot
    parameters: ValidateOperationRequestResource,
  ): ArmResponse<ValidateOperationsResponse> | ErrorResponse;

  /**
   * Triggers a validate operation for cross-tenant restore scenarios.
   * This is an asynchronous operation that performs validation checks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupTriggerValidateOperation")
  @post
  @operationId("ValidateOperationFromCrossTenantVault_Trigger")
  @tag("CrossTenant")
  triggerValidateOperationFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    ...ApiVersionParameter,

    /**
     * Trigger validate operation request
     */
    @bodyRoot
    parameters: ValidateOperationRequestResource,
  ): ArmResponse<ValidateOperationsResponse> | ArmAcceptedLroResponse | ErrorResponse;

  /**
   * Gets the result of a specific validate operation for cross-tenant restore scenarios.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Matches existing ValidateOperationResults pattern in routes.tsp"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupValidateOperationResults/{operationId}")
  @get
  @operationId("ValidateOperationResultFromCrossTenantVault_Get")
  @tag("CrossTenant")
  getValidateOperationResultFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * OperationID which represents the operation whose result needs to be fetched.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<ValidateOperationsResponse> | ArmAcceptedResponse<
    "Accepted",
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  /**
   * Gets the status of a validate operation for cross-tenant restore scenarios.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupValidateOperationsStatuses/{operationId}")
  @get
  @operationId("ValidateOperationStatusFromCrossTenantVault_Get")
  @tag("CrossTenant")
  getValidateOperationStatusFromCrossTenantVault(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * OperationID represents the operation whose status needs to be fetched.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}

/**
 * List of protected items for cross-tenant restore operations.
 */
@added(Versions.v2026_03_31_preview)
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
@added(Versions.v2026_03_31_preview)
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
@added(Versions.v2026_03_31_preview)
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

@@doc(CrossTenantVaultMappingResource.name, "Cross-tenant vault mapping name.");
@@doc(CrossTenantVaultMappingResource.properties,
  "CrossTenantVaultMappingResource properties"
);
@@doc(CrossTenantVaultMappings.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(CrossTenantVaultMappings.remove::parameters.body,
  "Request body for operation"
);

// ============================================================
// Cross-tenant Vault Credential operations
// ============================================================

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultCredentialOperations {
  /**
   * Generates a vault credential certificate for cross-tenant restore scenarios.
   * This is an asynchronous operation. BMS creates a TEE job that calls IDM's certificates
   * endpoint for the source vault, generating a self-signed certificate registered with AAD.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/generate")
  @post
  @operationId("CrossTenantVaultCredential_Generate")
  @tag("CrossTenant")
  generateCrossTenantVaultCredential(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Name identifier for the certificate.
     */
    @pattern(".*")
    @path
    certificateName: string,

    ...ApiVersionParameter,

    /**
     * Optional certificate generation options.
     */
    @bodyRoot
    parameters?: VaultCredentialCertificateRequest,
  ): ArmAcceptedLroResponse | ArmNoContentResponse | ErrorResponse;

  /**
   * Gets the result of an async vault credential generation operation.
   * Returns 202 Accepted while the TEE job is still in progress.
   * Returns 200 OK with VaultCredentialCertificateResponse when the job completes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Matches existing OperationResults pattern"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/operationResults/{operationId}")
  @get
  @operationId("CrossTenantVaultCredentialOperationResults_Get")
  @tag("CrossTenant")
  getVaultCredentialOperationResult(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Name identifier for the certificate.
     */
    @pattern(".*")
    @path
    certificateName: string,

    /**
     * Operation ID returned in the Location header of the generate call.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<VaultCredentialCertificateResponse> | ArmAcceptedResponse<
    "Accepted",
    ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  > | ErrorResponse;

  /**
   * Gets the status of an async vault credential generation operation.
   * Returns the current status (InProgress, Completed, Failed) and any associated job details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Custom operationId required for non-standard cross-tenant operation groups"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Non-standard cross-tenant pass-through operation"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/operationStatus/{operationId}")
  @get
  @operationId("CrossTenantVaultCredentialOperationStatuses_Get")
  @tag("CrossTenant")
  getVaultCredentialOperationStatus(
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the recovery services vault.
     */
    @pattern(".*")
    @path
    vaultName: string,

    /**
     * Cross-tenant vault mapping name.
     */
    @pattern(".*")
    @path
    crossTenantVaultMappingName: string,

    /**
     * Name identifier for the certificate.
     */
    @pattern(".*")
    @path
    certificateName: string,

    /**
     * Operation ID returned in the Azure-AsyncOperation header of the generate call.
     */
    @path
    operationId: string,

    ...ApiVersionParameter,
  ): ArmResponse<OperationStatus> | ErrorResponse;
}
