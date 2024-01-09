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
@doc("Environment entity.")
@parentResource(Workspace)
model Environment is ProxyResource<EnvironmentProperties> {
  @doc("The name of the environment.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("environmentName")
  @segment("environments")
  name: string;
}

@armResourceOperations
interface Environments {
  @doc("Returns details of the environment.")
  get is ArmResourceRead<Environment>;
  @doc("Checks if specified environment exists.")
  @head
  head(
    ...ResourceInstanceParameters<Environment, BaseParameters<Environment>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing environment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Environment>;
  @doc("Deletes the environment.")
  delete is ArmResourceDeleteSync<Environment>;
  @doc("Returns a collection of environments.")
  list is ArmResourceListByParent<Environment>;
}
