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

namespace Microsoft.Network;
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
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkInterfaceIPConfigurations {
  /**
   * Gets the specified network interface ip configuration.
   */
  get is ArmResourceRead<NetworkInterfaceIPConfiguration>;

  /**
   * Get all ip configurations in a network interface.
   */
  list is ArmResourceListByParent<NetworkInterfaceIPConfiguration>;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the ip configuration name."
);
@@doc(NetworkInterfaceIPConfiguration.properties,
  "Network interface IP configuration properties."
);
