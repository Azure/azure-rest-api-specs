import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./HybridComputePrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * Properties that define a Network Security Perimeter resource.
 */
@parentResource(HybridComputePrivateLinkScope)
model NetworkSecurityPerimeterConfiguration
  is Azure.ResourceManager.ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSecurityPerimeterConfiguration,
    KeyName = "perimeterName",
    SegmentName = "networkSecurityPerimeterConfigurations",
    NamePattern = "^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[.]{1}.+$"
  >;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  /**
   * Gets the network security perimeter configuration for a private link scope.
   */
  getByPrivateLinkScope is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;

  /**
   * Lists the network security perimeter configurations for a private link scope.
   */
  listByPrivateLinkScope is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;

  /**
   * Forces the network security perimeter configuration to refresh for a private link scope.
   */
  @action("reconcile")
  reconcileForPrivateLinkScope is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    void,
    ArmResponse<NetworkSecurityPerimeterConfigurationReconcileResult>
  >;
}

@@doc(NetworkSecurityPerimeterConfiguration.name,
  "The name, in the format {perimeterGuid}.{associationName}, of the Network Security Perimeter resource."
);
@@doc(NetworkSecurityPerimeterConfiguration.properties,
  "Properties that define a Network Security Perimeter resource."
);
