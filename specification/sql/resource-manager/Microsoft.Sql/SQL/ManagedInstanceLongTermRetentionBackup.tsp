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
 * A long term retention backup for a managed database.
 */
@subscriptionResource
model ManagedInstanceLongTermRetentionBackup
  is Azure.ResourceManager.ProxyResource<ManagedInstanceLongTermRetentionBackupProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceLongTermRetentionBackup,
    KeyName = "backupName",
    SegmentName = "longTermRetentionManagedInstanceBackups",
    NamePattern = ""
  >;
}

alias ManagedInstanceLongTermRetentionBackupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  {},
  {
    /** The backup name. */
    @path
    @segment("longTermRetentionManagedInstanceBackups")
    @key
    backupName: string;
  }
>;

@armResourceOperations
interface ManagedInstanceLongTermRetentionBackups {
  /**
   * Gets a long term retention backup for a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_Get")
  get is ManagedInstanceLongTermRetentionBackupOps.Read<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("LongTermRetentionManagedInstanceBackups_Delete")
  delete is ManagedInstanceLongTermRetentionBackupOps.DeleteWithoutOkAsync<
    ManagedInstanceLongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Lists all long term retention backups for a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByDatabase")
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
    locationName: string;

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
  }
>;

@armResourceOperations
interface LongTermRetentionManagedInstanceBackups {
  /**
   * Gets a long term retention backup for a managed database.
   */
  getByResourceGroup is LongTermRetentionManagedInstanceBackupOps.Read<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  deleteByResourceGroup is LongTermRetentionManagedInstanceBackupOps.DeleteWithoutOkAsync<
    ManagedInstanceLongTermRetentionBackup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse
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
@@doc(ManagedInstanceLongTermRetentionBackup.properties,
  "Resource properties."
);
