import "@typespec/versioning";

using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("Principal Type")
union PrincipalType {
  string,

  @doc("PrincipalType User")
  User: "User",

  @doc("PrincipalType Group")
  Group: "Group",

  @doc("PrincipalType ServicePrincipal")
  ServicePrincipal: "ServicePrincipal",
}

@doc("Principal for maintenance mode or role assignments")
model Principal {
  @doc("The object id associated with the principal")
  id: string;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Backwards compatibility - Existing union"
  @typeChangedFrom(
    Microsoft.Mission.Versions.v2026_05_01_preview,
    "User" | "Group" | "ServicePrincipal" | string
  )
  @doc("The type of the object id. We currently allow users, groups, and service principals")
  type: PrincipalType;
}
