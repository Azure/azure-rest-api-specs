import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workspace.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Chaos;

/**
 * Model that represents the latest workspace evaluation result.
 */
@parentResource(Workspace)
@singleton("latest")
model WorkspaceEvaluation
  is Azure.ResourceManager.ProxyResource<WorkspaceEvaluationProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceEvaluation,
    KeyName = "evaluationName",
    SegmentName = "evaluations",
    NamePattern = ""
  >;
}

/**
 * Model that represents the properties of the workspace evaluation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only singleton resource representing latest evaluation status"
model WorkspaceEvaluationProperties {
  /**
   * The evaluation status.
   */
  @visibility(Lifecycle.Read)
  status: WorkspaceEvaluationStatus;

  /**
   * The evaluation UTC start time.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * The evaluation UTC end time.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * System or infrastructure errors encountered during evaluation.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: OperationError[];

  /**
   * The workspace ID this evaluation belongs to.
   */
  @visibility(Lifecycle.Read)
  workspaceId: string;

  /**
   * The number of scenarios to evaluate.
   */
  @visibility(Lifecycle.Read)
  numScenariosToEvaluate?: int32;

  /**
   * The number of scenarios that evaluated successfully.
   */
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedSucceeded?: int32;

  /**
   * The number of scenarios that failed evaluation.
   */
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedFailed?: int32;

  /**
   * The number of scenarios that were cancelled during evaluation.
   */
  @visibility(Lifecycle.Read)
  numScenariosEvaluatedCancelled?: int32;

  /**
   * The overall evaluation result.
   */
  @visibility(Lifecycle.Read)
  evaluationResult?: RecommendationStatus;

  /**
   * Per-scenario evaluation results.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["scenarioName"])
  results?: ScenarioEvaluationResultItem[];
}

/**
 * Model that represents a single scenario evaluation result.
 */
model ScenarioEvaluationResultItem {
  /**
   * The name of the scenario that was evaluated.
   */
  scenarioName: string;

  /**
   * The evaluation result for this scenario.
   */
  evaluationResult: RecommendationStatus;
}

/**
 * Enum of the workspace evaluation status.
 */
union WorkspaceEvaluationStatus {
  string,

  /**
   * The evaluation is pending and has not started.
   */
  Pending: "Pending",

  /**
   * The evaluation has been accepted and is queued for execution.
   */
  Queued: "Queued",

  /**
   * The evaluation is in progress.
   */
  InProgress: "InProgress",

  /**
   * The evaluation completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The evaluation partially succeeded — some scenarios succeeded while others failed.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The evaluation failed.
   */
  Failed: "Failed",

  /**
   * The evaluation was canceled.
   */
  Canceled: "Canceled",
}
