import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./scenario.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.Chaos;

/**
 * Model that represents the scenario run.
 */
@parentResource(Scenario)
model ScenarioRun
  is Azure.ResourceManager.ProxyResource<ScenarioRunProperties> {
  ...ResourceNameParameter<
    Resource = ScenarioRun,
    KeyName = "runId",
    SegmentName = "runs",
    NamePattern = "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"
  >;
}

/**
 * Model that represents the properties of the scenario run.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "No direct write operations against this resource, only via POST operations surfaced as LROs."
model ScenarioRunProperties {
  /**
   * The workspace name.
   */
  @visibility(Lifecycle.Read)
  workspaceName: string;

  /**
   * The scenario name.
   */
  @visibility(Lifecycle.Read)
  scenarioName: string;

  /**
   * The scenario configuration name.
   */
  @visibility(Lifecycle.Read)
  scenarioConfigurationName: string;

  /**
   * The principal id for the managed identity used for the run.
   */
  @visibility(Lifecycle.Read)
  managedIdentityPrincipalId: string;

  /**
   * The scenario run status.
   */
  @visibility(Lifecycle.Read)
  @lroStatus
  status: ScenarioRunState;

  /**
   * All resources discovered for the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  resources: ScenarioRunResource[];

  /**
   * System or infrastructure errors encountered during the scenario run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * Business errors from fault injection — permission and resource state issues.
   */
  @visibility(Lifecycle.Read)
  executionErrors?: ScenarioErrors;

  /**
   * The scenario run json.
   */
  @visibility(Lifecycle.Read)
  scenarioRunJson?: string;

  /**
   * The scenario run summary.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["actionUrn"])
  scenarioRunSummary?: ScenarioRunSummaryAction[];

  /**
   * When the scenario run was started.
   */
  @visibility(Lifecycle.Read)
  startTime: utcDateTime;

  /**
   * When the scenario run was completed.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * Zone resolution information. Present when the scenario configuration
   * used physical zone targeting (`physicalZones`). Contains the mode,
   * requested physical zones, and per-subscription logical zone mappings.
   */
  @visibility(Lifecycle.Read)
  zoneResolution?: ZoneResolutionInfo;
}

/**
 * Information about how physical zones were resolved to logical zones
 * for each subscription during scenario execution.
 */
model ZoneResolutionInfo {
  /**
   * The zone targeting mode used for this run.
   * `logical` — customer specified logical zone identifiers directly.
   * `physical` — customer specified physical zone identifiers; the system
   * resolved them to per-subscription logical zones at execution time.
   */
  @visibility(Lifecycle.Read)
  mode: ZoneResolutionMode;

  /**
   * The physical zone identifiers requested by the customer in the
   * scenario configuration (e.g., `["westus2-az1"]`).
   * Empty array when `mode` is `logical`.
   */
  @visibility(Lifecycle.Read)
  requestedPhysicalZones: string[];

  /**
   * Per-subscription zone resolution results. Each entry maps a subscription
   * to the logical zone resolved from the requested physical zone.
   * Empty when `mode` is `logical`.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["subscriptionId"])
  subscriptionZoneMappings: ZoneResolutionMapping[];
}

/**
 * Maps a single subscription to its physical-to-logical zone resolutions.
 */
model ZoneResolutionMapping {
  /**
   * The subscription ID (e.g., `"6b052e15-03d3-4f17-b2e1-be7f07588291"`).
   */
  @visibility(Lifecycle.Read)
  subscriptionId: string;

  /**
   * The physical-to-logical zone mappings for this subscription.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["physicalZone"])
  zoneMappings: PhysicalToLogicalZoneMapping[];
}

/**
 * Maps a physical zone to the resolved logical zone for a given subscription.
 */
model PhysicalToLogicalZoneMapping {
  /**
   * The physical availability zone (e.g., `"westus2-az1"`).
   */
  @visibility(Lifecycle.Read)
  physicalZone: string;

  /**
   * The logical availability zone resolved for this subscription
   * (e.g., `"1"`, `"2"`, `"3"`).
   */
  @visibility(Lifecycle.Read)
  logicalZone: string;
}

/**
 * The zone resolution mode for a scenario run.
 */
union ZoneResolutionMode {
  string,

  /**
   * Logical zone mode — customer specified logical zone identifiers directly.
   */
  Logical: "logical",

  /**
   * Physical zone mode — system resolved physical zones to per-subscription
   * logical zones at execution time.
   */
  Physical: "physical",
}

/**
 * Model that represents the scenario run action.
 */
model ScenarioRunSummaryAction {
  /**
   * The resources associated with the specified action.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  resources: ScenarioRunResource[];

  /**
   * The urn for the given chaos action.
   */
  @visibility(Lifecycle.Read)
  @key
  actionUrn: string;

  /**
   * The state of the action.
   */
  @visibility(Lifecycle.Read)
  state: ScenarioSummaryState;

  /**
   * When the action was started.
   */
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  /**
   * When the action was completed.
   */
  @visibility(Lifecycle.Read)
  completedAt?: utcDateTime;
}

/**
 * Model that represents the scenario run resource.
 */
model ScenarioRunResource {
  /**
   * The resource id.
   */
  @visibility(Lifecycle.Read)
  @key
  id: string;
}

/**
 * Enum of the scenario run summary action state.
 */
union ScenarioSummaryState {
  string,

  /**
   * The action is pending and has not started.
   */
  Pending: "Pending",

  /**
   * The action is in the process of starting.
   */
  Starting: "Starting",

  /**
   * The action is in the process of running.
   */
  Running: "Running",

  /**
   * The action is in the process of stopping.
   */
  Stopping: "Stopping",

  /**
   * The action has completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The action is in the process of being canceled.
   */
  Canceling: "Canceling",

  /**
   * The action has been canceled.
   */
  Canceled: "Canceled",

  /**
   * The action is failing due to an error.
   */
  FailingOnError: "FailingOnError",

  /**
   * The action has failed.
   */
  Failed: "Failed",

  /**
   * The action was skipped.
   */
  Skipped: "Skipped",
}

/**
 * Enum of the scenario run state.
 */
union ScenarioRunState {
  string,

  /**
   * The scenario run has been queued and is waiting to start.
   */
  Queued: "Queued",

  /**
   * The scenario run is in the process of being resolved.
   */
  Resolving: "Resolving",

  /**
   * The scenario run is in the process of being generated.
   */
  Generating: "Generating",

  /**
   * The scenario run is in the process of being validated.
   */
  Validating: "Validating",

  /**
   * The scenario run validation has completed successfully.
   */
  ValidationSucceeded: "ValidationSucceeded",

  /**
   * The scenario run is in the process of being started.
   */
  Starting: "Starting",

  /**
   * The scenario run is in the process of being setup.
   */
  SettingUp: "SettingUp",

  /**
   * The scenario run is in the process of running.
   */
  Running: "Running",

  /**
   * The scenario run is in the process of being cleaned up.
   */
  CleaningUp: "CleaningUp",

  /**
   * The scenario run is in the process of being canceled.
   */
  Canceling: "Canceling",

  /**
   * The scenario run has been canceled.
   */
  @lroCanceled
  Canceled: "Canceled",

  /**
   * The scenario run has completed successfully.
   */
  @lroSucceeded
  Succeeded: "Succeeded",

  /**
   * The scenario run has failed.
   */
  @lroFailed
  Failed: "Failed",
}

/**
 * Model that represents a list of scenario runs and a link for pagination.
 */
model ScenarioRunListResult is Azure.Core.Page<ScenarioRun>;
