import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../Common/main.tsp";
import "../Common/NetworkInterface.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Compute;

/**
 * A virtual machine scale set in the Network SDK surface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Common.Features.virtualNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualMachineScaleSetNetwork extends Common.Resource {
  @visibility(Lifecycle.Read)
  @path
  @key("virtualMachineScaleSetName")
  @segment("virtualMachineScaleSets")
  name: string;
}

/**
 * A virtual machine scale set VM in the Network SDK surface.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Common.Features.virtualNetwork)
@parentResource(VirtualMachineScaleSetNetwork)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VirtualMachineScaleSetVmNetwork extends Common.Resource {
  @visibility(Lifecycle.Read)
  @path
  @key("virtualmachineIndex")
  @segment("virtualMachines")
  name: string;
}

/**
 * A network interface in a virtual machine scale set VM.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Common.Features.virtualNetwork)
@parentResource(VirtualMachineScaleSetVmNetwork)
model VirtualMachineScaleSetNetworkInterface extends NetworkInterface {
  @visibility(Lifecycle.Read)
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;
}

alias NetworkInterfaceOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {},
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface NetworkInterfaces {
  /**
   * Get the specified network interface in a virtual machine scale set.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}")
  getVirtualMachineScaleSetNetworkInterface is NetworkInterfaceOps.ActionSync<
    VirtualMachineScaleSetNetworkInterface,
    Request = void,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      virtualMachineScaleSetName: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      virtualmachineIndex: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      networkInterfaceName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<VirtualMachineScaleSetNetworkInterface>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets information about all network interfaces in a virtual machine in a virtual machine scale set.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces")
  listVirtualMachineScaleSetVMNetworkInterfaces is NetworkInterfaceOps.ActionSync<
    VirtualMachineScaleSetNetworkInterface,
    Request = void,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      virtualMachineScaleSetName: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      virtualmachineIndex: string;
    },
    Response = ArmResponse<
      ResourceListResult<VirtualMachineScaleSetNetworkInterface>
    >,
    OverrideErrorType = CloudError
  >;
}

@@doc(VirtualMachineScaleSetNetworkInterface.name,
  "The name of the network interface."
);
@@doc(VirtualMachineScaleSetNetworkInterface.properties,
  "Properties of the network interface."
);
