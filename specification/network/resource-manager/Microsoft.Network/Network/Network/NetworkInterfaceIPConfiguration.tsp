import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkInterface.tsp";
import "../Common/NetworkInterfaceIPConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface NetworkInterfaceIPConfigurations {
  /**
   * Gets the specified network interface ip configuration.
   */
  @tag("NetworkInterfaces")
  get is ArmResourceRead<NetworkInterfaceIPConfiguration, Error = CloudError>;

  /**
   * Get all ip configurations in a network interface.
   */
  @tag("NetworkInterfaces")
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
