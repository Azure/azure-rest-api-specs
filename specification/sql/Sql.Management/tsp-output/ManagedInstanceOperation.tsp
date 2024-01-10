import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A managed instance operation.")
@parentResource(ManagedInstance)
model ManagedInstanceOperation
  is ProxyResource<ManagedInstanceOperationProperties> {
  @key("operationId")
  @segment("operations")
  name: string;
}

@armResourceOperations
interface ManagedInstanceOperations {
  @doc("Gets a management operation on a managed instance.")
  get is ArmResourceRead<ManagedInstanceOperation>;

  @doc("Gets a list of operations performed on the managed instance.")
  listByManagedInstance is ArmResourceListByParent<ManagedInstanceOperation>;

  @doc("Cancels the asynchronous operation on the managed instance.")
  cancel is ArmResourceActionSync<ManagedInstanceOperation, void, void>;
}
