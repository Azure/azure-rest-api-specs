import "../../Common/ArmModels/AzureResourceProperties.tsp";
import "../Enums/Enums.tsp";
import "../Runbook/Runbook.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@added(ApiVersions.v2026_08_01_preview)
@doc("Runbook execution resource.")
@parentResource(Runbook)
model RunbookExecution is ProxyResource<RunbookExecutionProperties> {
  @doc("Runbook execution ARM name.")
  @key("runbookExecutionName")
  @segment("executions")
  @path
  @pattern("^[^<>&:\\?/#]{1,260}$")
  name: string;

  ...EntityTagProperty;
}

@doc("Runbook execution properties.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookExecutionProperties is AzureResourceProperties {
  @doc("Runbook artifact version identifier used for this execution.")
  @visibility(Lifecycle.Read)
  runbookArtifactVersionId?: string;

  @doc("Execution artifact identifier for this runbook execution.")
  @visibility(Lifecycle.Read)
  executionArtifactId?: string;

  @doc("Current runbook execution status.")
  status?: string;

  @doc("Start time of runbook execution.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of runbook execution.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;
}

@doc("Properties that can be updated on a runbook execution.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookExecutionPatchProperties {
  @doc("Updated status for runbook execution.")
  status?: string;
}

@doc("Patch request for a runbook execution.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookExecutionPatch {
  @doc("Properties to update on the runbook execution.")
  properties?: RunbookExecutionPatchProperties;
}

@doc("Request payload for runbook execution actions.")
@added(ApiVersions.v2026_08_01_preview)
model RunbookExecutionActionRequest {
  @doc("Action to be performed on runbook execution.")
  action: RunbookExecutionAction;

  @doc("Optional comment associated with the action.")
  @maxLength(256)
  comment?: string;

  @doc("Target identifier for the action.")
  targetId?: string;

  @doc("Migration entity ARM IDs in scope for this action.")
  migrationEntityIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Migrate/migrateProjects/migrationEntities";
    }
  ]>[];
}
