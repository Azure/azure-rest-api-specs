import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";
import "../Common/FrontendIPConfiguration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface FrontendIPConfigurations {
  /**
   * Gets load balancer frontend IP configuration.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<FrontendIPConfiguration, Error = CloudError>;

  /**
   * Gets all the load balancer frontend IP configurations.
   */
  @tag("LoadBalancers")
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
