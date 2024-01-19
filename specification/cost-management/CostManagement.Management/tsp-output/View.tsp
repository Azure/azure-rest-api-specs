import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CostManagement;
@doc("States and configurations of Cost Analysis.")
@tenantResource
model View is ProxyResource<ViewProperties> {
  @doc("View name")
  @path
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

@@projectedName(Views.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Views.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Views.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateOrUpdate View operation."
);
