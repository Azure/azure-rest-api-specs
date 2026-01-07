import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@typespec/rest";

using TypeSpec.Versioning;

namespace Microsoft.Edge;

@removed(Versions.v2025_06_01)
@added(Versions.v2025_12_01_preview)
@doc("Scenario enum")
union Scenario {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
