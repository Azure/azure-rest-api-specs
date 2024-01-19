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

namespace Microsoft.Security;
@doc("Compliance of a scope")
model Compliance is ExtensionResource<ComplianceProperties> {
  @doc("name of the Compliance")
  @path
  @key("complianceName")
  @segment("compliances")
  name: string;
}

@armResourceOperations
interface Compliances {
  @doc("Details of a specific Compliance.")
  get is ArmResourceRead<Compliance>;

  @doc("The Compliance scores of the specific management group.")
  list is ArmResourceListByParent<Compliance>;
}
