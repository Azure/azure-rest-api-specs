# Microsoft.Peering/peerings template reference
API Version: 2019-03-01-preview
## Template format

To create a Microsoft.Peering/peerings resource, add the following JSON to the resources section of your template.

```json
{
  "name": "string",
  "type": "Microsoft.Peering/peerings",
  "apiVersion": "2019-03-01-preview",
  "sku": {
    "name": "string",
    "tier": "string",
    "family": "string",
    "size": "string"
  },
  "kind": "string",
  "properties": {
    "direct": {
      "connections": [
        {
          "bandwidthInMbps": "integer",
          "provisionedBandwidthInMbps": "integer",
          "peeringDBFacilityId": "integer",
          "bgpSession": {
            "sessionPrefixV4": "string",
            "sessionPrefixV6": "string",
            "peerSessionIPv4Address": "string",
            "peerSessionIPv6Address": "string",
            "maxPrefixesAdvertisedV4": "integer",
            "maxPrefixesAdvertisedV6": "integer",
            "md5AuthenticationKey": "string"
          }
        }
      ],
      "peerAsn": "integer",
      "useForPeeringService": "boolean"
    },
    "exchange": {
      "connections": [
        {
          "peeringDBFacilityId": "integer",
          "bgpSession": {
            "sessionPrefixV4": "string",
            "sessionPrefixV6": "string",
            "peerSessionIPv4Address": "string",
            "peerSessionIPv6Address": "string",
            "maxPrefixesAdvertisedV4": "integer",
            "maxPrefixesAdvertisedV6": "integer",
            "md5AuthenticationKey": "string"
          }
        }
      ],
      "peerAsn": "integer"
    },
    "peeringLocation": "string"
  },
  "location": "string",
  "tags": {}
}
```
## Property values

The following tables describe the values you need to set in the schema.

<a id="Microsoft.Peering/peerings" />
### Microsoft.Peering/peerings object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  name | string | Yes |  |
|  type | enum | Yes | Microsoft.Peering/peerings |
|  apiVersion | enum | Yes | 2019-03-01-preview |
|  sku | object | Yes | The SKU that defines the tier and kind of the peering. - [PeeringSku object](#PeeringSku) |
|  kind | enum | Yes | The kind of the peering. - Direct or Exchange |
|  properties | object | Yes | The properties that define a peering. - [PeeringProperties object](#PeeringProperties) |
|  location | string | Yes | The location of the resource. |
|  tags | object | No | The resource tags. |


<a id="PeeringSku" />
### PeeringSku object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  name | enum | No | The name of the peering SKU. - Basic_Exchange_Free, Basic_Direct_Free, Premium_Direct_Free, Premium_Exchange_Metered |
|  tier | enum | No | The tier of the peering SKU. - Basic or Premium |
|  family | enum | No | The family of the peering SKU. - Direct or Exchange |
|  size | enum | No | The size of the peering SKU. - Free, Metered, Unlimited |


<a id="PeeringProperties" />
### PeeringProperties object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  direct | object | No | The properties that define a direct peering. - [PeeringPropertiesDirect object](#PeeringPropertiesDirect) |
|  exchange | object | No | The properties that define an exchange peering. - [PeeringPropertiesExchange object](#PeeringPropertiesExchange) |
|  peeringLocation | string | No | The location of the peering. |


<a id="PeeringPropertiesDirect" />
### PeeringPropertiesDirect object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  connections | array | No | The set of connections that constitute a direct peering. - [DirectConnection object](#DirectConnection) |
|  peerAsn | integer | No | The Autonomous System Number (ASN) associated with the peering. |
|  useForPeeringService | boolean | No | The flag that indicates whether or not the peering is used for peering service. |


<a id="PeeringPropertiesExchange" />
### PeeringPropertiesExchange object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  connections | array | No | The set of connections that constitute an exchange peering. - [ExchangeConnection object](#ExchangeConnection) |
|  peerAsn | integer | No | The Autonomous System Number (ASN) associated with the peering. |


<a id="DirectConnection" />
### DirectConnection object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  bandwidthInMbps | integer | No | The bandwidth of the connection. |
|  provisionedBandwidthInMbps | integer | No | The bandwidth that is actually provisioned. |
|  peeringDBFacilityId | integer | No | The PeeringDB.com ID of the facility at which the connection has to be set up. |
|  bgpSession | object | No | The BGP session associated with the connection. - [BgpSession object](#BgpSession) |


<a id="ExchangeConnection" />
### ExchangeConnection object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  peeringDBFacilityId | integer | No | The PeeringDB.com ID of the facility at which the connection has to be set up. |
|  bgpSession | object | No | The BGP session associated with the connection. - [BgpSession object](#BgpSession) |


<a id="BgpSession" />
### BgpSession object
|  Name | Type | Required | Value |
|  ---- | ---- | ---- | ---- |
|  sessionPrefixV4 | string | No | The IPv4 prefix that contains both ends' IPv4 addresses. |
|  sessionPrefixV6 | string | No | The IPv6 prefix that contains both ends' IPv6 addresses. |
|  peerSessionIPv4Address | string | No | The IPv4 session address on peer's end. |
|  peerSessionIPv6Address | string | No | The IPv6 session address on peer's end. |
|  maxPrefixesAdvertisedV4 | integer | No | The maximum number of prefixes advertised over the IPv4 session. |
|  maxPrefixesAdvertisedV6 | integer | No | The maximum number of prefixes advertised over the IPv6 session. |
|  md5AuthenticationKey | string | No | The MD5 authentication key of the session. |

