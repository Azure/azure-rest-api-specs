import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;
@doc("API entity.")
@parentResource(Workspace)
model Api is ProxyResource<ApiProperties> {
  @doc("The name of the API.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("apiName")
  @segment("apis")
  name: string;
}

@armResourceOperations
interface Apis {
  @doc("Returns details of the API.")
  get is ArmResourceRead<Api>;
  @doc("Checks if specified API exists.")
  @head
  head(
    ...ResourceInstanceParameters<Api, BaseParameters<Api>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing API.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Api>;
  @doc("Deletes specified API.")
  delete is ArmResourceDeleteSync<Api>;
  @doc("Returns a collection of APIs.")
  list is ArmResourceListByParent<Api>;
}
