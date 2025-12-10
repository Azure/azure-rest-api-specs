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

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface NetworkInterfaceIPConfigurations {
  /**
   * Gets the specified network interface ip configuration.
   */
  get is ArmResourceRead<NetworkInterfaceIPConfiguration, Error = CloudError>;

  /**
   * Get all ip configurations in a network interface.
   */
  list is ArmResourceListByParent<
    NetworkInterfaceIPConfiguration,
    Error = CloudError
  >;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the ip configuration name."
);
@@doc(NetworkInterfaceIPConfiguration.properties,
  "Network interface IP configuration properties."
);
