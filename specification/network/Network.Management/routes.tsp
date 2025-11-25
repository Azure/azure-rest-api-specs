// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ApplicationGatewaysOperationGroup {
  /**
   * Lists all available server variables.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableServerVariables")
  @autoRoute
  @get
  @action("applicationGatewayAvailableServerVariables")
  listAvailableServerVariables is ArmProviderActionSync<
    Response = ApplicationGatewayAvailableServerVariablesResult,
    Scope = SubscriptionActionScope,
    Error = Error
  >;

  /**
   * Lists all available request headers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableRequestHeaders")
  @autoRoute
  @get
  @action("applicationGatewayAvailableRequestHeaders")
  listAvailableRequestHeaders is ArmProviderActionSync<
    Response = ApplicationGatewayAvailableRequestHeadersResult,
    Scope = SubscriptionActionScope,
    Error = Error
  >;

  /**
   * Lists all available response headers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableResponseHeaders")
  @autoRoute
  @get
  @action("applicationGatewayAvailableResponseHeaders")
  listAvailableResponseHeaders is ArmProviderActionSync<
    Response = ApplicationGatewayAvailableResponseHeadersResult,
    Scope = SubscriptionActionScope,
    Error = Error
  >;

  /**
   * Lists all available web application firewall rule sets.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGateways_ListAvailableWafRuleSets")
  @autoRoute
  @get
  @action("applicationGatewayAvailableWafRuleSets")
  listAvailableWafRuleSets is ArmProviderActionSync<
    Response = ApplicationGatewayAvailableWafRuleSetsResult,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableDelegationsOperationGroup {
  /**
   * Gets all of the available subnet delegations for this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableDelegations_List")
  @autoRoute
  @list
  @action("availableDelegations")
  list is ArmProviderActionSync<
    Response = AvailableDelegationsResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableResourceGroupDelegationsOperationGroup {
  /**
   * Gets all of the available subnet delegations for this resource group in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableResourceGroupDelegations_List")
  @autoRoute
  @list
  @action("availableDelegations")
  list is ArmProviderActionSync<
    Response = AvailableDelegationsResult,
    Scope = Extension.ResourceGroup,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableServiceAliasesOperationGroup {
  /**
   * Gets all available service aliases for this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableServiceAliases_List")
  @autoRoute
  @list
  @action("availableServiceAliases")
  list is ArmProviderActionSync<
    Response = AvailableServiceAliasesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;

  /**
   * Gets all available service aliases for this resource group in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableServiceAliases_ListByResourceGroup")
  @autoRoute
  @list
  @action("availableServiceAliases")
  listByResourceGroup is ArmProviderActionSync<
    Response = AvailableServiceAliasesResult,
    Scope = Extension.ResourceGroup,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AzureFirewallFqdnTagsOperationGroup {
  /**
   * Gets all the Azure Firewall FQDN Tags in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AzureFirewallFqdnTags_ListAll")
  @autoRoute
  @get
  @list
  @action("azureFirewallFqdnTags")
  listAll is ArmProviderActionSync<
    Response = ResourceListResult<AzureFirewallFqdnTag>,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

/**
 * Checks whether a domain name in the cloudapp.azure.com zone is available for use.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@autoRoute
@get
@action("CheckDnsNameAvailability")
op checkDnsNameAvailability is ArmProviderActionSync<
  Response = DnsNameAvailabilityResult,
  Scope = SubscriptionActionScope,
  Parameters = {
    ...LocationParameter;

    /**
     * The domain name to be verified. It must conform to the following regular expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$.
     */
    @query("domainNameLabel")
    domainNameLabel: string;
  },
  Error = CloudError
>;

alias RoutesNetworkInterfaceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    @path
    @segment("providers")
    providerName: "microsoft.Compute";

    /** The name of the cloud service. */
    @path
    @segment("cloudServices")
    @key
    cloudServiceName: string;
  },
  {
    /** The name of the network interface. */
    @path
    @segment("networkInterfaces")
    @key
    networkInterfaceName: string;
  }
>;

