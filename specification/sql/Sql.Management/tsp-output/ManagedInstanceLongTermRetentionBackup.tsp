import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A long term retention backup for a managed database.")
@locationResource
model ManagedInstanceLongTermRetentionBackup
  is ProxyResource<ManagedInstanceLongTermRetentionBackupProperties> {
  @doc("The backup name.")
  @key("backupName")
  @segment("longTermRetentionManagedInstanceBackups")
  name: string;
}

@armResourceOperations
@projectedName("client", "LongTermRetentionManagedInstanceBackups")
interface ManagedInstanceLongTermRetentionBackups_LongTermRetentionManagedInstanceBackups {
  @doc("Gets a long term retention backup for a managed database.")
  get is ArmResourceRead<ManagedInstanceLongTermRetentionBackup>;

  @doc("Deletes a long term retention backup.")
  delete is ArmResourceDeleteAsync<ManagedInstanceLongTermRetentionBackup>;

  @doc("Lists all long term retention backups for a managed database.")
  listByDatabase is ArmResourceListByParent<
    ManagedInstanceLongTermRetentionBackup,
    {
      ...BaseParameters<ManagedInstanceLongTermRetentionBackup>;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
}
