import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@doc("Scenario enum")
union Scenario {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
