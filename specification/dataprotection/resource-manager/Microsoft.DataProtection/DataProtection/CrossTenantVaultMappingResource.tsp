import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "./BackupVaultResource.tsp";
import "./BackupInstanceResource.tsp";
import "./AzureBackupRecoveryPointResource.tsp";
import "./AzureBackupJobResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;

/**
 * State of a cross-tenant vault mapping.
 */
@added(Versions.v2026_08_31_preview)
union VaultMappingState {
  string,

  /**
   * The cross-tenant vault mapping is active.
   */
  Active: "Active",

  /**
   * The cross-tenant vault mapping is inactive.
   */
  Inactive: "Inactive",
}

/**
 * Cross-tenant vault mapping properties for cross-tenant restore.
 */
@added(Versions.v2026_08_31_preview)
model CrossTenantVaultMappingProperties {
  /**
   * ARM resource ID of the source backup vault whose data can be restored across tenants.
   */
  sourceVaultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DataProtection/backupVaults";
    }
  ]>;

  /**
   * Timestamp when the cross-tenant vault mapping was created.
   */
  @visibility(Lifecycle.Read)
  createdTime?: utcDateTime;

  /**
   * ResourceGuardOperationRequests on which the MUA (LAC) check will be performed.
   */
  resourceGuardOperationRequests?: string[];

  /**
   * Tenant ID of the source vault in the cross-tenant vault mapping.
   */
  @visibility(Lifecycle.Read)
  sourceTenantId?: string;

  /**
   * Provisioning state of the cross-tenant vault mapping.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Response for the cross-tenant vault mapping status check, from the source vault side.
 */
@added(Versions.v2026_08_31_preview)
model CrossTenantVaultMappingStatusResponse {
  /**
   * Name of the cross-tenant vault mapping, if the source vault is mapped.
   */
  mappingName?: string;

  /**
   * Current state of the cross-tenant vault mapping.
   */
  mappingState?: VaultMappingState;
}

/**
 * List of cross-tenant vault mapping resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Composition is used here to reuse the common DppResourceList paging model."
@added(Versions.v2026_08_31_preview)
model CrossTenantVaultMappingList extends DppResourceList {
  /**
   * List of resources.
   */
  @pageItems
  value?: CrossTenantVaultMapping[];
}

/**
 * Cross-tenant vault mapping resource for cross-tenant restore.
 */
