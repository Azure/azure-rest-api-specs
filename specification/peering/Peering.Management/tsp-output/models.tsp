import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Peering;

interface Operations extends Azure.ResourceManager.Operations {}

enum PeeringServiceProviderAvailability {
  Available,
  Unavailable,
}

enum LegacyPeeringsKind {
  Direct,
  Exchange,
}

/**
 * The type of direct peering.
 */
enum DirectPeeringType {
  Edge,
  Transit,
  Cdn,
  Internal,
  Ix,
  IxRs,
  Voice,
  EdgeZoneForOperators,
}

/**
 * The tier of the peering SKU.
 */
enum Tier {
  Basic,
  Premium,
}

/**
 * The family of the peering SKU.
 */
enum Family {
  Direct,
  Exchange,
}

/**
 * The size of the peering SKU.
 */
enum Size {
  Free,
  Metered,
  Unlimited,
}

/**
 * The kind of the peering.
 */
enum Kind {
  Direct,
  Exchange,
}

/**
 * The field indicating if Microsoft provides session ip addresses.
 */
enum SessionAddressProvider {
  Microsoft,
  Peer,
}

/**
 * The state of the connection.
 */
enum ConnectionState {
  None,
  PendingApproval,
  Approved,
  ProvisioningStarted,
  ProvisioningFailed,
  ProvisioningCompleted,
  Validating,
  Active,
  TypeChangeRequested,
  TypeChangeInProgress,
}

/**
 * The state of the IPv4 session.
 */
enum SessionStateV4 {
  None,
  Idle,
  Connect,
  Active,
  OpenSent,
  OpenConfirm,
  OpenReceived,
  Established,
  PendingAdd,
  PendingUpdate,
  PendingRemove,
}

/**
 * The state of the IPv6 session.
 */
enum SessionStateV6 {
  None,
  Idle,
  Connect,
  Active,
  OpenSent,
  OpenConfirm,
  OpenReceived,
  Established,
  PendingAdd,
  PendingUpdate,
  PendingRemove,
}

/**
 * The provisioning state of the resource.
 */
enum ProvisioningState {
  Succeeded,
  Updating,
  Deleting,
  Failed,
}

enum LookingGlassCommand {
  Traceroute,
  Ping,
  BgpRoute,
}

enum LookingGlassSourceType {
  EdgeSite,
  AzureRegion,
}

/**
 * Invoked command
 */
enum Command {
  Traceroute,
  Ping,
  BgpRoute,
}

/**
 * The role of the contact.
 */
enum Role {
  Noc,
  Policy,
  Technical,
  Service,
  Escalation,
  Other,
}

/**
 * The validation state of the ASN associated with the peer.
 */
enum ValidationState {
  None,
  Pending,
  Approved,
  Failed,
}

enum PeeringLocationsKind {
  Direct,
  Exchange,
}

enum PeeringLocationsDirectPeeringType {
  Edge,
  Transit,
  Cdn,
  Internal,
  Ix,
  IxRs,
  Voice,
  EdgeZoneForOperators,
}

/**
 * The prefix validation state.
 */
enum PrefixValidationState {
  None,
  Invalid,
  Verified,
  Failed,
  Pending,
  Warning,
  Unknown,
}

/**
 * The prefix learned type
 */
enum LearnedType {
  None,
  ViaServiceProvider,
  ViaSession,
}

/**
 * The paginated list of CDN peering prefixes.
 */
model CdnPeeringPrefixListResult is Azure.Core.Page<CdnPeeringPrefix>;

/**
 * The CDN peering prefix
 */
model CdnPeeringPrefix extends Resource {
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
  @visibility("read")
  prefix?: string;

  /**
   * The Azure region.
   */
  @visibility("read")
  azureRegion?: string;

  /**
   * The Azure service.
   */
  @visibility("read")
  azureService?: string;

  /**
   * The flag that indicates whether or not this is the primary region.
   */
  @visibility("read")
  isPrimaryRegion?: boolean;

  /**
   * The BGP Community
   */
  @visibility("read")
  bgpCommunity?: string;
}

/**
 * The ARM resource class.
 */
