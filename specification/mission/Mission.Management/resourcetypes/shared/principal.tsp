@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

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

  @doc("The type of the object id. We currently allow users, groups, and service principals")
  type: PrincipalType;
}
