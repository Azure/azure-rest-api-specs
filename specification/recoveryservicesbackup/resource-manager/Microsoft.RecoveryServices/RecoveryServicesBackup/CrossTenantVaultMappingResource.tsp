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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultMappings {
  /**
   * Gets the cross-tenant vault mapping by name.
   */
  get is ArmResourceRead<CrossTenantVaultMapping>;

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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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

// Shared parameter aliases for the LegacyOperations aliases below.
// `StandardResourceGroupParams` captures the standard scope plus the legacy
// provider segment used by every cross-tenant operation. The `*ParentParameters`
// aliases capture only the path-segment params for each common ARM URL prefix in
// the cross-tenant vault hierarchy. They are spread together in each Ops alias so
// the URL is emitted in the correct order (scope → provider → segments).
// Aliases (rather than `model`) keep these out of the generated SDK model surface.

alias StandardResourceGroupParams = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;
};

// Shared OData query parameter aliases for list operations. Hand-rolled (rather
// than using `Azure.ResourceManager.ArmFilterParameter` / `SkipTokenParameter`)
// to preserve the existing wire format: `$skipToken` keeps the capital `T` used
// throughout the rest of the RSV swagger, and both parameters remain optional.
alias ListFilterParameter = {
  /**
   * OData filter options.
   */
  @query("$filter")
  filter?: string;
};

alias ListSkipTokenParameter = {
  /**
   * skipToken Filter.
   */
  @query("$skipToken")
  skipToken?: string;
};

/**
 * Path segment parameters under /vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}.
 */
alias CrossTenantVaultMappingParentParameters = {
  @doc("The name of the recovery services vault.")
  @path
  @segment("vaults")
  vaultName: string;

  @doc("Cross-tenant vault mapping name.")
  @path
  @segment("backupCrossTenantVaultMappings")
  @pattern("^[A-Za-z][A-Za-z0-9]{1,99}$")
  crossTenantVaultMappingName: string;
};

/**
 * Path segment parameters extending the mapping parent down to a backup protection container.
 */
alias CrossTenantContainerParentParameters = {
  ...CrossTenantVaultMappingParentParameters;

  @doc("Fabric name associated with the backed up items.")
  @path
  @segment("backupFabrics")
  fabricName: string;

  @doc("Container name associated with the backed up items.")
  @path
  @segment("protectionContainers")
  containerName: string;
};

/**
 * Path segment parameters extending the container parent down to a protected item.
 */
alias CrossTenantProtectedItemParentParameters = {
  ...CrossTenantContainerParentParameters;

  @doc("Backed up item name.")
  @path
  @segment("protectedItems")
  protectedItemName: string;
};

/**
 * Path segment parameters extending the mapping parent down to a vault credential certificate.
 */
alias CrossTenantVaultCredentialParentParameters = {
  ...CrossTenantVaultMappingParentParameters;

  @doc("Name identifier for the certificate.")
  @path
  @segment("vaultCredentials")
  certificateName: string;
};

// LegacyOperations alias for routes parented at /vaults/{vaultName}/backupCrossTenantVaultMappings/{crossTenantVaultMappingName}/<child>
// The first arg captures the parent path; the second declares the child segment used by @segmentOf for list URLs.
alias BackupProtectedItemsFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultMappingParentParameters;
  },
  {
    @doc("Backup managed item name.")
    @path
    @segment("backupProtectedItems")
    @key
    protectedItemName: string;
  },
  ResourceName = "BackupProtectedItemsFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface BackupProtectedItemsFromCrossTenantVault {
  /**
   * Lists the protected items from the source vault in a different tenant.
   */
  @tag("CrossTenant")
  list is BackupProtectedItemsFromCrossTenantVaultOps.List<
    ProtectedItemResource,
    Parameters = {
      ...ListFilterParameter;
      ...ListSkipTokenParameter;
    },
    Response = ArmResponse<CrossTenantProtectedItemResourceList>
  >;
}

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface ProtectedItemFromCrossTenantVault {
  /**
   * Gets the details of a protected item from a cross-tenant vault.
   */
  @tag("CrossTenant")
  get is ProtectedItemFromCrossTenantVaultOps.Read<ProtectedItemResource>;
}

// LegacyOperations alias for routes parented at the protected-item resource (5 levels deep,
// child = protectedItems/{protectedItemName}).
alias ProtectedItemFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantContainerParentParameters;
  },
  {
    @doc("Backed up item name whose details are to be fetched.")
    @path
    @segment("protectedItems")
    @key
    protectedItemName: string;
  },
  ResourceName = "ProtectedItemFromCrossTenantVault"
>;

