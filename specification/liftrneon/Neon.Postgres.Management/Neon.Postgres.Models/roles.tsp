import "./commons.tsp"; // Import common types

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("The Neon Role resource type.")
@added(Neon.Postgres.Versions.v2_preview)
@parentResource(Branch)
model NeonRole is ProxyResource<NeonRoleProperties> {
  ...ResourceNameParameter<
    Resource = NeonRole,
    KeyName = "neonRoleName",
    SegmentName = "neonRoles",
    NamePattern = "^\\S.{0,62}\\S$|^\\S$"
  >;
}

@doc("Properties specific to Roles")
@added(Neon.Postgres.Versions.v2_preview)
model NeonRoleProperties {
  ...BaseEntity;

  @doc("The ID of the branch this role belongs to")
  branchId?: string;

  @doc("Permissions assigned to the role")
  permissions?: string[];

  @doc("Indicates whether the role has superuser privileges")
  isSuperUser?: boolean;
}
