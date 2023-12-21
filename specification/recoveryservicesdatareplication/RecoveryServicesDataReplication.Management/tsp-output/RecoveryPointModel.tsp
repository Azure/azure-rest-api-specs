import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.RecoveryServicesDataReplication;
@doc("Recovery point model.")
@parentResource(ProtectedItemModel)
model RecoveryPointModel is ProxyResource<RecoveryPointModelProperties> {
  @doc("The recovery point name.")
  @pattern("^[a-zA-Z0-9]*$")
  @path
  @key("recoveryPointName")
  @segment("recoveryPoints")
  name: string;
}

@armResourceOperations
interface RecoveryPoints {
  @doc("Gets the details of the recovery point of a protected item.")
  get is ArmResourceRead<RecoveryPointModel>;
  @doc("Gets the list of recovery points of the given protected item.")
  list is ArmResourceListByParent<RecoveryPointModel>;
}
