import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2025_03_30_preview)
@doc("Migration Wave resource.")
@parentResource(MigrateProject)
model Wave is ProxyResource<WaveProperties> {
  @doc("Migration Wave Resource")
  @key("waveName")
  @segment("waves")
  @path
  // "^[^<>&:\\?\/#\x00-\x1F\x7F]{1,260}$"
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Migration Wave Properties class.")
model WaveProperties is AzureResourceProperties {
  @doc("Description of the wave.")
  description?: string;

  @doc("Display Name of the wave.")
  displayName: string;

  @doc("ARG query and other details to create workloads within a wave")
  @madeOptional(ApiVersions.v2026_09_01_preview)
  arg?: Arg;

  @doc("The status of the wave.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Planned start date of the wave.")
  @madeOptional(ApiVersions.v2026_09_01_preview)
  plannedStartDate?: utcDateTime;

  @doc("Planned completion date of the wave.")
  plannedCompletionDate?: utcDateTime;

  @doc("Actual start date of the wave.")
  @visibility(Lifecycle.Read)
  actualStartDate?: utcDateTime;

  @doc("The current stage of the wave.")
  @visibility(Lifecycle.Read)
  stage?: string;

  @doc("The execution mode for the migration process.")
  @added(ApiVersions.v2026_09_01_preview)
  @visibility(Lifecycle.Read)
  executionMode?: ExecutionMode;

  @doc("The normalized migration status of the wave.")
  @added(ApiVersions.v2026_09_01_preview)
  @visibility(Lifecycle.Read)
  migrationStatus?: MigrationStatus;

  @doc("Waves on which this wave depends. An empty list clears all dependencies. Omit to retain the existing dependencies on update.")
  @added(ApiVersions.v2026_09_01_preview)
  @identifiers(#["waveArmId"])
  dependsOn?: WaveDependency[];

  @doc("The UTC timestamp when the wave was created.")
  @added(ApiVersions.v2026_09_01_preview)
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("The UTC timestamp when the wave was last updated.")
  @added(ApiVersions.v2026_09_01_preview)
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;
}

@doc("A wave dependency and the reason for the dependency.")
@added(ApiVersions.v2026_09_01_preview)
model WaveDependency {
  @doc("The full Azure resource identifier of the wave on which this wave depends.")
  waveArmId: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>;

  @doc("The reason for the dependency.")
  reasons?: string;
}

@doc("Properties that can be updated on a wave. Omitted properties retain their existing values.")
@added(ApiVersions.v2026_09_01_preview)
model WavePatchProperties {
  @doc("Description of the wave.")
  description?: string;

  @doc("Display name of the wave.")
  displayName?: string;

  @doc("Planned start date of the wave.")
  plannedStartDate?: utcDateTime;

  @doc("Planned completion date of the wave.")
  plannedCompletionDate?: utcDateTime;

  @doc("Waves on which this wave depends. An empty list clears all dependencies. Omit to retain the existing dependencies.")
  @identifiers(#["waveArmId"])
  dependsOn?: WaveDependency[];
}

@doc("Patch request for a wave.")
@added(ApiVersions.v2026_09_01_preview)
model WavePatch {
  @doc("Properties to update on the wave.")
  properties?: WavePatchProperties;
}

@doc("Inventory to associate with or dissociate from a wave. At least one application or workload resource identifier must be supplied across applicationIds and workloadIds. Either list may be omitted or empty when the other list contains an identifier.")
@added(ApiVersions.v2026_09_01_preview)
model WaveInventoryRequest {
  @doc("Full Azure resource identifiers of discovered applications.")
  applicationIds?: Array<armResourceIdentifier<[
    {
      type: "Microsoft.ApplicationMigration/discoveryHubs/applications";
    }
  ]>>;

  @doc("Full Azure resource identifiers of discovered workloads.")
  workloadIds?: armResourceIdentifier[];
}

@doc("A wave operation accepted for asynchronous processing.")
model WaveAcceptedResponse {
  ...ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Wave> &
    Azure.Core.Foundations.RetryAfterHeader>;

  @doc("The wave being processed.")
  @bodyRoot
  body: Wave;
}

@doc("ARG query and other details to create workloads within a wave.")
model Arg {
  @doc("The query to create workloads within the wave.")
  query: string;
}
