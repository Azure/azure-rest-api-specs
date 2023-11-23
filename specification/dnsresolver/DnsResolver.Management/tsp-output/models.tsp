import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Network;

interface Operations extends Azure.ResourceManager.Operations {}

enum DnsResolverState {
  Connected,
  Disconnected,
}

enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum IpAllocationMethod {
  Static,
  Dynamic,
}

enum ForwardingRuleState {
  Enabled,
  Disabled,
}

@doc("Represents the properties of a DNS resolver.")
model DnsResolverProperties {
  @doc("The reference to the virtual network. This cannot be changed after creation.")
  @visibility("read", "create")
  virtualNetwork: SubResource;

  @doc("The current status of the DNS resolver. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  dnsResolverState?: DnsResolverState;

  @doc("The current provisioning state of the DNS resolver. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid property of the DNS resolver resource.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("Reference to another ARM resource.")
model SubResource {
  @doc("Resource ID.")
  id: string;
}

@doc("An error message")
@error
model CloudError {
  @doc("The error message body")
  error?: CloudErrorBody;
}

@doc("The body of an error message")
model CloudErrorBody {
  @doc("The error code")
  code?: string;

  @doc("A description of what caused the error")
  message?: string;

  @doc("The target resource of the error message")
  target?: string;

  @doc("Extra error information")
  details?: CloudErrorBody[];
}

@doc("Represents the properties of an inbound endpoint for a DNS resolver.")
model InboundEndpointProperties {
  @doc("IP configurations for the inbound endpoint.")
  ipConfigurations: IpConfiguration[];

  @doc("The current provisioning state of the inbound endpoint. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid property of the inbound endpoint resource.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("IP configuration.")
model IpConfiguration {
  @doc("The reference to the subnet bound to the IP configuration.")
  subnet: SubResource;

  @doc("Private IP address of the IP configuration.")
  privateIpAddress?: string;

  @doc("Private IP address allocation method.")
  privateIpAllocationMethod?: IpAllocationMethod;
}

@doc("Represents the properties of an outbound endpoint for a DNS resolver.")
model OutboundEndpointProperties {
  @doc("The reference to the subnet used for the outbound endpoint.")
  subnet: SubResource;

  @doc("The current provisioning state of the outbound endpoint. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid property of the outbound endpoint resource.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("Represents the properties of a DNS forwarding ruleset.")
model DnsForwardingRulesetProperties {
  @doc("The reference to the DNS resolver outbound endpoints that are used to route DNS queries matching the forwarding rules in the ruleset to the target DNS servers.")
  dnsResolverOutboundEndpoints: SubResource[];

  @doc("The current provisioning state of the DNS forwarding ruleset. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid for the DNS forwarding ruleset.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("Represents the properties of a forwarding rule within a DNS forwarding ruleset.")
model ForwardingRuleProperties {
  @doc("The domain name for the forwarding rule.")
  domainName: string;

  @doc("DNS servers to forward the DNS query to.")
  targetDnsServers: TargetDnsServer[];

  @doc("Metadata attached to the forwarding rule.")
  metadata?: Record<string>;

  @doc("The state of forwarding rule.")
  forwardingRuleState?: ForwardingRuleState;

  @doc("The current provisioning state of the forwarding rule. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes a server to forward the DNS queries to.")
model TargetDnsServer {
  @doc("DNS server IP address.")
  ipAddress: string;

  @doc("DNS server port.")
  port?: int32;
}

@doc("Represents the properties of a virtual network link.")
model VirtualNetworkLinkProperties {
  @doc("The reference to the virtual network. This cannot be changed after creation.")
  virtualNetwork: SubResource;

  @doc("Metadata attached to the virtual network link.")
  metadata?: Record<string>;

  @doc("The current provisioning state of the virtual network link. This is a read-only property and any attempt to set this value will be ignored.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The response to an enumeration operation on sub-resources.")
model SubResourceListResult is Azure.Core.Page<SubResource>;

@doc("The response to an enumeration operation on Virtual Network DNS Forwarding Ruleset.")
model VirtualNetworkDnsForwardingRulesetListResult
  is Azure.Core.Page<VirtualNetworkDnsForwardingRuleset>;

@doc("Reference to DNS forwarding ruleset and associated virtual network link.")
model VirtualNetworkDnsForwardingRuleset {
  @doc("DNS Forwarding Ruleset Resource ID.")
  id?: string;

  @doc("Properties of the virtual network link sub-resource reference.")
  properties?: VirtualNetworkLinkSubResourceProperties;
}

@doc("The reference to the virtual network link that associates between the DNS forwarding ruleset and virtual network.")
model VirtualNetworkLinkSubResourceProperties {
  @doc("The reference to the virtual network link.")
  virtualNetworkLink?: SubResource;
}
