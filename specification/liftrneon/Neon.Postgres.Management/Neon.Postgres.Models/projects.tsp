import "./commons.tsp"; // Import common types

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase.Data;

namespace Neon.Postgres.Models;

@doc("Properties specific to Project")
@added(Neon.Postgres.Versions.v2_preview)
model ProjectProperties {
  ...BaseEntity;

  @doc("Region where the project is created")
  regionId?: string;

  @doc("Data Storage bytes per hour for the project")
  storage?: int64;

  @doc("Postgres version for the project")
  pgVersion?: int32;
}
