import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VaultModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataReplication;
@doc("Protected item model.")
@parentResource(VaultModel)
model ProtectedItemModel is ProxyResource<ProtectedItemModelProperties> {
  @doc("The protected item name.")
  @pattern("^[a-zA-Z0-9]*$")
  @key("protectedItemName")
  @segment("protectedItems")
  name: string;
}

@armResourceOperations
@projectedName("client", "ProtectedItem")
interface ProtectedItemModels_ProtectedItem {
  @doc("Gets the details of the protected item.")
  get is ArmResourceRead<ProtectedItemModel>;

  @doc("Creates the protected item.")
  create is ArmResourceCreateOrUpdateAsync<ProtectedItemModel>;

  @doc("Removes the protected item.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ProtectedItemModel,
    {
      ...BaseParameters<ProtectedItemModel>;

      @doc("A flag indicating whether to do force delete or not.")
      @query("forceDelete")
      forceDelete?: boolean;
    }
  >;

  @doc("Gets the list of protected items in the given vault.")
  list is ArmResourceListByParent<ProtectedItemModel>;

  @doc("Performs the planned failover on the protected item.")
  plannedFailover is ArmResourceActionAsync<
    ProtectedItemModel,
    PlannedFailoverModel,
    PlannedFailoverModel
  >;
}
