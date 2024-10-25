import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2024_06_01_preview)
@doc("Principal for maintenance mode or role assignments, for example")
model Principal {
  @doc("The object (or principal) id associated with the principal")
  id: string;

  @doc("The type of the object id. We currently allow users, groups, and service principals")
  type: "User" | "Group" | "ServicePrincipal" | string;
}