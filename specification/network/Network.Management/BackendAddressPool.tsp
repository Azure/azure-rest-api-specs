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
@parentResource(LoadBalancer)
model BackendAddressPool
  is Azure.ResourceManager.ProxyResource<BackendAddressPoolPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = BackendAddressPool,
    KeyName = "backendAddressPoolName",
    SegmentName = "backendAddressPools",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias ListInboundNatRulePortMappingsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

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
@armResourceOperations
interface BackendAddressPools {
  /**
   * Gets load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerBackendAddressPools_Get")
  get is ArmResourceRead<BackendAddressPool, Error = CloudError>;

  /**
   * Creates or updates a load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerBackendAddressPools_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BackendAddressPool,
    Error = CloudError
  >;

  /**
   * Deletes the specified load balancer backend address pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("LoadBalancerBackendAddressPools_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BackendAddressPool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all the load balancer backed address pools.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancerBackendAddressPools_List")
  list is ArmResourceListByParent<BackendAddressPool, Error = CloudError>;

  /**
   * List of inbound NAT rule port mappings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancers_ListInboundNatRulePortMappings")
  @action("queryInboundNatRulePortMapping")
  listInboundNatRulePortMappings is ListInboundNatRulePortMappingsOps.ActionAsync<
    BackendAddressPool,
    QueryInboundNatRulePortMappingRequest,
    ArmResponse<BackendAddressInboundNatRulePortMappings> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BackendAddressInboundNatRulePortMappings> &
      Azure.Core.Foundations.RetryAfterHeader>
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
