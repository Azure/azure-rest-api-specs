import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DataReplicationVault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Protected item model.")
@parentResource(DataReplicationVault)
model DataReplicationProtectedItem
  is ProxyResource<ProtectedItemModelProperties> {
  @doc("The protected item name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("protectedItemName")
  @segment("protectedItems")
  name: string;
}

@armResourceOperations
interface DataReplicationProtectedItems {
  @doc("Gets the details of the protected item.")
  get is ArmResourceRead<DataReplicationProtectedItem>;
  @doc("Creates the protected item.")
  create is ArmResourceCreateOrUpdateAsync<DataReplicationProtectedItem>;
  @doc("Removes the protected item.")
  delete is ArmResourceDeleteWithoutOkAsync<
    DataReplicationProtectedItem,
    {
      ...BaseParameters<DataReplicationProtectedItem>;

      @doc("A flag indicating whether to do force delete or not.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;
  @doc("Gets the list of protected items in the given vault.")
  list is ArmResourceListByParent<DataReplicationProtectedItem>;
  @doc("Performs the planned failover on the protected item.")
  plannedFailover is ArmResourceActionAsync<
    DataReplicationProtectedItem,
    PlannedFailoverModel,
    PlannedFailoverModel
  >;
}
