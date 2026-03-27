import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * A network interface in a resource group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NetworkInterface
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NetworkInterfacePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkInterface,
    KeyName = "networkInterfaceName",
    SegmentName = "networkInterfaces",
    NamePattern = ""
  >;

  /**
   * The extended location of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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
  listVirtualMachineScaleSetVMNetworkInterfaces is ArmResourceListByParent<
    NetworkInterface,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("virtualMachineScaleSets")
      virtualMachineScaleSetName: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("virtualMachines")
      virtualmachineIndex: string;
    },
    Error = CloudError
  >;
}

@@doc(NetworkInterface.name, "The name of the network interface.");
@@doc(NetworkInterface.properties, "Properties of the network interface.");
