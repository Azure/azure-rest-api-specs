import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A managed instance operation.")
@parentResource(ManagedInstance)
model ManagedInstanceOperation
  is ProxyResource<ManagedInstanceOperationProperties> {
  @path
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
