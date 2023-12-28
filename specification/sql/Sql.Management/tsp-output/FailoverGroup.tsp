import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A failover group.")
@parentResource(Server)
model FailoverGroup is ProxyResource<FailoverGroupProperties> {
  @doc("The name of the failover group.")
  @key("failoverGroupName")
  @segment("failoverGroups")
  name: string;
}

@armResourceOperations
interface FailoverGroups {
  @doc("Gets a failover group.")
  get is ArmResourceRead<FailoverGroup>;
  @doc("Creates or updates a failover group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<FailoverGroup>;
  @doc("Updates a failover group.")
  update is ArmCustomPatchAsync<FailoverGroup, FailoverGroupUpdate>;
  @doc("Deletes a failover group.")
  delete is ArmResourceDeleteAsync<FailoverGroup>;
  @doc("Lists the failover groups in a server.")
  listByServer is ArmResourceListByParent<FailoverGroup>;
  @doc("Fails over from the current primary server to this server.")
  failover is ArmResourceActionAsync<FailoverGroup, void, FailoverGroup>;
  @doc("Fails over from the current primary server to this server. This operation might result in data loss.")
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    FailoverGroup,
    void,
    FailoverGroup
  >;
  @doc("Fails over from the current primary server to this server. This operation tries planned before forced failover but might still result in data loss.")
  tryPlannedBeforeForcedFailover is ArmResourceActionAsync<
    FailoverGroup,
    void,
    FailoverGroup
  >;
}
