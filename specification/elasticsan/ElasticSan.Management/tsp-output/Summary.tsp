import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OffAzureSpringBoot;
@doc("The summary resource definition.")
@parentResource(SpringbootsitesModel)
model Summary is ProxyResource<SummariesProperties> {
  @doc("The name of summary")
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z][A-Za-z0-9]*$")
  @path
  @key("summaryName")
  @segment("summaries")
  name: string;
}

@armResourceOperations
interface Summaries {
  @doc("Gets the Summaries resource.")
  get is ArmResourceRead<Summary>;

  @doc("Lists the Summaries resource in springbootsites.")
  listBySite is ArmResourceListByParent<Summary>;
}