alias CloudServicesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    @path
    @segment("providers")
    providerName: "microsoft.Compute";

    /** The name of the cloud service. */
    @path
    @segment("cloudServices")
    @key
    cloudServiceName: string;
  },
  {
    /** The name of the public IP Address. */
    @path
    @segment("publicipaddresses")
    @key
    publicIpAddressName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetworkInterfacesOperationGroup {
  /**
   * Gets all network interfaces in a cloud service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkInterfaces_ListCloudServiceNetworkInterfaces")
  @autoRoute
  @get
  listCloudServiceNetworkInterfaces is RoutesNetworkInterfaceOps.List<
    NetworkInterface,
    Response = ResourceListResult<NetworkInterface>,
    OverrideErrorType = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PublicIPAddressesOperationGroup {
  /**
   * Gets information about all public IP addresses on a cloud service level.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PublicIPAddresses_ListCloudServicePublicIPAddresses")
  @autoRoute
  @get
  listCloudServicePublicIPAddresses is CloudServicesOps.List<
    PublicIPAddress,
    Response = ResourceListResult<PublicIPAddress>,
    OverrideErrorType = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableEndpointServicesOperationGroup {
  /**
   * List what values of endpoint services are available for use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailableEndpointServices_List")
  @autoRoute
  @list
  @action("virtualNetworkAvailableEndpointServices")
  list is ArmProviderActionSync<
    Response = EndpointServicesListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ExpressRouteServiceProvidersOperationGroup {
  /**
   * Gets all the available express route service providers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ExpressRouteServiceProviders_List")
  @autoRoute
  @list
  @action("expressRouteServiceProviders")
  list is ArmProviderActionSync<
    Response = ResourceListResult<ExpressRouteServiceProvider>,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LoadBalancersOperationGroup {
  /**
   * Swaps VIPs between two load balancers.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LoadBalancers_SwapPublicIpAddresses")
  @post
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/setLoadBalancerFrontendPublicIpAddresses")
  swapPublicIpAddresses(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,
    @body body: LoadBalancerVipSwapRequest,
  ): OkResponse | ArmAcceptedLroResponse | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetworkSecurityPerimeterAssociableResourceTypesOperationGroup {
  /**
   * Gets the list of resources that are onboarded with NSP. These resources can be associated with a network security perimeter
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterAssociableResourceTypes_List")
  @autoRoute
  @list
  @action("perimeterAssociableResourceTypes")
  list is ArmProviderActionSync<
    Response = PerimeterAssociableResourcesListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetworkSecurityPerimeterOperationStatusesOperationGroup {
  /**
   * Gets the operation status for the given operation id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterOperationStatuses_Get")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/networkSecurityPerimeterOperationStatuses/{operationId}")
  @get
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...LocationResourceParameter,

    /**
     * The operation id of the async operation.
     */
    @path
    operationId: string,
  ): ArmResponse<CommonTypes.OperationStatusResult> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface NetworkSecurityPerimeterServiceTagsOperationGroup {
  /**
   * Gets the list of service tags supported by NSP. These service tags can be used to create access rules in NSP.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkSecurityPerimeterServiceTags_List")
  @autoRoute
  @list
  @action("nspServiceTags")
  list is ArmProviderActionSync<
    Response = NspServiceTagsListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailablePrivateEndpointTypesOperationGroup {
  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailablePrivateEndpointTypes_List")
  @autoRoute
  @get
  @action("availablePrivateEndpointTypes")
  list is ArmProviderActionSync<
    Response = AvailablePrivateEndpointTypesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AvailablePrivateEndpointTypes_ListByResourceGroup")
  @autoRoute
  @list
  @action("availablePrivateEndpointTypes")
  listByResourceGroup is ArmProviderActionSync<
    Response = AvailablePrivateEndpointTypesResult,
    Scope = Extension.ResourceGroup,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PrivateLinkServicesOperationGroup {
  /**
   * Checks whether the subscription is visible to private link service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_CheckPrivateLinkServiceVisibility")
  @autoRoute
  checkPrivateLinkServiceVisibility is ArmProviderActionAsync<
    Request = CheckPrivateLinkServiceVisibilityRequest,
    Response = PrivateLinkServiceVisibility,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
  /**
   * Checks whether the subscription is visible to private link service in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_CheckPrivateLinkServiceVisibilityByResourceGroup")
  @autoRoute
  @action("checkPrivateLinkServiceVisibility")
  checkPrivateLinkServiceVisibilityByResourceGroup is ArmProviderActionAsync<
    Request = CheckPrivateLinkServiceVisibilityRequest,
    Response = PrivateLinkServiceVisibility,
    Scope = Extension.ResourceGroup,
    Parameters = LocationParameter,
    Error = CloudError
  >;
  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto approved in this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_ListAutoApprovedPrivateLinkServices")
  @autoRoute
  @list
  @action("autoApprovedPrivateLinkServices")
  listAutoApprovedPrivateLinkServices is ArmProviderActionSync<
    Response = AutoApprovedPrivateLinkServicesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
  /**
   * Returns all of the private link service ids that can be linked to a Private Endpoint with auto approved in this subscription in this region.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkServices_ListAutoApprovedPrivateLinkServicesByResourceGroup")
  @autoRoute
  @list
  @action("autoApprovedPrivateLinkServices")
  listAutoApprovedPrivateLinkServicesByResourceGroup is ArmProviderActionSync<
    Response = AutoApprovedPrivateLinkServicesResult,
    Scope = Extension.ResourceGroup,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface BgpServiceCommunitiesOperationGroup {
  /**
   * Gets all the available bgp service communities.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BgpServiceCommunities_List")
  @autoRoute
  @get
  @action("bgpServiceCommunities")
  list is ArmProviderActionSync<
    Response = ResourceListResult<BgpServiceCommunity>,
    Scope = SubscriptionActionScope,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServiceTagsOperationGroup {
  /**
   * Gets a list of service tag information resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceTags_List")
  @autoRoute
  @get
  @action("serviceTags")
  list is ArmProviderActionSync<
    Response = ServiceTagsListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServiceTagInformationOperationGroup {
  /**
   * Gets a list of service tag information resources with pagination.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ServiceTagInformation_List")
  @autoRoute
  @list
  @action("serviceTagDetails")
  list is ArmProviderActionSync<
    Response = ServiceTagInformationListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * Do not return address prefixes for the tag(s).
       */
      @query("noAddressPrefixes")
      noAddressPrefixes?: boolean;

      /**
       * Return tag information for a particular tag.
       */
      @query("tagName")
      tagName?: string;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * List network usages for a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_List")
  @autoRoute
  @list
  @action("usages")
  list is ArmProviderActionSync<
    Response = UsagesListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = CloudError
  >;
}

@@Azure.ClientGenerator.Core.clientName(PrivateLinkServicesOperationGroup.checkPrivateLinkServiceVisibilityByResourceGroup::parameters.body,
  "parameters"
);