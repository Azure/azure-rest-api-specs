import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Network;

#suppress "@azure-tools/typespec-azure-core/no-enum" "Fixture keeps only feature flags referenced by the operationId test files."
#suppress "@azure-tools/typespec-azure-core/documentation-required"
enum Features {
  virtualNetwork,
  expressRoute,
  virtualWAN,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Fixture resource shape copied from Network Common."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "Fixture resource shape copied from Network Common."
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model Resource {
  id?: string;

  @visibility(Lifecycle.Read)
  name?: string;

  @visibility(Lifecycle.Read)
  type?: string;

  location?: string;

  tags?: Record<string>;
}

model ResourceWithRequiredLocation extends Resource {
  location: string;
}

model ResourceWithReadOnlyNameAndID extends Resource {}

model SubResource {
  id?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "Fixture resource shape copied from Network Common."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "Fixture resource shape copied from Network Common."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Fixture resource shape copied from Network Common."
@Azure.ResourceManager.Legacy.customAzureResource(#{ isAzureResource: true })
model SubResourceModel extends SubResource {
  name?: string;

  @visibility(Lifecycle.Read)
  type?: string;
}

@error
model CloudError {
  error?: Error;
}

model Error {
  code?: string;
  message?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Fixture model for patch operations."
model TagsObject {
  tags?: Record<string>;
}

model BastionHostPropertiesFormat {}

model Sku {
  name?: string;
}

model BastionShareableLinkListRequest {
  vms?: BastionShareableLink[];
}

model BastionShareableLink {
  vm: SubResource;
}

model BastionShareableLinkListResult is Azure.Core.Page<BastionShareableLink>;

model BastionShareableLinkTokenListRequest {
  tokens?: string[];
}

model BastionActiveSessionListResult is Azure.Core.Page<BastionActiveSession>;

model BastionActiveSession {
  sessionId?: string;
}

model SessionIds {
  sessionIds?: string[];
}

model BastionSessionDeleteResult is Azure.Core.Page<BastionSessionState>;

model BastionSessionState {}

model ExpressRoutePortPropertiesFormat {}

model ExpressRouteLink extends SubResource {}

model ExpressRouteLinkListResult is Azure.Core.Page<ExpressRouteLink>;

model GenerateExpressRoutePortsLOARequest {}

model GenerateExpressRoutePortsLOAResult {
  encodedContent?: string;
}

model ExpressRouteProviderPortProperties {}

model EffectiveRouteListResult {}

model EffectiveNetworkSecurityGroupListResult {}

model NetworkInterfacePropertiesFormat {}

model ExtendedLocation {
  name?: string;
  type?: string;
}

model NetworkInterfaceLoadBalancerListResult is Azure.Core.Page<LoadBalancer>;

model LoadBalancer extends Resource {}

model ExpressRoutePortListResult is Azure.Core.Page<ExpressRoutePort>;

model RoutePropertiesFormat {}

model RouteTablePropertiesFormat {}

model P2SVpnGatewayProperties {}

model ListP2SVpnGatewaysResult is Azure.Core.Page<P2SVpnGateway>;

model P2SVpnProfileParameters {}

model VpnProfileResponse {}

model P2SVpnConnectionRequest {}

model P2SVpnConnectionHealthRequest {}

model P2SVpnConnectionHealth {}

model VpnServerConfigurationProperties {}

model VpnServerConfigurationPolicyGroupProperties {}

model ListVpnServerConfigurationPolicyGroupsResult is Azure.Core.Page<VpnServerConfigurationPolicyGroup>;

model VpnGatewayProperties {}

model VpnSiteLinkConnectionProperties {}

model ListVpnSiteLinkConnectionsResult is Azure.Core.Page<VpnSiteLinkConnection>;

model ExpressRouteGatewayProperties {}

model ExpressRouteGatewayList is Azure.Core.Page<ExpressRouteGateway>;

model ExpressRouteConnection extends SubResource {}

model ExpressRouteConnectionList is Azure.Core.Page<ExpressRouteConnection>;

model BgpConnectionProperties {}

model ListVirtualHubBgpConnectionResults is Azure.Core.Page<BgpConnection>;

model PeerRoute {}

alias PeerRouteList = PeerRoute[];

model VirtualHubProperties {}

alias stringApplicationJson = string;
