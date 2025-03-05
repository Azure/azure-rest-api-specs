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
  @visibility("read")
  status?: string;

  /**
   * String that represents the start date time.
   */
  @visibility("read")
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility("read")
  stoppedAt?: utcDateTime;

  /**
   * Resource provisioning state. Not currently in use for executions.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Model that represents the execution details of an Experiment.
 */
model ExperimentExecutionDetails {
  /**
   * String of the resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * String of the fully qualified resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * String of the resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The properties of the experiment execution details.
   */
  @visibility("read")
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
  @visibility("read")
  status?: string;

  /**
   * String that represents the start date time.
   */
  @visibility("read")
  startedAt?: utcDateTime;

  /**
   * String that represents the stop date time.
   */
  @visibility("read")
  stoppedAt?: utcDateTime;

  /**
   * Resource provisioning state. Not currently in use for executions.
   */
  @removed(Microsoft.Chaos.Versions.v2025_01_01)
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The reason why the execution failed.
   */
  @visibility("read")
  failureReason?: string;

  /**
   * String that represents the last action date time.
   */
  @visibility("read")
  lastActionAt?: utcDateTime;

  /**
   * The information of the experiment run.
   */
  @visibility("read")
  runInformation?: ExperimentExecutionDetailsPropertiesRunInformation;
}

/**
 * The information of the experiment run.
 */
model ExperimentExecutionDetailsPropertiesRunInformation {
  /**
   * The steps of the experiment run.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["stepName"])
  steps?: StepStatus[];
}

/**
 * Model that represents the a list of branches and branch statuses.
 */
model StepStatus {
  /**
   * The name of the step.
   */
  @visibility("read")
  stepName?: string;

  /**
   * The id of the step.
   */
  @visibility("read")
  stepId?: string;

  /**
   * The value of the status of the step.
   */
  @visibility("read")
  status?: string;

  /**
   * The array of branches.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["branchName"])
  branches?: BranchStatus[];
}

/**
 * Model that represents the a list of actions and action statuses.
 */
model BranchStatus {
  /**
   * The name of the branch status.
   */
  @visibility("read")
  branchName?: string;

  /**
   * The id of the branch status.
   */
  @visibility("read")
  branchId?: string;

  /**
   * The status of the branch.
   */
  @visibility("read")
  status?: string;

  /**
   * The array of actions.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["actionId"])
  actions?: ActionStatus[];
}

/**
 * Model that represents the an action and its status.
 */
model ActionStatus {
  /**
   * The name of the action status.
   */
  @visibility("read")
  actionName?: string;

  /**
   * The id of the action status.
   */
  @visibility("read")
  actionId?: string;

  /**
   * The status of the action.
   */
  @visibility("read")
  status?: string;

  /**
   * String that represents the start time of the action.
   */
  @visibility("read")
  startTime?: utcDateTime;

  /**
   * String that represents the end time of the action.
   */
  @visibility("read")
  endTime?: utcDateTime;

  /**
   * The array of targets.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  targets?: ExperimentExecutionActionTargetDetailsProperties[];
}

/**
 * Model that represents the Experiment action target details properties model.
 */
model ExperimentExecutionActionTargetDetailsProperties {
  /**
   * The status of the execution.
   */
  @visibility("read")
  status?: string;

  /**
   * The target for the action.
   */
  @visibility("read")
  target?: string;

  /**
   * String that represents the failed date time.
   */
  @visibility("read")
  targetFailedTime?: utcDateTime;

  /**
   * String that represents the completed date time.
   */
  @visibility("read")
  targetCompletedTime?: utcDateTime;

  /**
   * The error of the action.
   */
  @visibility("read")
  error?: ExperimentExecutionActionTargetDetailsError;
}

/**
 * Model that represents the Experiment action target details error model.
 */
model ExperimentExecutionActionTargetDetailsError {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message
   */
  @visibility("read")
  message?: string;
}

/**
 * Model that represents a list of Experiment executions and a link for pagination.
 */
model ExperimentExecutionListResult is Azure.Core.Page<ExperimentExecution>;