model Resource {
  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The ID of the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;
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
  @visibility("read")
  tier?: Tier;

  /**
   * The family of the peering SKU.
   */
  @visibility("read")
  family?: Family;

  /**
   * The size of the peering SKU.
   */
  @visibility("read")
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
   * The location of the peering.
   */
  peeringLocation?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The properties that define a direct peering.
 */
model PeeringPropertiesDirect {
  /**
   * The set of connections that constitute a direct peering.
   */
  connections?: DirectConnection[];

  /**
   * The flag that indicates whether or not the peering is used for peering service.
   */
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
  microsoftTrackingId?: string;

  /**
   * The PeeringDB.com ID of the facility at which the connection has to be set up.
   */
  peeringDBFacilityId?: int32;

  /**
   * The state of the connection.
   */
  @visibility("read")
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
  @visibility("read")
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
  microsoftSessionIPv4Address?: string;

  /**
   * The IPv6 session address on Microsoft's end.
   */
  microsoftSessionIPv6Address?: string;

  /**
   * The IPv4 session address on peer's end.
   */
  peerSessionIPv4Address?: string;

  /**
   * The IPv6 session address on peer's end.
   */
  peerSessionIPv6Address?: string;

  /**
   * The state of the IPv4 session.
   */
  @visibility("read")
  sessionStateV4?: SessionStateV4;

  /**
   * The state of the IPv6 session.
   */
  @visibility("read")
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
  peeringDBFacilityId?: int32;

  /**
   * The state of the connection.
   */
  @visibility("read")
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
  @visibility("read")
  errorMessage?: string;
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
 * The information related to the operation.
 */
model OperationDisplayInfo {
  /**
   * The name of the resource provider.
   */
  @visibility("read")
  provider?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  resource?: string;

  /**
   * The name of the operation.
   */
  @visibility("read")
  operation?: string;

  /**
   * The description of the operation.
   */
  @visibility("read")
  description?: string;
}

/**
 * The properties of the operation.
 */
model OperationProperties {
  /**
   * Service specification payload.
   */
  @visibility("read")
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload.
 */
model ServiceSpecification {
  /**
   * Specifications of the Metrics for Azure Monitoring.
   */
  @visibility("read")
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Metrics for Azure Monitoring.
 */
model MetricSpecification {
  /**
   * Name of the metric.
   */
  @visibility("read")
  name?: string;

  /**
   * Localized friendly display name of the metric.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Localized friendly description of the metric.
   */
  @visibility("read")
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric.
   */
  @visibility("read")
  unit?: string;

  /**
   * Aggregation type will be set to one of the values: Average, Minimum, Maximum, Total, Count.
   */
  @visibility("read")
  aggregationType?: string;

  /**
   * Supported time grain types for the metric.
   */
  @visibility("read")
  supportedTimeGrainTypes?: string[];

  /**
   * Dimensions of the metric.
   */
  @visibility("read")
  dimensions?: MetricDimension[];
}

/**
 * Dimensions of the metric.
 */
model MetricDimension {
  /**
   * Name of the dimension.
   */
  @visibility("read")
  name?: string;

  /**
   * Localized friendly display name of the dimension.
   */
  @visibility("read")
  displayName?: string;
}

/**
 * The properties that define a peer's ASN.
 */
model PeerAsnProperties {
  /**
   * The Autonomous System Number (ASN) of the peer.
   */
  peerAsn?: int32;

  /**
   * The contact details of the peer.
   */
  peerContactDetail?: ContactDetail[];

  /**
   * The name of the peer.
   */
  peerName?: string;

  /**
   * The validation state of the ASN associated with the peer.
   */
  @visibility("read")
  validationState?: ValidationState;

  /**
   * The error message for the validation state
   */
  @visibility("read")
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
 * The paginated list of peering locations.
 */
model PeeringLocationListResult is Azure.Core.Page<PeeringLocation>;

/**
 * Peering location is where connectivity could be established to the Microsoft Cloud Edge.
 */
model PeeringLocation extends Resource {
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
  peeringFacilities?: DirectPeeringFacility[];

  /**
   * The list of bandwidth offers available at the peering location.
   */
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
  peeringDBFacilityId?: int32;

  /**
   * The PeeringDB.com URL of the facility.
   */
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
  microsoftIPv4Address?: string;

  /**
   * The IPv6 address of Microsoft at the exchange peering facility.
   */
  microsoftIPv6Address?: string;

  /**
   * The IPv4 prefixes associated with the exchange peering facility.
   */
  facilityIPv4Prefix?: string;

  /**
   * The IPv6 prefixes associated with the exchange peering facility.
   */
  facilityIPv6Prefix?: string;

  /**
   * The PeeringDB.com ID of the facility.
   */
  peeringDBFacilityId?: int32;

  /**
   * The PeeringDB.com URL of the facility.
   */
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
  @visibility("read")
  peeringServicePrefixKey?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
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
  @visibility("read")
  prefixValidationState?: PrefixValidationState;

  /**
   * The peering service prefix key that is to be shared with the customer.
   */
  @visibility("read")
  peeringServicePrefixKey?: string;

  /**
   * The error message associated with the validation state, if any.
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model Paths1Sywd6ZSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringsPeeringnamePatchRequestbodyContentApplicationJsonSchema
  extends ResourceTags {}

/**
 * The resource tags.
 */
model ResourceTags {
  /**
   * Gets or sets the tags, a dictionary of descriptors arm object
   */
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
  @visibility("read")
  prefix?: string;

  /**
   * The next hop for the prefix.
   */
  @visibility("read")
  nextHop?: string;

  /**
   * The AS path for the prefix.
   */
  @visibility("read")
  asPath?: string;

  /**
   * The origin AS change information for the prefix.
   */
  @visibility("read")
  originAsValidationState?: string;

  /**
   * The RPKI validation state for the prefix and origin AS that's listed in the AS path.
   */
  @visibility("read")
  rpkiValidationState?: string;

  /**
   * The authority which holds the Route Origin Authorization record for the prefix, if any.
   */
  @visibility("read")
  trustAnchor?: string;

  /**
   * The received timestamp associated with the prefix.
   */
  @visibility("read")
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
  @visibility("read")
  isTestSuccessful?: boolean;

  /**
   * The path representing the Connection Monitor test.
   */
  @visibility("read")
  path?: string[];

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The paginated list of peering service countries.
 */
model PeeringServiceCountryListResult is Azure.Core.Page<PeeringServiceCountry>;

/**
 * The peering service country.
 */
model PeeringServiceCountry extends Resource {}

/**
 * The paginated list of peering service locations.
 */
model PeeringServiceLocationListResult
  is Azure.Core.Page<PeeringServiceLocation>;

/**
 * The peering service location.
 */
model PeeringServiceLocation extends Resource {
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
  @visibility("read")
  prefixValidationState?: PrefixValidationState;

  /**
   * The prefix learned type
   */
  @visibility("read")
  learnedType?: LearnedType;

  /**
   * The error message for validation state
   */
  @visibility("read")
  errorMessage?: string;

  /**
   * The list of events for peering service prefix
   */
  @visibility("read")
  events?: PeeringServicePrefixEvent[];

  /**
   * The peering service prefix key
   */
  peeringServicePrefixKey?: string;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The details of the event associated with a prefix.
 */
model PeeringServicePrefixEvent {
  /**
   * The timestamp of the event associated with a prefix.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  /**
   * The type of the event associated with a prefix.
   */
  @visibility("read")
  eventType?: string;

  /**
   * The summary of the event associated with a prefix.
   */
  @visibility("read")
  eventSummary?: string;

  /**
   * The level of the event associated with a prefix.
   */
  @visibility("read")
  eventLevel?: string;

  /**
   * The description of the event associated with a prefix.
   */
  @visibility("read")
  eventDescription?: string;
}

/**
 * The paginated list of peering service providers.
 */
model PeeringServiceProviderListResult
  is Azure.Core.Page<PeeringServiceProvider>;

/**
 * PeeringService provider
 */
model PeeringServiceProvider extends Resource {
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
  @visibility("read")
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
  @visibility("read")
  workspaceID?: string;

  /**
   * The Workspace Key.
   */
  @visibility("read")
  key?: string;

  /**
   * The list of connected agents.
   */
  @visibility("read")
  connectedAgents?: string[];
}

model Paths3702DwSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringservicesPeeringservicenamePatchRequestbodyContentApplicationJsonSchema
  extends ResourceTags {}

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
  @visibility("read")
  prefix?: string;

  /**
   * The Azure region.
   */
  @visibility("read")
  azureRegion?: string;

  /**
   * The peer ASN.
   */
  @visibility("read")
  peerAsn?: int32;
}
