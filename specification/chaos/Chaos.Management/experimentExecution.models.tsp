import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./experiment.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Chaos;

/**
 * Model that represents the execution of a Experiment.
 */
@parentResource(Experiment)
model ExperimentExecution
  is Azure.ResourceManager.ProxyResource<ExperimentExecutionProperties> {
  ...ResourceNameParameter<
    Resource = ExperimentExecution,
    KeyName = "executionId",
    SegmentName = "executions",
    NamePattern = "^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$"
  >;
}

/**
 * Model that represents the execution properties of an Experiment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Unused property, avoids breaking changes in SDK."
model ExperimentExecutionProperties {
  /**
   * The status of the execution.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * String that represents the start date time.
   */
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility(Lifecycle.Read)
  stoppedAt?: utcDateTime;

  /**
   * Resource provisioning state. Not currently in use for executions.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents the execution details of an Experiment.
 */
model ExperimentExecutionDetails {
  /**
   * String of the resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * String of the fully qualified resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * String of the resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The properties of the experiment execution details.
   */
  @visibility(Lifecycle.Read)
  properties?: ExperimentExecutionDetailsProperties;
}

/**
 * Model that represents the extended properties of an experiment execution.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ExperimentExecutionDetailsProperties {
  /**
   * The status of the execution.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * String that represents the start date time.
   */
  @visibility(Lifecycle.Read)
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility(Lifecycle.Read)
  stoppedAt?: utcDateTime;

  /**
   * Resource provisioning state. Not currently in use for executions.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The reason why the execution failed.
   */
  @visibility(Lifecycle.Read)
  failureReason?: string;

  /**
   * String that represents the last action date time.
   */
  @visibility(Lifecycle.Read)
  lastActionAt?: utcDateTime;

  /**
   * The information of the experiment run.
   */
  @visibility(Lifecycle.Read)
  runInformation?: ExperimentExecutionDetailsPropertiesRunInformation;
}

/**
 * The information of the experiment run.
 */
model ExperimentExecutionDetailsPropertiesRunInformation {
  /**
   * The steps of the experiment run.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["stepName"])
  steps?: StepStatus[];
}

/**
 * Model that represents the a list of branches and branch statuses.
 */
model StepStatus {
  /**
   * The name of the step.
   */
  @visibility(Lifecycle.Read)
  stepName?: string;

  /**
   * The id of the step.
   */
  @visibility(Lifecycle.Read)
  stepId?: string;

  /**
   * The value of the status of the step.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The array of branches.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["branchName"])
  branches?: BranchStatus[];
}

/**
 * Model that represents the a list of actions and action statuses.
 */
model BranchStatus {
  /**
   * The name of the branch status.
   */
  @visibility(Lifecycle.Read)
  branchName?: string;

  /**
   * The id of the branch status.
   */
  @visibility(Lifecycle.Read)
  branchId?: string;

  /**
   * The status of the branch.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The array of actions.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["actionId"])
  actions?: ActionStatus[];
}

/**
 * Model that represents the an action and its status.
 */
model ActionStatus {
  /**
   * The name of the action status.
   */
  @visibility(Lifecycle.Read)
  actionName?: string;

  /**
   * The id of the action status.
   */
  @visibility(Lifecycle.Read)
  actionId?: string;

  /**
   * The status of the action.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * String that represents the start time of the action.
   */
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  /**
   * String that represents the end time of the action.
   */
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  /**
   * The array of targets.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  targets?: ExperimentExecutionActionTargetDetailsProperties[];
}

/**
 * Model that represents the Experiment action target details properties model.
 */
model ExperimentExecutionActionTargetDetailsProperties {
  /**
   * The status of the execution.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The target for the action.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * String that represents the failed date time.
   */
  @visibility(Lifecycle.Read)
  targetFailedTime?: utcDateTime;

  /**
   * String that represents the completed date time.
   */
  @visibility(Lifecycle.Read)
  targetCompletedTime?: utcDateTime;

  /**
   * The error of the action.
   */
  @visibility(Lifecycle.Read)
  error?: ExperimentExecutionActionTargetDetailsError;
}

/**
 * Model that represents the Experiment action target details error model.
 */
model ExperimentExecutionActionTargetDetailsError {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Model that represents a list of Experiment executions and a link for pagination.
 */
model ExperimentExecutionListResult is Azure.Core.Page<ExperimentExecution>;
