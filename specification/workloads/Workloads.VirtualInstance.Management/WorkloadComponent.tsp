import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "./VirtualInstance.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Workloads;
/**
 * Defines the Workload Component resource.
 */
@parentResource(VirtualInstance)
model WorkloadComponent is TrackedResource<WorkloadComponentProperties> {
  ...ResourceNameParameter<
    Resource = VirtualInstance,
    KeyName = "componentName",
    SegmentName = "components",
    NamePattern = "^[a-zA-Z0-9-_]{3,64}$"
  >;
}

@armResourceOperations
interface WorkloadComponents {
  /**
   * Gets the workload component corresponding to the Virtual Instance resource.
   */
  get is ArmResourceRead<WorkloadComponent>;

  /**
   * Creates a workload component corresponding to the Virtual Instance resource.
   */
  create is ArmResourceCreateOrReplaceAsync<WorkloadComponent>;

  /**
   * Updates a workload component corresponding to the Virtual Instance resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    WorkloadComponent,
    UpdateWorkloadComponentRequest
  >;

  /**
   * Deletes the workload component corresponding to the Virtual Instance resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadComponent>;

  /**
   * List all the workload components corresponding to the Virtual Instance resource.
   */
  @list
  list is ArmResourceListByParent<WorkloadComponent>;
}

@@doc(WorkloadComponent.name, "The name of the Workload Component resource");
@@doc(WorkloadComponents.create::parameters.resource,
  "Request body to create the Workload Component resource."
);
