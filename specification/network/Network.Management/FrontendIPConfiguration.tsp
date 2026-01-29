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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@parentResource(LoadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FrontendIPConfiguration extends SubResourceModel {
  properties?: FrontendIPConfigurationPropertiesFormat;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @path
  @key("frontendIPConfigurationName")
  @segment("frontendIPConfigurations")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
@@doc(FrontendIPConfiguration.name,
  "The name of the resource that is unique within the set of frontend IP configurations used by the load balancer. This name can be used to access the resource."
);
@@doc(FrontendIPConfiguration.properties,
  "Properties of the load balancer probe."
);
