import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A replication link.")
@parentResource(SqlDatabase)
model SqlServerDatabaseReplicationLink
  is ProxyResource<ReplicationLinkProperties> {
  @doc("The name of the replication link.")
  @path
  @key("linkId")
  @segment("replicationLinks")
  name: string;
}

@armResourceOperations
interface SqlServerDatabaseReplicationLinks {
  @doc("Gets a replication link.")
  get is ArmResourceRead<SqlServerDatabaseReplicationLink>;
  @doc("Deletes the replication link.")
  delete is ArmResourceDeleteAsync<SqlServerDatabaseReplicationLink>;
  @doc("Gets a list of replication links on database.")
  listByDatabase is ArmResourceListByParent<SqlServerDatabaseReplicationLink>;
  @doc("Fails over from the current primary server to this server.")
  failover is ArmResourceActionAsync<
    SqlServerDatabaseReplicationLink,
    void,
    SqlServerDatabaseReplicationLink
  >;
  @doc("Fails over from the current primary server to this server allowing data loss.")
  failoverAllowDataLoss is ArmResourceActionAsync<
    SqlServerDatabaseReplicationLink,
    void,
    SqlServerDatabaseReplicationLink
  >;
}
