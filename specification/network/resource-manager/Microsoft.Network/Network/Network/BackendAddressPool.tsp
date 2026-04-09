import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./LoadBalancer.tsp";
import "../Common/BackendAddressPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

alias ListInboundNatRulePortMappingsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("resourceGroups")
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the load balancer. */
    @path
    @segment("loadBalancers")
    @key
    loadBalancerName: string;
  },
  {
    /** The name of the backend address pool. */
    @path
    @segment("backendAddressPools")
    @key
    backendPoolName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@armResourceOperations(#{ omitTags: true })
interface BackendAddressPools {
  /**
   * Gets load balancer backend address pool.
   */
  @tag("LoadBalancers")
  get is ArmResourceRead<BackendAddressPool, Error = CloudError>;

  /**
   * Creates or updates a load balancer backend address pool.
   */
  @tag("LoadBalancers")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BackendAddressPool,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LoadBalancers")
  delete is ArmResourceDeleteWithoutOkAsync<
    BackendAddressPool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the load balancer backed address pools.
   */
  @tag("LoadBalancers")
  list is ArmResourceListByParent<
    BackendAddressPool,
    Response = LoadBalancerBackendAddressPoolListResult,
    Error = CloudError
  >;

  /**
   * List of inbound NAT rule port mappings.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("LoadBalancers")
  @action("queryInboundNatRulePortMapping")
  listInboundNatRulePortMappings is ListInboundNatRulePortMappingsOps.ActionAsync<
    BackendAddressPool,
    QueryInboundNatRulePortMappingRequest,
    void,
    Response = ArmResponse<BackendAddressInboundNatRulePortMappings> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BackendAddressInboundNatRulePortMappings> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @body
      _: BackendAddressInboundNatRulePortMappings;
    }),
    OverrideErrorType = CloudError
  >;
}

@@doc(BackendAddressPool.name, "The name of the backend address pool.");
@@doc(BackendAddressPool.properties,
  "Properties of load balancer backend address pool."
);
@@doc(BackendAddressPools.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update load balancer backend address pool operation."
);
@@doc(BackendAddressPools.listInboundNatRulePortMappings::parameters.body,
  "Query inbound NAT rule port mapping request."
);
