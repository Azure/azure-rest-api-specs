import "./commons.tsp"; // Import common types

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Neon.Postgres;

@doc("The Neon Database resource type.")
@added(Neon.Postgres.Versions.v2_preview)
@parentResource(Branch)
model NeonDatabase is ProxyResource<NeonDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = NeonDatabase,
    KeyName = "neonDatabaseName",
    SegmentName = "neonDatabases",
    NamePattern = "^\\S.{0,62}\\S$|^\\S$"
  >;
}

@doc("Properties specific to Databases")
@added(Neon.Postgres.Versions.v2_preview)
model NeonDatabaseProperties {
  ...BaseEntity;

  @doc("The ID of the branch this database belongs to")
  branchId?: string;

  @doc("The name of the role that owns the database")
  ownerName?: string;
}
