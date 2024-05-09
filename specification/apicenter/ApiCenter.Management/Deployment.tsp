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
@doc("API deployment entity.")
@parentResource(Api)
model Deployment is ProxyResource<DeploymentProperties> {
  @doc("The name of the API deployment.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-zA-Z0-9-]{3,90}$")
  @path
  @key("deploymentName")
  @segment("deployments")
  name: string;
}

@armResourceOperations
interface Deployments {
  @doc("Returns details of the API deployment.")
  get is ArmResourceRead<Deployment>;
  @doc("Checks if specified API deployment exists.")
  @head
  head(
    ...ResourceInstanceParameters<Deployment, BaseParameters<Deployment>>,
  ): OkResponse | ErrorResponse;
  @doc("Creates new or updates existing API deployment.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Deployment>;
  @doc("Deletes API deployment.")
  delete is ArmResourceDeleteSync<Deployment>;
  @doc("Returns a collection of API deployments.")
  list is ArmResourceListByParent<Deployment>;
}
