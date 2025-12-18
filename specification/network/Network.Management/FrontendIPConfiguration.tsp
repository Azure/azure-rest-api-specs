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
  
  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;

  /**
   * A list of availability zones denoting the IP allocated for the resource needs to come from.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: string[];
}

@armResourceOperations
interface FrontendIPConfigurations {
  /**
   * Gets load balancer frontend IP configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerFrontendIPConfigurations_Get")
  get is ArmResourceRead<FrontendIPConfiguration, Error = CloudError>;

  /**
   * Gets all the load balancer frontend IP configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerFrontendIPConfigurations_List")
  list is ArmResourceListByParent<
    FrontendIPConfiguration,
    Response = LoadBalancerFrontendIPConfigurationListResult,
    Error = CloudError
  >;
}

@@doc(FrontendIPConfiguration.name,
  "The name of the frontend IP configuration."
);
@@doc(FrontendIPConfiguration.properties,
  "Properties of the load balancer probe."
);
