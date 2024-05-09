import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Api.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ApiCenter;
@doc("API version entity.")
@parentResource(Api)
model ApiVersion is ProxyResource<ApiVersionProperties> {
  @doc("The name of the API version.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;
}

@armResourceOperations
interface ApiVersions {
  @doc("Returns details of the API version.")
  get is ArmResourceRead<ApiVersion>;
  @doc("Checks if specified API version exists.")
  @head
  head(
    ...ResourceInstanceParameters<ApiVersion, BaseParameters<ApiVersion>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing API version.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApiVersion>;
  @doc("Deletes specified API version")
  delete is ArmResourceDeleteSync<ApiVersion>;
  @doc("Returns a collection of API versions.")
  list is ArmResourceListByParent<ApiVersion>;
}
