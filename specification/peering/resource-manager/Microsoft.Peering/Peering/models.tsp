import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Peering;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union Paths1Ou8OgqSubscriptionsSubscriptionidProvidersMicrosoftPeeringCheckserviceprovideravailabilityPostResponses200ContentApplicationJsonSchema {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LegacyPeeringsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exchange: "Exchange",
}

/**
 * The type of direct peering.
 */
union DirectPeeringType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Edge: "Edge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transit: "Transit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cdn: "Cdn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ix: "Ix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IxRs: "IxRs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Voice: "Voice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZoneForOperators: "EdgeZoneForOperators",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PeerProp: "PeerProp",
}

/**
 * The tier of the peering SKU.
 */
union Tier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
}

/**
 * The family of the peering SKU.
 */
union Family {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exchange: "Exchange",
}

/**
 * The size of the peering SKU.
 */
union Size {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Metered: "Metered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unlimited: "Unlimited",
}

/**
 * The kind of the peering.
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exchange: "Exchange",
}

/**
 * The field indicating if Microsoft provides session ip addresses.
 */
union SessionAddressProvider {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Microsoft: "Microsoft",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Peer: "Peer",
}

/**
 * The state of the connection.
 */
union ConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingApproval: "PendingApproval",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProvisioningStarted: "ProvisioningStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProvisioningFailed: "ProvisioningFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProvisioningCompleted: "ProvisioningCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TypeChangeRequested: "TypeChangeRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TypeChangeInProgress: "TypeChangeInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExternalBlocker: "ExternalBlocker",
}

/**
 * The state of the IPv4 session.
 */
union SessionStateV4 {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connect: "Connect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenSent: "OpenSent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenConfirm: "OpenConfirm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenReceived: "OpenReceived",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Established: "Established",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingAdd: "PendingAdd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingUpdate: "PendingUpdate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingRemove: "PendingRemove",
}

/**
 * The state of the IPv6 session.
 */
union SessionStateV6 {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Idle: "Idle",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connect: "Connect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenSent: "OpenSent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenConfirm: "OpenConfirm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OpenReceived: "OpenReceived",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Established: "Established",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingAdd: "PendingAdd",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingUpdate: "PendingUpdate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PendingRemove: "PendingRemove",
}

/**
 * The protocol of the traffic that will be sent for the connectivity probe.
 */
union Protocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ICMP: "ICMP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TCP: "TCP",
}

/**
 * The provisioning state of the resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LookingGlassCommand {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Traceroute: "Traceroute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ping: "Ping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BgpRoute: "BgpRoute",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LookingGlassSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeSite: "EdgeSite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureRegion: "AzureRegion",
}

/**
 * Invoked command
 */
union Command {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Traceroute: "Traceroute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ping: "Ping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BgpRoute: "BgpRoute",
}

/**
 * The role of the contact.
 */
union Role {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Noc: "Noc",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Policy: "Policy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Technical: "Technical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Service: "Service",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Escalation: "Escalation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Other: "Other",
}

/**
 * The validation state of the ASN associated with the peer.
 */
union ValidationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union PeeringLocationsKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Direct: "Direct",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Exchange: "Exchange",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union PeeringLocationsDirectPeeringType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Edge: "Edge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Transit: "Transit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cdn: "Cdn",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ix: "Ix",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IxRs: "IxRs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Voice: "Voice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EdgeZoneForOperators: "EdgeZoneForOperators",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PeerProp: "PeerProp",
}

/**
 * The prefix validation state.
 */
union PrefixValidationState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Verified: "Verified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
}

/**
 * The prefix learned type
 */
union LearnedType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ViaServiceProvider: "ViaServiceProvider",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ViaSession: "ViaSession",
}

/**
 * The CDN peering prefix
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CdnPeeringPrefix extends CommonTypes.Resource {
  /**
   * The properties that define a cdn peering prefix.
   */
  properties?: CdnPeeringPrefixProperties;
}

/**
 * The properties that define a CDN peering prefix
 */
