import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres.Models;

@doc("Properties specific to Roles")
@added(Neon.Postgres.Versions.v2_preview)
model NeonRoleProperties {
  ...BaseEntity;

  @doc("The ID of the branch this role belongs to")
  branchId: string;

  @doc("Permissions assigned to the role")
  permissions: string[];

  @doc("Indicates whether the role has superuser privileges")
  isSuperUser?: boolean;
}
