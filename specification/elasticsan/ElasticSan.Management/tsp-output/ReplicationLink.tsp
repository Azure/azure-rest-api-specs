import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A replication link.")
@parentResource(Database)
model ReplicationLink is ProxyResource<ReplicationLinkProperties> {
  @doc("The name of the replication link.")
  @path
  @key("linkId")
  @segment("replicationLinks")
  name: string;
}

@armResourceOperations
interface ReplicationLinks {
  @doc("Gets a replication link.")
  get is ArmResourceRead<ReplicationLink>;

  @doc("Deletes the replication link.")
  delete is ArmResourceDeleteAsync<ReplicationLink>;

  @doc("Gets a list of replication links on database.")
  listByDatabase is ArmResourceListByParent<ReplicationLink>;

  @doc("Fails over from the current primary server to this server.")
  failover is ArmResourceActionAsync<ReplicationLink, void, ReplicationLink>;

  @doc("Fails over from the current primary server to this server allowing data loss.")
  failoverAllowDataLoss is ArmResourceActionAsync<
    ReplicationLink,
    void,
    ReplicationLink
  >;
}
