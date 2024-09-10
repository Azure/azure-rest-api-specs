import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("UseCase enum")
union UseCase {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
