import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Support;
@doc("ProblemClassification resource object.")
@parentResource(Service)
model ProblemClassification is ProxyResource<ProblemClassificationProperties> {
  @doc("Name of problem classification.")
  @path
  @key("problemClassificationName")
  @segment("problemClassifications")
  name: string;
}

@armResourceOperations
interface ProblemClassifications {
  @doc("Get problem classification details for a specific Azure service.")
  get is ArmResourceRead<ProblemClassification>;

  @doc("Lists all the problem classifications (categories) available for a specific Azure service. Always use the service and problem classifications obtained programmatically. This practice ensures that you always have the most recent set of service and problem classification Ids.")
  list is ArmResourceListByParent<ProblemClassification>;
}
