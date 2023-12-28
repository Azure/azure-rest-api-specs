import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An instance failover group.")
model InstanceFailoverGroup is ProxyResource<InstanceFailoverGroupProperties> {
  @doc("The name of the failover group.")
  @key("failoverGroupName")
  @segment("instanceFailoverGroups")
  name: string;
}

@armResourceOperations
interface InstanceFailoverGroups {
  @doc("Gets a failover group.")
  get is ArmResourceRead<InstanceFailoverGroup>;
  @doc("Creates or updates a failover group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InstanceFailoverGroup>;
  @doc("Deletes a failover group.")
  delete is ArmResourceDeleteAsync<InstanceFailoverGroup>;
  @doc("Lists the failover groups in a location.")
  listByLocation is ArmResourceListByParent<InstanceFailoverGroup>;
  @doc("Fails over from the current primary managed instance to this managed instance.")
  failover is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    InstanceFailoverGroup
  >;
  @doc("Fails over from the current primary managed instance to this managed instance. This operation might result in data loss.")
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    InstanceFailoverGroup
  >;
}
