import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../../Common/ArmModels/MigrateProject.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2026_08_01_preview)
@doc("Runbook resource.")
@parentResource(MigrateProject)
model Runbook is ProxyResource<RunbookProperties> {
  @doc("Runbook ARM name.")
  @key("runbookName")
  @segment("runbooks")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Runbook properties.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookProperties is AzureResourceProperties {
  @doc("Runbook scope definition.")
  scope: RunbookScopeProperties;

  @doc("Artifact identifier associated with this runbook.")
  @visibility(Lifecycle.Read)
  artifactId?: string;

  @doc("Current runbook state.")
  @visibility(Lifecycle.Read)
  state?: string;

  @doc("Runbook description.")
  @maxLength(256)
  description: string;
}

@doc("Base runbook scope model.")
@discriminator("scopeType")
@added(ApiVersions.v2026_08_01_preview)
model RunbookScopeProperties {
  @doc("Scope type for this runbook.")
  scopeType: RunbookScopeType;
}

@doc("Wave scope for a runbook.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookScopeWaveProperties extends RunbookScopeProperties {
  @doc("Scope type for this runbook.")
  scopeType: RunbookScopeType.Wave;

  @doc("Wave ARM identifier for wave-scoped runbooks.")
  waveId?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>;
}

@doc("Request payload for adding a runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepAddRequest {
  @doc("Runbook step name.")
  @maxLength(64)
  stepName: string;

  @doc("Display name for the runbook step.")
  @maxLength(64)
  displayName: string;

  @doc("Runbook step description.")
  @maxLength(256)
  description: string;

  @doc("Partner step reference identifier.")
  stepRef: string;

  @doc("Migration entity ARM IDs associated with this step.")
  migrationEntityIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>[];

  @doc("Dependencies for this runbook step.")
  @identifiers(#["stepId"])
  dependsOn?: RunbookStepDependency[];
}

@doc("Request payload for updating a runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepUpdateRequest {
  @doc("Runbook step identifier.")
  stepId: string;

  @doc("Display name for the runbook step.")
  @maxLength(64)
  displayName?: string;

  @doc("Runbook step description.")
  @maxLength(256)
  description?: string;

  @doc("Dependencies for this runbook step.")
  @identifiers(#["stepId"])
  dependsOn?: RunbookStepDependency[];
}

@doc("Request payload for deleting a runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepDeleteRequest {
  @doc("Runbook step identifier.")
  stepId: string;
}

@doc("Dependency relationship for a runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepDependency {
  @doc("Dependency mode between source and target steps.")
  mode?: RunbookStepDependencyMode;

  @doc("Target step identifier this step depends on.")
  stepId: string;

  @doc("Entity mapping for migration entity mode dependencies.")
  @identifiers(#["from", "to"])
  entityMap?: RunbookStepEntityMapEntry[];
}

@doc("Entity mapping entry for runbook step dependency.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepEntityMapEntry {
  @doc("Source migration entity identifier.")
  from: string;

  @doc("Target migration entity identifier.")
  to: string;
}

@doc("Request payload for merging runbook workstreams.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookWorkstreamsMergeRequest {
  @doc("Workstream IDs to merge.")
  workstreamId: string[];

  @doc("Optional new workstream name for the merged output.")
  @maxLength(64)
  newWorkstreamName?: string;
}

@doc("Request payload for splitting a runbook workstream.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookWorkstreamSplitRequest {
  @doc("Source workstream identifier.")
  sourceWorkstreamId: string;

  @doc("Runbook step IDs to move to the new workstream.")
  stepIds: string[];

  @doc("Name of the new workstream.")
  @maxLength(64)
  newWorkstreamName: string;
}

@doc("Runbook download URL response.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookDownloadUrlResponse {
  @doc("Download URL for runbook content.")
  downloadUrl: url;

  @doc("Expiration time for the download URL.")
  expiresAt: utcDateTime;
}

@doc("Runbook input upload URL response.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookInputUploadUrlResponse {
  @doc("Upload URL for runbook input content.")
  uploadUrl: url;

  @doc("Expiration time for the upload URL.")
  expiresAt: utcDateTime;
}

@doc("Runbook input download URL response.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookInputDownloadUrlResponse {
  @doc("Download URL for runbook input content.")
  downloadUrl: url;

  @doc("Expiration time for the download URL.")
  expiresAt: utcDateTime;
}