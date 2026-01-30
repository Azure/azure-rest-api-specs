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
 * Pool of backend IP addresses.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.loadBalancer)
@parentResource(LoadBalancer)
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackendAddressPool extends SubResourceModel {
  properties?: BackendAddressPoolPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("backendAddressPoolName")
  @segment("backendAddressPools")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

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
@armResourceOperations
interface BackendAddressPools {
  /**
   * Gets load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerBackendAddressPools_Get")
  get is ArmResourceRead<BackendAddressPool, Error = CloudError>;

  /**
   * Creates or updates a load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerBackendAddressPools_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BackendAddressPool,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerBackendAddressPools_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BackendAddressPool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the load balancer backed address pools.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancerBackendAddressPools_List")
  list is ArmResourceListByParent<
    BackendAddressPool,
    Response = LoadBalancerBackendAddressPoolListResult,
    Error = CloudError
  >;

  /**
   * List of inbound NAT rule port mappings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("LoadBalancers_ListInboundNatRulePortMappings")
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
