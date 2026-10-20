import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents the scenario.
 */
@parentResource(Workspace)
model Scenario is Azure.ResourceManager.ProxyResource<ScenarioProperties> {
  ...ResourceNameParameter<
    Resource = Scenario,
    KeyName = "scenarioName",
    SegmentName = "scenarios",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Model that represents the properties of the scenario.
 */
model ScenarioProperties {
  /**
   * Most recent provisioning state for the given scenario resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Resource ID of the template version this scenario was created from (optional).
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "createdFrom")
  @visibility(Lifecycle.Read)
  createdFromReadOnly?: string;

  /**
   * Resource ID of the template version this scenario was created from (optional).
   * The ID has the form
   * `/providers/Microsoft.Chaos/scenarioTemplates/{scenarioTemplateName}/versions/{version}`.
   * This property retains its existing string representation for compatibility
   * with earlier API versions and SDKs.
   *
   * A scenario's structure comes from exactly one of two mutually exclusive sources.
   * When `createdFrom` is supplied on create, the referenced template version is the
   * authoritative source for the scenario's structure; inline `parameters` and
   * `actions` are not used. When `createdFrom` is absent, the structure comes from
   * the inline `parameters` and `actions` supplied in the request.
   * Supplying neither source is rejected by request validation.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  createdFrom?: string;

  /**
   * Version of the scenario.
   */
  @removed(Microsoft.Chaos.Versions.v2026_11_01)
  @renamedFrom(Microsoft.Chaos.Versions.v2026_11_01, "version")
  @visibility(Lifecycle.Read)
  versionReadOnly?: string;

  /**
   * Version of the scenario, supplied by the author. Defaults to `1.0` when not
   * supplied on create. This is the scenario's own version and is independent of
   * the version of any template it was created from.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  version?: string;

  /**
   * Description of what this scenario does (optional).
   */
  description?: string;

  /**
   * Parameter definitions for the scenario.
   */
  @madeOptional(Microsoft.Chaos.Versions.v2026_11_01)
  @identifiers(#["name"])
  parameters?: ScenarioParameter[];

  /**
   * Array of actions that define the scenario's orchestration.
   */
  @madeOptional(Microsoft.Chaos.Versions.v2026_11_01)
  @minItems(1)
  @identifiers(#["name"])
  actions?: ScenarioAction[];

  /**
   * Scenario-wide default for how a scenario run reacts when one of its actions fails.
   * An action that does not supply its own `failureBehavior` inherits this value; when
   * neither is supplied the effective behavior is `Stop`.
   *
   * Not used when `createdFrom` is supplied, for the same reason as `parameters` and
   * `actions`: the referenced template version is then the authoritative source for the
   * scenario's structure, and it supplies this policy too. A value sent in the request is
   * ignored in that case — on create the referenced template's policy is used, and on update
   * the policy of the already persisted template is preserved.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  failureBehavior?: FailureBehavior;

  /**
   * The recommendation information for this scenario.
   */
  @visibility(Lifecycle.Read)
  recommendation?: Recommendation;
}

/**
 * Model that represents a single scenario parameter definition.
 */
model ScenarioParameter {
  /**
   * The name of the parameter.
   */
  @minLength(1)
  name: string;

  /**
   * Parameter data type.
   */
  type: ParameterType;

  /**
   * Default value for the parameter.
   */
  default?: string;

  /**
   * Whether this parameter is required.
   */
  required?: boolean;

  /**
   * Description of the parameter.
   */
  description?: string;

  /**
   * Format validation applied to the parameter's value, and examples of values that satisfy it.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  format?: ScenarioParameterFormat;
}

/**
 * Model that represents the format validation applied to a scenario parameter's value.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioParameterFormat {
  /**
   * The built-in format the value is validated against.
   */
  formatType?: ParameterFormatType;

  /**
   * Human-readable examples of values that satisfy the format.
   */
  examples?: string[];
}

/**
 * Enum of the built-in formats a scenario parameter's value can be validated against.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
union ParameterFormatType {
  string,

  /**
   * The value must be an Azure resource ID.
   */
  AzureResourceId: "AzureResourceId",

  /**
   * The value must be an Azure region name.
   */
  AzureRegion: "AzureRegion",

  /**
   * The value must be an Azure availability zone.
   */
  AzureZone: "AzureZone",

  /**
   * The value must be an ISO 8601 duration.
   */
  Duration: "Duration",

  /**
   * The value must be well-formed JSON.
   */
  Json: "Json",
}

/**
 * Enum for parameter types.
 */
union ParameterType {
  string,

  /**
   * String parameter type.
   */
  String: "string",

  /**
   * Number parameter type.
   */
  Number: "number",

  /**
   * Boolean parameter type.
   */
  Boolean: "boolean",

  /**
   * Object parameter type.
   */
  Object: "object",

  /**
   * Array parameter type.
   */
  Array: "array",
}

/**
 * Model that represents a scenario action.
 */
model ScenarioAction {
  /**
   * Unique name for the action.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  name: string;

  /**
   * Identifier of the action and version (e.g., "microsoft-compute-shutdown/1.0").
   */
  actionId: string;

  /**
   * Human-readable description of what this action does.
   */
  description?: string;

  /**
   * ISO 8601 duration for how long the action runs (e.g., PT30M for 30 minutes). Supports template macro syntax (%%\{parameters.\<name\>\}%%).
   */
  duration: string;

  /**
   * Action-specific parameter values.
   */
  @identifiers(#["key"])
  parameters?: KeyValuePair[];

  /**
   * Action-specific target matching criteria evaluated during execution. When provided,
   * the collection must contain either `logicalZone` and `region`, or `physicalZone`.
   * Matcher names must be unique, the two modes cannot be combined, and the service
   * enforces the cross-item combination at runtime.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  @minItems(1)
  @maxItems(2)
  @identifiers(#["name"])
  matchers?: ScenarioActionMatcher[];

  /**
   * Action dependencies that control when this action starts.
   */
  runAfter?: RunAfter;

  /**
   * ISO 8601 duration to wait before action starts (e.g., PT30S for 30 seconds). Supports template macro syntax.
   */
  waitBefore?: string;

  /**
   * ISO 8601 duration for maximum action execution time. Supports template macro syntax.
   */
  timeout?: string;

  /**
   * External resource reference for the action.
   */
  externalResource?: ExternalResource;

  /**
   * Per-action override for how the scenario run reacts when this action fails. When omitted,
   * the action inherits the scenario-level `failureBehavior`; when neither is supplied the
   * effective behavior is `Stop`.
   */
  @added(Microsoft.Chaos.Versions.v2026_11_01)
  failureBehavior?: FailureBehavior;
}

/**
 * Model that represents an action-specific target matching criterion.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
model ScenarioActionMatcher {
  /**
   * The matcher name, such as `logicalZone`, `physicalZone`, or `region`.
   */
  name: ScenarioActionMatcherName;

  /**
   * The value that targets must match. Supports template macro syntax.
   */
  value: string;
}

/**
 * Enum of the supported action matcher names.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "The matcher name set is intentionally fixed and non-extensible."
@added(Microsoft.Chaos.Versions.v2026_11_01)
enum ScenarioActionMatcherName {
  /**
   * Match targets by logical availability zone.
   */
  LogicalZone: "logicalZone",

  /**
   * Match targets by physical availability zone.
   */
  PhysicalZone: "physicalZone",

  /**
   * Match targets by Azure region.
   */
  Region: "region",
}

/**
 * Enum of how a scenario run reacts when an action fails.
 */
@added(Microsoft.Chaos.Versions.v2026_11_01)
union FailureBehavior {
  string,

  /**
   * The action failure stops the scenario run and drives it to the `Failed` terminal state.
   * This is the effective behavior when no `failureBehavior` is supplied.
   */
  Stop: "Stop",

  /**
   * The action failure is suppressed: it does not by itself end the scenario run, and the run
   * continues with its remaining actions. Suppression affects the run's result only. It does not
   * change dependency scheduling, which stays under the control of each action's `runAfter` —
   * an action that should still start after a failed dependency says so there.
   *
   * A run that completes normally and whose action failures were all suppressed terminates as
   * `PartiallySucceeded`. Any failure that is not suppressed still drives the run to `Failed`,
   * and cancellation keeps its existing result.
   */
  Continue: "Continue",
}

/**
 * Model that represents an external resource reference.
 */
model ExternalResource {
  /**
   * The resource ID of the external resource.
   */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Model that represents action dependencies.
 */
model RunAfter {
  /**
   * Defines how multiple dependencies are evaluated.
   */
  behavior?: RunAfterBehavior = RunAfterBehavior.Any;

  /**
   * Array of action dependencies.
   */
  @identifiers(#["name"])
  items: ActionDependency[];
}

/**
 * Enum for run after behavior.
 */
union RunAfterBehavior {
  string,

  /**
   * Always continues after all dependencies (like a finally block).
   */
  Any: "Any",

  /**
   * All dependencies must be satisfied to continue.
   */
  All: "All",

  /**
   * At least one dependency must be satisfied to continue.
   */
  AtLeastOne: "AtLeastOne",
}

/**
 * Model that represents an action dependency.
 */
model ActionDependency {
  /**
   * The type of dependency.
   */
  type: ActionDependencyType;

  /**
   * Name of the action this depends on.
   */
  name: string;

  /**
   * The lifecycle state of the dependency action that triggers this action to start.
   */
  onActionLifecycle?: ActionLifecycle;
}

/**
 * Enum for action dependency type.
 */
union ActionDependencyType {
  string,

  /**
   * Action dependency type.
   */
  Action: "Action",
}

/**
 * Enum for action lifecycle states.
 */
union ActionLifecycle {
  string,

  /**
   * Trigger when action reaches any terminal state.
   */
  AnyTerminal: "AnyTerminal",

  /**
   * Trigger when action starts.
   */
  Start: "Start",

  /**
   * Trigger when action is running.
   */
  Running: "Running",

  /**
   * Trigger on success.
   */
  Success: "Success",

  /**
   * Trigger on failure.
   */
  Failure: "Failure",

  /**
   * Trigger when action is skipped.
   */
  Skipped: "Skipped",
}

/**
 * Model that represents a scenario recommendation.
 */
model Recommendation {
  /**
   * The recommendation status.
   */
  @visibility(Lifecycle.Read)
  recommendationStatus: RecommendationStatus;

  /**
   * The UTC time when the recommendation was evaluated.
   */
  @visibility(Lifecycle.Read)
  evaluationRunAt?: utcDateTime;
}

/**
 * Enum of the scenario validation state.
 */
union RecommendationStatus {
  string,

  /**
   * The scenario recommendation status has not been evaluated.
   */
  NotEvaluated: "NotEvaluated",

  /**
   * The scenario recommendation status is recommended.
   */
  Recommended: "Recommended",

  /**
   * The scenario recommendation status is not applicable.
   */
  NotApplicable: "NotApplicable",

  /**
   * The scenario recommendation status is currently being evaluated.
   */
  Evaluating: "Evaluating",

  /**
   * The scenario recommendation evaluation has failed.
   */
  EvaluationFailed: "EvaluationFailed",

  /**
   * The scenario recommendation evaluation was cancelled.
   */
  EvaluationCancelled: "EvaluationCancelled",
}

/**
 * Model that represents a list of scenarios and a link for pagination.
 */
model ScenarioListResult is Azure.Core.Page<Scenario>;
