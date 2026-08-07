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
   * Name of the cross-tenant vault mapping.
   */
  @visibility(Lifecycle.Read)
  mappingName?: string;

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
interface CrossTenantVaultMappings {
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
interface CrossTenantVaultMappingStatus {
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
interface BackupInstancesFromCrossTenantVault {
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
interface BackupInstanceFromCrossTenantVault {
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
interface RestoresFromCrossTenantVault {
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
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface ValidateRestoreFromCrossTenantVault {
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
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = OperationJobExtendedInfo>>,
    OverrideErrorType = CloudError
  >;
}

@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface RestorableTimeRangesFromCrossTenantVault {
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
interface RecoveryPointsFromCrossTenantVault {
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
interface RecoveryPointFromCrossTenantVault {
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
interface BackupJobsFromCrossTenantVault {
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
interface JobFromCrossTenantVault {
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
interface BackupInstanceOperationStatusFromCrossTenantVault {
  /**
   * Gets the status of a cross-tenant operation (e.g. a cross-tenant restore) for a backup instance of the mapped source vault.
   */
  get is BackupInstanceOperationStatusFromCrossTenantVaultOps.Read<
    OperationResource,
    OverrideErrorType = CloudError
  >;
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
interface BackupInstanceOperationResultFromCrossTenantVault {
  /**
   * Fetches the result of a cross-tenant operation (e.g. a cross-tenant restore) for a backup instance of the
   * mapped source vault - the leg the restore's Location header points at. Returns 202 with Location/Retry-After
   * while pending, and 200 with the operation result body when complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "BMS/DPP async operation-result GET is a Location-header LRO poller (202 while pending, 200 with body when done) - the frozen BMS-wide wire every existing Azure-Backup SDK/CLI poller depends on."
  get is BackupInstanceOperationResultFromCrossTenantVaultOps.Read<
    OperationJobExtendedInfo,
    Response = ArmResponse<OperationJobExtendedInfo> | AcceptedResponse,
    OverrideErrorType = CloudError
  >;
}

@@doc(
  RestoresFromCrossTenantVault.trigger::parameters.body,
  "Request body for operation"
);
@@doc(
  ValidateRestoreFromCrossTenantVault.trigger::parameters.body,
  "Request body for operation"
);
@@doc(
  RestorableTimeRangesFromCrossTenantVault.find::parameters.body,
  "Request body for operation"
);
