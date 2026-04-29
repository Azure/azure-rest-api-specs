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
model CrossTenantVaultMapping
  is ProxyResource<CrossTenantVaultMappingProperties> {
  ...ResourceNameParameter<
    Resource = CrossTenantVaultMapping,
    SegmentName = "backupCrossTenantVaultMappings",
    NamePattern = "^[A-Za-z][A-Za-z0-9]{1,99}$"
  >;
}

// ============================================================
// CRUD operations on CrossTenantVaultMapping
// ============================================================

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "CTR resource uses remove action instead of standard DELETE"
@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface CrossTenantVaultMappings {
  /**
   * Creates or updates the cross-tenant vault mapping for cross-tenant restore operations.
   * This API updates the target vault properties with source vault ID and creates catalog mapping.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<CrossTenantVaultMapping>;

  /**
   * Lists the cross-tenant vault mapping configurations for cross-tenant restore operations.
   * Retrieves the current cross-tenant vault mapping details including source vault mappings and mapping state.
   */
  list is ArmResourceListByParent<CrossTenantVaultMapping>;

  /**
   * Removes the cross-tenant vault mapping for cross-tenant restore operations.
   * This API removes the target vault properties associated with source vault ID and deletes catalog mapping.
   */
  #suppress "deprecated" "ArmResourceActionNoContentAsync emits 202+204 which the PostResponseCodes Spectral lint rule expects. The non-deprecated alternative ArmResourceActionNoResponseContentAsync emits 202-only (modern long-running async pattern), but the lint rule lags and still requires the 202+204 shape. Using the deprecated template avoids the suppression and keeps the spec lint-clean."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "ArmResourceActionNoContentAsync intentionally emits 202+204 to satisfy the Spectral PostResponseCodes rule (which lags the modern 202-only pattern). The TypeSpec-side warning here flags the same template's response shape from the opposite direction. The emitted swagger is valid and matches the Spectral rule's expectations."
  @action("removeCrossTenantVaultMapping")
  remove is ArmResourceActionNoContentAsync<
    CrossTenantVaultMapping,
    RemoveCrossTenantVaultMappingRequest
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

// ============================================================
// Cross-tenant pass-through operations (split per operationId prefix)
// ============================================================

// LegacyOperations alias for routes parented at /vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/<child>
// The first model arg captures the parent path; the second declares the child segment used by @segmentOf for list URLs.
@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface BackupProtectedItemsFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        @doc("The name of the recovery services vault.")
        @path
        @segment("vaults")
        @key
        vaultName: string,

        @doc("Cross-tenant vault mapping name.")
        @path
        @segment("backupCrossTenantVaultMappings")
        @key
        @pattern("^[A-Za-z][A-Za-z0-9]{1,99}$")
        crossTenantVaultMappingName: string,
      },
      {
        @doc("Backup managed item name.")
        @path
        @segment("backupProtectedItems")
        @key
        protectedItemName: string,
      },
      ResourceName = "BackupProtectedItemsFromCrossTenantVault"
    > {}

@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface BackupProtectedItemsFromCrossTenantVault {
  /**
   * Lists the protected items from the source vault in a different tenant.
   */
  @tag("CrossTenant")
  list is BackupProtectedItemsFromCrossTenantVaultOps.List<
    ProtectedItemResource,
    Parameters = {
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
    Response = ArmResponse<CrossTenantProtectedItemResourceList>
  >;
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ProtectedItemFromCrossTenantVault {
  /**
   * Gets the details of a protected item from a cross-tenant vault.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultRecoveryPoints {
  /**
   * Lists recovery points from the source vault in a different tenant.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints")
  @get
  @list
  @tag("CrossTenant")
  list(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultRecoveryPoint {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID from the source
   * vault in a different tenant.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface RestoresFromCrossTenantVault {
  /**
   * Restores the specified backed up data from a source vault in a different tenant. This is an asynchronous operation.
   * To know the status of this API call, use GetProtectedItemOperationResult API.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/recoveryPoints/{recoveryPointId}/restore")
  @post
  @tag("CrossTenant")
  trigger(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ProtectedItemOperationResultsFromCrossTenantVault {
  /**
   * Fetches the result of any cross-tenant operation on the backup item.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationResults/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ProtectedItemOperationStatusesFromCrossTenantVault {
  /**
   * Fetches the status of a cross-tenant operation such as triggering a restore.
   * The status can be in progress, completed or failed.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/protectedItems/{protectedItemName}/operationsStatus/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface BackupJobsFromCrossTenantVault {
  /**
   * Provides a pageable list of cross-tenant backup jobs.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupJobs")
  @get
  @list
  @tag("CrossTenant")
  list(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface JobDetailsFromCrossTenantVault {
  /**
   * Gets extended information associated with a cross-tenant backup job.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupJobs/{jobName}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface OperationFromCrossTenantVault {
  /**
   * Validates a backup operation for cross-tenant restore scenarios.
   * This API performs validation checks before executing a backup operation.
   */
  @action("backupValidateOperation")
  @tag("CrossTenant")
  validate is ArmResourceActionSync<
    CrossTenantVaultMapping,
    ValidateOperationRequestResource,
    ValidateOperationsResponse
  >;
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations
interface ValidateOperationFromCrossTenantVault {
  /**
   * Triggers a validate operation for cross-tenant restore scenarios.
   * This is an asynchronous operation that performs validation checks.
   */
  @action("backupTriggerValidateOperation")
  @tag("CrossTenant")
  trigger is ArmResourceActionAsync<
    CrossTenantVaultMapping,
    ValidateOperationRequestResource,
    ValidateOperationsResponse
  >;
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ValidateOperationResultFromCrossTenantVault {
  /**
   * Gets the result of a specific validate operation for cross-tenant restore scenarios.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Matches existing ValidateOperationResults pattern in routes.tsp"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupValidateOperationResults/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface ValidateOperationStatusFromCrossTenantVault {
  /**
   * Gets the status of a validate operation for cross-tenant restore scenarios.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/backupValidateOperationsStatuses/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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

@@doc(CrossTenantVaultMapping.name, "Cross-tenant vault mapping name.");
@@doc(CrossTenantVaultMapping.properties, "CrossTenantVaultMapping properties");
@@doc(CrossTenantVaultMappings.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(CrossTenantVaultMappings.remove::parameters.body,
  "Request body for operation"
);

// ============================================================
// Cross-tenant Vault Credential operations
// ============================================================

// ============================================================
// Cross-tenant Vault Credential operations (split per operationId prefix)
// ============================================================

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultCredential {
  /**
   * Generates a vault credential certificate for cross-tenant restore scenarios.
   * This is an asynchronous operation. BMS creates a TEE job that calls IDM's certificates
   * endpoint for the source vault, generating a self-signed certificate registered with AAD.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/generate")
  @post
  @tag("CrossTenant")
  generate(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultCredentialOperationResults {
  /**
   * Gets the result of an async vault credential generation operation.
   * Returns 202 Accepted while the TEE job is still in progress.
   * Returns 200 OK with VaultCredentialCertificateResponse when the job completes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "Matches existing OperationResults pattern"
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/operationResults/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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
}

@added(Versions.v2026_03_31_preview)
@armResourceOperations(#{ allowStaticRoutes: true })
interface CrossTenantVaultCredentialOperationStatuses {
  /**
   * Gets the status of an async vault credential generation operation.
   * Returns the current status (InProgress, Completed, Failed) and any associated job details.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/vaultCredentials/{certificateName}/operationStatus/{operationId}")
  @get
  @tag("CrossTenant")
  get(
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