model CdnPeeringPrefixProperties {
  /**
   * The prefix.
   */
  @visibility(Lifecycle.Read)
  prefix?: string;

  /**
   * The Azure region.
   */
  @visibility(Lifecycle.Read)
  azureRegion?: string;

  /**
   * The Azure service.
   */
  @visibility(Lifecycle.Read)
  azureService?: string;

  /**
   * The flag that indicates whether or not this is the primary region.
   */
  @visibility(Lifecycle.Read)
  isPrimaryRegion?: boolean;

  /**
   * The BGP Community
   */
  @visibility(Lifecycle.Read)
  bgpCommunity?: string;
}

/**
 * The error response that indicates why an operation has failed.
 */
@error
model ErrorResponse {
  /**
   * The error detail that describes why an operation has failed.
   */
  error?: ErrorDetail;
}

/**
 * The error detail that describes why an operation has failed.
 */
model ErrorDetail {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Class for CheckServiceProviderAvailabilityInput
 */
model CheckServiceProviderAvailabilityInput {
  /**
   * Gets or sets the peering service location.
   */
  peeringServiceLocation?: string;

  /**
   * Gets or sets the peering service provider.
   */
  peeringServiceProvider?: string;
}

/**
 * The SKU that defines the tier and kind of the peering.
 */
model PeeringSku {
  /**
   * The name of the peering SKU.
   */
  name?: string;

  /**
   * The tier of the peering SKU.
   */
  @visibility(Lifecycle.Read)
  tier?: Tier;

  /**
   * The family of the peering SKU.
   */
  @visibility(Lifecycle.Read)
  family?: Family;

  /**
   * The size of the peering SKU.
   */
  @visibility(Lifecycle.Read)
  size?: Size;
}

/**
 * The properties that define connectivity to the Microsoft Cloud Edge.
 */
model PeeringProperties {
  /**
   * The properties that define a direct peering.
   */
  direct?: PeeringPropertiesDirect;

  /**
   * The properties that define an exchange peering.
   */
  exchange?: PeeringPropertiesExchange;

  /**
   * The connectivity probes associated with the peering.
   */
  @identifiers(#[])
  connectivityProbes?: ConnectivityProbe[];

  /**
   * The location of the peering.
   */
  peeringLocation?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties that define a direct peering.
 */
model PeeringPropertiesDirect {
  /**
   * The set of connections that constitute a direct peering.
   */
  @identifiers(#[])
  connections?: DirectConnection[];

  /**
   * The flag that indicates whether or not the peering is used for peering service.
   */
  @visibility(Lifecycle.Read)
  useForPeeringService?: boolean;

  /**
   * The reference of the peer ASN.
   */
  peerAsn?: SubResource;

  /**
   * The type of direct peering.
   */
  directPeeringType?: DirectPeeringType;
}

/**
 * The properties that define a direct connection.
 */
model DirectConnection {
  /**
   * The bandwidth of the connection.
   */
  bandwidthInMbps?: int32;

  /**
   * The bandwidth that is actually provisioned.
   */
  @visibility(Lifecycle.Read)
  provisionedBandwidthInMbps?: int32;

  /**
   * The field indicating if Microsoft provides session ip addresses.
   */
  sessionAddressProvider?: SessionAddressProvider;

  /**
   * The flag that indicates whether or not the connection is used for peering service.
   */
  useForPeeringService?: boolean;

  /**
   * The ID used within Microsoft's peering provisioning system to track the connection
   */
  @visibility(Lifecycle.Read)
  microsoftTrackingId?: string;

  /**
   * The PeeringDB.com ID of the facility at which the connection has to be set up.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityId?: int32;

  /**
   * The state of the connection.
   */
  @visibility(Lifecycle.Read)
  connectionState?: ConnectionState;

  /**
   * The BGP session associated with the connection.
   */
  bgpSession?: BgpSession;

  /**
   * The unique identifier (GUID) for the connection.
   */
  connectionIdentifier?: string;

  /**
   * The error message related to the connection state, if any.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * The properties that define a BGP session.
 */
model BgpSession {
  /**
   * The IPv4 prefix that contains both ends' IPv4 addresses.
   */
  sessionPrefixV4?: string;

  /**
   * The IPv6 prefix that contains both ends' IPv6 addresses.
   */
  sessionPrefixV6?: string;

  /**
   * The IPv4 session address on Microsoft's end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  microsoftSessionIPv4Address?: string;

  /**
   * The IPv6 session address on Microsoft's end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  microsoftSessionIPv6Address?: string;

  /**
   * The IPv4 session address on peer's end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peerSessionIPv4Address?: string;

  /**
   * The IPv6 session address on peer's end.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peerSessionIPv6Address?: string;

  /**
   * The state of the IPv4 session.
   */
  @visibility(Lifecycle.Read)
  sessionStateV4?: SessionStateV4;

  /**
   * The state of the IPv6 session.
   */
  @visibility(Lifecycle.Read)
  sessionStateV6?: SessionStateV6;

  /**
   * The maximum number of prefixes advertised over the IPv4 session.
   */
  maxPrefixesAdvertisedV4?: int32;

  /**
   * The maximum number of prefixes advertised over the IPv6 session.
   */
  maxPrefixesAdvertisedV6?: int32;

  /**
   * The MD5 authentication key of the session.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Property 'md5AuthenticationKey' looks like it contains sensitive information. Consider marking it with @secret decorator to ensure it is handled securely."
  md5AuthenticationKey?: string;
}

/**
 * The sub resource.
 */
model SubResource {
  /**
   * The identifier of the referenced resource.
   */
  id?: string;
}

/**
 * The properties that define an exchange peering.
 */
model PeeringPropertiesExchange {
  /**
   * The set of connections that constitute an exchange peering.
   */
  @identifiers(#[])
  connections?: ExchangeConnection[];

  /**
   * The reference of the peer ASN.
   */
  peerAsn?: SubResource;
}

/**
 * The properties that define an exchange connection.
 */
model ExchangeConnection {
  /**
   * The PeeringDB.com ID of the facility at which the connection has to be set up.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityId?: int32;

  /**
   * The state of the connection.
   */
  @visibility(Lifecycle.Read)
  connectionState?: ConnectionState;

  /**
   * The BGP session associated with the connection.
   */
  bgpSession?: BgpSession;

  /**
   * The unique identifier (GUID) for the connection.
   */
  connectionIdentifier?: string;

  /**
   * The error message related to the connection state, if any.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * Represents a connectivity probe, a configuration peers can add to direct and exchange peerings to create ping tests. These ping
 * tests will allow us to generate availability, jitter, and latency data for traffic (using ICMP or TCP) from Azure to an endpoint
 * IP address given by the customer. This data will be emitted such that the peer can view these metrics in the Azure portal in the
 * Connectivity probe blade of their peering.
 */
model ConnectivityProbe {
  /**
   * The endpoint IP address where traffic will be sent to from Azure for the connectivity probe.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpoint?: string;

  /**
   * The Azure region where traffic will originate from for the connectivity probe.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureRegion?: string;

  /**
   * The protocol of the traffic that will be sent for the connectivity probe.
   */
  protocol?: Protocol;

  /**
   * Set to contain the prefixes that agents in Azure will send traffic from. For peers to allow into their
   * network the connectivity probe traffic can reach their endpoint for the connectivity probe.
   */
  @visibility(Lifecycle.Read)
  prefixesToAccesslist?: string[];
}

/**
 * Looking glass output model
 */
model LookingGlassOutput {
  /**
   * Invoked command
   */
  command?: Command;

  /**
   * Output of the command
   */
  output?: string;
}

/**
 * The paginated list of peering API operations.
 */
model OperationListResult {
  /**
   * The list of peering API operations.
   */
  @pageItems
  value?: Operation[];

  /**
   * The link to fetch the next page of peering API operations.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * The peering API operation.
 */
model Operation {
  /**
   * The name of the operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The information related to the operation.
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplayInfo;

  /**
   * The flag that indicates whether the operation applies to data plane.
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * The properties of the operation.
   */
  @visibility(Lifecycle.Read)
  properties?: OperationProperties;
}

/**
 * The information related to the operation.
 */
model OperationDisplayInfo {
  /**
   * The name of the resource provider.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The name of the operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The properties of the operation.
 */
model OperationProperties {
  /**
   * Service specification payload.
   */
  @visibility(Lifecycle.Read)
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload.
 */
model ServiceSpecification {
  /**
   * Specifications of the Metrics for Azure Monitoring.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Metrics for Azure Monitoring.
 */
model MetricSpecification {
  /**
   * Name of the metric.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localized friendly display name of the metric.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Localized friendly description of the metric.
   */
  @visibility(Lifecycle.Read)
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Aggregation type will be set to one of the values: Average, Minimum, Maximum, Total, Count.
   */
  @visibility(Lifecycle.Read)
  aggregationType?: string;

  /**
   * Supported time grain types for the metric.
   */
  @visibility(Lifecycle.Read)
  supportedTimeGrainTypes?: string[];

  /**
   * Dimensions of the metric.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  dimensions?: MetricDimension[];
}

/**
 * Dimensions of the metric.
 */
model MetricDimension {
  /**
   * Name of the dimension.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Localized friendly display name of the dimension.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * The properties that define a peer's ASN.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PeerAsnProperties {
  /**
   * The Autonomous System Number (ASN) of the peer.
   */
  peerAsn?: int32;

  /**
   * The contact details of the peer.
   */
  @identifiers(#[])
  peerContactDetail?: ContactDetail[];

  /**
   * The name of the peer.
   */
  peerName?: string;

  /**
   * The validation state of the ASN associated with the peer.
   */
  @visibility(Lifecycle.Read)
  validationState?: ValidationState;

  /**
   * The error message for the validation state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * The contact detail class.
 */
model ContactDetail {
  /**
   * The role of the contact.
   */
  role?: Role;

  /**
   * The e-mail address of the contact.
   */
  email?: string;

  /**
   * The phone number of the contact.
   */
  phone?: string;
}

/**
 * Peering location is where connectivity could be established to the Microsoft Cloud Edge.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PeeringLocation extends CommonTypes.Resource {
  /**
   * The kind of peering that the peering location supports.
   */
  kind?: Kind;

  /**
   * The properties that define a peering location.
   */
  properties?: PeeringLocationProperties;
}

/**
 * The properties that define a peering location.
 */
model PeeringLocationProperties {
  /**
   * The properties that define a direct peering location.
   */
  direct?: PeeringLocationPropertiesDirect;

  /**
   * The properties that define an exchange peering location.
   */
  exchange?: PeeringLocationPropertiesExchange;

  /**
   * The name of the peering location.
   */
  peeringLocation?: string;

  /**
   * The country in which the peering location exists.
   */
  country?: string;

  /**
   * The Azure region associated with the peering location.
   */
  azureRegion?: string;
}

/**
 * The properties that define a direct peering location.
 */
model PeeringLocationPropertiesDirect {
  /**
   * The list of direct peering facilities at the peering location.
   */
  @identifiers(#[])
  peeringFacilities?: DirectPeeringFacility[];

  /**
   * The list of bandwidth offers available at the peering location.
   */
  @identifiers(#[])
  bandwidthOffers?: PeeringBandwidthOffer[];
}

/**
 * The properties that define a direct peering facility.
 */
model DirectPeeringFacility {
  /**
   * The address of the direct peering facility.
   */
  address?: string;

  /**
   * The type of the direct peering.
   */
  directPeeringType?: DirectPeeringType;

  /**
   * The PeeringDB.com ID of the facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityId?: int32;

  /**
   * The PeeringDB.com URL of the facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityLink?: string;
}

/**
 * The properties that define a peering bandwidth offer.
 */
model PeeringBandwidthOffer {
  /**
   * The name of the bandwidth offer.
   */
  offerName?: string;

  /**
   * The value of the bandwidth offer in Mbps.
   */
  valueInMbps?: int32;
}

/**
 * The properties that define an exchange peering location.
 */
model PeeringLocationPropertiesExchange {
  /**
   * The list of exchange peering facilities at the peering location.
   */
  @identifiers(#[])
  peeringFacilities?: ExchangePeeringFacility[];
}

/**
 * The properties that define an exchange peering facility.
 */
model ExchangePeeringFacility {
  /**
   * The name of the exchange peering facility.
   */
  exchangeName?: string;

  /**
   * The bandwidth of the connection between Microsoft and the exchange peering facility.
   */
  bandwidthInMbps?: int32;

  /**
   * The IPv4 address of Microsoft at the exchange peering facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  microsoftIPv4Address?: string;

  /**
   * The IPv6 address of Microsoft at the exchange peering facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  microsoftIPv6Address?: string;

  /**
   * The IPv4 prefixes associated with the exchange peering facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  facilityIPv4Prefix?: string;

  /**
   * The IPv6 prefixes associated with the exchange peering facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  facilityIPv6Prefix?: string;

  /**
   * The PeeringDB.com ID of the facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityId?: int32;

  /**
   * The PeeringDB.com URL of the facility.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  peeringDBFacilityLink?: string;
}

/**
 * The properties that define a registered ASN.
 */
model PeeringRegisteredAsnProperties {
  /**
   * The customer's ASN from which traffic originates.
   */
  asn?: int32;

  /**
   * The peering service prefix key that is to be shared with the customer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Property 'peeringServicePrefixKey' looks like it contains sensitive information. Consider marking it with @secret decorator to ensure it is handled securely."
  @visibility(Lifecycle.Read)
  peeringServicePrefixKey?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties that define a registered prefix.
 */
model PeeringRegisteredPrefixProperties {
  /**
   * The customer's prefix from which traffic originates.
   */
  prefix?: string;

  /**
   * The prefix validation state.
   */
  @visibility(Lifecycle.Read)
  prefixValidationState?: PrefixValidationState;

  /**
   * The peering service prefix key that is to be shared with the customer.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Property 'peeringServicePrefixKey' looks like it contains sensitive information. Consider marking it with @secret decorator to ensure it is handled securely."
  @visibility(Lifecycle.Read)
  peeringServicePrefixKey?: string;

  /**
   * The error message associated with the validation state, if any.
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The resource tags.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "For backward compatibility"
model ResourceTags {
  /**
   * Gets or sets the tags, a dictionary of descriptors arm object
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The paginated list of received routes for the peering.
 */
model PeeringReceivedRouteListResult is Azure.Core.Page<PeeringReceivedRoute>;

/**
 * The properties that define a received route.
 */
model PeeringReceivedRoute {
  /**
   * The prefix.
   */
  @visibility(Lifecycle.Read)
  prefix?: string;

  /**
   * The next hop for the prefix.
   */
  @visibility(Lifecycle.Read)
  nextHop?: string;

  /**
   * The AS path for the prefix.
   */
  @visibility(Lifecycle.Read)
  asPath?: string;

  /**
   * The origin AS change information for the prefix.
   */
  @visibility(Lifecycle.Read)
  originAsValidationState?: string;

  /**
   * The RPKI validation state for the prefix and origin AS that's listed in the AS path.
   */
  @visibility(Lifecycle.Read)
  rpkiValidationState?: string;

  /**
   * The authority which holds the Route Origin Authorization record for the prefix, if any.
   */
  @visibility(Lifecycle.Read)
  trustAnchor?: string;

  /**
   * The received timestamp associated with the prefix.
   */
  @visibility(Lifecycle.Read)
  receivedTimestamp?: string;
}

/**
 * The properties that define a Connection Monitor Test.
 */
model ConnectionMonitorTestProperties {
  /**
   * The Connection Monitor test source agent
   */
  sourceAgent?: string;

  /**
   * The Connection Monitor test destination
   */
  destination?: string;

  /**
   * The Connection Monitor test destination port
   */
  destinationPort?: int32;

  /**
   * The Connection Monitor test frequency in seconds
   */
  testFrequencyInSec?: int32;

  /**
   * The flag that indicates if the Connection Monitor test is successful or not.
   */
  @visibility(Lifecycle.Read)
  isTestSuccessful?: boolean;

  /**
   * The path representing the Connection Monitor test.
   */
  @visibility(Lifecycle.Read)
  path?: string[];

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The peering service country.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model PeeringServiceCountry extends CommonTypes.Resource {}

/**
 * The peering service location.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PeeringServiceLocation extends CommonTypes.Resource {
  /**
   * The properties that define a peering service location.
   */
  properties?: PeeringServiceLocationProperties;
}

/**
 * The properties that define connectivity to the Peering Service Location.
 */
model PeeringServiceLocationProperties {
  /**
   * Country of the customer
   */
  country?: string;

  /**
   * State of the customer
   */
  state?: string;

  /**
   * Azure region for the location
   */
  azureRegion?: string;
}

/**
 * The peering service prefix properties class.
 */
model PeeringServicePrefixProperties {
  /**
   * The prefix from which your traffic originates.
   */
  prefix?: string;

  /**
   * The prefix validation state
   */
  @visibility(Lifecycle.Read)
  prefixValidationState?: PrefixValidationState;

  /**
   * The prefix learned type
   */
  @visibility(Lifecycle.Read)
  learnedType?: LearnedType;

  /**
   * The error message for validation state
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /**
   * The list of events for peering service prefix
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  events?: PeeringServicePrefixEvent[];

  /**
   * The peering service prefix key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Property 'peeringServicePrefixKey' looks like it contains sensitive information. Consider marking it with @secret decorator to ensure it is handled securely."
  peeringServicePrefixKey?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The details of the event associated with a prefix.
 */
model PeeringServicePrefixEvent {
  /**
   * The timestamp of the event associated with a prefix.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  /**
   * The type of the event associated with a prefix.
   */
  @visibility(Lifecycle.Read)
  eventType?: string;

  /**
   * The summary of the event associated with a prefix.
   */
  @visibility(Lifecycle.Read)
  eventSummary?: string;

  /**
   * The level of the event associated with a prefix.
   */
  @visibility(Lifecycle.Read)
  eventLevel?: string;

  /**
   * The description of the event associated with a prefix.
   */
  @visibility(Lifecycle.Read)
  eventDescription?: string;
}

/**
 * PeeringService provider
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PeeringServiceProvider extends CommonTypes.Resource {
  /**
   * The properties that define a peering service provider.
   */
  properties?: PeeringServiceProviderProperties;
}

/**
 * The properties that define connectivity to the Peering Service Provider.
 */
model PeeringServiceProviderProperties {
  /**
   * The name of the service provider.
   */
  serviceProviderName?: string;

  /**
   * The list of locations at which the service provider peers with Microsoft.
   */
  peeringLocations?: string[];
}

/**
 * The SKU that defines the type of the peering service.
 */
model PeeringServiceSku {
  /**
   * The name of the peering service SKU.
   */
  name?: string;
}

/**
 * The properties that define connectivity to the Peering Service.
 */
model PeeringServiceProperties {
  /**
   * The location (state/province) of the customer.
   */
  peeringServiceLocation?: string;

  /**
   * The name of the service provider.
   */
  peeringServiceProvider?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The primary peering (Microsoft/service provider) location to be used for customer traffic.
   */
  providerPrimaryPeeringLocation?: string;

  /**
   * The backup peering (Microsoft/service provider) location to be used for customer traffic.
   */
  providerBackupPeeringLocation?: string;

  /**
   * The Log Analytics Workspace Properties
   */
  logAnalyticsWorkspaceProperties?: LogAnalyticsWorkspaceProperties;
}

/**
 * The properties that define a Log Analytics Workspace.
 */
model LogAnalyticsWorkspaceProperties {
  /**
   * The Workspace ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property name"
  @visibility(Lifecycle.Read)
  workspaceID?: string;

  /**
   * The Workspace Key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "Property 'key' looks like it contains sensitive information. Consider marking it with @secret decorator to ensure it is handled securely."
  @visibility(Lifecycle.Read)
  key?: string;

  /**
   * The list of connected agents.
   */
  @visibility(Lifecycle.Read)
  connectedAgents?: string[];
}

/**
 * The paginated list of RP unbilled prefixes.
 */
model RpUnbilledPrefixListResult is Azure.Core.Page<RpUnbilledPrefix>;

/**
 * The Routing Preference unbilled prefix
 */
model RpUnbilledPrefix {
  /**
   * The prefix.
   */
  @visibility(Lifecycle.Read)
  prefix?: string;

  /**
   * The Azure region.
   */
  @visibility(Lifecycle.Read)
  azureRegion?: string;

  /**
   * The peer ASN.
   */
  @visibility(Lifecycle.Read)
  peerAsn?: int32;
}