@added(Versions.v2026_08_31_preview)
@parentResource(BackupVaultResource)
model CrossTenantVaultMapping
  is Azure.ResourceManager.ProxyResource<CrossTenantVaultMappingProperties> {
  ...ResourceNameParameter<
    Resource = CrossTenantVaultMapping,
    KeyName = "mappingName",
    SegmentName = "crossTenantVaultMappings",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Cross-tenant vault mappings are removed via the POST 'remove' action (RBAC separation-of-duties + Resource Guard / MUA body semantics), not a DELETE verb."
@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface DppCrossTenantVaultMappings {
  /**
   * Gets a cross-tenant vault mapping by name from the target vault.
   */
  get is ArmResourceRead<CrossTenantVaultMapping, Error = CloudError>;

  /**
   * Creates or updates a cross-tenant vault mapping under the target vault.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CrossTenantVaultMapping,
    Error = CloudError
  >;

  /**
   * Lists the cross-tenant vault mappings under the target vault.
   */
  @list
  list is ArmResourceListByParent<
    CrossTenantVaultMapping,
    Response = ArmResponse<CrossTenantVaultMappingList>,
    Error = CloudError
  >;

  /**
   * Removes a cross-tenant vault mapping from the target vault.
   */
  @action("remove")
  remove is ArmResourceActionSync<
    CrossTenantVaultMapping,
    void,
    OkResponse,
    Error = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface DppCrossTenantVaultMappingStatus {
  /**
   * Gets the status (Active/Inactive) of a cross-tenant vault mapping from the source vault side.
   */
  @action("crossTenantVaultMappingStatus")
  check is ArmResourceActionSync<
    BackupVaultResource,
    void,
    CrossTenantVaultMappingStatusResponse,
    Error = CloudError
  >;
}

@@doc(
  CrossTenantVaultMapping.name,
  "The name of the cross-tenant vault mapping."
);
@@doc(
  CrossTenantVaultMapping.properties,
  "CrossTenantVaultMapping properties."
);

// ---------------------------------------------------------------------------
// Cross-tenant pass-through legs. These reuse existing DPP body models
// (BackupInstanceResource, AzureBackupRecoveryPointResource, AzureBackupJobResource,
// OperationResource, OperationJobExtendedInfo) on deep routes under an active
// cross-tenant vault mapping. A TypeSpec resource can have only one @parentResource,
// so the existing body models cannot be re-parented under the mapping; LegacyOperations
// reuses them on the custom cross-tenant route without duplicating the resource type.
// ---------------------------------------------------------------------------

// Backup-instance level ops (list/get + restore/validateRestore/findRestorableTimeRanges),
// parented at /backupVaults/{vaultName}/crossTenantVaultMappings/{mappingName}.
@armResourceOperations
interface BackupInstanceFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = CrossTenantVaultMapping,
          KeyName = "mappingName",
          SegmentName = "crossTenantVaultMappings",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupInstanceResource,
        KeyName = "backupInstanceName",
        SegmentName = "backupInstances",
        NamePattern = ""
      >>
    > {}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BackupInstancesFromDppCrossTenantVault {
  /**
   * Lists the backup instances of the mapped source vault in a different tenant.
   */
  list is BackupInstanceFromCrossTenantVaultOps.List<
    BackupInstanceResource,
    Response = ArmResponse<BackupInstanceResourceList>,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BackupInstanceFromDppCrossTenantVault {
  /**
   * Gets a backup instance of the mapped source vault in a different tenant.
   */
  get is BackupInstanceFromCrossTenantVaultOps.Read<
    BackupInstanceResource,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface RestoresFromDppCrossTenantVault {
  /**
   * Triggers restore for a backup instance of the mapped source vault in a different tenant.
   */
  @action("restore")
  trigger is BackupInstanceFromCrossTenantVaultOps.ActionAsync<
    BackupInstanceResource,
    AzureBackupRestoreRequest,
    OperationJobExtendedInfo,
    Response =
      | OperationJobExtendedInfo
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface ValidateRestoreFromDppCrossTenantVault {
  /**
   * Validates whether restore can be triggered for a backup instance of the mapped source vault in a different tenant.
   */
  @action("validateRestore")
  trigger is BackupInstanceFromCrossTenantVaultOps.ActionAsync<
    BackupInstanceResource,
    ValidateRestoreRequestObject,
    OperationJobExtendedInfo,
    Response =
      | OperationJobExtendedInfo
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface RestorableTimeRangesFromDppCrossTenantVault {
  /**
   * Finds the restorable time ranges for a backup instance of the mapped source vault in a different tenant.
   */
  @action("findRestorableTimeRanges")
  find is BackupInstanceFromCrossTenantVaultOps.ActionSync<
    BackupInstanceResource,
    AzureBackupFindRestorableTimeRangesRequest,
    ArmResponse<AzureBackupFindRestorableTimeRangesResponseResource>,
    OverrideErrorType = CloudError
  >;
}

// Recovery-point level ops (list/get), parented at the backup instance under the mapping.
@armResourceOperations
interface RecoveryPointFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = CrossTenantVaultMapping,
          KeyName = "mappingName",
          SegmentName = "crossTenantVaultMappings",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupInstanceResource,
          KeyName = "backupInstanceName",
          SegmentName = "backupInstances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = AzureBackupRecoveryPointResource,
        KeyName = "recoveryPointId",
        SegmentName = "recoveryPoints",
        NamePattern = ""
      >>
    > {}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface RecoveryPointsFromDppCrossTenantVault {
  /**
   * Lists the vault-tier recovery points for a backup instance of the mapped source vault in a different tenant.
   */
  list is RecoveryPointFromCrossTenantVaultOps.List<
    AzureBackupRecoveryPointResource,
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
    Response = ArmResponse<AzureBackupRecoveryPointResourceList>,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface RecoveryPointFromDppCrossTenantVault {
  /**
   * Gets a vault-tier recovery point for a backup instance of the mapped source vault in a different tenant.
   */
  get is RecoveryPointFromCrossTenantVaultOps.Read<
    AzureBackupRecoveryPointResource,
    OverrideErrorType = CloudError
  >;
}

// Job level ops (list/get), parented at the cross-tenant vault mapping.
@armResourceOperations
interface JobFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = CrossTenantVaultMapping,
          KeyName = "mappingName",
          SegmentName = "crossTenantVaultMappings",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = AzureBackupJobResource,
        KeyName = "jobId",
        SegmentName = "backupJobs",
        NamePattern = ""
      >>
    > {}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BackupJobsFromDppCrossTenantVault {
  /**
   * Lists the jobs of the mapped source vault in a different tenant.
   */
  list is JobFromCrossTenantVaultOps.List<
    AzureBackupJobResource,
    Response = ArmResponse<AzureBackupJobResourceList>,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface JobFromDppCrossTenantVault {
  /**
   * Gets a job of the mapped source vault in a different tenant.
   */
  get is JobFromCrossTenantVaultOps.Read<
    AzureBackupJobResource,
    OverrideErrorType = CloudError
  >;
}

// Operation-status poller, parented at the backup instance under the mapping.
@armResourceOperations
interface BackupInstanceOperationStatusFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = CrossTenantVaultMapping,
          KeyName = "mappingName",
          SegmentName = "crossTenantVaultMappings",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupInstanceResource,
          KeyName = "backupInstanceName",
          SegmentName = "backupInstances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupInstanceResource,
        KeyName = "operationId",
        SegmentName = "operationStatus",
        NamePattern = ""
      >>
    > {}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BackupInstanceOperationStatusFromDppCrossTenantVault {
  /**
   * Gets the status of a cross-tenant operation (e.g. a cross-tenant restore) for a backup instance of the mapped source vault.
   */
  get is BackupInstanceOperationStatusFromCrossTenantVaultOps.Read<
    OperationResource,
    OverrideErrorType = CloudError
  >;
}

/**
 * Accepted (202) response for the cross-tenant operation-result poller: carries the Location header
 * the caller polls (plus Retry-After) while the long-running operation is still in progress.
 */
@added(Versions.v2026_08_31_preview)
model CrossTenantOperationResultAcceptedResponse {
  /**
   * The HTTP 202 status code indicating the cross-tenant operation is still in progress.
   */
  @statusCode statusCode: 202;

  /**
   * The URL to poll for the operation result while it is still in progress.
   */
  @header("Location") location?: string;

  /**
   * The recommended number of seconds to wait before polling again.
   */
  @header("Retry-After") retryAfter?: int32;
}

// Operation-result poller (Location-header LRO), parented at the backup instance under the mapping.
@armResourceOperations
interface BackupInstanceOperationResultFromCrossTenantVaultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupVaultResource,
          KeyName = "vaultName",
          SegmentName = "backupVaults",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = CrossTenantVaultMapping,
          KeyName = "mappingName",
          SegmentName = "crossTenantVaultMappings",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = BackupInstanceResource,
          KeyName = "backupInstanceName",
          SegmentName = "backupInstances",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BackupInstanceResource,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BackupInstanceOperationResultFromDppCrossTenantVault {
  /**
   * Fetches the result of a cross-tenant operation (e.g. a cross-tenant restore) for a backup instance of the
   * mapped source vault - the leg the restore's Location header points at. Returns 202 with Location/Retry-After
   * while pending, and 200 with the operation result body when complete.
   */
  get is BackupInstanceOperationResultFromCrossTenantVaultOps.Read<
    OperationJobExtendedInfo,
    Response =
      | ArmResponse<OperationJobExtendedInfo>
      | CrossTenantOperationResultAcceptedResponse,
    OverrideErrorType = CloudError
  >;
}

@@doc(
  RestoresFromDppCrossTenantVault.trigger::parameters.body,
  "Request body for operation"
);
@@doc(
  ValidateRestoreFromDppCrossTenantVault.trigger::parameters.body,
  "Request body for operation"
);
@@doc(
  RestorableTimeRangesFromDppCrossTenantVault.find::parameters.body,
  "Request body for operation"
);
