import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The allowed names for the access bridge.
 */
union AccessBridgeAllowedName {
  string,

  /**
   * The access bridge for bare metal machine bastion access.
   */
  Bastion: "Bastion",

  /**
   * The access bridge for cluster access to private vault.
   */
  PrivateVault: "PrivateVault",

  /**
   * The access bridge for access to the storage dashboard.
   */
  StorageDashboard: "StorageDashboard",
}

/**
 * The detailed status reported by the access bridge.
 */
union AccessBridgeDetailedStatus {
  string,

  /**
   * The access bridge is healthy and operating normally.
   */
  Running: "Running",

  /**
   * The access bridge is experiencing degraded performance or partial outages.
   */
  Degraded: "Degraded",

  /**
   * The access bridge is not operational.
   */
  Failed: "Failed",
}

/**
 * The provisioning state of the access bridge.
 */
union AccessBridgeProvisioningState {
  string,

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",
}

/**
 * The direction of allowed network traffic based on the rule.
 */
union SecurityRuleDirection {
  string,

  /**
   * Inbound traffic toward the on-premsises cluster.
   */
  Inbound: "Inbound",

  /**
   * Outbound traffic from the on-premises cluster.
   */
  Outbound: "Outbound",
}

/**
 * The protocol advertised by the access bridge endpoints.
 */
union TransportProtocol {
  string,

  /**
   * The TCP transport protocol.
   */
  TCP: "TCP",

  /**
   * The UDP transport protocol.
   */
  UDP: "UDP",
}

/**
 * AccessBridgeList represents a paged list of access bridges.
 */
model AccessBridgeList is Azure.Core.Page<AccessBridge>;

/**
 * AccessBridgeProperties captures the input and status for an access bridge.
 */
model AccessBridgeProperties {
  ...AccessBridgeCreationProperties;
  ...AccessBridgeMutableProperties;
  ...AccessBridgeStatus;

  /**
   * The provisioning state of the access bridge.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AccessBridgeProvisioningState;
}

/**
 * AccessBridgeCreationProperties groups the creation-only fields for the access bridge.
 */
model AccessBridgeCreationProperties {
  /**
   * The IPv4 subnet from which the access bridge allocates an address. This subnet must be part of the internal network specified by networkId.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4ConnectedPrefix?: string;

  /**
   * The IPv6 subnet from which the access bridge allocates an address. This subnet must be part of the internal network specified by networkId.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6ConnectedPrefix?: string;

  /**
   * The resource ID of the internal network in a layer 3 isolation domain containing the IP subnets to use.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;
}

/**
 * AccessBridgeMutableProperties groups the mutable fields for the access bridge.
 */
model AccessBridgeMutableProperties {
  /**
   * The list of security rules enforced by the access bridge.
   */
  @identifiers(#[])
  securityRules?: AccessBridgeSecurityRule[];
}

/**
 * AccessBridgeStatus exposes the read-only values produced by the platform.
 */
model AccessBridgeStatus {
  /**
   * The detailed status reported by the access bridge.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: AccessBridgeDetailedStatus;

  /**
   * The descriptive message that accompanies the detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The observed endpoints that clients should use to reach the access bridge.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["fqdn"])
  endpoints?: AccessBridgeEndpoint[];

  /**
   * The protocol advertised by the access bridge endpoints.
   */
  @visibility(Lifecycle.Read)
  protocol?: TransportProtocol;
}

/**
 * AccessBridgeEndpoint describes a single advertised service endpoint.
 */
model AccessBridgeEndpoint {
  /**
   * The fully qualified domain name used to describe the certificate name for the endpoint.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The IPv4 address associated with the endpoint.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * The IPv6 address associated with the endpoint.
   */
  @visibility(Lifecycle.Read)
  ipv6Address?: string;

  /**
   * The name that identifies the type of endpoint (for example VIP or host).
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * AccessBridgeSecurityRule captures an individual access rule enforced by the bridge.
 */
model AccessBridgeSecurityRule {
  /**
   * The user provided value describing this rule.
   */
  description?: string;

  /**
   * The direction of allowed network traffic based on the rule.
   */
  direction: SecurityRuleDirection;

  /**
   * The set of IPv4 addresses permitted as the source or destination of the security rule. For as single address, utilize a /32 (CIDR notation). One or both Ipv4Addresses and Ipv6Addresses must be specified. Example formats: 10.10.10.10-10.10.10.20 or 10.10.10.10/24.
   */
  ipv4Addresses?: string[];

  /**
   * The set of IPv6 addresses permitted as the source or destination of the security rule. For as single address, utilize a /128 (CIDR notation). One or both Ipv4Addresses and Ipv6Addresses must be specified. Example formats: 2001:db8:abcd::1-2001:db8:abcd::ff or 2001:db8:abcd::1/64.
   */
  ipv6Addresses?: string[];

  /**
   * The source or destination port or port range. Example 24562 or 24562-24570.
   */
  port: string;
}

/**
 * AccessBridgePatchParameters represents the payload for a PATCH request to an access bridge.
 */
model AccessBridgePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: AccessBridgePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * AccessBridgePatchProperties identifies the mutable properties for patch operations.
 */
model AccessBridgePatchProperties {
  ...AccessBridgeMutableProperties;
}
