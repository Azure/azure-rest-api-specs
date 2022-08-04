import * as coreClient from "@azure/core-client";
import * as coreRestPipeline from "@azure/core-rest-pipeline";
import * as coreAuth from "@azure/core-auth";
import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "./lroImpl";
import {
  ApplicationGatewaysImpl,
  ApplicationGatewayPrivateLinkResourcesImpl,
  ApplicationGatewayPrivateEndpointConnectionsImpl,
  ApplicationSecurityGroupsImpl,
  AvailableDelegationsImpl,
  AvailableResourceGroupDelegationsImpl,
  AvailableServiceAliasesImpl,
  AzureFirewallsImpl,
  AzureFirewallFqdnTagsImpl,
  WebCategoriesImpl,
  BastionHostsImpl,
  NetworkInterfacesImpl,
  PublicIPAddressesImpl,
  CustomIPPrefixesImpl,
  DdosCustomPoliciesImpl,
  DdosProtectionPlansImpl,
  DscpConfigurationOperationsImpl,
  AvailableEndpointServicesImpl,
  ExpressRouteCircuitAuthorizationsImpl,
  ExpressRouteCircuitPeeringsImpl,
  ExpressRouteCircuitConnectionsImpl,
  PeerExpressRouteCircuitConnectionsImpl,
  ExpressRouteCircuitsImpl,
  ExpressRouteServiceProvidersImpl,
  ExpressRouteCrossConnectionsImpl,
  ExpressRouteCrossConnectionPeeringsImpl,
  ExpressRoutePortsLocationsImpl,
  ExpressRoutePortsImpl,
  ExpressRouteLinksImpl,
  ExpressRoutePortAuthorizationsImpl,
  ExpressRouteProviderPortsLocationImpl,
  FirewallPoliciesImpl,
  FirewallPolicyRuleCollectionGroupsImpl,
  FirewallPolicyIdpsSignaturesImpl,
  FirewallPolicyIdpsSignaturesOverridesImpl,
  FirewallPolicyIdpsSignaturesFilterValuesImpl,
  IpAllocationsImpl,
  IpGroupsImpl,
  LoadBalancersImpl,
  LoadBalancerBackendAddressPoolsImpl,
  LoadBalancerFrontendIPConfigurationsImpl,
  InboundNatRulesImpl,
  LoadBalancerLoadBalancingRulesImpl,
  LoadBalancerOutboundRulesImpl,
  LoadBalancerNetworkInterfacesImpl,
  LoadBalancerProbesImpl,
  NatGatewaysImpl,
  NetworkInterfaceIPConfigurationsImpl,
  NetworkInterfaceLoadBalancersImpl,
  NetworkInterfaceTapConfigurationsImpl,
  NetworkManagersImpl,
  NetworkManagerCommitsImpl,
  NetworkManagerDeploymentStatusOperationsImpl,
  SubscriptionNetworkManagerConnectionsImpl,
  ManagementGroupNetworkManagerConnectionsImpl,
  ConnectivityConfigurationsImpl,
  NetworkGroupsImpl,
  StaticMembersImpl,
  ScopeConnectionsImpl,
  SecurityAdminConfigurationsImpl,
  AdminRuleCollectionsImpl,
  AdminRulesImpl,
  NetworkProfilesImpl,
  NetworkSecurityGroupsImpl,
  SecurityRulesImpl,
  DefaultSecurityRulesImpl,
  NetworkVirtualAppliancesImpl,
  VirtualApplianceSitesImpl,
  VirtualApplianceSkusImpl,
  InboundSecurityRuleOperationsImpl,
  NetworkWatchersImpl,
  PacketCapturesImpl,
  ConnectionMonitorsImpl,
  FlowLogsImpl,
  OperationsImpl,
  PrivateEndpointsImpl,
  AvailablePrivateEndpointTypesImpl,
  PrivateDnsZoneGroupsImpl,
  PrivateLinkServicesImpl,
  PublicIPPrefixesImpl,
  RouteFiltersImpl,
  RouteFilterRulesImpl,
  RouteTablesImpl,
  RoutesImpl,
  SecurityPartnerProvidersImpl,
  BgpServiceCommunitiesImpl,
  ServiceEndpointPoliciesImpl,
  ServiceEndpointPolicyDefinitionsImpl,
  ServiceTagsImpl,
  ServiceTagInformationOperationsImpl,
  UsagesImpl,
  VirtualNetworksImpl,
  SubnetsImpl,
  ResourceNavigationLinksImpl,
  ServiceAssociationLinksImpl,
  VirtualNetworkPeeringsImpl,
  VirtualNetworkGatewaysImpl,
  VirtualNetworkGatewayConnectionsImpl,
  LocalNetworkGatewaysImpl,
  VirtualNetworkGatewayNatRulesImpl,
  VirtualNetworkTapsImpl,
  VirtualRoutersImpl,
  VirtualRouterPeeringsImpl,
  VirtualWansImpl,
  VpnSitesImpl,
  VpnSiteLinksImpl,
  VpnSitesConfigurationImpl,
  VpnServerConfigurationsImpl,
  ConfigurationPolicyGroupsImpl,
  VirtualHubsImpl,
  HubVirtualNetworkConnectionsImpl,
  VpnGatewaysImpl,
  VpnLinkConnectionsImpl,
  VpnConnectionsImpl,
  VpnSiteLinkConnectionsImpl,
  NatRulesImpl,
  P2SVpnGatewaysImpl,
  VpnServerConfigurationsAssociatedWithVirtualWanImpl,
  VirtualHubRouteTableV2SImpl,
  ExpressRouteGatewaysImpl,
  ExpressRouteConnectionsImpl,
  VirtualHubBgpConnectionImpl,
  VirtualHubBgpConnectionsImpl,
  VirtualHubIpConfigurationImpl,
  HubRouteTablesImpl,
  RoutingIntentOperationsImpl,
  WebApplicationFirewallPoliciesImpl,
  VipSwapImpl
} from "./operations";
import {
  ApplicationGateways,
  ApplicationGatewayPrivateLinkResources,
  ApplicationGatewayPrivateEndpointConnections,
  ApplicationSecurityGroups,
  AvailableDelegations,
  AvailableResourceGroupDelegations,
  AvailableServiceAliases,
  AzureFirewalls,
  AzureFirewallFqdnTags,
  WebCategories,
  BastionHosts,
  NetworkInterfaces,
  PublicIPAddresses,
  CustomIPPrefixes,
  DdosCustomPolicies,
  DdosProtectionPlans,
  DscpConfigurationOperations,
  AvailableEndpointServices,
  ExpressRouteCircuitAuthorizations,
  ExpressRouteCircuitPeerings,
  ExpressRouteCircuitConnections,
  PeerExpressRouteCircuitConnections,
  ExpressRouteCircuits,
  ExpressRouteServiceProviders,
  ExpressRouteCrossConnections,
  ExpressRouteCrossConnectionPeerings,
  ExpressRoutePortsLocations,
  ExpressRoutePorts,
  ExpressRouteLinks,
  ExpressRoutePortAuthorizations,
  ExpressRouteProviderPortsLocation,
  FirewallPolicies,
  FirewallPolicyRuleCollectionGroups,
  FirewallPolicyIdpsSignatures,
  FirewallPolicyIdpsSignaturesOverrides,
  FirewallPolicyIdpsSignaturesFilterValues,
  IpAllocations,
  IpGroups,
  LoadBalancers,
  LoadBalancerBackendAddressPools,
  LoadBalancerFrontendIPConfigurations,
  InboundNatRules,
  LoadBalancerLoadBalancingRules,
  LoadBalancerOutboundRules,
  LoadBalancerNetworkInterfaces,
  LoadBalancerProbes,
  NatGateways,
  NetworkInterfaceIPConfigurations,
  NetworkInterfaceLoadBalancers,
  NetworkInterfaceTapConfigurations,
  NetworkManagers,
  NetworkManagerCommits,
  NetworkManagerDeploymentStatusOperations,
  SubscriptionNetworkManagerConnections,
  ManagementGroupNetworkManagerConnections,
  ConnectivityConfigurations,
  NetworkGroups,
  StaticMembers,
  ScopeConnections,
  SecurityAdminConfigurations,
  AdminRuleCollections,
  AdminRules,
  NetworkProfiles,
  NetworkSecurityGroups,
  SecurityRules,
  DefaultSecurityRules,
  NetworkVirtualAppliances,
  VirtualApplianceSites,
  VirtualApplianceSkus,
  InboundSecurityRuleOperations,
  NetworkWatchers,
  PacketCaptures,
  ConnectionMonitors,
  FlowLogs,
  Operations,
  PrivateEndpoints,
  AvailablePrivateEndpointTypes,
  PrivateDnsZoneGroups,
  PrivateLinkServices,
  PublicIPPrefixes,
  RouteFilters,
  RouteFilterRules,
  RouteTables,
  Routes,
  SecurityPartnerProviders,
  BgpServiceCommunities,
  ServiceEndpointPolicies,
  ServiceEndpointPolicyDefinitions,
  ServiceTags,
  ServiceTagInformationOperations,
  Usages,
  VirtualNetworks,
  Subnets,
  ResourceNavigationLinks,
  ServiceAssociationLinks,
  VirtualNetworkPeerings,
  VirtualNetworkGateways,
  VirtualNetworkGatewayConnections,
  LocalNetworkGateways,
  VirtualNetworkGatewayNatRules,
  VirtualNetworkTaps,
  VirtualRouters,
  VirtualRouterPeerings,
  VirtualWans,
  VpnSites,
  VpnSiteLinks,
  VpnSitesConfiguration,
  VpnServerConfigurations,
  ConfigurationPolicyGroups,
  VirtualHubs,
  HubVirtualNetworkConnections,
  VpnGateways,
  VpnLinkConnections,
  VpnConnections,
  VpnSiteLinkConnections,
  NatRules,
  P2SVpnGateways,
  VpnServerConfigurationsAssociatedWithVirtualWan,
  VirtualHubRouteTableV2S,
  ExpressRouteGateways,
  ExpressRouteConnections,
  VirtualHubBgpConnection,
  VirtualHubBgpConnections,
  VirtualHubIpConfiguration,
  HubRouteTables,
  RoutingIntentOperations,
  WebApplicationFirewallPolicies,
  VipSwap
} from "./operationsInterfaces";
import * as Parameters from "./models/parameters";
import * as Mappers from "./models/mappers";
import {
  NetworkManagementClientOptionalParams,
  BastionShareableLink,
  BastionShareableLinkListRequest,
  PutBastionShareableLinkNextOptionalParams,
  PutBastionShareableLinkOptionalParams,
  GetBastionShareableLinkNextOptionalParams,
  GetBastionShareableLinkOptionalParams,
  BastionActiveSession,
  GetActiveSessionsNextOptionalParams,
  GetActiveSessionsOptionalParams,
  BastionSessionState,
  SessionIds,
  DisconnectActiveSessionsNextOptionalParams,
  DisconnectActiveSessionsOptionalParams,
  PutBastionShareableLinkResponse,
  DeleteBastionShareableLinkOptionalParams,
  GetBastionShareableLinkResponse,
  GetActiveSessionsResponse,
  DisconnectActiveSessionsResponse,
  CheckDnsNameAvailabilityOptionalParams,
  CheckDnsNameAvailabilityResponse,
  ExpressRouteProviderPortOptionalParams,
  ExpressRouteProviderPortResponse,
  ActiveConfigurationParameter,
  ListActiveConnectivityConfigurationsOptionalParams,
  ListActiveConnectivityConfigurationsResponse,
  ListActiveSecurityAdminRulesOptionalParams,
  ListActiveSecurityAdminRulesResponse,
  QueryRequestOptions,
  ListNetworkManagerEffectiveConnectivityConfigurationsOptionalParams,
  ListNetworkManagerEffectiveConnectivityConfigurationsResponse,
  ListNetworkManagerEffectiveSecurityAdminRulesOptionalParams,
  ListNetworkManagerEffectiveSecurityAdminRulesResponse,
  SupportedSecurityProvidersOptionalParams,
  SupportedSecurityProvidersResponse,
  VirtualWanVpnProfileParameters,
  GeneratevirtualwanvpnserverconfigurationvpnprofileOptionalParams,
  GeneratevirtualwanvpnserverconfigurationvpnprofileResponse,
  PutBastionShareableLinkNextResponse,
  GetBastionShareableLinkNextResponse,
  GetActiveSessionsNextResponse,
  DisconnectActiveSessionsNextResponse
} from "./models";

