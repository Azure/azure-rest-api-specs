import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;

@added(Versions.v2024_06_01_preview)
@doc("API source entity.")
@parentResource(Workspace)
model ApiSource is ProxyResource<ApiSourceProperties> {
  @doc("The name of the API.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("apiSourceName")
  @segment("apiSources")
  name: string;
}

@added(Versions.v2024_06_01_preview)
@armResourceOperations
interface ApiSources {
  @doc("Returns details of the API source.")
  get is ArmResourceRead<ApiSource>;
  @doc("Checks if specified API source exists.")
  @head
  head(
    ...ResourceInstanceParameters<
      ApiSource,
      Foundations.BaseParameters<ApiSource>
    >,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing API source.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApiSource>;
  @doc("Deletes specified API source.")
  delete is ArmResourceDeleteSync<ApiSource>;
  @doc("Returns a collection of API sources.")
  list is ArmResourceListByParent<ApiSource>;
}
