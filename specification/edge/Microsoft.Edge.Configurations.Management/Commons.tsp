import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Usecase enum")
union Usecase {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
