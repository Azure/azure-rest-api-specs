import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Network;

/**
 * The current status of the DNS resolver. This is a read-only property and any attempt to set this value will be ignored.
 */
union DnsResolverState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * The current provisioning state of the resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Private IP address allocation method.
 */
union IpAllocationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Static: "Static",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dynamic: "Dynamic",
}

/**
 * The state of forwarding rule.
 */
union ForwardingRuleState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The type of action to take.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Alert: "Alert",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Block: "Block",
}

/**
 * The state of DNS security rule.
 */
union DnsSecurityRuleState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The action type in requests for bulk upload or download of a DNS resolver domain list.
 */
union Action {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Upload: "Upload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Download: "Download",
}

/**
 * Represents the properties of a DNS resolver.
 */
model DnsResolverProperties {
  /**
   * The reference to the virtual network. This cannot be changed after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  virtualNetwork: SubResource;

  /**
   * The current status of the DNS resolver. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  dnsResolverState?: DnsResolverState;

  /**
   * The current provisioning state of the DNS resolver. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid property of the DNS resolver resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Reference to another ARM resource.
 */
model SubResource {
  /**
   * Resource ID.
   */
  id: string;
}

/**
 * An error message
 */
@error
model CloudError {
  /**
   * The error message body
   */
  error?: CloudErrorBody;
}

/**
 * The body of an error message
 */
model CloudErrorBody {
  /**
   * The error code
   */
  code?: string;

  /**
   * A description of what caused the error
   */
  message?: string;

  /**
   * The target resource of the error message
   */
  target?: string;

  /**
   * Extra error information
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: CloudErrorBody[];
}

/**
 * Describes a DNS resolver for PATCH operation.
 */
model DnsResolverPatch {
  /**
   * Tags for DNS Resolver.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of an inbound endpoint for a DNS resolver.
 */
model InboundEndpointProperties {
  /**
   * IP configurations for the inbound endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipConfigurations: IpConfiguration[];

  /**
   * The current provisioning state of the inbound endpoint. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid property of the inbound endpoint resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * IP configuration.
 */
model IpConfiguration {
  /**
   * The reference to the subnet bound to the IP configuration.
   */
  subnet: SubResource;

  /**
   * Private IP address of the IP configuration.
   */
  privateIpAddress?: string;

  /**
   * Private IP address allocation method.
   */
  privateIpAllocationMethod?: IpAllocationMethod = IpAllocationMethod.Dynamic;
}

/**
 * Describes an inbound endpoint for a DNS resolver for PATCH operation.
 */
model InboundEndpointPatch {
  /**
   * Tags for inbound endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of an outbound endpoint for a DNS resolver.
 */
model OutboundEndpointProperties {
  /**
   * The reference to the subnet used for the outbound endpoint.
   */
  subnet: SubResource;

  /**
   * The current provisioning state of the outbound endpoint. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid property of the outbound endpoint resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Describes an outbound endpoint for a DNS resolver for PATCH operation.
 */
model OutboundEndpointPatch {
  /**
   * Tags for outbound endpoint.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of a DNS forwarding ruleset.
 */
model DnsForwardingRulesetProperties {
  /**
   * The reference to the DNS resolver outbound endpoints that are used to route DNS queries matching the forwarding rules in the ruleset to the target DNS servers.
   */
  dnsResolverOutboundEndpoints: SubResource[];

  /**
   * The current provisioning state of the DNS forwarding ruleset. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid for the DNS forwarding ruleset.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Describes a DNS forwarding ruleset PATCH operation.
 */
model DnsForwardingRulesetPatch {
  /**
   * The reference to the DNS resolver outbound endpoints that are used to route DNS queries matching the forwarding rules in the ruleset to the target DNS servers.
   */
  dnsResolverOutboundEndpoints?: SubResource[];

  /**
   * Tags for DNS Resolver.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of a forwarding rule within a DNS forwarding ruleset.
 */
model ForwardingRuleProperties {
  /**
   * The domain name for the forwarding rule.
   */
  domainName: string;

  /**
   * DNS servers to forward the DNS query to.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  targetDnsServers: TargetDnsServer[];

  /**
   * Metadata attached to the forwarding rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * The state of forwarding rule.
   */
  forwardingRuleState?: ForwardingRuleState;

  /**
   * The current provisioning state of the forwarding rule. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Describes a server to forward the DNS queries to.
 */
model TargetDnsServer {
  /**
   * DNS server IP address.
   */
  ipAddress: string;

  /**
   * DNS server port.
   */
  port?: int32 = 53;
}

/**
 * Describes a forwarding rule for PATCH operation.
 */
model ForwardingRulePatch {
  /**
   * Updatable properties of the forwarding rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ForwardingRulePatchProperties;
}

/**
 * Represents the updatable properties of a forwarding rule within a DNS forwarding ruleset.
 */
model ForwardingRulePatchProperties {
  /**
   * DNS servers to forward the DNS query to.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  targetDnsServers?: TargetDnsServer[];

  /**
   * Metadata attached to the forwarding rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * The state of forwarding rule.
   */
  forwardingRuleState?: ForwardingRuleState = ForwardingRuleState.Enabled;
}

/**
 * Represents the properties of a virtual network link.
 */
model VirtualNetworkLinkProperties {
  /**
   * The reference to the virtual network. This cannot be changed after creation.
   */
  virtualNetwork: SubResource;

  /**
   * Metadata attached to the virtual network link.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;

  /**
   * The current provisioning state of the virtual network link. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Describes a virtual network link for PATCH operation.
 */
model VirtualNetworkLinkPatch {
  /**
   * Updatable properties of the virtual network link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualNetworkLinkPatchProperties;
}

/**
 * Represents the updatable properties of the virtual network link.
 */
model VirtualNetworkLinkPatchProperties {
  /**
   * Metadata attached to the virtual network link.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  metadata?: Record<string>;
}

/**
 * The response to an enumeration operation on sub-resources.
 */
model SubResourceListResult is Azure.Core.Page<SubResource>;

/**
 * The response to an enumeration operation on Virtual Network DNS Forwarding Ruleset.
 */
model VirtualNetworkDnsForwardingRulesetListResult
  is Azure.Core.Page<VirtualNetworkDnsForwardingRuleset>;

/**
 * Reference to DNS forwarding ruleset and associated virtual network link.
 */
model VirtualNetworkDnsForwardingRuleset {
  /**
   * DNS Forwarding Ruleset Resource ID.
   */
  id?: string;

  /**
   * Properties of the virtual network link sub-resource reference.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualNetworkLinkSubResourceProperties;
}

/**
 * The reference to the virtual network link that associates between the DNS forwarding ruleset and virtual network.
 */
model VirtualNetworkLinkSubResourceProperties {
  /**
   * The reference to the virtual network link.
   */
  virtualNetworkLink?: SubResource;
}

/**
 * Represents the properties of a DNS resolver policy.
 */
model DnsResolverPolicyProperties {
  /**
   * The current provisioning state of the DNS resolver policy. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid property of the DNS resolver policy resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Describes a DNS resolver policy for PATCH operation.
 */
model DnsResolverPolicyPatch {
  /**
   * Tags for DNS resolver policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of a DNS security rule.
 */
model DnsSecurityRuleProperties {
  /**
   * The priority of the DNS security rule.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  priority: int32;

  /**
   * The action to take on DNS requests that match the DNS security rule.
   */
  action: DnsSecurityRuleAction;

  /**
   * DNS resolver policy domains lists that the DNS security rule applies to.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsResolverDomainLists: SubResource[];

  /**
   * The state of DNS security rule.
   */
  dnsSecurityRuleState?: DnsSecurityRuleState;

  /**
   * The current provisioning state of the DNS security rule. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The action to take on DNS requests that match the DNS security rule.
 */
model DnsSecurityRuleAction {
  /**
   * The type of action to take.
   */
  actionType?: ActionType;
}

/**
 * Describes a DNS security rule for PATCH operation.
 */
model DnsSecurityRulePatch {
  /**
   * Updatable properties of the DNS security rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DnsSecurityRulePatchProperties;

  /**
   * Tags for DNS security rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the updatable properties of a DNS security rule.
 */
model DnsSecurityRulePatchProperties {
  /**
   * The action to take on DNS requests that match the DNS security rule.
   */
  action?: DnsSecurityRuleAction;

  /**
   * DNS resolver policy domains lists that the DNS security rule applies to.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  dnsResolverDomainLists?: SubResource[];

  /**
   * The state of DNS security rule.
   */
  dnsSecurityRuleState?: DnsSecurityRuleState;

  /**
   * The priority of the DNS security rule.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  priority?: int32;
}

/**
 * Represents the properties of a DNS resolver policy virtual network link.
 */
model DnsResolverPolicyVirtualNetworkLinkProperties {
  /**
   * The reference to the virtual network. This cannot be changed after creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  virtualNetwork: SubResource;

  /**
   * The current provisioning state of the DNS resolver policy virtual network link. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Describes a DNS resolver policy virtual network link for PATCH operation.
 */
model DnsResolverPolicyVirtualNetworkLinkPatch {
  /**
   * Tags for the DNS resolver policy virtual network link.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the properties of a DNS resolver domain list.
 */
model DnsResolverDomainListProperties {
  /**
   * The domains in the domain list. Will be null if user is using large domain list.
   */
  domains?: string[];

  /**
   * The URL for bulk upload or download for domain lists containing larger set of domains. This will be populated if domains is empty or null.
   */
  @visibility(Lifecycle.Read)
  domainsUrl?: string;

  /**
   * The current provisioning state of the DNS resolver domain list. This is a read-only property and any attempt to set this value will be ignored.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resourceGuid property of the DNS resolver domain list resource.
   */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Describes a DNS resolver domain list for PATCH operation.
 */
model DnsResolverDomainListPatch {
  /**
   * Updatable properties of the DNS resolver domain list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DnsResolverDomainListPatchProperties;

  /**
   * Tags for DNS resolver domain list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Represents the updatable properties of a DNS resolver domain list.
 */
model DnsResolverDomainListPatchProperties {
  /**
   * The domains in the domain list.
   */
  domains?: string[];
}

/**
 * Describes a DNS resolver domain list for bulk UPLOAD or DOWNLOAD operations.
 */
model DnsResolverDomainListBulk {
  /**
   * Properties of the DNS resolver domain list upload or download request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: DnsResolverDomainListBulkProperties;
}

/**
 * Describes DNS resolver domain list properties for bulk UPLOAD or DOWNLOAD operations.
 */
model DnsResolverDomainListBulkProperties {
  /**
   * The storage account blob file URL to be used in the bulk upload or download request of DNS resolver domain list.
   */
  storageUrl: string;

  /**
   * The action to take in the request, Upload or Download.
   */
  action: Action;
}
