import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineScaleSet.tsp";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Compute;

/**
 * Defines a virtual machine scale set lifecycle hook event.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "backcompat"
@added(Versions.v2025_11_01)
@parentResource(VirtualMachineScaleSet)
model VMScaleSetLifecycleHookEvent
  is ProxyResource<VMScaleSetLifecycleHookEventProperties> {
  ...ResourceNameParameter<
    Resource = VMScaleSetLifecycleHookEvent,
    KeyName = "lifecycleHookEventName",
    SegmentName = "lifecycleHookEvents",
    NamePattern = ""
  >;
}

/**
 * The List virtual machine scale set lifecycle hook events operation response.
 */
@added(Versions.v2025_11_01)
model VMScaleSetLifecycleHookEventListResult
  is Azure.Core.Page<VMScaleSetLifecycleHookEvent>;

@@identifiers(VMScaleSetLifecycleHookEventListResult.value, #["name", "id"]);

@@doc(VMScaleSetLifecycleHookEventListResult.value,
  "The list of virtual machine scale set lifecycle hook events created for a virtual machine scale set resource."
);
@@doc(VMScaleSetLifecycleHookEventListResult.nextLink,
  "The uri to fetch the next page of virtual machine scale set lifecycle hook events. Call ListNext() with this to fetch the next page of virtual machine scale set lifecycle hook events."
);

@armResourceOperations
@added(Versions.v2025_11_01)
interface VirtualMachineScaleSetLifeCycleHookEvents {
  /**
   * Gets a virtual machine scale set lifecycle hook event.
   */
  get is ComputeResourceRead<VMScaleSetLifecycleHookEvent>;

  /**
   * The operation to update a virtual machine scale set lifecycle hook event.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchSync<
    VMScaleSetLifecycleHookEvent,
    VMScaleSetLifecycleHookEventUpdate,
    Response = ArmResponse<VMScaleSetLifecycleHookEvent>
  >;

  /**
   * Gets a list of virtual machine scale set lifecycle hook events created for a virtual machine scale set resource.
   */
  list is ComputeResourceListByParent<
    VMScaleSetLifecycleHookEvent,
    Response = VMScaleSetLifecycleHookEventListResult
  >;
}

@@doc(VMScaleSetLifecycleHookEvent.properties,
  "Defines the virtual machine scale set lifecycle hook event properties."
);
@@doc(VirtualMachineScaleSetLifeCycleHookEvents.update::parameters.properties,
  "Parameters supplied to the Update virtual machine scale set lifecycle hook event operation."
);
