## Swagger Changes

### Changes for `minLength`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolverPolicies'].post.parameters[0].minLength__added` | added | `1` |

### Changes for `pattern`

| Path | Change Type | Value |
|------|------------|-------|
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolverPolicies'].post.parameters[0].pattern__added` | added | `^.+$` |

### Changes for `CloudError`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudError__deleted` | deleted | `{"type":"object","properties":{"error":{"$ref":"#/definitions/CloudErrorBody"}},"x-ms-external":true...` |

### Changes for `CloudErrorBody`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.CloudErrorBody__deleted` | deleted | `{"type":"object","properties":{"code":{"type":"string"},"message":{"type":"string"},"target":{"type"...` |

### Changes for `ResourceGuid`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ResourceGuid__deleted` | deleted | `{"type":"string"}` |

### Changes for `Azure.ResourceManager.ArmResponse<DnsResolverDomainList>`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions['Azure.ResourceManager.ArmResponse<DnsResolverDomainList>__added']` | added | `{"type":"object","properties":{"body":{"$ref":"#/definitions/DnsResolverDomainList"}},"required":["b...` |

### Changes for `systemData`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DnsForwardingRuleset.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.DnsResolver.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.DnsResolverDomainList.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.DnsResolverPolicy.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.DnsResolverPolicyVirtualNetworkLink.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.DnsSecurityRule.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.ForwardingRule.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.InboundEndpoint.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.OutboundEndpoint.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |
| `definitions.VirtualNetworkLink.properties.systemData__deleted` | deleted | `{"$ref":"../../../../../common-types/resource-management/v5/types.json#/definitions/systemData","rea...` |

### Changes for `x-ms-client-name`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DnsForwardingRuleset.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.DnsResolver.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.DnsResolverDomainList.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.DnsResolverPolicy.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.DnsResolverPolicyVirtualNetworkLink.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.DnsSecurityRule.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.ForwardingRule.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.InboundEndpoint.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.OutboundEndpoint.properties.etag['x-ms-client-name__added']` | added | `eTag` |
| `definitions.VirtualNetworkLink.properties.etag['x-ms-client-name__added']` | added | `eTag` |

### Changes for `required`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.DnsForwardingRulesetListResult.required__added` | added | `["value"]` |
| `definitions.DnsResolverDomainListListResult.required__added` | added | `["value"]` |
| `definitions.DnsResolverListResult.required__added` | added | `["value"]` |
| `definitions.DnsResolverPolicyListResult.required__added` | added | `["value"]` |
| `definitions.DnsResolverPolicyVirtualNetworkLinkListResult.required__added` | added | `["value"]` |
| `definitions.DnsSecurityRuleListResult.required__added` | added | `["value"]` |
| `definitions.ForwardingRuleListResult.required__added` | added | `["value"]` |
| `definitions.InboundEndpointListResult.required__added` | added | `["value"]` |
| `definitions.OutboundEndpointListResult.required__added` | added | `["value"]` |
| `definitions.SubResourceListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkDnsForwardingRulesetListResult.required__added` | added | `["value"]` |
| `definitions.VirtualNetworkLinkListResult.required__added` | added | `["value"]` |

### Changes for `default`

| Path | Change Type | Value |
|------|------------|-------|
| `definitions.ForwardingRulePatchProperties.properties.forwardingRuleState.default__deleted` | deleted | `Enabled` |

## Modified Values

| Path | Old Value | New Value |
|------|-----------|----------|
| `info.description` | `The DNS Resolver Policy Management Client.` | `DNS Resolver Client` |
| `info.title` | `DnsResolverPolicyManagementClient` | `DnsResolverManagementClient` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Network/dnsForwardingRulesets'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/providers/Microsoft.Network/dnsResolvers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].delete.parameters[1].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].put.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/forwardingRules/{forwardingRuleName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsForwardingRulesets/{dnsForwardingRulesetName}/virtualNetworkLinks/{virtualNetworkLinkName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverDomainLists/{dnsResolverDomainListName}'].delete.parameters[1].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverDomainLists/{dnsResolverDomainListName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverDomainLists/{dnsResolverDomainListName}'].put.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverDomainLists/{dnsResolverDomainListName}/bulk'].post.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverDomainLists/{dnsResolverDomainListName}/bulk'].post.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}'].delete.parameters[1].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}'].put.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/dnsSecurityRules/{dnsSecurityRuleName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/dnsSecurityRules/{dnsSecurityRuleName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/dnsSecurityRules/{dnsSecurityRuleName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/virtualNetworkLinks/{dnsResolverPolicyVirtualNetworkLinkName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/virtualNetworkLinks/{dnsResolverPolicyVirtualNetworkLinkName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolverPolicies/{dnsResolverPolicyName}/virtualNetworkLinks/{dnsResolverPolicyVirtualNetworkLinkName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].delete.parameters[1].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].put.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].put.parameters[3].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/inboundEndpoints/{inboundEndpointName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].delete.parameters[2].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].delete.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].get.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].patch.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].put.parameters[3].name` | `If-Match` | `if-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].put.parameters[4].name` | `If-None-Match` | `if-none-match` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/dnsResolvers/{dnsResolverName}/outboundEndpoints/{outboundEndpointName}'].put.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsForwardingRulesets'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |
| `paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/listDnsResolvers'].post.responses.default.schema.$ref` | `#/definitions/CloudError` | `../../../../../common-types/resource-management/v5/types.json#/definitions/ErrorResponse` |

