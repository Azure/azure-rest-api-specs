import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Peering;

interface Operations extends Azure.ResourceManager.Operations {}

enum PeeringServiceProviderAvailability {
  Available,
  Unavailable,
}

enum LegacyPeeringsKind {
  Direct,
  Exchange,
}

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

enum Tier {
  Basic,
  Premium,
}

enum Family {
  Direct,
  Exchange,
}

enum Size {
  Free,
  Metered,
  Unlimited,
}

enum Kind {
  Direct,
  Exchange,
}

enum SessionAddressProvider {
  Microsoft,
  Peer,
}

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

enum Command {
  Traceroute,
  Ping,
  BgpRoute,
}

enum Role {
  Noc,
  Policy,
  Technical,
  Service,
  Escalation,
  Other,
}

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

enum PrefixValidationState {
  None,
  Invalid,
  Verified,
  Failed,
  Pending,
  Warning,
  Unknown,
}

enum LearnedType {
  None,
  ViaServiceProvider,
  ViaSession,
}

@doc("The paginated list of CDN peering prefixes.")
model CdnPeeringPrefixListResult is Azure.Core.Page<CdnPeeringPrefix>;

@doc("The CDN peering prefix")
model CdnPeeringPrefix {
  ...Resource;

  @doc("The properties that define a cdn peering prefix.")
  properties?: CdnPeeringPrefixProperties;
}

@doc("The properties that define a CDN peering prefix")
model CdnPeeringPrefixProperties {
  @doc("The prefix.")
  @visibility("read")
  prefix?: string;

  @doc("The Azure region.")
  @visibility("read")
  azureRegion?: string;

  @doc("The Azure service.")
  @visibility("read")
  azureService?: string;

  @doc("The flag that indicates whether or not this is the primary region.")
  @visibility("read")
  isPrimaryRegion?: boolean;

  @doc("The BGP Community")
  @visibility("read")
  bgpCommunity?: string;
}

@doc("Class for CheckServiceProviderAvailabilityInput")
model CheckServiceProviderAvailabilityInput {
  @doc("Gets or sets the peering service location.")
  peeringServiceLocation?: string;

  @doc("Gets or sets the peering service provider.")
  peeringServiceProvider?: string;
}

@doc("The SKU that defines the tier and kind of the peering.")
model PeeringSku {
  @doc("The name of the peering SKU.")
  name?: string;

  @doc("The tier of the peering SKU.")
  @visibility("read")
  tier?: Tier;

  @doc("The family of the peering SKU.")
  @visibility("read")
  family?: Family;

  @doc("The size of the peering SKU.")
  @visibility("read")
  size?: Size;
}

