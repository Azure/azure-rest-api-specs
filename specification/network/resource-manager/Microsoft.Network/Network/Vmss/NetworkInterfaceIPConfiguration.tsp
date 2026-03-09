import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * IPConfiguration in a network interface.
 */
@parentResource(NetworkInterface)
model NetworkInterfaceIPConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkInterfaceIPConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkInterfaceIPConfiguration,
    KeyName = "ipConfigurationName",
    SegmentName = "ipConfigurations",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias NetworkInterfaceIPConfigurationOps = Azure.ResourceManager.Legacy.RoutedOperations<
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

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface NetworkInterfaceIPConfigurations {
  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}")
  @tag("NetworkInterfaces")
  getVirtualMachineScaleSetIpConfiguration is NetworkInterfaceIPConfigurationOps.ActionSync<
    NetworkInterfaceIPConfiguration,
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

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @key
      ipConfigurationName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<NetworkInterfaceIPConfiguration>,
    OverrideErrorType = CloudError
  >;

  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   */
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations")
  @tag("NetworkInterfaces")
  listVirtualMachineScaleSetIpConfigurations is NetworkInterfaceIPConfigurationOps.ActionSync<
    NetworkInterfaceIPConfiguration,
    Request = void,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("virtualMachineScaleSets")
      @key
      virtualMachineScaleSetName: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("virtualMachines")
      @key
      virtualmachineIndex: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @path
      @segment("networkInterfaces")
      @key
      networkInterfaceName: string;

      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<ResourceListResult<NetworkInterfaceIPConfiguration>>,
    OverrideErrorType = CloudError
  >;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the ip configuration."
);
@@doc(NetworkInterfaceIPConfiguration.properties,
  "Network interface IP configuration properties."
);
