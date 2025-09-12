import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * The task run that has the ARM resource and properties.
 * The task run will have the information of request and result of a run.
 */
@parentResource(Registry)
model TaskRun is Azure.ResourceManager.ProxyResource<TaskRunProperties> {
  ...ResourceNameParameter<
    Resource = TaskRun,
    KeyName = "taskRunName",
    SegmentName = "taskRuns",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;

  /**
   * The location of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface TaskRuns {
  /**
   * Gets the detailed information for a given task run.
   */
  get is ArmResourceRead<TaskRun>;

  /**
   * Creates a task run for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<TaskRun>;

  /**
   * Updates a task run with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    TaskRun,
    PatchModel = TaskRunUpdateParameters,
    Response = TaskRun | ArmResourceCreatedResponse<
      TaskRun,
      LroHeaders = ArmAsyncOperationHeader<FinalResult = TaskRun> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a specified task run resource.
   */
  delete is ArmResourceDeleteSync<TaskRun>;

  /**
   * Lists all the task runs for a specified container registry.
   */
  @list
  list is ArmResourceListByParent<
    TaskRun,
    Response = ArmResponse<TaskRunListResult>
  >;

  /**
   * Gets the detailed information for a given task run that includes all secrets.
   */
  @action("listDetails")
  getDetails is ArmResourceActionSync<TaskRun, void, ArmResponse<TaskRun>>;
}

@@maxLength(TaskRun.name, 50);
@@minLength(TaskRun.name, 5);
@@doc(TaskRun.name, "The name of the task run.");
@@doc(TaskRun.properties,
  "The properties associated with the task run, i.e., request and result of the run"
);
@@doc(TaskRuns.create::parameters.resource,
  "The parameters of a run that needs to scheduled."
);
@@doc(TaskRuns.update::parameters.properties,
  "The parameters for updating a task run."
);
