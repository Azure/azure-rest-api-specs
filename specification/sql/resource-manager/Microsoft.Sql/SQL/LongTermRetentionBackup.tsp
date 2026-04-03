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

alias LongTermRetentionBackupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    },
    Response = LongTermRetentionBackupListResult
  >;

  /**
   * Change a long term retention backup access tier.
   */
  changeAccessTier is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    ChangeLongTermRetentionBackupAccessTierParameters,
    Result = void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Copy an existing long term retention backup.
   */
  copy is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    CopyLongTermRetentionBackupParameters,
    void,
    Response = ArmResponse<LongTermRetentionBackupOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackupOperationResult>>
  >;

  /**
   * Lock time based immutability of an existing long term retention backup.
   */
  lockTimeBasedImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Remove legal hold immutability of an existing long term retention backup.
   */
  removeLegalHoldImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Remove time based immutability of an existing long term retention backup.
   */
  removeTimeBasedImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Set legal hold immutability of an existing long term retention backup.
   */
  setLegalHoldImmutability is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Updates an existing long term retention backup.
   */
  update is LongTermRetentionBackupOps.ActionAsync<
    LongTermRetentionBackup,
    UpdateLongTermRetentionBackupParameters,
    void,
    Response = ArmResponse<LongTermRetentionBackupOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackupOperationResult>>
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

@armResourceOperations(#{ omitTags: true })
interface LongTermRetentionBackupOperationGroup {
  /**
   * Gets a long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  getByResourceGroup is LongTermRetentionBackupOperationGroupOps.Read<LongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LongTermRetentionBackups")
  deleteByResourceGroup is LongTermRetentionBackupOperationGroupOps.DeleteWithoutOkAsync<
    LongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lists all long term retention backups for a database based on a particular resource group.
   */
  @tag("LongTermRetentionBackups")
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
    },
    Response = LongTermRetentionBackupListResult
  >;

  /**
   * Change a long term retention backup access tier.
   */
  @tag("LongTermRetentionBackups")
  @action("changeAccessTier")
  changeAccessTierByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    ChangeLongTermRetentionBackupAccessTierParameters,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Copy an existing long term retention backup to a different server.
   */
  @tag("LongTermRetentionBackups")
  @action("copy")
  copyByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    CopyLongTermRetentionBackupParameters,
    void,
    Response = ArmResponse<LongTermRetentionBackupOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackupOperationResult>>
  >;

  /**
   * Lock time based immutability of an existing long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  @action("lockTimeBasedImmutability")
  lockTimeBasedImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Remove legal hold immutability of an existing long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  @action("removeLegalHoldImmutability")
  removeLegalHoldImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Remove time based immutability of an existing long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  @action("removeTimeBasedImmutability")
  removeTimeBasedImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Set legal hold immutability of an existing long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  @action("setLegalHoldImmutability")
  setLegalHoldImmutabilityByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    void,
    void,
    Response = ArmResponse<LongTermRetentionBackup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackup>>
  >;

  /**
   * Updates an existing long term retention backup.
   */
  @tag("LongTermRetentionBackups")
  @action("update")
  updateByResourceGroup is LongTermRetentionBackupOperationGroupOps.ActionAsync<
    LongTermRetentionBackup,
    UpdateLongTermRetentionBackupParameters,
    void,
    Response = ArmResponse<LongTermRetentionBackupOperationResult> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionBackupOperationResult>>
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
