

``` yaml
isAzureSpec: true
isArm: true
require: https://github.com/Azure/azure-rest-api-specs/blob/a9e895ccfe29d0646795f7ff1cb78e185bd09529/specification/dnsresolver/resource-manager/readme.md
library-name: dnsresolver
skip-csproj: true
modelerfour:
  flatten-payloads: false

partial-resources:
  /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}: VirtualNetwork

override-operation-name:
  DnsResolvers_ListByVirtualNetwork: GetDnsResolvers
  DnsForwardingRulesets_ListByVirtualNetwork: GetDnsForwardingRulesets

format-by-name-rules:
  'tenantId': 'uuid'
  'ETag': 'etag'
  'location': 'azure-location'
  '*Uri': 'Uri'
  '*Uris': 'Uri'
  '*IPAddress': 'ip-address'
  'ResourceGuid': 'uuid'


rename-mapping:
  ProvisioningState: DnsResolverProvisioningState
  ForwardingRule: DnsForwardingRule
  ForwardingRuleState: DnsForwardingRuleState
  ForwardingRule.properties.forwardingRuleState: DnsForwardingRuleState
  ForwardingRulePatch.properties.forwardingRuleState: DnsForwardingRuleState
  InboundEndpoint: DnsResolverInboundEndpoint
  IpConfiguration: InboundEndpointIpConfiguration
  IpAllocationMethod: InboundEndpointIPAllocationMethod
  OutboundEndpoint: DnsResolverOutboundEndpoint
  VirtualNetworkLink: DnsForwardingRulesetVirtualNetworkLink

directive:
  - from: dnsresolver.json
    where: $.definitions
    transform: >
      $.VirtualNetworkDnsForwardingRuleset.properties.id['x-ms-format'] = 'arm-id';
```
