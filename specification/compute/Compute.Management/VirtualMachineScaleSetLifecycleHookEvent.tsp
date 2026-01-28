import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineScaleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Compute;

/**
 * Defines a VMScaleSet lifecycle hook event.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "backcompat"
@parentResource(VirtualMachineScaleSet)
model VMScaleSetLifecycleHookEvent
  is ProxyResource<VMScaleSetLifecycleHookEventProperties> {
  ...ResourceNameParameter<
    Resource = VMScaleSetLifecycleHookEvent,
    KeyName = "lifecycleHookEvent",
    SegmentName = "lifecycleHookEvents",
    NamePattern = ""
  >;
}

/**
 * The List VMScaleSet lifecycle hook events operation response.
 */
model VMScaleSetLifecycleHookEventListResult
  is Azure.Core.Page<VMScaleSetLifecycleHookEvent>;

@@identifiers(VMScaleSetLifecycleHookEventListResult.value, #["name", "id"]);

@@doc(VMScaleSetLifecycleHookEventListResult.value,
  "The list of VMScaleSet lifecycle hook events."
);
@@doc(VMScaleSetLifecycleHookEventListResult.nextLink,
  "The uri to fetch the next page of virtual machine scale set lifecycle hook events. Call ListNext() with this to fetch the next page of VMScaleSet lifecycle hook events."
);

@armResourceOperations
interface VirtualMachineScaleSetLifeCycleHookEvents {
  /**
   * Gets a VMScaleSet lifecycle hook event.
   */
  get is ComputeResourceRead<VMScaleSetLifecycleHookEvent>;

  /**
   * The operation to update an VMScaleSet lifecycle hook event.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchSync<
    VMScaleSetLifecycleHookEvent,
    VMScaleSetLifecycleHookEvent,
    Response = ArmResponse<VMScaleSetLifecycleHookEvent>
  >;

  /**
   * Gets a list of all lifecycle hook in a VMScaleSet.
   */
  list is ComputeResourceListByParent<
    VMScaleSetLifecycleHookEvent,
    Response = VMScaleSetLifecycleHookEventListResult
  >;
}

@@doc(VMScaleSetLifecycleHookEvent.properties,
  "Defines the VMScaleSet lifecycle hook event properties."
);
@@doc(VirtualMachineScaleSetLifeCycleHookEvents.update::parameters.properties,
  "Parameters supplied to the Update VMScaleSet lifecycle hook event."
);
