import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProtectedItemModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
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
interface RecoveryPointModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the details of the recovery point of a protected item.")
  @operationId("RecoveryPoints_Get")
  get is ArmResourceRead<RecoveryPointModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of recovery points of the given protected item.")
  @operationId("RecoveryPoints_List")
  list is ArmResourceListByParent<RecoveryPointModel>;
}
