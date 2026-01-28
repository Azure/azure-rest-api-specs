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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(NetworkInterface)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkInterfaceIPConfiguration extends SubResourceModel {
  properties?: NetworkInterfaceIPConfigurationPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("ipConfigurationName")
  @segment("ipConfigurations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@@doc(NetworkInterfaceIPConfiguration.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);

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
