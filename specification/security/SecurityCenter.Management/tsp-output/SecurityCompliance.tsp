import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.SecurityCenter;
@doc("Compliance of a scope")
model SecurityCompliance is ExtensionResource<ComplianceProperties> {
  @doc("name of the Compliance")
  @path
  @key("complianceName")
  @segment("compliances")
  name: string;
}

@armResourceOperations
interface SecurityCompliances {
  @doc("Details of a specific Compliance.")
  get is ArmResourceRead<SecurityCompliance>;
  @doc("The Compliance scores of the specific management group.")
  list is ArmResourceListByParent<SecurityCompliance>;
}
