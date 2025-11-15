import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Update.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Details of an Update run
 */
@parentResource(Update)
model UpdateRun is Azure.ResourceManager.ProxyResource<UpdateRunProperties> {
  ...ResourceNameParameter<
    Resource = UpdateRun,
    KeyName = "updateRunName",
    SegmentName = "updateRuns",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface UpdateRuns {
  /**
   * Get the Update run for a specified update
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<UpdateRun>;

  /**
   * Put Update runs for a specified update
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    UpdateRun,
    Response = ArmResourceCreatedResponse<UpdateRun> | ArmResourceUpdatedResponse<UpdateRun>
  >;

  /**
   * Delete specified Update Run
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    UpdateRun,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> &
      ArmLroLocationHeader) | ArmDeletedNoContentResponse
  >;

  /**
   * List all Update runs for a specified update
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  list is ArmResourceListByParent<
    UpdateRun,
    Response = ArmResponse<UpdateRunList>
  >;
}

@@doc(UpdateRun.name, "The name of the Update Run");
@@doc(UpdateRun.properties, "Describes Update Run Properties.");
@@doc(UpdateRuns.put::parameters.resource,
  "Properties of the updateRuns object"
);

// Models

/**
 * List of Update runs
 */
model UpdateRunList is Azure.Core.Page<UpdateRun>;

/**
 * Details of an Update run
 */
model UpdateRunProperties {
  /**
   * Provisioning state of the UpdateRuns proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Timestamp of the update run was started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStarted?: utcDateTime;

  /**
   * Timestamp of the most recently completed step in the update run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * Duration of the update run.
   */
  duration?: string;

  /**
   * State of the update run.
   */
  state?: UpdateRunPropertiesState;

  /**
   * Progress representation of the update run steps.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  progress?: UpdateRunsStep;
}

/**
 * Progress representation of the update run steps.
 */
model UpdateRunsStep {
  /**
   * Name of the step.
   */
  name?: string;

  /**
   * More detailed description of the step.
   */
  description?: string;

  /**
   * Error message, specified if the step is in a failed state.
   */
  errorMessage?: string;

  /**
   * Status of the step, bubbled up from the ECE action plan for installation attempts. Values are: 'Success', 'Error', 'InProgress', and 'Unknown status'.
   */
  status?: string;

  /**
   * When the step started, or empty if it has not started executing.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * When the step reached a terminal state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Completion time of this step or the last completed sub-step.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  /**
   * Expected execution time of a given step. This is optionally authored in the update action plan and can be empty.
   */
  expectedExecutionTime?: string;

  /**
   * Recursive model for child steps of this step.
   */
  @identifiers(#["name"])
  steps?: UpdateRunsStep[];
}
