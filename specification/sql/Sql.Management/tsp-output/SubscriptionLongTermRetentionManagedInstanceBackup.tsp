import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A long term retention backup for a managed database.")
@locationResource
model SubscriptionLongTermRetentionManagedInstanceBackup
  is ProxyResource<ManagedInstanceLongTermRetentionBackupProperties> {
  @doc("The backup name.")
  @path
  @key("backupName")
  @segment("longTermRetentionManagedInstanceBackups")
  name: string;
}

@armResourceOperations
interface SubscriptionLongTermRetentionManagedInstanceBackups {
  @doc("Gets a long term retention backup for a managed database.")
  get is ArmResourceRead<SubscriptionLongTermRetentionManagedInstanceBackup>;
  @doc("Deletes a long term retention backup.")
  delete is ArmResourceDeleteAsync<SubscriptionLongTermRetentionManagedInstanceBackup>;
  @doc("Lists all long term retention backups for a managed database.")
  listByDatabase is ArmResourceListByParent<
    SubscriptionLongTermRetentionManagedInstanceBackup,
    {
      ...BaseParameters<SubscriptionLongTermRetentionManagedInstanceBackup>;

      @doc("Whether or not to only get the latest backup for each database.")
      @query("onlyLatestPerDatabase")
      onlyLatestPerDatabase?: boolean;

      @doc("Whether to query against just live databases, just deleted databases, or all databases.")
      @query("databaseState")
      databaseState?: DatabaseState;
    }
  >;
}
