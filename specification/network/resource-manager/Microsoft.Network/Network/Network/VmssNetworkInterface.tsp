import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./shared-models.tsp";
import "./NetworkInterface.models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

alias VmssNetworkInterfaceOps = Azure.ResourceManager.Legacy.RoutedOperations<
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

alias NetworkInterfaceListOps = Azure.ResourceManager.Legacy.RoutedOperations<
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

alias PublicIPAddressListOps = Azure.ResourceManager.Legacy.RoutedOperations<
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The fixed VMSS API version is required for backward compatibility."
@featureFile(Features.vmssNetworkConfiguration)
@Azure.Core.Legacy.overrideApiVersion("2018-10-01")
interface VmssNetworkInterfacesOperationGroup {
  /**
   * Gets all network interfaces in a virtual machine scale set.
   */
  @featureFile(Features.vmssNetworkConfiguration)
  @tag("NetworkInterfaces")
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/networkInterfaces")
  listVirtualMachineScaleSetNetworkInterfaces is NetworkInterfaceListOps.ActionSync<
    NetworkInterface,
    Request = void,
    Parameters = {
      /**
       * The name of the virtual machine scale set.
       */
      @path
      @key
      virtualMachineScaleSetName: string;
    },
    Response = ArmResponse<ResourceListResult<NetworkInterface>>,
    OverrideErrorType = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "The fixed VMSS API version is required for backward compatibility."
@featureFile(Features.vmssNetworkConfiguration)
@Azure.Core.Legacy.overrideApiVersion("2018-10-01")
@armResourceOperations(#{ allowStaticRoutes: true })
interface VmssNetworkInterfaces {
  /**
   * Get the specified network interface in a virtual machine scale set.
   */
  @featureFile(Features.vmssNetworkConfiguration)
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}")
  getVirtualMachineScaleSetNetworkInterface is VmssNetworkInterfaceOps.ActionSync<
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
  @featureFile(Features.vmssNetworkConfiguration)
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces")
  listVirtualMachineScaleSetVMNetworkInterfaces is VmssNetworkInterfaceOps.ActionSync<
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
