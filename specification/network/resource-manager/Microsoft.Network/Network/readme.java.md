## Java

These settings apply only when `--java` is specified on the command line.

``` yaml $(java)
add-inner: ApplicationGatewayIpConfiguration,ApplicationGatewayPathRule,ApplicationGatewayProbe,ApplicationGatewayRedirectConfiguration,ApplicationGatewayRequestRoutingRule,ApplicationGatewaySslCertificate,ApplicationGatewayUrlPathMap,ApplicationGatewayAuthenticationCertificate,VirtualNetworkGatewayIpConfiguration,ConnectionMonitor,PacketCapture,ApplicationGateway,ApplicationGatewayListener
enable-sync-stack: false
directive:
  - rename-operation:
      from: VirtualHubBgpConnection_Get
      to: VirtualHubBgpConnections_Get
  - rename-operation:
      from: VirtualHubBgpConnection_CreateOrUpdate
      to: VirtualHubBgpConnections_CreateOrUpdate
  - rename-operation:
      from: VirtualHubBgpConnection_Delete
      to: VirtualHubBgpConnections_Delete
  - rename-operation:
      from: InboundSecurityRule_CreateOrUpdate
      to: InboundSecurityRuleOperation_CreateOrUpdate
  - rename-operation:
      from: InboundSecurityRule_Get
      to: InboundSecurityRuleOperation_Get
  - from: vmssNetworkInterface.json
    where: '$.info'
    transform: >
      $["version"] = "2018-10-01";
  - from: vmssNetworkPublicIpAddress.json
    where: '$.info'
    transform: >
      $["version"] = "2018-10-01";
  - from: applicationGateway.json
    where: '$.definitions.ApplicationGatewayFirewallExclusion'
    transform: >
      $["required"] = ["matchVariable"]
```

