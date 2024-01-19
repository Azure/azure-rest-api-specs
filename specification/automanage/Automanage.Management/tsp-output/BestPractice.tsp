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

namespace Microsoft.Automanage;
@doc("Definition of the Automanage best practice.")
@tenantResource
model BestPractice is ProxyResource<ConfigurationProfileProperties> {
  @doc("The Automanage best practice name.")
  @path
  @key("bestPracticeName")
  @segment("bestPractices")
  name: string;
}

@armResourceOperations
interface BestPractices {
  @doc("Get information about a Automanage best practice")
  get is ArmResourceRead<BestPractice>;

  @doc("Retrieve a list of Automanage best practices")
  listByTenant is ArmResourceListByParent<BestPractice>;
}
