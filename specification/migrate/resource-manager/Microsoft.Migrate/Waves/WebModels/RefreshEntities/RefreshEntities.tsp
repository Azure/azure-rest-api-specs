import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Request body for refreshing migration entities and groups.")
@added(ApiVersions.v2026_02_01_preview)
model RefreshEntitiesRequest {
  @doc("List of migration entity ARM IDs to refresh. Each ID must be a fully qualified ARM resource ID belonging to the same subscription and resource group as the migrate project.")
  migrationEntityIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>>;

  @doc("List of migration entity group ARM IDs. All entities within these groups will be refreshed. Each ID must be a fully qualified ARM resource ID belonging to the same subscription and resource group as the migrate project.")
  migrationEntityGroupIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
    }
  ]>>;
}

@doc("Response body for refresh migration entities operation.")
@added(ApiVersions.v2026_02_01_preview)
model RefreshEntitiesResponse {
  @doc("List of migration entity ARM IDs being refreshed.")
  @visibility(Lifecycle.Read)
  migrationEntityIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>>;

  @doc("List of migration entity group ARM IDs being refreshed.")
  @visibility(Lifecycle.Read)
  migrationEntityGroupIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntityGroups";
    }
  ]>>;
}