// LegacyOperations alias for routes parented at /vaults/{}/backupCrossTenantVaultMappings/{}/backupFabrics/{}/protectionContainers/{}/protectedItems/{}/<child>
alias CrossTenantVaultRecoveryPointsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantProtectedItemParentParameters;
  },
  {
    @doc("RecoveryPointID represents the backed up data to be fetched.")
    @path
    @segment("recoveryPoints")
    @key
    recoveryPointId: string;
  },
  ResourceName = "CrossTenantVaultRecoveryPoints"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultRecoveryPoints {
  /**
   * Lists recovery points from the source vault in a different tenant.
   */
  @tag("CrossTenant")
  list is CrossTenantVaultRecoveryPointsOps.List<
    RecoveryPointResource,
    Parameters = {
      ...ListFilterParameter;
    },
    Response = ArmResponse<CrossTenantRecoveryPointResourceList>
  >;
}

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultRecoveryPoint {
  /**
   * Provides the information of the backed up data identified using RecoveryPointID from the source
   * vault in a different tenant.
   */
  @tag("CrossTenant")
  get is CrossTenantVaultRecoveryPointsOps.Read<RecoveryPointResource>;
}

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface RestoresFromCrossTenantVault {
  /**
   * Restores the specified backed up data from a source vault in a different tenant. This is an asynchronous operation.
   * To know the status of this API call, use GetProtectedItemOperationResult API.
   */
  @action("restore")
  @tag("CrossTenant")
  trigger is CrossTenantVaultRecoveryPointsOps.ActionAsync<
    RecoveryPointResource,
    RestoreRequestResource,
    void,
    Response = ArmAcceptedLroResponse | ArmNoContentResponse
  >;
}

// LegacyOperations alias for routes parented at the protected-item resource
// (5 levels deep, child = operationResults/{operationId}).
alias ProtectedItemOperationResultsFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantProtectedItemParentParameters;
  },
  {
    @doc("OperationID which represents the operation whose result needs to be fetched.")
    @path
    @segment("operationResults")
    @key
    operationId: string;
  },
  ResourceName = "ProtectedItemOperationResultsFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface ProtectedItemOperationResultsFromCrossTenantVault {
  /**
   * Fetches the result of any cross-tenant operation on the backup item.
   * While the operation is in progress this returns 202 Accepted with Location/Retry-After
   * headers pointing back at this same poll URL. When the operation completes it returns
   * either 200 OK with the final ProtectedItemResource body, or 204 No Content if there
   * is no body to return.
   */
  @tag("CrossTenant")
  get is ProtectedItemOperationResultsFromCrossTenantVaultOps.Read<
    ProtectedItemResource,
    Response =
      | ArmResponse<ProtectedItemResource>
      | ArmAcceptedResponse<
          "Accepted",
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
  >;
}

// LegacyOperations alias for routes parented at the protected-item resource
// (5 levels deep, child = operationsStatus/{operationId}).
alias ProtectedItemOperationStatusesFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantProtectedItemParentParameters;
  },
  {
    @doc("OperationID represents the operation whose status needs to be fetched.")
    @path
    @segment("operationsStatus")
    @key
    operationId: string;
  },
  ResourceName = "ProtectedItemOperationStatusesFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface ProtectedItemOperationStatusesFromCrossTenantVault {
  /**
   * Fetches the status of a cross-tenant operation such as triggering a restore.
   * The status can be in progress, completed or failed.
   */
  @tag("CrossTenant")
  get is ProtectedItemOperationStatusesFromCrossTenantVaultOps.Read<OperationStatus>;
}

// LegacyOperations alias for routes parented at the mapping resource,
// child = backupJobs/{jobName}. Used by both BackupJobsFromCrossTenantVault.list
// and JobDetailsFromCrossTenantVault.get.
alias BackupJobsFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultMappingParentParameters;
  },
  {
    @doc("Name of the job whose details are to be fetched.")
    @path
    @segment("backupJobs")
    @key
    jobName: string;
  },
  ResourceName = "BackupJobsFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface BackupJobsFromCrossTenantVault {
  /**
   * Provides a pageable list of cross-tenant backup jobs.
   */
  @tag("CrossTenant")
  list is BackupJobsFromCrossTenantVaultOps.List<
    JobResource,
    Parameters = {
      ...ListFilterParameter;
      ...ListSkipTokenParameter;
    },
    Response = ArmResponse<CrossTenantJobResourceList>
  >;
}

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface JobDetailsFromCrossTenantVault {
  /**
   * Gets extended information associated with a cross-tenant backup job.
   */
  @tag("CrossTenant")
  get is BackupJobsFromCrossTenantVaultOps.Read<JobResource>;
}

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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

// LegacyOperations alias for routes parented at the mapping resource,
// child = backupValidateOperationResults/{operationId}.
alias ValidateOperationResultFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultMappingParentParameters;
  },
  {
    @doc("OperationID which represents the operation whose result needs to be fetched.")
    @path
    @segment("backupValidateOperationResults")
    @key
    operationId: string;
  },
  ResourceName = "ValidateOperationResultFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface ValidateOperationResultFromCrossTenantVault {
  /**
   * Gets the result of a specific validate operation for cross-tenant restore scenarios.
   * While the operation is in progress this returns 202 Accepted with Location/Retry-After
   * headers pointing back at this same poll URL. When the operation completes it returns
   * either 200 OK with the final ValidateOperationsResponse body, or 204 No Content if
   * there is no body to return.
   */
  @tag("CrossTenant")
  get is ValidateOperationResultFromCrossTenantVaultOps.Read<
    CrossTenantVaultMapping,
    Response =
      | ArmResponse<ValidateOperationsResponse>
      | ArmAcceptedResponse<
          "Accepted",
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
  >;
}

