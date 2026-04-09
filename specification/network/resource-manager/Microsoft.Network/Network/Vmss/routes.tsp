import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "../Common/main.tsp";
import "../Common/NetworkInterface.tsp";
import "../Common/PublicIPAddress.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Compute;

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
interface NetworkInterfacesOperationGroup {
  /**
   * Gets all network interfaces in a virtual machine scale set.
   */
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PublicIPAddressesOperationGroup {
  /**
   * Gets information about all public IP addresses on a virtual machine scale set level.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/publicipaddresses")
  listVirtualMachineScaleSetPublicIPAddresses is PublicIPAddressListOps.ActionSync<
    PublicIPAddress,
    Request = void,
    Parameters = {
      /**
       * The name of the virtual machine scale set.
       */
      @path
      @key
      virtualMachineScaleSetName: string;
    },
    Response = ArmResponse<ResourceListResult<PublicIPAddress>>,
    OverrideErrorType = CloudError
  >;
}
