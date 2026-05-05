import "./commons.tsp"; // Import common types

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("The Branch resource type.")
@added(Neon.Postgres.Versions.v2_preview)
@parentResource(Project)
model Branch is ProxyResource<BranchProperties> {
  ...ResourceNameParameter<
    Resource = Branch,
    KeyName = "branchName",
    SegmentName = "branches",
    NamePattern = "^\\S.{0,62}\\S$|^\\S$"
  >;
}

@doc("Properties specific to Branch")
@added(Neon.Postgres.Versions.v2_preview)
model BranchProperties {
  ...BaseEntity;

  @doc("The ID of the project this branch belongs to")
  projectId?: string;

  @doc("The ID of the parent branch")
  @pattern("^[a-z0-9-]{1,60}$")
  parentId?: string;

  @doc("Role name associated with the branch")
  roleName?: string;

  @doc("Database name associated with the branch")
  databaseName?: string;

  @doc("Roles associated with the branch")
  @identifiers(#[])
  roles?: NeonRoleProperties[];

  @doc("Neon Databases associated with the branch")
  @identifiers(#[])
  databases?: NeonDatabaseProperties[];

  @doc("Endpoints associated with the branch")
  @identifiers(#[])
  endpoints?: EndpointProperties[];

  @doc("Unique identifier for the branch")
  @pattern("^[a-z0-9-]{1,60}$")
  @added(Neon.Postgres.Versions.v3_preview)
  branchId?: string;

  @doc("Name of the branch")
  @pattern("^\\S.{0,126}\\S$|^\\S$")
  @added(Neon.Postgres.Versions.v3_preview)
  branch?: string;

  @doc("Total data size in MB for the branch")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  dataSize?: string;

  @doc("Last active compute for the branch")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  lastActive?: string;

  @doc("Compute hours for the branch")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  computeHours?: string;

  @doc("Branch protected status")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  protected?: boolean;

  @doc("Branch default status")
  @added(Neon.Postgres.Versions.v3_preview)
  @visibility(Lifecycle.Read)
  isDefault?: boolean;
}
