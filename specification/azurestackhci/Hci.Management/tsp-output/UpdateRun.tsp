import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Update.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
@doc("Details of an Update run")
@parentResource(Update)
model UpdateRun is ProxyResource<UpdateRunProperties> {
  @doc("The name of the Update Run")
  @path
  @key("updateRunName")
  @segment("updateRuns")
  name: string;
}

@armResourceOperations
interface UpdateRuns {
  @doc("Get the Update run for a specified update")
  get is ArmResourceRead<UpdateRun>;

  @doc("Put Update runs for a specified update")
  put is ArmResourceCreateOrReplaceSync<UpdateRun>;

  @doc("Delete specified Update Run")
  delete is ArmResourceDeleteAsync<
    UpdateRun,
    BaseParameters<UpdateRun>,
    ArmAsyncOperationHeader
  >;

  @doc("List all Update runs for a specified update")
  list is ArmResourceListByParent<UpdateRun>;
}

@@projectedName(UpdateRuns.put::parameters.resource,
  "json",
  "updateRunsProperties"
);
@@extension(UpdateRuns.put::parameters.resource,
  "x-ms-client-name",
  "updateRunsProperties"
);
@@doc(UpdateRuns.put::parameters.resource,
  "Properties of the updateRuns object"
);
