import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A long term retention backup for a managed database.
 */
@locationResource
model ManagedInstanceLongTermRetentionBackup
  is ProxyResource<ManagedInstanceLongTermRetentionBackupProperties> {
  /**
   * The backup name.
   */
  @path
  @key("backupName")
  @segment("longTermRetentionManagedInstanceBackups")
  name: string;
}

@armResourceOperations
interface ManagedInstanceLongTermRetentionBackups {
  /**
   * Gets a long term retention backup for a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LongTermRetentionManagedInstanceBackups_Get")
  get is ArmResourceRead<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Deletes a long term retention backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LongTermRetentionManagedInstanceBackups_Delete")
  delete is ArmResourceDeleteAsync<ManagedInstanceLongTermRetentionBackup>;

  /**
   * Lists all long term retention backups for a managed database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LongTermRetentionManagedInstanceBackups_ListByDatabase")
  listByDatabase is ArmResourceListByParent<
    ManagedInstanceLongTermRetentionBackup,
    {
      ...BaseParameters<ManagedInstanceLongTermRetentionBackup>;

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