// LegacyOperations alias for routes parented at the mapping resource,
// child = backupValidateOperationsStatuses/{operationId}.
alias ValidateOperationStatusFromCrossTenantVaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultMappingParentParameters;
  },
  {
    @doc("OperationID represents the operation whose status needs to be fetched.")
    @path
    @segment("backupValidateOperationsStatuses")
    @key
    operationId: string;
  },
  ResourceName = "ValidateOperationStatusFromCrossTenantVault"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface ValidateOperationStatusFromCrossTenantVault {
  /**
   * Gets the status of a validate operation for cross-tenant restore scenarios.
   */
  @tag("CrossTenant")
  get is ValidateOperationStatusFromCrossTenantVaultOps.Read<OperationStatus>;
}

/**
 * List of protected items for cross-tenant restore operations.
 */
@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
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
@@doc(
  CrossTenantVaultMappings.createOrUpdate::parameters.resource,
  "Request body for operation"
);
@@doc(
  CrossTenantVaultMappings.remove::parameters.body,
  "Request body for operation"
);

// ============================================================
// Cross-tenant Vault Credential operations
// ============================================================

// ============================================================
// Cross-tenant Vault Credential operations (split per operationId prefix)
// ============================================================

// LegacyOperations alias for routes parented at the mapping resource,
// child = vaultCredentials/{certificateName}.
alias CrossTenantVaultCredentialOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultMappingParentParameters;
  },
  {
    @doc("Name identifier for the certificate.")
    @path
    @segment("vaultCredentials")
    @key
    certificateName: string;
  },
  ResourceName = "CrossTenantVaultCredential"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultCredential {
  /**
   * Generates a vault credential certificate for cross-tenant restore scenarios.
   * This is an asynchronous operation. BMS creates a TEE job that calls IDM's certificates
   * endpoint for the source vault, generating a self-signed certificate registered with AAD.
   */
  @action("generate")
  @tag("CrossTenant")
  generate is CrossTenantVaultCredentialOps.ActionAsync<
    CrossTenantVaultMapping,
    VaultCredentialCertificateRequest,
    void,
    Response = ArmAcceptedLroResponse | ArmNoContentResponse,
    OptionalRequestBody = true
  >;
}

// LegacyOperations alias for routes parented at the certificate resource,
// child = operationResults/{operationId}.
alias CrossTenantVaultCredentialOperationResultsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultCredentialParentParameters;
  },
  {
    @doc("Operation ID returned in the Location header of the generate call.")
    @path
    @segment("operationResults")
    @key
    operationId: string;
  },
  ResourceName = "CrossTenantVaultCredentialOperationResults"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultCredentialOperationResults {
  /**
   * Gets the result of an async vault credential generation operation.
   * While the TEE job is in progress this returns 202 Accepted with Location/Retry-After
   * headers pointing back at this same poll URL. When the job completes it returns either
   * 200 OK with the generated VaultCredentialCertificateResponse body, or 204 No Content
   * if there is no body to return.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "Phase 9 (PR #41694 issuecomment-4449163933): operation-result Read is templated against the parent CrossTenantVaultMapping resource (per live1206's suggested fix) so the .NET mgmt emitter resolves the resource type for Exists-pipeline generation; the 200 returns VaultCredentialCertificateResponse, which is the actual operation-result payload. RPC 008 (same schema across PUT/GET/PATCH/LIST) does not apply: this route is a polling GET, not a resource lifecycle operation."
  @tag("CrossTenant")
  get is CrossTenantVaultCredentialOperationResultsOps.Read<
    CrossTenantVaultMapping,
    Response =
      | ArmResponse<VaultCredentialCertificateResponse>
      | ArmAcceptedResponse<
          "Accepted",
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
  >;
}

// LegacyOperations alias for routes parented at the certificate resource,
// child = operationStatus/{operationId} (singular, distinct from other status routes).
alias CrossTenantVaultCredentialOperationStatusesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...StandardResourceGroupParams;
    ...CrossTenantVaultCredentialParentParameters;
  },
  {
    @doc("Operation ID returned in the Azure-AsyncOperation header of the generate call.")
    @path
    @segment("operationStatus")
    @key
    operationId: string;
  },
  ResourceName = "CrossTenantVaultCredentialOperationStatuses"
>;

@added(Versions.v2026_03_31_preview)
@removed(Versions.v2026_05_01)
@added(Versions.v2026_05_31_preview)
@removed(Versions.v2026_07_01)
@armResourceOperations
interface CrossTenantVaultCredentialOperationStatuses {
  /**
   * Gets the status of an async vault credential generation operation.
   * Returns the current status (InProgress, Completed, Failed) and any associated job details.
   */
  @tag("CrossTenant")
  get is CrossTenantVaultCredentialOperationStatusesOps.Read<OperationStatus>;
}
