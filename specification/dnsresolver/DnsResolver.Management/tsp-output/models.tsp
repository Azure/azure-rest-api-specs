import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DnsResolverManagementClient;

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

@doc("Describes a DNS resolver.")
model DnsResolver {
  ...TrackedResource;

  @doc("ETag of the DNS resolver.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the DNS resolver.")
  properties: DnsResolverProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents the properties of a DNS resolver.")
model DnsResolverProperties {
  @doc("The reference to the virtual network. This cannot be changed after creation.")
  virtualNetwork: SubResource;

  @doc("""
The current status of the DNS resolver. This is a read-only property and any
attempt to set this value will be ignored.
""")
  @visibility("read")
  dnsResolverState?: DnsResolverState;

  @doc("""
The current provisioning state of the DNS resolver. This is a read-only
property and any attempt to set this value will be ignored.
""")
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

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;
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

@doc("Describes a DNS resolver for PATCH operation.")
model DnsResolverPatch {
  @doc("Tags for DNS Resolver.")
  tags?: Record<string>;
}

@doc("The response to an enumeration operation on DNS resolvers.")
model DnsResolverListResult is Azure.Core.Page<DnsResolver>;

@doc("Describes an inbound endpoint for a DNS resolver.")
model InboundEndpoint {
  ...TrackedResource;

  @doc("ETag of the inbound endpoint.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the inbound endpoint.")
  properties: InboundEndpointProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents the properties of an inbound endpoint for a DNS resolver.")
model InboundEndpointProperties {
  @doc("IP configurations for the inbound endpoint.")
  ipConfigurations: IpConfiguration[];

  @doc("""
The current provisioning state of the inbound endpoint. This is a read-only
property and any attempt to set this value will be ignored.
""")
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

@doc("Describes an inbound endpoint for a DNS resolver for PATCH operation.")
model InboundEndpointPatch {
  @doc("Tags for inbound endpoint.")
  tags?: Record<string>;
}

@doc("""
The response to an enumeration operation on inbound endpoints for a DNS
resolver.
""")
model InboundEndpointListResult is Azure.Core.Page<InboundEndpoint>;

@doc("Describes an outbound endpoint for a DNS resolver.")
model OutboundEndpoint {
  ...TrackedResource;

  @doc("ETag of the outbound endpoint.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the outbound endpoint.")
  properties: OutboundEndpointProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents the properties of an outbound endpoint for a DNS resolver.")
model OutboundEndpointProperties {
  @doc("The reference to the subnet used for the outbound endpoint.")
  subnet: SubResource;

  @doc("""
The current provisioning state of the outbound endpoint. This is a read-only
property and any attempt to set this value will be ignored.
""")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid property of the outbound endpoint resource.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("Describes an outbound endpoint for a DNS resolver for PATCH operation.")
model OutboundEndpointPatch {
  @doc("Tags for outbound endpoint.")
  tags?: Record<string>;
}

@doc("""
The response to an enumeration operation on outbound endpoints for a DNS
resolver.
""")
model OutboundEndpointListResult is Azure.Core.Page<OutboundEndpoint>;

@doc("Describes a DNS forwarding ruleset.")
model DnsForwardingRuleset {
  ...TrackedResource;

  @doc("ETag of the DNS forwarding ruleset.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the DNS forwarding ruleset.")
  properties: DnsForwardingRulesetProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents the properties of a DNS forwarding ruleset.")
model DnsForwardingRulesetProperties {
  @doc("""
The reference to the DNS resolver outbound endpoints that are used to route DNS
queries matching the forwarding rules in the ruleset to the target DNS servers.
""")
  dnsResolverOutboundEndpoints: SubResource[];

  @doc("""
The current provisioning state of the DNS forwarding ruleset. This is a
read-only property and any attempt to set this value will be ignored.
""")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resourceGuid for the DNS forwarding ruleset.")
  @visibility("read")
  resourceGuid?: string;
}

@doc("Describes a DNS forwarding ruleset PATCH operation.")
model DnsForwardingRulesetPatch {
  @doc("""
The reference to the DNS resolver outbound endpoints that are used to route DNS
queries matching the forwarding rules in the ruleset to the target DNS servers.
""")
  dnsResolverOutboundEndpoints?: SubResource[];

  @doc("Tags for DNS Resolver.")
  tags?: Record<string>;
}

@doc("The response to an enumeration operation on DNS forwarding rulesets.")
model DnsForwardingRulesetListResult is Azure.Core.Page<DnsForwardingRuleset>;

@doc("Describes a forwarding rule within a DNS forwarding ruleset.")
model ForwardingRule {
  ...ProxyResource;

  @doc("ETag of the forwarding rule.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the forwarding rule.")
  properties: ForwardingRuleProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
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

  @doc("""
The current provisioning state of the forwarding rule. This is a read-only
property and any attempt to set this value will be ignored.
""")
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

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("Describes a forwarding rule for PATCH operation.")
model ForwardingRulePatch {
  @doc("Updatable properties of the forwarding rule.")
  properties?: ForwardingRulePatchProperties;
}

@doc("""
Represents the updatable properties of a forwarding rule within a DNS
forwarding ruleset.
""")
model ForwardingRulePatchProperties {
  @doc("DNS servers to forward the DNS query to.")
  targetDnsServers?: TargetDnsServer[];

  @doc("Metadata attached to the forwarding rule.")
  metadata?: Record<string>;

  @doc("The state of forwarding rule.")
  forwardingRuleState?: ForwardingRuleState;
}

@doc("""
The response to an enumeration operation on forwarding rules within a DNS
forwarding ruleset.
""")
model ForwardingRuleListResult is Azure.Core.Page<ForwardingRule>;

@doc("Describes a virtual network link.")
model VirtualNetworkLink {
  ...ProxyResource;

  @doc("ETag of the virtual network link.")
  @visibility("read")
  etag?: string;

  @doc("Properties of the virtual network link.")
  properties: VirtualNetworkLinkProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Represents the properties of a virtual network link.")
model VirtualNetworkLinkProperties {
  @doc("The reference to the virtual network. This cannot be changed after creation.")
  virtualNetwork: SubResource;

  @doc("Metadata attached to the virtual network link.")
  metadata?: Record<string>;

  @doc("""
The current provisioning state of the virtual network link. This is a read-only
property and any attempt to set this value will be ignored.
""")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Describes a virtual network link for PATCH operation.")
model VirtualNetworkLinkPatch {
  @doc("Updatable properties of the virtual network link.")
  properties?: VirtualNetworkLinkPatchProperties;
}

@doc("Represents the updatable properties of the virtual network link.")
model VirtualNetworkLinkPatchProperties {
  @doc("Metadata attached to the virtual network link.")
  metadata?: Record<string>;
}

@doc("The response to an enumeration operation on virtual network links.")
model VirtualNetworkLinkListResult is Azure.Core.Page<VirtualNetworkLink>;

@doc("The response to an enumeration operation on sub-resources.")
model SubResourceListResult is Azure.Core.Page<SubResource>;

@doc("""
The response to an enumeration operation on Virtual Network DNS Forwarding
Ruleset.
""")
model VirtualNetworkDnsForwardingRulesetListResult
  is Azure.Core.Page<VirtualNetworkDnsForwardingRuleset>;

@doc("Reference to DNS forwarding ruleset and associated virtual network link.")
model VirtualNetworkDnsForwardingRuleset {
  @doc("DNS Forwarding Ruleset Resource ID.")
  id?: string;

  @doc("Properties of the virtual network link sub-resource reference.")
  properties?: VirtualNetworkLinkSubResourceProperties;
}

@doc("""
The reference to the virtual network link that associates between the DNS
forwarding ruleset and virtual network.
""")
model VirtualNetworkLinkSubResourceProperties {
  @doc("The reference to the virtual network link.")
  virtualNetworkLink?: SubResource;
}
