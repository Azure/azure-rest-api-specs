namespace Microsoft.Migrate;

@doc("Name of a load balancer SKU.")
union LbSkuName {
  @doc("Basic SKU.")
  Basic: "Basic",

  @doc("Standard SKU.")
  Standard: "Standard",

  @doc("Gateway SKU.")
  Gateway: "Gateway",

  string,
}

@doc("Tier of a load balancer SKU.")
union LbSkuTier {
  @doc("Regional tier.")
  Regional: "Regional",

  @doc("Global tier.")
  Global: "Global",

  string,
}

@doc("Scope of the load balancer indicating external (Public) or internal (Private).")
union LbType {
  @doc("Public load balancer.")
  Public: "Public",

  @doc("Private load balancer.")
  Private: "Private",

  string,
}

@doc("IP address allocation method.")
union LbIpAllocationMethod {
  @doc("Dynamic IP allocation.")
  Dynamic: "Dynamic",

  @doc("Static IP allocation.")
  Static: "Static",

  string,
}

@doc("Protocol of the load balancer health probe.")
union LbProbeProtocol {
  @doc("HTTP protocol.")
  Http: "Http",

  @doc("TCP protocol.")
  Tcp: "Tcp",

  @doc("HTTPS protocol.")
  Https: "Https",

  string,
}

@doc("Transport protocol used by load balancing rules, outbound rules")
union LbTransportProtocol {
  @doc("UDP protocol.")
  Udp: "Udp",

  @doc("TCP protocol.")
  Tcp: "Tcp",

  @doc("All protocols.")
  All: "All",

  string,
}

@doc("Whether network traffic is allowed or denied.")
union NsgSecurityRuleAccess {
  @doc("Allow network traffic.")
  Allow: "Allow",

  @doc("Deny network traffic.")
  Deny: "Deny",

  string,
}

@doc("The direction of the rule. Specifies if rule will be evaluated on incoming or outgoing traffic.")
union NsgSecurityRuleDirection {
  @doc("Inbound traffic.")
  Inbound: "Inbound",

  @doc("Outbound traffic.")
  Outbound: "Outbound",

  string,
}

@doc("Network protocol this rule applies to.")
union NsgSecurityRuleProtocol {
  @doc("TCP protocol.")
  Tcp: "Tcp",

  @doc("UDP protocol.")
  Udp: "Udp",

  @doc("ICMP protocol.")
  Icmp: "Icmp",

  @doc("ESP protocol.")
  Esp: "Esp",

  @doc("Any protocol.")
  Asterisk: "*",

  @doc("AH protocol.")
  Ah: "Ah",

  string,
}

@doc("The target type of an inbound NAT rule.")
union InboundNatRuleTargetType {
  @doc("The rule targets a specific Azure virtual machine.")
  AzureVm: "AzureVm",

  @doc("The rule targets a backend address pool.")
  BackendPool: "BackendPool",

  string,
}

// ──────────────────────────────────────────────
// Application Gateway enums
// ──────────────────────────────────────────────

@doc("Name of an application gateway SKU.")
union AppGwSku {
  @doc("Standard v2 SKU.")
  Standard_v2: "Standard_v2",

  @doc("WAF v2 SKU.")
  WAF_v2: "WAF_v2",

  string,
}

@doc("Application gateway protocol.")
union AppGwProtocol {
  @doc("HTTP protocol.")
  Http: "Http",

  @doc("HTTPS protocol.")
  Https: "Https",

  @doc("TCP protocol.")
  Tcp: "Tcp",

  @doc("TLS protocol.")
  Tls: "Tls",

  string,
}

@doc("Application gateway request routing rule type.")
union AppGwRequestRoutingRuleType {
  @doc("Basic routing rule.")
  Basic: "Basic",

  @doc("Path based routing rule.")
  PathBasedRouting: "PathBasedRouting",

  string,
}

@doc("Scope of the application gateway indicating external (Public) or internal (Private).")
union AppGwType {
  @doc("Public application gateway.")
  Public: "Public",

  @doc("Private application gateway.")
  Private: "Private",

  string,
}
