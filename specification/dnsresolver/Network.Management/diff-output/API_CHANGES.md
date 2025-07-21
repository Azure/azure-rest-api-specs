## Swagger Changes

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