/// <reference lib="esnext.asynciterable" />
export class NetworkManagementClient extends coreClient.ServiceClient {
  $host: string;
  subscriptionId: string;

  /**
   * Initializes a new instance of the NetworkManagementClient class.
   * @param credentials Subscription credentials which uniquely identify client subscription.
   * @param subscriptionId The subscription credentials which uniquely identify the Microsoft Azure
   *                       subscription. The subscription ID forms part of the URI for every service call.
   * @param options The parameter options
   */
  constructor(
    credentials: coreAuth.TokenCredential,
    subscriptionId: string,
    options?: NetworkManagementClientOptionalParams
  ) {
    if (credentials === undefined) {
      throw new Error("'credentials' cannot be null");
    }
    if (subscriptionId === undefined) {
      throw new Error("'subscriptionId' cannot be null");
    }

    // Initializing default values for options
    if (!options) {
      options = {};
    }
    const defaults: NetworkManagementClientOptionalParams = {
      requestContentType: "application/json; charset=utf-8",
      credential: credentials
    };

    const packageDetails = `azsdk-js-arm-network/1.0.0-beta.1`;
    const userAgentPrefix =
      options.userAgentOptions && options.userAgentOptions.userAgentPrefix
        ? `${options.userAgentOptions.userAgentPrefix} ${packageDetails}`
        : `${packageDetails}`;

    const optionsWithDefaults = {
      ...defaults,
      ...options,
      userAgentOptions: {
        userAgentPrefix
      },
      baseUri:
        options.endpoint ?? options.baseUri ?? "https://management.azure.com"
    };
    super(optionsWithDefaults);

    if (options?.pipeline && options.pipeline.getOrderedPolicies().length > 0) {
      const pipelinePolicies: coreRestPipeline.PipelinePolicy[] = options.pipeline.getOrderedPolicies();
      const bearerTokenAuthenticationPolicyFound = pipelinePolicies.some(
        (pipelinePolicy) =>
          pipelinePolicy.name ===
          coreRestPipeline.bearerTokenAuthenticationPolicyName
      );
      if (!bearerTokenAuthenticationPolicyFound) {
        this.pipeline.removePolicy({
          name: coreRestPipeline.bearerTokenAuthenticationPolicyName
        });
        this.pipeline.addPolicy(
          coreRestPipeline.bearerTokenAuthenticationPolicy({
            scopes: `${optionsWithDefaults.baseUri}/.default`,
            challengeCallbacks: {
              authorizeRequestOnChallenge:
                coreClient.authorizeRequestOnClaimChallenge
            }
          })
        );
      }
    }
    // Parameter assignments
    this.subscriptionId = subscriptionId;

    // Assigning values to Constant parameters
    this.$host = options.$host || "https://management.azure.com";
    this.applicationGateways = new ApplicationGatewaysImpl(this);
    this.applicationGatewayPrivateLinkResources = new ApplicationGatewayPrivateLinkResourcesImpl(
      this
    );
    this.applicationGatewayPrivateEndpointConnections = new ApplicationGatewayPrivateEndpointConnectionsImpl(
      this
    );
    this.applicationSecurityGroups = new ApplicationSecurityGroupsImpl(this);
    this.availableDelegations = new AvailableDelegationsImpl(this);
    this.availableResourceGroupDelegations = new AvailableResourceGroupDelegationsImpl(
      this
    );
    this.availableServiceAliases = new AvailableServiceAliasesImpl(this);
    this.azureFirewalls = new AzureFirewallsImpl(this);
    this.azureFirewallFqdnTags = new AzureFirewallFqdnTagsImpl(this);
    this.webCategories = new WebCategoriesImpl(this);
    this.bastionHosts = new BastionHostsImpl(this);
    this.networkInterfaces = new NetworkInterfacesImpl(this);
    this.publicIPAddresses = new PublicIPAddressesImpl(this);
    this.customIPPrefixes = new CustomIPPrefixesImpl(this);
    this.ddosCustomPolicies = new DdosCustomPoliciesImpl(this);
    this.ddosProtectionPlans = new DdosProtectionPlansImpl(this);
    this.dscpConfigurationOperations = new DscpConfigurationOperationsImpl(
      this
    );
    this.availableEndpointServices = new AvailableEndpointServicesImpl(this);
    this.expressRouteCircuitAuthorizations = new ExpressRouteCircuitAuthorizationsImpl(
      this
    );
    this.expressRouteCircuitPeerings = new ExpressRouteCircuitPeeringsImpl(
      this
    );
    this.expressRouteCircuitConnections = new ExpressRouteCircuitConnectionsImpl(
      this
    );
    this.peerExpressRouteCircuitConnections = new PeerExpressRouteCircuitConnectionsImpl(
      this
    );
    this.expressRouteCircuits = new ExpressRouteCircuitsImpl(this);
    this.expressRouteServiceProviders = new ExpressRouteServiceProvidersImpl(
      this
    );
    this.expressRouteCrossConnections = new ExpressRouteCrossConnectionsImpl(
      this
    );
    this.expressRouteCrossConnectionPeerings = new ExpressRouteCrossConnectionPeeringsImpl(
      this
    );
    this.expressRoutePortsLocations = new ExpressRoutePortsLocationsImpl(this);
    this.expressRoutePorts = new ExpressRoutePortsImpl(this);
    this.expressRouteLinks = new ExpressRouteLinksImpl(this);
    this.expressRoutePortAuthorizations = new ExpressRoutePortAuthorizationsImpl(
      this
    );
    this.expressRouteProviderPortsLocation = new ExpressRouteProviderPortsLocationImpl(
      this
    );
    this.firewallPolicies = new FirewallPoliciesImpl(this);
    this.firewallPolicyRuleCollectionGroups = new FirewallPolicyRuleCollectionGroupsImpl(
      this
    );
    this.firewallPolicyIdpsSignatures = new FirewallPolicyIdpsSignaturesImpl(
      this
    );
    this.firewallPolicyIdpsSignaturesOverrides = new FirewallPolicyIdpsSignaturesOverridesImpl(
      this
    );
    this.firewallPolicyIdpsSignaturesFilterValues = new FirewallPolicyIdpsSignaturesFilterValuesImpl(
      this
    );
    this.ipAllocations = new IpAllocationsImpl(this);
    this.ipGroups = new IpGroupsImpl(this);
    this.loadBalancers = new LoadBalancersImpl(this);
    this.loadBalancerBackendAddressPools = new LoadBalancerBackendAddressPoolsImpl(
      this
    );
    this.loadBalancerFrontendIPConfigurations = new LoadBalancerFrontendIPConfigurationsImpl(
      this
    );
    this.inboundNatRules = new InboundNatRulesImpl(this);
    this.loadBalancerLoadBalancingRules = new LoadBalancerLoadBalancingRulesImpl(
      this
    );
    this.loadBalancerOutboundRules = new LoadBalancerOutboundRulesImpl(this);
    this.loadBalancerNetworkInterfaces = new LoadBalancerNetworkInterfacesImpl(
      this
    );
    this.loadBalancerProbes = new LoadBalancerProbesImpl(this);
    this.natGateways = new NatGatewaysImpl(this);
    this.networkInterfaceIPConfigurations = new NetworkInterfaceIPConfigurationsImpl(
      this
    );
    this.networkInterfaceLoadBalancers = new NetworkInterfaceLoadBalancersImpl(
      this
    );
    this.networkInterfaceTapConfigurations = new NetworkInterfaceTapConfigurationsImpl(
      this
    );
    this.networkManagers = new NetworkManagersImpl(this);
    this.networkManagerCommits = new NetworkManagerCommitsImpl(this);
    this.networkManagerDeploymentStatusOperations = new NetworkManagerDeploymentStatusOperationsImpl(
      this
    );
    this.subscriptionNetworkManagerConnections = new SubscriptionNetworkManagerConnectionsImpl(
      this
    );
    this.managementGroupNetworkManagerConnections = new ManagementGroupNetworkManagerConnectionsImpl(
      this
    );
    this.connectivityConfigurations = new ConnectivityConfigurationsImpl(this);
    this.networkGroups = new NetworkGroupsImpl(this);
    this.staticMembers = new StaticMembersImpl(this);
    this.scopeConnections = new ScopeConnectionsImpl(this);
    this.securityAdminConfigurations = new SecurityAdminConfigurationsImpl(
      this
    );
    this.adminRuleCollections = new AdminRuleCollectionsImpl(this);
    this.adminRules = new AdminRulesImpl(this);
    this.networkProfiles = new NetworkProfilesImpl(this);
    this.networkSecurityGroups = new NetworkSecurityGroupsImpl(this);
    this.securityRules = new SecurityRulesImpl(this);
    this.defaultSecurityRules = new DefaultSecurityRulesImpl(this);
    this.networkVirtualAppliances = new NetworkVirtualAppliancesImpl(this);
    this.virtualApplianceSites = new VirtualApplianceSitesImpl(this);
    this.virtualApplianceSkus = new VirtualApplianceSkusImpl(this);
    this.inboundSecurityRuleOperations = new InboundSecurityRuleOperationsImpl(
      this
    );
    this.networkWatchers = new NetworkWatchersImpl(this);
    this.packetCaptures = new PacketCapturesImpl(this);
    this.connectionMonitors = new ConnectionMonitorsImpl(this);
    this.flowLogs = new FlowLogsImpl(this);
    this.operations = new OperationsImpl(this);
    this.privateEndpoints = new PrivateEndpointsImpl(this);
    this.availablePrivateEndpointTypes = new AvailablePrivateEndpointTypesImpl(
      this
    );
    this.privateDnsZoneGroups = new PrivateDnsZoneGroupsImpl(this);
    this.privateLinkServices = new PrivateLinkServicesImpl(this);
    this.publicIPPrefixes = new PublicIPPrefixesImpl(this);
    this.routeFilters = new RouteFiltersImpl(this);
    this.routeFilterRules = new RouteFilterRulesImpl(this);
    this.routeTables = new RouteTablesImpl(this);
    this.routes = new RoutesImpl(this);
    this.securityPartnerProviders = new SecurityPartnerProvidersImpl(this);
    this.bgpServiceCommunities = new BgpServiceCommunitiesImpl(this);
    this.serviceEndpointPolicies = new ServiceEndpointPoliciesImpl(this);
    this.serviceEndpointPolicyDefinitions = new ServiceEndpointPolicyDefinitionsImpl(
      this
    );
    this.serviceTags = new ServiceTagsImpl(this);
    this.serviceTagInformationOperations = new ServiceTagInformationOperationsImpl(
      this
    );
    this.usages = new UsagesImpl(this);
    this.virtualNetworks = new VirtualNetworksImpl(this);
    this.subnets = new SubnetsImpl(this);
    this.resourceNavigationLinks = new ResourceNavigationLinksImpl(this);
    this.serviceAssociationLinks = new ServiceAssociationLinksImpl(this);
    this.virtualNetworkPeerings = new VirtualNetworkPeeringsImpl(this);
    this.virtualNetworkGateways = new VirtualNetworkGatewaysImpl(this);
    this.virtualNetworkGatewayConnections = new VirtualNetworkGatewayConnectionsImpl(
      this
    );
    this.localNetworkGateways = new LocalNetworkGatewaysImpl(this);
    this.virtualNetworkGatewayNatRules = new VirtualNetworkGatewayNatRulesImpl(
      this
    );
    this.virtualNetworkTaps = new VirtualNetworkTapsImpl(this);
    this.virtualRouters = new VirtualRoutersImpl(this);
    this.virtualRouterPeerings = new VirtualRouterPeeringsImpl(this);
    this.virtualWans = new VirtualWansImpl(this);
    this.vpnSites = new VpnSitesImpl(this);
    this.vpnSiteLinks = new VpnSiteLinksImpl(this);
    this.vpnSitesConfiguration = new VpnSitesConfigurationImpl(this);
    this.vpnServerConfigurations = new VpnServerConfigurationsImpl(this);
    this.configurationPolicyGroups = new ConfigurationPolicyGroupsImpl(this);
    this.virtualHubs = new VirtualHubsImpl(this);
    this.hubVirtualNetworkConnections = new HubVirtualNetworkConnectionsImpl(
      this
    );
    this.vpnGateways = new VpnGatewaysImpl(this);
    this.vpnLinkConnections = new VpnLinkConnectionsImpl(this);
    this.vpnConnections = new VpnConnectionsImpl(this);
    this.vpnSiteLinkConnections = new VpnSiteLinkConnectionsImpl(this);
    this.natRules = new NatRulesImpl(this);
    this.p2SVpnGateways = new P2SVpnGatewaysImpl(this);
    this.vpnServerConfigurationsAssociatedWithVirtualWan = new VpnServerConfigurationsAssociatedWithVirtualWanImpl(
      this
    );
    this.virtualHubRouteTableV2S = new VirtualHubRouteTableV2SImpl(this);
    this.expressRouteGateways = new ExpressRouteGatewaysImpl(this);
    this.expressRouteConnections = new ExpressRouteConnectionsImpl(this);
    this.virtualHubBgpConnection = new VirtualHubBgpConnectionImpl(this);
    this.virtualHubBgpConnections = new VirtualHubBgpConnectionsImpl(this);
    this.virtualHubIpConfiguration = new VirtualHubIpConfigurationImpl(this);
    this.hubRouteTables = new HubRouteTablesImpl(this);
    this.routingIntentOperations = new RoutingIntentOperationsImpl(this);
    this.webApplicationFirewallPolicies = new WebApplicationFirewallPoliciesImpl(
      this
    );
    this.vipSwap = new VipSwapImpl(this);
  }

