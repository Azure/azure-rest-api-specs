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
 * Tap configuration in a Network Interface.
 */
@parentResource(NetworkInterface)
model NetworkInterfaceTapConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkInterfaceTapConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = NetworkInterfaceTapConfiguration,
    KeyName = "tapConfigurationName",
    SegmentName = "tapConfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface NetworkInterfaceTapConfigurations {
  /**
   * Get the specified tap configuration on a network interface.
   */
  get is ArmResourceRead<NetworkInterfaceTapConfiguration, Error = CloudError>;

  /**
   * Creates or updates a Tap configuration in the specified NetworkInterface.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NetworkInterfaceTapConfiguration, Error = CloudError>;

  /**
   * Deletes the specified tap configuration from the NetworkInterface.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterfaceTapConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Get all Tap configurations in a network interface.
   */
  list is ArmResourceListByParent<NetworkInterfaceTapConfiguration, Error = CloudError>;
}

@@doc(NetworkInterfaceTapConfiguration.name,
  "The name of the tap configuration."
);
@@doc(NetworkInterfaceTapConfiguration.properties,
  "Properties of the Virtual Network Tap configuration."
);
@@doc(NetworkInterfaceTapConfigurations.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update tap configuration operation."
);
