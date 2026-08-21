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
  description?: string;
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
  waveId: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/waves";
    }
  ]>;
}

@doc("Request payload for adding a runbook step.")
@discriminator("stepRef")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepAddRequest {
  @doc("Reference value that identifies the concrete runbook step type.")
  stepRef: RunbookStepRef;

  @doc("Identifier of the workstream to which the step is added.")
  workstreamId: string;

  @doc("Display name for the runbook step.")
  @maxLength(64)
  displayName: string;

  @doc("Runbook step description.")
  @maxLength(256)
  description?: string;

  @doc("Dependencies for this runbook step.")
  @identifiers(#["stepId"])
  dependsOn?: RunbookStepDependency[];
}

@doc("Request payload for adding a manual runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookManualStepAddRequest extends RunbookStepAddRequest {
  @doc("Discriminator for a manual runbook step.")
  stepRef: RunbookStepRef.Manual;
}

@doc("Request payload for adding an approval runbook step.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookApprovalStepAddRequest extends RunbookStepAddRequest {
  @doc("Discriminator for an approval runbook step.")
  stepRef: RunbookStepRef.Approval;

  @doc("Migration entity Azure resource identifiers associated with this approval step.")
  migrationEntityIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>[];
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
  @doc("What must complete in the target step before the dependent step can run.")
  waitFor: RunbookStepDependencyWaitFor;

  @doc("Target step identifier this step depends on.")
  stepId: string;

  @doc("Explicit migration entity pairs for mapped entity dependencies.")
  @identifiers(#["dependentEntity", "waitsFor"])
  entityPairs?: RunbookStepEntityPair[];
}

@doc("Migration entity pair for a mapped runbook step dependency.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookStepEntityPair {
  @doc("Migration entity identifier in the dependent step.")
  dependentEntity: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>;

  @doc("Migration entity identifier in the target step.")
  waitsFor: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>;
}

@doc("Request payload for merging runbook workstreams.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookWorkstreamsMergeRequest {
  @doc("Workstream IDs to merge.")
  @minItems(2)
  workstreamIds: string[];

  @doc("Display name for the merged workstream.")
  @maxLength(64)
  displayName: string;
}

@doc("Request payload for splitting a runbook workstream.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookWorkstreamSplitRequest {
  @doc("Source workstream identifier.")
  sourceWorkstreamId: string;

  @doc("Runbook step IDs to move to the new workstream.")
  @minItems(1)
  stepIds: string[];

  @doc("Display name for the new workstream.")
  @maxLength(64)
  displayName: string;
}
