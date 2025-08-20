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

  @doc("Name of the role")
  @pattern("^\\S.{0,62}\\S$|^\\S$")
  @added(Neon.Postgres.Versions.v3_preview)
  roleName?: string;

  @doc("Timestamp indicating when the role was last updated")
  @visibility(Lifecycle.Read)
  @added(Neon.Postgres.Versions.v3_preview)
  lastUpdated?: string;

  @doc("Databases name associated with the role")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  owns?: string;
}