  /**
   * Creates a Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  public beginListPutBastionShareableLinkAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: PutBastionShareableLinkOptionalParams
  ): PagedAsyncIterableIterator<BastionShareableLink> {
    const iter = this.putBastionShareableLinkPagingAll(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.putBastionShareableLinkPagingPage(
          resourceGroupName,
          bastionHostName,
          bslRequest,
          options
        );
      }
    };
  }

  private async *putBastionShareableLinkPagingPage(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: PutBastionShareableLinkOptionalParams
  ): AsyncIterableIterator<BastionShareableLink[]> {
    const poller = await this._putBastionShareableLink(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    );
    let result: any = await poller.pollUntilDone();
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._putBastionShareableLinkNext(
        resourceGroupName,
        bastionHostName,
        bslRequest,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *putBastionShareableLinkPagingAll(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: PutBastionShareableLinkOptionalParams
  ): AsyncIterableIterator<BastionShareableLink> {
    for await (const page of this.putBastionShareableLinkPagingPage(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Return the Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  public listBastionShareableLink(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: GetBastionShareableLinkOptionalParams
  ): PagedAsyncIterableIterator<BastionShareableLink> {
    const iter = this.getBastionShareableLinkPagingAll(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.getBastionShareableLinkPagingPage(
          resourceGroupName,
          bastionHostName,
          bslRequest,
          options
        );
      }
    };
  }

  private async *getBastionShareableLinkPagingPage(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: GetBastionShareableLinkOptionalParams
  ): AsyncIterableIterator<BastionShareableLink[]> {
    let result = await this._getBastionShareableLink(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._getBastionShareableLinkNext(
        resourceGroupName,
        bastionHostName,
        bslRequest,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *getBastionShareableLinkPagingAll(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: GetBastionShareableLinkOptionalParams
  ): AsyncIterableIterator<BastionShareableLink> {
    for await (const page of this.getBastionShareableLinkPagingPage(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Returns the list of currently active sessions on the Bastion.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  public beginListActiveSessionsAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    options?: GetActiveSessionsOptionalParams
  ): PagedAsyncIterableIterator<BastionActiveSession> {
    const iter = this.getActiveSessionsPagingAll(
      resourceGroupName,
      bastionHostName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.getActiveSessionsPagingPage(
          resourceGroupName,
          bastionHostName,
          options
        );
      }
    };
  }

  private async *getActiveSessionsPagingPage(
    resourceGroupName: string,
    bastionHostName: string,
    options?: GetActiveSessionsOptionalParams
  ): AsyncIterableIterator<BastionActiveSession[]> {
    const poller = await this._getActiveSessions(
      resourceGroupName,
      bastionHostName,
      options
    );
    let result: any = await poller.pollUntilDone();
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._getActiveSessionsNext(
        resourceGroupName,
        bastionHostName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *getActiveSessionsPagingAll(
    resourceGroupName: string,
    bastionHostName: string,
    options?: GetActiveSessionsOptionalParams
  ): AsyncIterableIterator<BastionActiveSession> {
    for await (const page of this.getActiveSessionsPagingPage(
      resourceGroupName,
      bastionHostName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Returns the list of currently active sessions on the Bastion.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param sessionIds The list of sessionids to disconnect.
   * @param options The options parameters.
   */
  public listDisconnectActiveSessions(
    resourceGroupName: string,
    bastionHostName: string,
    sessionIds: SessionIds,
    options?: DisconnectActiveSessionsOptionalParams
  ): PagedAsyncIterableIterator<BastionSessionState> {
    const iter = this.disconnectActiveSessionsPagingAll(
      resourceGroupName,
      bastionHostName,
      sessionIds,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.disconnectActiveSessionsPagingPage(
          resourceGroupName,
          bastionHostName,
          sessionIds,
          options
        );
      }
    };
  }

  private async *disconnectActiveSessionsPagingPage(
    resourceGroupName: string,
    bastionHostName: string,
    sessionIds: SessionIds,
    options?: DisconnectActiveSessionsOptionalParams
  ): AsyncIterableIterator<BastionSessionState[]> {
    let result = await this._disconnectActiveSessions(
      resourceGroupName,
      bastionHostName,
      sessionIds,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._disconnectActiveSessionsNext(
        resourceGroupName,
        bastionHostName,
        sessionIds,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *disconnectActiveSessionsPagingAll(
    resourceGroupName: string,
    bastionHostName: string,
    sessionIds: SessionIds,
    options?: DisconnectActiveSessionsOptionalParams
  ): AsyncIterableIterator<BastionSessionState> {
    for await (const page of this.disconnectActiveSessionsPagingPage(
      resourceGroupName,
      bastionHostName,
      sessionIds,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates a Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  private async _putBastionShareableLink(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: PutBastionShareableLinkOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PutBastionShareableLinkResponse>,
      PutBastionShareableLinkResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<PutBastionShareableLinkResponse> => {
      return this.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, bastionHostName, bslRequest, options },
      putBastionShareableLinkOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Deletes the Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  async beginDeleteBastionShareableLink(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: DeleteBastionShareableLinkOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>> {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<void> => {
      return this.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, bastionHostName, bslRequest, options },
      deleteBastionShareableLinkOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Deletes the Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  async beginDeleteBastionShareableLinkAndWait(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: DeleteBastionShareableLinkOptionalParams
  ): Promise<void> {
    const poller = await this.beginDeleteBastionShareableLink(
      resourceGroupName,
      bastionHostName,
      bslRequest,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Return the Bastion Shareable Links for all the VMs specified in the request.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param options The options parameters.
   */
  private _getBastionShareableLink(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    options?: GetBastionShareableLinkOptionalParams
  ): Promise<GetBastionShareableLinkResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, bslRequest, options },
      getBastionShareableLinkOperationSpec
    );
  }

  /**
   * Returns the list of currently active sessions on the Bastion.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param options The options parameters.
   */
  private async _getActiveSessions(
    resourceGroupName: string,
    bastionHostName: string,
    options?: GetActiveSessionsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<GetActiveSessionsResponse>,
      GetActiveSessionsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<GetActiveSessionsResponse> => {
      return this.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, bastionHostName, options },
      getActiveSessionsOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Returns the list of currently active sessions on the Bastion.
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param sessionIds The list of sessionids to disconnect.
   * @param options The options parameters.
   */
  private _disconnectActiveSessions(
    resourceGroupName: string,
    bastionHostName: string,
    sessionIds: SessionIds,
    options?: DisconnectActiveSessionsOptionalParams
  ): Promise<DisconnectActiveSessionsResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, sessionIds, options },
      disconnectActiveSessionsOperationSpec
    );
  }

  /**
   * Checks whether a domain name in the cloudapp.azure.com zone is available for use.
   * @param location The location of the domain name.
   * @param domainNameLabel The domain name to be verified. It must conform to the following regular
   *                        expression: ^[a-z][a-z0-9-]{1,61}[a-z0-9]$.
   * @param options The options parameters.
   */
  checkDnsNameAvailability(
    location: string,
    domainNameLabel: string,
    options?: CheckDnsNameAvailabilityOptionalParams
  ): Promise<CheckDnsNameAvailabilityResponse> {
    return this.sendOperationRequest(
      { location, domainNameLabel, options },
      checkDnsNameAvailabilityOperationSpec
    );
  }

  /**
   * Retrieves detail of a provider port.
   * @param providerport The name of the provider port.
   * @param options The options parameters.
   */
  expressRouteProviderPort(
    providerport: string,
    options?: ExpressRouteProviderPortOptionalParams
  ): Promise<ExpressRouteProviderPortResponse> {
    return this.sendOperationRequest(
      { providerport, options },
      expressRouteProviderPortOperationSpec
    );
  }

  /**
   * Lists active connectivity configurations in a network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Active Configuration Parameter.
   * @param options The options parameters.
   */
  listActiveConnectivityConfigurations(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: ActiveConfigurationParameter,
    options?: ListActiveConnectivityConfigurationsOptionalParams
  ): Promise<ListActiveConnectivityConfigurationsResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, networkManagerName, parameters, options },
      listActiveConnectivityConfigurationsOperationSpec
    );
  }

  /**
   * Lists active security admin rules in a network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Active Configuration Parameter.
   * @param options The options parameters.
   */
  listActiveSecurityAdminRules(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: ActiveConfigurationParameter,
    options?: ListActiveSecurityAdminRulesOptionalParams
  ): Promise<ListActiveSecurityAdminRulesResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, networkManagerName, parameters, options },
      listActiveSecurityAdminRulesOperationSpec
    );
  }

  /**
   * List all effective connectivity configurations applied on a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to list correct page.
   * @param options The options parameters.
   */
  listNetworkManagerEffectiveConnectivityConfigurations(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: QueryRequestOptions,
    options?: ListNetworkManagerEffectiveConnectivityConfigurationsOptionalParams
  ): Promise<ListNetworkManagerEffectiveConnectivityConfigurationsResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, parameters, options },
      listNetworkManagerEffectiveConnectivityConfigurationsOperationSpec
    );
  }

  /**
   * List all effective security admin rules applied on a virtual network.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param parameters Parameters supplied to list correct page.
   * @param options The options parameters.
   */
  listNetworkManagerEffectiveSecurityAdminRules(
    resourceGroupName: string,
    virtualNetworkName: string,
    parameters: QueryRequestOptions,
    options?: ListNetworkManagerEffectiveSecurityAdminRulesOptionalParams
  ): Promise<ListNetworkManagerEffectiveSecurityAdminRulesResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, parameters, options },
      listNetworkManagerEffectiveSecurityAdminRulesOperationSpec
    );
  }

  /**
   * Gives the supported security providers for the virtual wan.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN for which supported security providers are needed.
   * @param options The options parameters.
   */
  supportedSecurityProviders(
    resourceGroupName: string,
    virtualWANName: string,
    options?: SupportedSecurityProvidersOptionalParams
  ): Promise<SupportedSecurityProvidersResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, virtualWANName, options },
      supportedSecurityProvidersOperationSpec
    );
  }

  /**
   * Generates a unique VPN profile for P2S clients for VirtualWan and associated VpnServerConfiguration
   * combination in the specified resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param vpnClientParams Parameters supplied to the generate VirtualWan VPN profile generation
   *                        operation.
   * @param options The options parameters.
   */
  async beginGeneratevirtualwanvpnserverconfigurationvpnprofile(
    resourceGroupName: string,
    virtualWANName: string,
    vpnClientParams: VirtualWanVpnProfileParameters,
    options?: GeneratevirtualwanvpnserverconfigurationvpnprofileOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        GeneratevirtualwanvpnserverconfigurationvpnprofileResponse
      >,
      GeneratevirtualwanvpnserverconfigurationvpnprofileResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<GeneratevirtualwanvpnserverconfigurationvpnprofileResponse> => {
      return this.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, virtualWANName, vpnClientParams, options },
      generatevirtualwanvpnserverconfigurationvpnprofileOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Generates a unique VPN profile for P2S clients for VirtualWan and associated VpnServerConfiguration
   * combination in the specified resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param vpnClientParams Parameters supplied to the generate VirtualWan VPN profile generation
   *                        operation.
   * @param options The options parameters.
   */
  async beginGeneratevirtualwanvpnserverconfigurationvpnprofileAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    vpnClientParams: VirtualWanVpnProfileParameters,
    options?: GeneratevirtualwanvpnserverconfigurationvpnprofileOptionalParams
  ): Promise<GeneratevirtualwanvpnserverconfigurationvpnprofileResponse> {
    const poller = await this.beginGeneratevirtualwanvpnserverconfigurationvpnprofile(
      resourceGroupName,
      virtualWANName,
      vpnClientParams,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * PutBastionShareableLinkNext
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param nextLink The nextLink from the previous successful call to the PutBastionShareableLink
   *                 method.
   * @param options The options parameters.
   */
  private _putBastionShareableLinkNext(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    nextLink: string,
    options?: PutBastionShareableLinkNextOptionalParams
  ): Promise<PutBastionShareableLinkNextResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, bslRequest, nextLink, options },
      putBastionShareableLinkNextOperationSpec
    );
  }

  /**
   * GetBastionShareableLinkNext
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param bslRequest Post request for all the Bastion Shareable Link endpoints.
   * @param nextLink The nextLink from the previous successful call to the GetBastionShareableLink
   *                 method.
   * @param options The options parameters.
   */
  private _getBastionShareableLinkNext(
    resourceGroupName: string,
    bastionHostName: string,
    bslRequest: BastionShareableLinkListRequest,
    nextLink: string,
    options?: GetBastionShareableLinkNextOptionalParams
  ): Promise<GetBastionShareableLinkNextResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, bslRequest, nextLink, options },
      getBastionShareableLinkNextOperationSpec
    );
  }

  /**
   * GetActiveSessionsNext
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param nextLink The nextLink from the previous successful call to the GetActiveSessions method.
   * @param options The options parameters.
   */
  private _getActiveSessionsNext(
    resourceGroupName: string,
    bastionHostName: string,
    nextLink: string,
    options?: GetActiveSessionsNextOptionalParams
  ): Promise<GetActiveSessionsNextResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, nextLink, options },
      getActiveSessionsNextOperationSpec
    );
  }

  /**
   * DisconnectActiveSessionsNext
   * @param resourceGroupName The name of the resource group.
   * @param bastionHostName The name of the Bastion Host.
   * @param sessionIds The list of sessionids to disconnect.
   * @param nextLink The nextLink from the previous successful call to the DisconnectActiveSessions
   *                 method.
   * @param options The options parameters.
   */
  private _disconnectActiveSessionsNext(
    resourceGroupName: string,
    bastionHostName: string,
    sessionIds: SessionIds,
    nextLink: string,
    options?: DisconnectActiveSessionsNextOptionalParams
  ): Promise<DisconnectActiveSessionsNextResponse> {
    return this.sendOperationRequest(
      { resourceGroupName, bastionHostName, sessionIds, nextLink, options },
      disconnectActiveSessionsNextOperationSpec
    );
  }

  applicationGateways: ApplicationGateways;
  applicationGatewayPrivateLinkResources: ApplicationGatewayPrivateLinkResources;
  applicationGatewayPrivateEndpointConnections: ApplicationGatewayPrivateEndpointConnections;
  applicationSecurityGroups: ApplicationSecurityGroups;
  availableDelegations: AvailableDelegations;
  availableResourceGroupDelegations: AvailableResourceGroupDelegations;
  availableServiceAliases: AvailableServiceAliases;
  azureFirewalls: AzureFirewalls;
  azureFirewallFqdnTags: AzureFirewallFqdnTags;
  webCategories: WebCategories;
  bastionHosts: BastionHosts;
  networkInterfaces: NetworkInterfaces;
  publicIPAddresses: PublicIPAddresses;
  customIPPrefixes: CustomIPPrefixes;
  ddosCustomPolicies: DdosCustomPolicies;
  ddosProtectionPlans: DdosProtectionPlans;
  dscpConfigurationOperations: DscpConfigurationOperations;
  availableEndpointServices: AvailableEndpointServices;
  expressRouteCircuitAuthorizations: ExpressRouteCircuitAuthorizations;
  expressRouteCircuitPeerings: ExpressRouteCircuitPeerings;
  expressRouteCircuitConnections: ExpressRouteCircuitConnections;
  peerExpressRouteCircuitConnections: PeerExpressRouteCircuitConnections;
  expressRouteCircuits: ExpressRouteCircuits;
  expressRouteServiceProviders: ExpressRouteServiceProviders;
  expressRouteCrossConnections: ExpressRouteCrossConnections;
  expressRouteCrossConnectionPeerings: ExpressRouteCrossConnectionPeerings;
  expressRoutePortsLocations: ExpressRoutePortsLocations;
  expressRoutePorts: ExpressRoutePorts;
  expressRouteLinks: ExpressRouteLinks;
  expressRoutePortAuthorizations: ExpressRoutePortAuthorizations;
  expressRouteProviderPortsLocation: ExpressRouteProviderPortsLocation;
  firewallPolicies: FirewallPolicies;
  firewallPolicyRuleCollectionGroups: FirewallPolicyRuleCollectionGroups;
  firewallPolicyIdpsSignatures: FirewallPolicyIdpsSignatures;
  firewallPolicyIdpsSignaturesOverrides: FirewallPolicyIdpsSignaturesOverrides;
  firewallPolicyIdpsSignaturesFilterValues: FirewallPolicyIdpsSignaturesFilterValues;
  ipAllocations: IpAllocations;
  ipGroups: IpGroups;
  loadBalancers: LoadBalancers;
  loadBalancerBackendAddressPools: LoadBalancerBackendAddressPools;
  loadBalancerFrontendIPConfigurations: LoadBalancerFrontendIPConfigurations;
  inboundNatRules: InboundNatRules;
  loadBalancerLoadBalancingRules: LoadBalancerLoadBalancingRules;
  loadBalancerOutboundRules: LoadBalancerOutboundRules;
  loadBalancerNetworkInterfaces: LoadBalancerNetworkInterfaces;
  loadBalancerProbes: LoadBalancerProbes;
  natGateways: NatGateways;
  networkInterfaceIPConfigurations: NetworkInterfaceIPConfigurations;
  networkInterfaceLoadBalancers: NetworkInterfaceLoadBalancers;
  networkInterfaceTapConfigurations: NetworkInterfaceTapConfigurations;
  networkManagers: NetworkManagers;
  networkManagerCommits: NetworkManagerCommits;
  networkManagerDeploymentStatusOperations: NetworkManagerDeploymentStatusOperations;
  subscriptionNetworkManagerConnections: SubscriptionNetworkManagerConnections;
  managementGroupNetworkManagerConnections: ManagementGroupNetworkManagerConnections;
  connectivityConfigurations: ConnectivityConfigurations;
  networkGroups: NetworkGroups;
  staticMembers: StaticMembers;
  scopeConnections: ScopeConnections;
  securityAdminConfigurations: SecurityAdminConfigurations;
  adminRuleCollections: AdminRuleCollections;
  adminRules: AdminRules;
  networkProfiles: NetworkProfiles;
  networkSecurityGroups: NetworkSecurityGroups;
  securityRules: SecurityRules;
  defaultSecurityRules: DefaultSecurityRules;
  networkVirtualAppliances: NetworkVirtualAppliances;
  virtualApplianceSites: VirtualApplianceSites;
  virtualApplianceSkus: VirtualApplianceSkus;
  inboundSecurityRuleOperations: InboundSecurityRuleOperations;
  networkWatchers: NetworkWatchers;
  packetCaptures: PacketCaptures;
  connectionMonitors: ConnectionMonitors;
  flowLogs: FlowLogs;
  operations: Operations;
  privateEndpoints: PrivateEndpoints;
  availablePrivateEndpointTypes: AvailablePrivateEndpointTypes;
  privateDnsZoneGroups: PrivateDnsZoneGroups;
  privateLinkServices: PrivateLinkServices;
  publicIPPrefixes: PublicIPPrefixes;
  routeFilters: RouteFilters;
  routeFilterRules: RouteFilterRules;
  routeTables: RouteTables;
  routes: Routes;
  securityPartnerProviders: SecurityPartnerProviders;
  bgpServiceCommunities: BgpServiceCommunities;
  serviceEndpointPolicies: ServiceEndpointPolicies;
  serviceEndpointPolicyDefinitions: ServiceEndpointPolicyDefinitions;
  serviceTags: ServiceTags;
  serviceTagInformationOperations: ServiceTagInformationOperations;
  usages: Usages;
  virtualNetworks: VirtualNetworks;
  subnets: Subnets;
  resourceNavigationLinks: ResourceNavigationLinks;
  serviceAssociationLinks: ServiceAssociationLinks;
  virtualNetworkPeerings: VirtualNetworkPeerings;
  virtualNetworkGateways: VirtualNetworkGateways;
  virtualNetworkGatewayConnections: VirtualNetworkGatewayConnections;
  localNetworkGateways: LocalNetworkGateways;
  virtualNetworkGatewayNatRules: VirtualNetworkGatewayNatRules;
  virtualNetworkTaps: VirtualNetworkTaps;
  virtualRouters: VirtualRouters;
  virtualRouterPeerings: VirtualRouterPeerings;
  virtualWans: VirtualWans;
  vpnSites: VpnSites;
  vpnSiteLinks: VpnSiteLinks;
  vpnSitesConfiguration: VpnSitesConfiguration;
  vpnServerConfigurations: VpnServerConfigurations;
  configurationPolicyGroups: ConfigurationPolicyGroups;
  virtualHubs: VirtualHubs;
  hubVirtualNetworkConnections: HubVirtualNetworkConnections;
  vpnGateways: VpnGateways;
  vpnLinkConnections: VpnLinkConnections;
  vpnConnections: VpnConnections;
  vpnSiteLinkConnections: VpnSiteLinkConnections;
  natRules: NatRules;
  p2SVpnGateways: P2SVpnGateways;
  vpnServerConfigurationsAssociatedWithVirtualWan: VpnServerConfigurationsAssociatedWithVirtualWan;
  virtualHubRouteTableV2S: VirtualHubRouteTableV2S;
  expressRouteGateways: ExpressRouteGateways;
  expressRouteConnections: ExpressRouteConnections;
  virtualHubBgpConnection: VirtualHubBgpConnection;
  virtualHubBgpConnections: VirtualHubBgpConnections;
  virtualHubIpConfiguration: VirtualHubIpConfiguration;
  hubRouteTables: HubRouteTables;
  routingIntentOperations: RoutingIntentOperations;
  webApplicationFirewallPolicies: WebApplicationFirewallPolicies;
  vipSwap: VipSwap;
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const putBastionShareableLinkOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}/createShareableLinks",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    201: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    202: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    204: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.bslRequest,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const deleteBastionShareableLinkOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}/deleteShareableLinks",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.bslRequest,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getBastionShareableLinkOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}/getShareableLinks",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.bslRequest,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getActiveSessionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}/getActiveSessions",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.BastionActiveSessionListResult
    },
    201: {
      bodyMapper: Mappers.BastionActiveSessionListResult
    },
    202: {
      bodyMapper: Mappers.BastionActiveSessionListResult
    },
    204: {
      bodyMapper: Mappers.BastionActiveSessionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const disconnectActiveSessionsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/bastionHosts/{bastionHostName}/disconnectActiveSessions",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.BastionSessionDeleteResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.sessionIds,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const checkDnsNameAvailabilityOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/CheckDnsNameAvailability",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DnsNameAvailabilityResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.domainNameLabel],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const expressRouteProviderPortOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteProviderPorts/{providerport}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteProviderPort
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.providerport
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listActiveConnectivityConfigurationsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/listActiveConnectivityConfigurations",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ActiveConnectivityConfigurationsListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters6,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listActiveSecurityAdminRulesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/listActiveSecurityAdminRules",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.ActiveSecurityAdminRulesListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters6,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listNetworkManagerEffectiveConnectivityConfigurationsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveConnectivityConfigurations",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper:
        Mappers.NetworkManagerEffectiveConnectivityConfigurationListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters7,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listNetworkManagerEffectiveSecurityAdminRulesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listNetworkManagerEffectiveSecurityAdminRules",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerEffectiveSecurityAdminRulesListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters7,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualNetworkName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const supportedSecurityProvidersOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{virtualWANName}/supportedSecurityProviders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualWanSecurityProviders
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualWANName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const generatevirtualwanvpnserverconfigurationvpnprofileOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{virtualWANName}/GenerateVpnProfile",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VpnProfileResponse
    },
    201: {
      bodyMapper: Mappers.VpnProfileResponse
    },
    202: {
      bodyMapper: Mappers.VpnProfileResponse
    },
    204: {
      bodyMapper: Mappers.VpnProfileResponse
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.vpnClientParams,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualWANName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const putBastionShareableLinkNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    202: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getBastionShareableLinkNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionShareableLinkListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getActiveSessionsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionActiveSessionListResult
    },
    202: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const disconnectActiveSessionsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.BastionSessionDeleteResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.bastionHostName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