@doc("The properties that define connectivity to the Microsoft Cloud Edge.")
model PeeringProperties {
  @doc("The properties that define a direct peering.")
  direct?: PeeringPropertiesDirect;

  @doc("The properties that define an exchange peering.")
  exchange?: PeeringPropertiesExchange;

  @doc("The location of the peering.")
  peeringLocation?: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties that define a direct peering.")
model PeeringPropertiesDirect {
  @doc("The set of connections that constitute a direct peering.")
  connections?: DirectConnection[];

  @doc("The flag that indicates whether or not the peering is used for peering service.")
  @visibility("read")
  useForPeeringService?: boolean;

  @doc("The reference of the peer ASN.")
  peerAsn?: SubResource;

  @doc("The type of direct peering.")
  directPeeringType?: DirectPeeringType;
}

@doc("The properties that define a direct connection.")
model DirectConnection {
  @doc("The bandwidth of the connection.")
  bandwidthInMbps?: int32;

  @doc("The bandwidth that is actually provisioned.")
  @visibility("read")
  provisionedBandwidthInMbps?: int32;

  @doc("The field indicating if Microsoft provides session ip addresses.")
  sessionAddressProvider?: SessionAddressProvider;

  @doc("The flag that indicates whether or not the connection is used for peering service.")
  useForPeeringService?: boolean;

  @doc("The ID used within Microsoft's peering provisioning system to track the connection")
  @visibility("read")
  microsoftTrackingId?: string;

  @doc("The PeeringDB.com ID of the facility at which the connection has to be set up.")
  peeringDBFacilityId?: int32;

  @doc("The state of the connection.")
  @visibility("read")
  connectionState?: ConnectionState;

  @doc("The BGP session associated with the connection.")
  bgpSession?: BgpSession;

  @doc("The unique identifier (GUID) for the connection.")
  connectionIdentifier?: string;

  @doc("The error message related to the connection state, if any.")
  @visibility("read")
  errorMessage?: string;
}

@doc("The properties that define a BGP session.")
model BgpSession {
  @doc("The IPv4 prefix that contains both ends' IPv4 addresses.")
  sessionPrefixV4?: string;

  @doc("The IPv6 prefix that contains both ends' IPv6 addresses.")
  sessionPrefixV6?: string;

  @doc("The IPv4 session address on Microsoft's end.")
  microsoftSessionIPv4Address?: string;

  @doc("The IPv6 session address on Microsoft's end.")
  microsoftSessionIPv6Address?: string;

  @doc("The IPv4 session address on peer's end.")
  peerSessionIPv4Address?: string;

  @doc("The IPv6 session address on peer's end.")
  peerSessionIPv6Address?: string;

  @doc("The state of the IPv4 session.")
  @visibility("read")
  sessionStateV4?: SessionStateV4;

  @doc("The state of the IPv6 session.")
  @visibility("read")
  sessionStateV6?: SessionStateV6;

  @doc("The maximum number of prefixes advertised over the IPv4 session.")
  maxPrefixesAdvertisedV4?: int32;

  @doc("The maximum number of prefixes advertised over the IPv6 session.")
  maxPrefixesAdvertisedV6?: int32;

  @doc("The MD5 authentication key of the session.")
  md5AuthenticationKey?: string;
}

@doc("The sub resource.")
model SubResource {
  @doc("The identifier of the referenced resource.")
  id?: string;
}

@doc("The properties that define an exchange peering.")
model PeeringPropertiesExchange {
  @doc("The set of connections that constitute an exchange peering.")
  connections?: ExchangeConnection[];

  @doc("The reference of the peer ASN.")
  peerAsn?: SubResource;
}

@doc("The properties that define an exchange connection.")
model ExchangeConnection {
  @doc("The PeeringDB.com ID of the facility at which the connection has to be set up.")
  peeringDBFacilityId?: int32;

  @doc("The state of the connection.")
  @visibility("read")
  connectionState?: ConnectionState;

  @doc("The BGP session associated with the connection.")
  bgpSession?: BgpSession;

  @doc("The unique identifier (GUID) for the connection.")
  connectionIdentifier?: string;

  @doc("The error message related to the connection state, if any.")
  @visibility("read")
  errorMessage?: string;
}

@doc("Looking glass output model")
model LookingGlassOutput {
  @doc("Invoked command")
  command?: Command;

  @doc("Output of the command")
  output?: string;
}

@doc("The information related to the operation.")
model OperationDisplayInfo {
  @doc("The name of the resource provider.")
  @visibility("read")
  provider?: string;

  @doc("The type of the resource.")
  @visibility("read")
  resource?: string;

  @doc("The name of the operation.")
  @visibility("read")
  operation?: string;

  @doc("The description of the operation.")
  @visibility("read")
  description?: string;
}

@doc("The properties of the operation.")
model OperationProperties {
  @doc("Service specification payload.")
  @visibility("read")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload.")
model ServiceSpecification {
  @doc("Specifications of the Metrics for Azure Monitoring.")
  @visibility("read")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Metrics for Azure Monitoring.")
model MetricSpecification {
  @doc("Name of the metric.")
  @visibility("read")
  name?: string;

  @doc("Localized friendly display name of the metric.")
  @visibility("read")
  displayName?: string;

  @doc("Localized friendly description of the metric.")
  @visibility("read")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric.")
  @visibility("read")
  unit?: string;

  @doc("Aggregation type will be set to one of the values: Average, Minimum, Maximum, Total, Count.")
  @visibility("read")
  aggregationType?: string;

  @doc("Supported time grain types for the metric.")
  @visibility("read")
  supportedTimeGrainTypes?: string[];

  @doc("Dimensions of the metric.")
  @visibility("read")
  dimensions?: MetricDimension[];
}

@doc("Dimensions of the metric.")
model MetricDimension {
  @doc("Name of the dimension.")
  @visibility("read")
  name?: string;

  @doc("Localized friendly display name of the dimension.")
  @visibility("read")
  displayName?: string;
}

@doc("The properties that define a peer's ASN.")
model PeerAsnProperties {
  @doc("The Autonomous System Number (ASN) of the peer.")
  peerAsn?: int32;

  @doc("The contact details of the peer.")
  peerContactDetail?: ContactDetail[];

  @doc("The name of the peer.")
  peerName?: string;

  @doc("The validation state of the ASN associated with the peer.")
  @visibility("read")
  validationState?: ValidationState;

  @doc("The error message for the validation state")
  @visibility("read")
  errorMessage?: string;
}

@doc("The contact detail class.")
model ContactDetail {
  @doc("The role of the contact.")
  role?: Role;

  @doc("The e-mail address of the contact.")
  email?: string;

  @doc("The phone number of the contact.")
  phone?: string;
}

@doc("The paginated list of peering locations.")
model PeeringLocationListResult is Azure.Core.Page<PeeringLocation>;

@doc("Peering location is where connectivity could be established to the Microsoft Cloud Edge.")
model PeeringLocation {
  ...Resource;

  @doc("The kind of peering that the peering location supports.")
  kind?: Kind;

  @doc("The properties that define a peering location.")
  properties?: PeeringLocationProperties;
}

@doc("The properties that define a peering location.")
model PeeringLocationProperties {
  @doc("The properties that define a direct peering location.")
  direct?: PeeringLocationPropertiesDirect;

  @doc("The properties that define an exchange peering location.")
  exchange?: PeeringLocationPropertiesExchange;

  @doc("The name of the peering location.")
  peeringLocation?: string;

  @doc("The country in which the peering location exists.")
  country?: string;

  @doc("The Azure region associated with the peering location.")
  azureRegion?: string;
}

@doc("The properties that define a direct peering location.")
model PeeringLocationPropertiesDirect {
  @doc("The list of direct peering facilities at the peering location.")
  peeringFacilities?: DirectPeeringFacility[];

  @doc("The list of bandwidth offers available at the peering location.")
  bandwidthOffers?: PeeringBandwidthOffer[];
}

@doc("The properties that define a direct peering facility.")
model DirectPeeringFacility {
  @doc("The address of the direct peering facility.")
  address?: string;

  @doc("The type of the direct peering.")
  directPeeringType?: DirectPeeringType;

  @doc("The PeeringDB.com ID of the facility.")
  peeringDBFacilityId?: int32;

  @doc("The PeeringDB.com URL of the facility.")
  peeringDBFacilityLink?: string;
}

@doc("The properties that define a peering bandwidth offer.")
model PeeringBandwidthOffer {
  @doc("The name of the bandwidth offer.")
  offerName?: string;

  @doc("The value of the bandwidth offer in Mbps.")
  valueInMbps?: int32;
}

@doc("The properties that define an exchange peering location.")
model PeeringLocationPropertiesExchange {
  @doc("The list of exchange peering facilities at the peering location.")
  peeringFacilities?: ExchangePeeringFacility[];
}

@doc("The properties that define an exchange peering facility.")
model ExchangePeeringFacility {
  @doc("The name of the exchange peering facility.")
  exchangeName?: string;

  @doc("The bandwidth of the connection between Microsoft and the exchange peering facility.")
  bandwidthInMbps?: int32;

  @doc("The IPv4 address of Microsoft at the exchange peering facility.")
  microsoftIPv4Address?: string;

  @doc("The IPv6 address of Microsoft at the exchange peering facility.")
  microsoftIPv6Address?: string;

  @doc("The IPv4 prefixes associated with the exchange peering facility.")
  facilityIPv4Prefix?: string;

  @doc("The IPv6 prefixes associated with the exchange peering facility.")
  facilityIPv6Prefix?: string;

  @doc("The PeeringDB.com ID of the facility.")
  peeringDBFacilityId?: int32;

  @doc("The PeeringDB.com URL of the facility.")
  peeringDBFacilityLink?: string;
}

@doc("The properties that define a registered ASN.")
model PeeringRegisteredAsnProperties {
  @doc("The customer's ASN from which traffic originates.")
  asn?: int32;

  @doc("The peering service prefix key that is to be shared with the customer.")
  @visibility("read")
  peeringServicePrefixKey?: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The properties that define a registered prefix.")
model PeeringRegisteredPrefixProperties {
  @doc("The customer's prefix from which traffic originates.")
  prefix?: string;

  @doc("The prefix validation state.")
  @visibility("read")
  prefixValidationState?: PrefixValidationState;

  @doc("The peering service prefix key that is to be shared with the customer.")
  @visibility("read")
  peeringServicePrefixKey?: string;

  @doc("The error message associated with the validation state, if any.")
  @visibility("read")
  errorMessage?: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model Paths1Sywd6ZSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringsPeeringnamePatchRequestbodyContentApplicationJsonSchema {
  ...ResourceTags;
}

@doc("The resource tags.")
model ResourceTags {
  @doc("Gets or sets the tags, a dictionary of descriptors arm object")
  tags?: Record<string>;
}

@doc("The paginated list of received routes for the peering.")
model PeeringReceivedRouteListResult is Azure.Core.Page<PeeringReceivedRoute>;

@doc("The properties that define a received route.")
model PeeringReceivedRoute {
  @doc("The prefix.")
  @visibility("read")
  prefix?: string;

  @doc("The next hop for the prefix.")
  @visibility("read")
  nextHop?: string;

  @doc("The AS path for the prefix.")
  @visibility("read")
  asPath?: string;

  @doc("The origin AS change information for the prefix.")
  @visibility("read")
  originAsValidationState?: string;

  @doc("The RPKI validation state for the prefix and origin AS that's listed in the AS path.")
  @visibility("read")
  rpkiValidationState?: string;

  @doc("The authority which holds the Route Origin Authorization record for the prefix, if any.")
  @visibility("read")
  trustAnchor?: string;

  @doc("The received timestamp associated with the prefix.")
  @visibility("read")
  receivedTimestamp?: string;
}

@doc("The properties that define a Connection Monitor Test.")
model ConnectionMonitorTestProperties {
  @doc("The Connection Monitor test source agent")
  sourceAgent?: string;

  @doc("The Connection Monitor test destination")
  destination?: string;

  @doc("The Connection Monitor test destination port")
  destinationPort?: int32;

  @doc("The Connection Monitor test frequency in seconds")
  testFrequencyInSec?: int32;

  @doc("The flag that indicates if the Connection Monitor test is successful or not.")
  @visibility("read")
  isTestSuccessful?: boolean;

  @doc("The path representing the Connection Monitor test.")
  @visibility("read")
  path?: string[];

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The paginated list of peering service countries.")
model PeeringServiceCountryListResult is Azure.Core.Page<PeeringServiceCountry>;

@doc("The peering service country.")
model PeeringServiceCountry {
  ...Resource;
}

@doc("The paginated list of peering service locations.")
model PeeringServiceLocationListResult
  is Azure.Core.Page<PeeringServiceLocation>;

@doc("The peering service location.")
model PeeringServiceLocation {
  ...Resource;

  @doc("The properties that define a peering service location.")
  properties?: PeeringServiceLocationProperties;
}

@doc("The properties that define connectivity to the Peering Service Location.")
model PeeringServiceLocationProperties {
  @doc("Country of the customer")
  country?: string;

  @doc("State of the customer")
  state?: string;

  @doc("Azure region for the location")
  azureRegion?: string;
}

@doc("The peering service prefix properties class.")
model PeeringServicePrefixProperties {
  @doc("The prefix from which your traffic originates.")
  prefix?: string;

  @doc("The prefix validation state")
  @visibility("read")
  prefixValidationState?: PrefixValidationState;

  @doc("The prefix learned type")
  @visibility("read")
  learnedType?: LearnedType;

  @doc("The error message for validation state")
  @visibility("read")
  errorMessage?: string;

  @doc("The list of events for peering service prefix")
  @visibility("read")
  events?: PeeringServicePrefixEvent[];

  @doc("The peering service prefix key")
  peeringServicePrefixKey?: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The details of the event associated with a prefix.")
model PeeringServicePrefixEvent {
  @doc("The timestamp of the event associated with a prefix.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTimestamp?: utcDateTime;

  @doc("The type of the event associated with a prefix.")
  @visibility("read")
  eventType?: string;

  @doc("The summary of the event associated with a prefix.")
  @visibility("read")
  eventSummary?: string;

  @doc("The level of the event associated with a prefix.")
  @visibility("read")
  eventLevel?: string;

  @doc("The description of the event associated with a prefix.")
  @visibility("read")
  eventDescription?: string;
}

@doc("The paginated list of peering service providers.")
model PeeringServiceProviderListResult
  is Azure.Core.Page<PeeringServiceProvider>;

@doc("PeeringService provider")
model PeeringServiceProvider {
  ...Resource;

  @doc("The properties that define a peering service provider.")
  properties?: PeeringServiceProviderProperties;
}

@doc("The properties that define connectivity to the Peering Service Provider.")
model PeeringServiceProviderProperties {
  @doc("The name of the service provider.")
  serviceProviderName?: string;

  @doc("The list of locations at which the service provider peers with Microsoft.")
  peeringLocations?: string[];
}

@doc("The SKU that defines the type of the peering service.")
model PeeringServiceSku {
  @doc("The name of the peering service SKU.")
  name?: string;
}

@doc("The properties that define connectivity to the Peering Service.")
model PeeringServiceProperties {
  @doc("The location (state/province) of the customer.")
  peeringServiceLocation?: string;

  @doc("The name of the service provider.")
  peeringServiceProvider?: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The primary peering (Microsoft/service provider) location to be used for customer traffic.")
  providerPrimaryPeeringLocation?: string;

  @doc("The backup peering (Microsoft/service provider) location to be used for customer traffic.")
  providerBackupPeeringLocation?: string;

  @doc("The Log Analytics Workspace Properties")
  logAnalyticsWorkspaceProperties?: LogAnalyticsWorkspaceProperties;
}

@doc("The properties that define a Log Analytics Workspace.")
model LogAnalyticsWorkspaceProperties {
  @doc("The Workspace ID.")
  @visibility("read")
  workspaceID?: string;

  @doc("The Workspace Key.")
  @visibility("read")
  key?: string;

  @doc("The list of connected agents.")
  @visibility("read")
  connectedAgents?: string[];
}

model Paths3702DwSubscriptionsSubscriptionidResourcegroupsResourcegroupnameProvidersMicrosoftPeeringPeeringservicesPeeringservicenamePatchRequestbodyContentApplicationJsonSchema {
  ...ResourceTags;
}

@doc("The paginated list of RP unbilled prefixes.")
model RpUnbilledPrefixListResult is Azure.Core.Page<RpUnbilledPrefix>;

@doc("The Routing Preference unbilled prefix")
model RpUnbilledPrefix {
  @doc("The prefix.")
  @visibility("read")
  prefix?: string;

  @doc("The Azure region.")
  @visibility("read")
  azureRegion?: string;

  @doc("The peer ASN.")
  @visibility("read")
  peerAsn?: int32;
}
