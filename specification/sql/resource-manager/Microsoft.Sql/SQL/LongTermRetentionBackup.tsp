import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A long term retention backup.
 */
@subscriptionResource
model LongTermRetentionBackup
  is Azure.ResourceManager.ProxyResource<LongTermRetentionBackupProperties> {
  ...ResourceNameParameter<
    Resource = LongTermRetentionBackup,
    KeyName = "backupName",
    SegmentName = "longTermRetentionBackups",
    NamePattern = ""
  >;
}

alias LongTermRetentionBackupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Sql";

    /** The location of the database. */
    @path
    @segment("locations")
    @key
    locationName: string;

    /** The name of the server */
    @path
    @segment("longTermRetentionServers")
    @key
    longTermRetentionServerName: string;

    /** The name of the database */
    @path
    @segment("longTermRetentionDatabases")
    @key
    longTermRetentionDatabaseName: string;
  },
  {},
  {
    /** The backup name. */
    @path
    @segment("longTermRetentionBackups")
    @key
    backupName: string;
  }
>;

@armResourceOperations
interface LongTermRetentionBackups {
  /**
   * Gets a long term retention backup.
   */
  get is LongTermRetentionBackupOps.Read<LongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is LongTermRetentionBackupOps.DeleteWithoutOkAsync<
    LongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lists all long term retention backups for a database.
   */
  listByDatabase is LongTermRetentionBackupOps.List<
    LongTermRetentionBackup,
    Parameters = {
      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;

  /**
   * Change a long term retention backup access tier.
   */
  changeAccessTier is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    ChangeLongTermRetentionBackupAccessTierParameters,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Copy an existing long term retention backup.
   */
  copy is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    CopyLongTermRetentionBackupParameters,
    ArmResponse<LongTermRetentionBackupOperationResult>
  >;

  /**
   * Lock time based immutability of an existing long term retention backup.
   */
  lockTimeBasedImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Remove legal hold immutability of an existing long term retention backup.
   */
  removeLegalHoldImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Remove time based immutability of an existing long term retention backup.
   */
  removeTimeBasedImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Set legal hold immutability of an existing long term retention backup.
   */
  setLegalHoldImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Updates an existing long term retention backup.
   */
  update is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    UpdateLongTermRetentionBackupParameters,
    ArmResponse<LongTermRetentionBackupOperationResult>
  >;
}
alias LongTermRetentionBackupOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location of the database. */
    @path
    @segment("locations")
    @key
    locationName: string;

    /** The name of the server */
    @path
    @segment("longTermRetentionServers")
    @key
    longTermRetentionServerName: string;

    /** The name of the database */
    @path
    @segment("longTermRetentionDatabases")
    @key
    longTermRetentionDatabaseName: string;
  },
  {
    /** The backup name. */
    @path
    @segment("longTermRetentionBackups")
    @key
    backupName: string;
  }
>;

@armResourceOperations
interface LongTermRetentionBackupOperationGroup {
  /**
   * Gets a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_GetByResourceGroup")
  getByResourceGroup is LongTermRetentionBackupOperationGroupOps.Read<LongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("LongTermRetentionBackups_DeleteByResourceGroup")
  deleteByResourceGroup is LongTermRetentionBackupOperationGroupOps.DeleteWithoutOkAsync<
    LongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lists all long term retention backups for a database based on a particular resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ListByResourceGroupDatabase")
  listByResourceGroupDatabase is LongTermRetentionBackupOperationGroupOps.List<
    LongTermRetentionBackup,
    Parameters = {
      /**
       * Whether or not to only get the latest backup for each database.
       */
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      /**
       * Whether to query against just live databases, just deleted databases, or all databases.
       */
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;

  /**
   * Change a long term retention backup access tier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_ChangeAccessTierByResourceGroup")
  @action("changeAccessTier")
  changeAccessTierByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    ChangeLongTermRetentionBackupAccessTierParameters,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Copy an existing long term retention backup to a different server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_CopyByResourceGroup")
  @action("copy")
  copyByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    CopyLongTermRetentionBackupParameters,
    ArmResponse<LongTermRetentionBackupOperationResult>
  >;

  /**
   * Lock time based immutability of an existing long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_LockTimeBasedImmutabilityByResourceGroup")
  @action("lockTimeBasedImmutability")
  lockTimeBasedImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Remove legal hold immutability of an existing long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_RemoveLegalHoldImmutabilityByResourceGroup")
  @action("removeLegalHoldImmutability")
  removeLegalHoldImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Remove time based immutability of an existing long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_RemoveTimeBasedImmutabilityByResourceGroup")
  @action("removeTimeBasedImmutability")
  removeTimeBasedImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Set legal hold immutability of an existing long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_SetLegalHoldImmutabilityByResourceGroup")
  @action("setLegalHoldImmutability")
  setLegalHoldImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    ArmResponse<LongTermRetentionBackup>
  >;

  /**
   * Updates an existing long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionBackups_UpdateByResourceGroup")
  @action("update")
  updateByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    UpdateLongTermRetentionBackupParameters,
    ArmResponse<LongTermRetentionBackupOperationResult>
  >;
}

@@doc(LongTermRetentionBackup.name, "The backup name.");
@@doc(LongTermRetentionBackup.properties, "Resource properties.");
@@doc(LongTermRetentionBackups.changeAccessTier::parameters.body, "");
@@doc(LongTermRetentionBackups.copy::parameters.body,
  "The parameters needed for long term retention copy request"
);
@@doc(LongTermRetentionBackups.update::parameters.body,
  "The requested backup resource state"
);
@@doc(LongTermRetentionBackupOperationGroup.changeAccessTierByResourceGroup::parameters.body,
  ""
);
@@doc(LongTermRetentionBackupOperationGroup.copyByResourceGroup::parameters.body,
  "The parameters needed for long term retention copy request"
);
@@doc(LongTermRetentionBackupOperationGroup.updateByResourceGroup::parameters.body,
  "The requested backup resource state"
);
