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
    NetworkInterface,
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
    Response = ArmResponse<NetworkInterface>,
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
    NetworkInterface,
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
    Response = ArmResponse<ResourceListResult<NetworkInterface>>,
    OverrideErrorType = CloudError
  >;
}

@@doc(NetworkInterface.name, "The name of the network interface.");
@@doc(NetworkInterface.properties, "Properties of the network interface.");
