import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineScaleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Describes a Virtual Machine Scale Set Extension.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@parentResource(VirtualMachineScaleSet)
model VirtualMachineScaleSetExtension
  is ProxySubResourceReadOnly<VirtualMachineScaleSetExtensionProperties> {
  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  @encodedName("application/json", "type")
  vmType?: string;

  /**
   * Resource name
   */
  name?: string;

  /**
   * The name of the VM scale set extension.
   */
  @path
  @visibility(Lifecycle.Read)
  @segment("extensions")
  @key("vmssExtensionName")
  vmssExtensionName: string;
}

@armResourceOperations
interface VirtualMachineScaleSetExtensions {
  /**
   * The operation to get the extension.
   */
  get is ComputeResourceRead<
    VirtualMachineScaleSetExtension,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update an extension.
   */
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    VirtualMachineScaleSetExtension,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update an extension.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    VirtualMachineScaleSetExtension,
    VirtualMachineScaleSetExtensionUpdate,
    Response = ArmResponse<VirtualMachineScaleSetExtension> | ArmResourceCreatedResponse<
      VirtualMachineScaleSetExtension,
      LroHeaders = ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * The operation to delete the extension.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<VirtualMachineScaleSetExtension>;

  /**
   * Gets a list of all extensions in a VM scale set.
   */
  list is ComputeResourceListByParent<
    VirtualMachineScaleSetExtension,
    Response = VirtualMachineScaleSetExtensionListResult
  >;
}

@@doc(VirtualMachineScaleSetExtension.properties,
  "Describes the properties of a Virtual Machine Scale Set Extension."
);
@@doc(VirtualMachineScaleSetExtensions.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create VM scale set Extension operation."
);
@@doc(VirtualMachineScaleSetExtensions.update::parameters.properties,
  "Parameters supplied to the Update VM scale set Extension operation."
);
