import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automanage;
@doc("Definition of the Automanage best practice.")
@tenantResource
model AutomanageBestPractice is ProxyResource<ConfigurationProfileProperties> {
  @doc("The Automanage best practice name.")
  @path
  @key("bestPracticeName")
  @segment("bestPractices")
  name: string;
}

@armResourceOperations
interface AutomanageBestPractices {
  @doc("Get information about a Automanage best practice")
  get is ArmResourceRead<AutomanageBestPractice>;
  @doc("Retrieve a list of Automanage best practices")
  listByTenant is ArmResourceListByParent<AutomanageBestPractice>;
}
