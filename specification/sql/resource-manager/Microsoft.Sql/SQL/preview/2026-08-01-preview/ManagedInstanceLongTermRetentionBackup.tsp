import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Sql;
/**
 * A long term retention backup for a managed database.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@subscriptionResource
@Azure.ResourceManager.Legacy.feature(
  Features.LongTermRetentionManagedInstanceBackups
)
model ManagedInstanceLongTermRetentionBackup
  is Azure.ResourceManager.ProxyResource<ManagedInstanceLongTermRetentionBackupProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceLongTermRetentionBackup,
    KeyName = "backupName",
    SegmentName = "longTermRetentionManagedInstanceBackups",
    NamePattern = ""
  >;
}

alias ManagedInstanceLongTermRetentionBackupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    locationName: Azure.Core.azureLocation;

    /** The name of the managed instance. */
    @path
    @segment("longTermRetentionManagedInstances")
    @key
    managedInstanceName: string;

    /** The name of the managed database. */
    @path
    @segment("longTermRetentionDatabases")
    @key
    databaseName: string;
  },
  {
    /** The backup name. */
    @path
    @segment("longTermRetentionManagedInstanceBackups")
    @key
    backupName: string;
  },
  ResourceName = "SubscriptionLongTermRetentionManagedInstanceBackup"
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
@Azure.ResourceManager.Legacy.feature(
  Features.LongTermRetentionManagedInstanceBackups
)
interface ManagedInstanceLongTermRetentionBackups {
  /**
   * Gets a long term retention backup for a managed database.
   */
  @tag("LongTermRetentionManagedInstanceBackups")
  get is ManagedInstanceLongTermRetentionBackupOps.Read<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LongTermRetentionManagedInstanceBackups")
  delete is ManagedInstanceLongTermRetentionBackupOps.DeleteWithoutOkAsync<
    ManagedInstanceLongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lock time based immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @tag("LongTermRetentionManagedInstanceBackups")
  lockTimeBasedImmutability is ManagedInstanceLongTermRetentionBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Remove legal hold immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @tag("LongTermRetentionManagedInstanceBackups")
  removeLegalHoldImmutability is ManagedInstanceLongTermRetentionBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Remove time based immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @tag("LongTermRetentionManagedInstanceBackups")
  removeTimeBasedImmutability is ManagedInstanceLongTermRetentionBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Set legal hold immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @tag("LongTermRetentionManagedInstanceBackups")
  setLegalHoldImmutability is ManagedInstanceLongTermRetentionBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Lists all long term retention backups for a managed database.
   */
  @tag("LongTermRetentionManagedInstanceBackups")
  listByDatabase is ManagedInstanceLongTermRetentionBackupOps.List<
    ManagedInstanceLongTermRetentionBackup,
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
}
alias LongTermRetentionManagedInstanceBackupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location of the database. */
    @path
    @segment("locations")
    @key
    locationName: Azure.Core.azureLocation;

    /** The name of the managed instance. */
    @path
    @segment("longTermRetentionManagedInstances")
    @key
    managedInstanceName: string;

    /** The name of the managed database. */
    @path
    @segment("longTermRetentionDatabases")
    @key
    databaseName: string;
  },
  {
    /** The backup name. */
    @path
    @segment("longTermRetentionManagedInstanceBackups")
    @key
    backupName: string;
  },
  ResourceName = "ResourceGroupLongTermRetentionManagedInstanceBackup"
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Features.LongTermRetentionManagedInstanceBackups
)
interface LongTermRetentionManagedInstanceBackups {
  /**
   * Gets a long term retention backup for a managed database.
   */
  getByResourceGroup is LongTermRetentionManagedInstanceBackupOps.Read<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  deleteByResourceGroup is LongTermRetentionManagedInstanceBackupOps.DeleteWithoutOkAsync<
    ManagedInstanceLongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lock time based immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @action("lockTimeBasedImmutability")
  lockTimeBasedImmutabilityByResourceGroup is LongTermRetentionManagedInstanceBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Remove legal hold immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @action("removeLegalHoldImmutability")
  removeLegalHoldImmutabilityByResourceGroup is LongTermRetentionManagedInstanceBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Remove time based immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @action("removeTimeBasedImmutability")
  removeTimeBasedImmutabilityByResourceGroup is LongTermRetentionManagedInstanceBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Set legal hold immutability of an existing managed instance long term retention backup.
   */
  @added(Versions.v2026_08_01_preview)
  @action("setLegalHoldImmutability")
  setLegalHoldImmutabilityByResourceGroup is LongTermRetentionManagedInstanceBackupOps.ActionAsync<
    ManagedInstanceLongTermRetentionBackup,
    void,
    void,
    Response =
      | ArmResponse<ManagedInstanceLongTermRetentionBackup>
      | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionBackup>>
  >;

  /**
   * Lists all long term retention backups for a managed database.
   */
  listByResourceGroupDatabase is LongTermRetentionManagedInstanceBackupOps.List<
    ManagedInstanceLongTermRetentionBackup,
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
}

@@doc(ManagedInstanceLongTermRetentionBackup.name, "The backup name.");
@@doc(
  ManagedInstanceLongTermRetentionBackup.properties,
  "Resource properties."
);
