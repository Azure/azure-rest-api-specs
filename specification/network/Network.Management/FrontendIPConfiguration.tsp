import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Frontend IP address of the load balancer.
 */
@parentResource(LoadBalancer)
model FrontendIPConfiguration
  is Azure.ResourceManager.ProxyResource<FrontendIPConfigurationPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = FrontendIPConfiguration,
    KeyName = "frontendIPConfigurationName",
    SegmentName = "frontendIPConfigurations",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...Azure.ResourceManager.AvailabilityZonesProperty;
}

@armResourceOperations
interface FrontendIPConfigurations {
  /**
   * Gets load balancer frontend IP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerFrontendIPConfigurations_Get")
  get is ArmResourceRead<FrontendIPConfiguration>;

  /**
   * Gets all the load balancer frontend IP configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerFrontendIPConfigurations_List")
  list is ArmResourceListByParent<FrontendIPConfiguration>;
}

@@doc(FrontendIPConfiguration.name,
  "The name of the frontend IP configuration."
);
@@doc(FrontendIPConfiguration.properties,
  "Properties of the load balancer probe."
);
