import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres.Models;

@doc("Properties specific to Branch")
@added(Neon.Postgres.Versions.v2_preview)
model BranchProperties {
  ...BaseEntity;

  @doc("The ID of the project this branch belongs to")
  projectId: string;

  @doc("The ID of the parent branch")
  @pattern("^[a-z0-9-]{1,60}$")
  parentId?: string;
}
