import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CostManagement;
@doc("States and configurations of Cost Analysis.")
@tenantResource
model View is ProxyResource<ViewProperties> {
  @doc("View name")
  @key("viewName")
  @segment("views")
  name: string;
}

@armResourceOperations
interface Views {
  @doc("Gets the view by view name.")
  get is ArmResourceRead<View>;
  @doc("The operation to create or update a view. Update operation requires latest eTag to be set in the request. You may obtain the latest eTag by performing a get operation. Create operation does not require eTag.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<View>;
  @doc("The operation to delete a view.")
  delete is ArmResourceDeleteSync<View>;
}
