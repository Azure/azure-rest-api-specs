import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

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
  @visibility(Lifecycle.Read)
  createdFrom?: string;

  /**
   * Version of the scenario.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Description of what this scenario does (optional).
   */
  description?: string;

  /**
   * Parameter definitions for the scenario.
   */
  @identifiers(#["name"])
  parameters: ScenarioParameter[];

  /**
   * Array of actions that define the scenario's orchestration.
   */
  @minItems(1)
  @identifiers(#["name"])
  actions: ScenarioAction[];

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
   * Unique resource name identifying the action type.
   */
  urn: string;

  /**
   * Azure resource types this action targets (e.g., Microsoft.Compute/virtualMachineScaleSets).
   */
  @minItems(1)
  targetTypes: string[];

  /**
   * Human-readable description of what this action does.
   */
  description?: string;

  /**
   * ISO 8601 duration for how long the action runs (e.g., PT30M for 30 minutes).
   */
  duration: duration;

  /**
   * Action-specific parameters.
   */
  @identifiers(#["name"])
  parameters?: ScenarioParameter[];

  /**
   * Action dependencies that control when this action starts.
   */
  runAfter?: RunAfter;

  /**
   * ISO 8601 duration to wait before action starts (e.g., PT30S for 30 seconds).
   */
  waitBefore?: duration;

  /**
   * ISO 8601 duration for maximum action execution time (for actions without inherent duration).
   */
  timeout?: duration;

  /**
   * External resource reference for the action.
   */
  externalResource?: ExternalResource;
}

/**
 * Model that represents an external resource reference.
 */
model ExternalResource {
  /**
   * The resource ID of the external resource.
   */
  resourceId?: string;
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
  @minItems(1)
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
