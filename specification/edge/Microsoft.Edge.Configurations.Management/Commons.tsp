import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Scenario enum")
union Scenario {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
