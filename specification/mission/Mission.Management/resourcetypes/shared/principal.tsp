@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Principal for maintenance mode or role assignments")
model Principal {
  @doc("The object id associated with the principal")
  id: string;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Backwards compatibility - Existing union"
  @doc("The type of the object id. We currently allow users, groups, and service principals")
  type: "User" | "Group" | "ServicePrincipal" | string;
}
