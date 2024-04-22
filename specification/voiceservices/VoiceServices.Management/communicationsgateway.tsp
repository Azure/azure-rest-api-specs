// Definitions for the CommunicationsGateway resource and child resources

import "@typespec/openapi";
import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.VoiceServices;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("A TestLine resource")
@parentResource(CommunicationsGateway)
model TestLine is TrackedResource<TestLineProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("testLineName")
  @segment("testLines")
  @doc("Unique identifier for this test line")
  @visibility("Read")
  @path
  name: string;
}

@doc("The purpose of the TestLine resource.")
enum TestLinePurpose {
  @doc("The test line is used for manual testing")
  Manual,

  @doc("The test line is used for automated testing")
  Automated,
}

@doc("Details of the TestLine resource.")
model TestLineProperties is ResourceProperties {
  @doc("The phone number")
  @visibility("read", "update", "create")
  phoneNumber: string;

  @doc("Purpose of this test line, e.g. automated or manual testing")
  @visibility("read", "update", "create")
  purpose: TestLinePurpose;
}

// The 200 response support in Delete api is deprecated,
// ArmResourceDeleteWithoutOKAsync method adheres to the updated pattern,
// returning only 202 and 204 responses. Since we give 200 OK response on successful deletion
// hence suppressing it in terms of backward compatibility
#suppress "deprecated" "For backward compatibility"
@armResourceOperations
interface TestLines
  extends ResourceRead<TestLine>,
    ResourceCreate<TestLine>,
    ResourceDelete<TestLine>,
    ResourceListByParent<TestLine>,
    ResourceUpdateNoProperties<TestLine> {}

@doc("A CommunicationsGateway resource")
model CommunicationsGateway
  is TrackedResource<CommunicationsGatewayProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("communicationsGatewayName")
  @segment("communicationsGateways")
  @doc("Unique identifier for this deployment")
  @visibility("Read")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Add property for versioning"
  @added(Versions.v2023_04_03)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedIdentityProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Add property for versioning"
  @added(Versions.v2023_07_13_preview)
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku?: Azure.ResourceManager.Foundations.ResourceSkuType;
}

@doc("The status of the current CommunicationsGateway resource.")
enum Status {
  @doc("The resource has been created or updated, but the CommunicationsGateway service has not yet been updated to reflect the changes.")
  ChangePending,

  @doc("The CommunicationsGateway service is up and running with the parameters specified in the resource.")
  Complete,
}

@doc("The method for terminating emergency calls to the PSTN.")
enum E911Type {
  @doc("Emergency calls are not handled different from other calls")
  Standard,

  @doc("Emergency calls are routed directly to the ESRP")
  DirectToEsrp,
}

@doc("The voice codecs expected for communication with Teams.")
enum TeamsCodecs {
  @doc("Pulse code modulation(PCM) U-law narrowband audio codec(G.711u)")
  PCMA,

  @doc("Pulse code modulation(PCM) U-law narrowband audio codec(G.711u)")
  PCMU,

  @doc("G.722 wideband audio codec")
  G722,

  @doc("G.722.2 wideband audio codec")
  G722_2,

  @doc("SILK/8000 narrowband audio codec")
  SILK_8,

  @doc("SILK/16000 wideband audio codec")
  SILK_16,
}

@doc("How this deployment connects back to the Operator Network")
enum Connectivity {
  @doc("This deployment connects to the Operator Network using a Public IP address, e.g. when using MAPS")
  PublicAddress,
}

@doc("Configuration for voice services which use AI")
@added(Versions.v2024_02_05_preview)
model AiVoiceServices {
  @doc("Azure Operator Call Protection details")
  @visibility("read", "update", "create")
  @added(Versions.v2024_02_05_preview)
  callProtection?: CallProtectionDetails;
}

@doc("Configuration for Azure Operator Call Protection")
@added(Versions.v2024_02_05_preview)
model CallProtectionDetails {
  @doc("Whether Azure Operator Call Protection is enabled or not. Defaults to false.")
  @visibility("read", "update", "create")
  @added(Versions.v2024_02_05_preview)
  enabled?: boolean;

  @doc("Resource ID of the storage account to write Azure Operator Call Protection logs to.")
  @visibility("read", "update", "create")
  @added(Versions.v2024_02_05_preview)
  logStorageAccountId?: string;
}

@doc("Indicate whether 'UseOperatorPeerGroupConfig' or 'UseStaticDefaultConfig' peer group configuration is in use")
@added(Versions.v2024_02_16_preview)
enum OperatorPeerGroupConfigSchemeValue {
  @doc("If the operator peer group and routing properties would not be used")
  UseOperatorPeerGroupConfig,

  @doc("If the operator peer group and routing properties would be used")
  UseStaticDefaultConfig,
}

@doc("Type of DNS amongst SRV record/A records/IP addresses and ports to connect to peer")
@added(Versions.v2024_02_16_preview)
enum PeerType {
  @doc("IP address and port combination")
  IP,

  @doc("Address record and port combination")
  ARecord,

  @doc("SRV record")
  SRV,
}

@doc("Signaling Protocol List")
@added(Versions.v2024_02_16_preview)
enum SignalingProtocols {
  @doc("Transport Layer Security protocol to provide secure communication")
  TLS,

  @doc("Transmission Control Protocol")
  TCP,

  @doc("User Datagram Protocol")
  UDP,
}

@doc("Azure Communication Gateway utilizes the following media protocols for handling media traffic")
@added(Versions.v2024_02_16_preview)
enum MediaProtocols {
  @doc("Secure Real-time Transport Protocol")
  SRTP,

  @doc("Real-time Transport Protocol")
  RTP,
}

@doc("Protocol to use for signalling traffic on an Mobile Control Point")
@added(Versions.v2024_02_16_preview)
enum MCPProtocols {
  @doc("Transport Layer Security protocol to provide secure communication")
  TLS,

  @doc("Transmission Control Protocol for maintaining reliable connection")
  TCP,
}

@doc("Details of Peer - the point at the edge of an Operator Network, where Azure Communication Gateway will connect SIP Peers")
@added(Versions.v2024_02_16_preview)
model Peer {
  @doc("Unique name of peer")
  @visibility("read", "update", "create")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerName?: string;

  @doc("Type of the Peer")
  @visibility("read", "update", "create")
  peerType?: PeerType;

  @doc("Connection details containing the IP address and port number")
  @OpenAPI.extension("x-ms-identifiers", [])
  @visibility("read", "update", "create")
  ipsAndPorts?: IpAndPortDetails[];

  @doc("Connection details containing the address records and port number")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  aRecordsAndPorts?: ArecordAndPortDetails[];

  @doc("The DNS SRV record of Operator Network, where Azure Communication Gateway will connect SIP Peers")
  @visibility("read", "update", "create")
  srvRecord?: string;

  @doc("The allowed source IP addresses or CIDR ranges for signaling")
  @visibility("read", "update", "create")
  allowedSignalingSourceAddressPrefixes?: string[] = [];

  @doc("The allowed source IP addresses or CIDR ranges for media")
  @visibility("read", "update", "create")
  allowedMediaSourceAddressPrefixes?: string[] = [];
}

@doc("Provides service and peer group mapping, and peer group routing for all required combinations of service, location and peer.")
@added(Versions.v2024_02_16_preview)
model CallPolicy {
  @doc("The default mapping between Services and peer groups")
  @visibility("read", "update", "create")
  defaultMappings?: DefaultMappings;

  @doc("Routing priorities on a per-peer group and per-serviceLocation basis")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["peerGroupName"])
  peerGroupRoutings?: PeerGroupRouting[];
}

@doc("Mappings for routing, provides the ability to route calls based on service and location to a set of peers belonging to a peer group")
@added(Versions.v2024_02_16_preview)
model PeerGroupRouting {
  @doc("The name of the peer group used for mapping")
  @visibility("read", "update", "create")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerGroupName?: string;

  @doc("Routing Details about which service location would use which peer and at what priority")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", [])
  routings?: RoutingDetails[];
}

@doc("Details of the properties required for routing")
@added(Versions.v2024_02_16_preview)
model RoutingDetails {
  @doc("The name of peer defined earlier in peer group-->peers properties")
  @visibility("read", "update", "create")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerName?: string;

  @doc("The service location name where resources are deployed for communication services")
  @visibility("read", "update", "create")
  serviceLocation?: string;

  @doc("Priority defined, where 0 being the highest priority")
  @visibility("read", "update", "create")
  @minValue(0)
  @maxValue(100)
  priority?: int64;
}

@doc("Details of the default mappings between services and peer group")
@added(Versions.v2024_02_16_preview)
model DefaultMappings {
  @doc("Service to peer group mappings which tells what would be the default peer group for particular service")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["service"])
  serviceToPeerGroup?: ServiceToPeerGroup[];

  @doc("peer group to Service mappings which tells what would be the default service for particular peer group")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["peerGroup"])
  peerGroupToService?: PeerGroupToService[];
}

@doc("Details of the default mapping for Communications Services to peer group")
@added(Versions.v2024_02_16_preview)
model ServiceToPeerGroup {
  @doc("Name of the backend service")
  @visibility("read", "update", "create")
  service?: CommunicationsPlatform;

  @doc("Name of the default peer group for service")
  @visibility("read", "update", "create")
  defaultPeerGroup?: string;
}

@doc("Details of the default mapping for peer group to Service")
@added(Versions.v2024_02_16_preview)
model PeerGroupToService {
  @doc("Name of the peer group")
  @visibility("read", "update", "create")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerGroup?: string;

  @doc("Name of the default Communication Platform for peer group")
  @visibility("read", "update", "create")
  defaultService?: CommunicationsPlatform;
}

@doc("Connection details containing the combination of IP address and port number")
@added(Versions.v2024_02_16_preview)
model IpAndPortDetails {
  @doc("IP address identifying the peer of Operator Network")
  @visibility("read", "update", "create")
  ipAddress?: string;

  @doc("Port identifying the peer of Operator Network")
  @visibility("read", "update", "create")
  @minValue(1)
  @maxValue(65535)
  port?: int64;
}

@doc("Connection details containing the combination of A records and port number to uniquely identify the peer of Operator Network")
@added(Versions.v2024_02_16_preview)
model ArecordAndPortDetails {
  @doc("Address record identifying the peer of Operator Network")
  @visibility("read", "update", "create")
  aRecord?: string;

  @doc("Port identifying the peer of Operator Network")
  @visibility("read", "update", "create")
  @minValue(1)
  @maxValue(65535)
  port?: int64;
}

@doc("Azure Communication Gateway IP addresses or address ranges for sending traffic to Operator Network/ Communication Services which would be used for ACL firewall rules")
@added(Versions.v2024_02_16_preview)
model AcgAddressRanges {
  @doc("Azure Communication Gateway IP addresses or address ranges for sending signalling traffic to Communication Services")
  signalingForBackendServices?: string[];

  @doc("Azure Communication Gateway IP addresses or address ranges for sending signalling traffic to Operator Network")
  @visibility("read", "update", "create")
  signalingForOperator?: string[];

  @doc("Azure Communication Gateway IP address/FQDN for receiving signalling traffic from communications services")
  @visibility("read", "update", "create")
  mediaForBackendServices?: string[];

  @doc("Azure Communication Gateway IP addresses or address ranges for media traffic between Operator Network and Azure Communication Gateway ")
  @visibility("read", "update", "create")
  mediaForOperator?: string[];
}

@doc("Azure Communication Gateway Contact information allocated at runtime and used by operator/BackendServices to connect to Azure Communication Gateway")
@added(Versions.v2024_02_16_preview)
model AcgContactInfo {
  @doc("Azure Communication Gateway contact Peer details")
  @OpenAPI.extension("x-ms-identifiers", ["peerGroupName"])
  @visibility("read")
  peerGroups?: AcgContactPeerGroupDetails[];

  @doc("Azure Communication Gateway contact BackendServices details")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  backendServices?: AcgContactBackendServiceDetails[];
}

@doc("Allocated Azure Communication Gateway Contact information to be used by peer")
@added(Versions.v2024_02_16_preview)
model AcgContactPeerGroupDetails {
  @doc("Name of the peer group defined in the peer groups property")
  @visibility("read")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerGroupName?: string;

  @doc("IP addresses allocated for peer group")
  @visibility("read")
  ipAddresses?: string[];

  @doc("SRV record (created on basis of the peer group's peerGroupName and DNS hash)")
  @visibility("read")
  srvRecord?: string;

  @doc("Port number to be used by customer to connect with Azure Communication Gateway")
  @visibility("read")
  @minValue(1)
  @maxValue(65535)
  port?: int64;
}

@doc("Allocated Azure Communication Gateway details used by communication services")
@added(Versions.v2024_02_16_preview)
model AcgContactBackendServiceDetails {
  @doc("Operator's chosen communication service/platform")
  @visibility("read")
  serviceName?: string;

  @doc("Allocated IP addresses used by communication services")
  @visibility("read")
  ipAddresses?: string[];

  @doc("SRV record (created on basis of the backend service's serviceName and DNS hash)")
  @visibility("read")
  srvRecord?: string;

  @doc("Port number to be used by communication services to connect with Azure Communication Gateway")
  @visibility("read")
  @minValue(1)
  @maxValue(65535)
  port?: int64;
}

@doc("The service region configuration needed for Teams Callings.")
model ServiceRegionProperties {
  @doc("The name of the region in which the resources needed for Teams Calling will be deployed.")
  @visibility("read", "create")
  name: string;

  @doc("The configuration used in this region as primary, and other regions as backup.")
  @visibility("read", "update", "create")
  primaryRegionProperties: PrimaryRegionProperties;

  @doc("Azure Communication Gateway IP addresses or address ranges for sending signalling traffic to communication services/Operator")
  @added(Versions.v2024_02_16_preview)
  @visibility("read")
  acgAddressRanges?: AcgAddressRanges;

  @doc("Azure Communication Gateway contact information used by operator/communication services to connect to Azure Communication Gateway")
  @added(Versions.v2024_02_16_preview)
  @visibility("read")
  acgContactInfo?: AcgContactInfo;
}

@doc("The Peer Group Properties used to connect to operator")
@added(Versions.v2024_02_16_preview)
model PeerGroupProperties {
  @doc("The name of the Peer Group")
  @visibility("read", "create")
  @minLength(1)
  @maxLength(10)
  @pattern("^[a-zA-Z0-9-]+$")
  peerGroupName?: string;

  @doc("The point at the edge of an Operator Network, where Azure Communication Gateway will connect SIP Peers")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["peerName"])
  peers?: Peer[];

  @doc("Supported signaling protocol")
  @visibility("read", "update", "create")
  signalingProtocol?: SignalingProtocols = SignalingProtocols.TLS;

  @doc("Supported media protocol")
  @visibility("read", "update", "create")
  mediaProtocol?: MediaProtocols = MediaProtocols.SRTP;

  @doc("Voice codecs to support per Communication Services")
  @visibility("read", "update", "create")
  codecs?: TeamsCodecs[];
}

@doc("The configuration used in this region as primary, and other regions as backup.")
model PrimaryRegionProperties {
  @doc("IP address to use to contact the Operator Network from this region")
  @visibility("read", "update", "create")
  operatorAddresses: string[];

  @doc("IP address to use to contact the ESRP from this region")
  @visibility("read", "update", "create")
  esrpAddresses?: string[];

  @doc("The allowed source IP addresses or CIDR ranges for signaling")
  @visibility("read", "update", "create")
  allowedSignalingSourceAddressPrefixes?: string[] = [];

  @doc("The allowed source IP addresses or CIDR ranges for media")
  @visibility("read", "update", "create")
  allowedMediaSourceAddressPrefixes?: string[] = [];
}

@doc("Available platform types.")
enum CommunicationsPlatform {
  @doc("Operator Connect")
  OperatorConnect,

  @doc("Teams Phone Mobile")
  TeamsPhoneMobile,

  @doc("Teams Direct Routing")
  @added(Versions.v2023_09_01)
  TeamsDirectRouting,

  @doc("Zoom Platform")
  @added(Versions.v2023_09_21)
  Zoom,

  @doc("AI Voice Services")
  @added(Versions.v2024_02_05_preview)
  AiVoiceServices,
}

@doc("API Bridge activation state.")
@added(Versions.v2023_09_01)
enum ApiBridgeActivationState {
  @doc("API Bridge is enabled")
  @added(Versions.v2023_09_01)
  enabled,

  @doc("API Bridge is disabled")
  @added(Versions.v2023_09_01)
  disabled,
}

@doc("Zoom regions.")
@added(Versions.v2023_09_21)
enum ZoomRegion {
  @doc("North America Region")
  NorthAmerica,

  @doc("EMEA Region")
  EMEA,

  @doc("APAC Region")
  APAC,

  @doc("Japan Region")
  Japan,

  @doc("Australia and New Zealand Region")
  AustraliaNewZealand,

  @doc("Latin America Region")
  LatinAmerica,
}

@doc("Zoom test line.")
@added(Versions.v2023_09_21)
model ZoomTestLine {
  @doc("Phone number for the test line.")
  @visibility("read", "update", "create")
  phoneNumber: string;
}

@doc("Configuration for the Zoom platform.")
@added(Versions.v2023_09_21)
model ZoomConfig {
  @doc("Zoom platform test lines.")
  @OpenAPI.extension("x-ms-identifiers", ["phoneNumber"])
  @visibility("read", "update", "create")
  testLines: ZoomTestLine[];

  @doc("The Zoom region to which this Communications Gateway is connected.")
  @visibility("read", "update", "create")
  region: ZoomRegion;
}

@doc("Configuration of the API Bridge.")
model ApiBridgeProperties {
  @doc("The activation state of the API Bridge for this Communications Gateway")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  configureApiBridge?: ApiBridgeActivationState = ApiBridgeActivationState.disabled;

  @doc("FQDNs for sending requests to the API Bridge endpoint")
  @visibility("read")
  @added(Versions.v2023_09_01)
  endpointFqdns?: string[];

  @doc("The allowed source IP addresses or CIDR ranges for accessing the API Bridge")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  allowedAddressPrefixes?: string[];
}

@doc("Details of a DNS Domain delegated to the Communications Gateway.")
@added(Versions.v2023_09_01)
model DnsDelegationProperties {
  @doc("Domain name to delegate")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  domain?: string;

  @doc("The Azure-hosted DNS Name Servers for the delegated DNS Zones")
  @visibility("read")
  @added(Versions.v2023_09_01)
  nameServers?: string[];
}

@doc("Details of DNS Domains delegated to the Communications Gateway.")
@added(Versions.v2023_09_01)
model DnsDelegationsProperties {
  @doc("DNS Domains to delegate for the creation of DNS Zones by the Azure Communications Gateway")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["domain"])
  @added(Versions.v2023_09_01)
  delegations?: DnsDelegationProperties[];
}

@doc("Details of a Custom SIP Header.")
@added(Versions.v2023_09_01)
model CustomSipHeader {
  @doc("The name of the Custom SIP Header")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  name?: string;
}

@doc("Properties of Custom SIP Headers.")
@added(Versions.v2023_09_01)
model CustomSipHeadersProperties {
  @doc("The Custom SIP Headers to apply to the calls which traverse the Communications Gateway")
  @visibility("read", "update", "create")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  @added(Versions.v2023_09_01)
  headers?: CustomSipHeader[];
}

@doc("Available auto-generated domain name scopes.")
enum AutoGeneratedDomainNameLabelScope {
  @doc("Generated domain name label depends on resource name and tenant ID.")
  TenantReuse,

  @doc("Generated domain name label depends on resource name, tenant ID and subscription ID.")
  SubscriptionReuse,

  @doc("Generated domain name label depends on resource name, tenant ID, subscription ID and resource group name.")
  ResourceGroupReuse,

  @doc("Generated domain name label is always unique.")
  NoReuse,
}

@doc("Details of the CommunicationsGateway resource.")
model CommunicationsGatewayProperties is ResourceProperties {
  @doc("The current status of the deployment.")
  @visibility("read")
  status?: Status;

  @doc("The regions in which to deploy the resources needed for Teams Calling")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  @visibility("read", "update", "create")
  serviceLocations: ServiceRegionProperties[];

  @doc("Logical SIP connection with specific properties connecting Azure Communication Gateway to an Operator’s Network, used to connect sessions for a specified service ")
  @added(Versions.v2024_02_16_preview)
  @OpenAPI.extension("x-ms-identifiers", ["peerGroupName"])
  @visibility("read", "update", "create")
  peerGroups?: PeerGroupProperties[];

  @doc("Define the mapping between backend services and Peer as well as routing priorities")
  @added(Versions.v2024_02_16_preview)
  @visibility("read", "update", "create")
  callPolicy?: CallPolicy;

  @doc("How to connect back to the Operator Network, e.g. MAPS")
  @visibility("read", "create")
  connectivity: Connectivity;

  @doc("Indicate whether peer group and routing configuration would be used or not")
  @added(Versions.v2024_02_16_preview)
  @visibility("read", "create")
  operatorPeerGroupConfigScheme?: OperatorPeerGroupConfigSchemeValue = OperatorPeerGroupConfigSchemeValue.UseStaticDefaultConfig;

  @doc("Voice codecs to support")
  @visibility("read", "update", "create")
  codecs: TeamsCodecs[];

  @doc("How to handle 911 calls")
  @visibility("read", "update", "create")
  e911Type: E911Type;

  @doc("What platforms to support")
  @visibility("read", "update", "create")
  @minItems(1)
  platforms: CommunicationsPlatform[];

  @doc("Details of API bridge functionality, if required")
  @visibility("read", "update", "create")
  apiBridge?: ApiBridgeProperties;

  @doc("The scope at which the auto-generated domain name can be re-used")
  @visibility("read", "create")
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope = AutoGeneratedDomainNameLabelScope.TenantReuse;

  @doc("The autogenerated label used as part of the FQDNs for accessing the Communications Gateway")
  @visibility("read")
  autoGeneratedDomainNameLabel?: string;

  @doc("This number is used in Teams Phone Mobile scenarios for access to the voicemail IVR from the native dialer.")
  @visibility("read", "update", "create")
  teamsVoicemailPilotNumber?: string;

  @doc("Whether an on-premises Mobile Control Point is in use.")
  @visibility("read", "update", "create")
  onPremMcpEnabled?: boolean = false;

  @added(Versions.v2023_04_03)
  @doc("Whether an integrated Mobile Control Point is in use.")
  @visibility("read", "update", "create")
  integratedMcpEnabled?: boolean = false;

  @added(Versions.v2024_02_16_preview)
  @doc("Preferred protocol for MCP, if integrated MCP is enabled.")
  @visibility("read", "update", "create")
  preferredProtocolForMcp?: MCPProtocols = MCPProtocols.TLS;

  @doc("A list of dial strings used for emergency calling.")
  @visibility("read", "update", "create")
  emergencyDialStrings?: string[] = ["911", "933"];

  // Added 2023-09-01

  @doc("Details of DNS Domains to delegate to the Communications Gateway.")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  dnsDelegations?: DnsDelegationsProperties;

  @doc("Custom SIP Header to add to any subscriber with a custom_header value, if required.")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_01)
  customSipHeaders?: CustomSipHeadersProperties;

  @doc("A list of IP allocated prefixes which may be used to receive signaling data from this Communications Gateway.")
  @visibility("read")
  @added(Versions.v2023_09_01)
  allocatedSignalingAddressPrefixes?: string[];

  @doc("A list of allocated IP prefixes which may be used to receive media data from this Communications Gateway.")
  @visibility("read")
  @added(Versions.v2023_09_01)
  allocatedMediaAddressPrefixes?: string[];

  // Added 2023-09-21

  @doc("Configuration for Zoom platform")
  @visibility("read", "update", "create")
  @added(Versions.v2023_09_21)
  zoomConfig?: ZoomConfig;

  @doc("Configuration for AI Voice services")
  @visibility("read", "update", "create")
  @added(Versions.v2024_02_05_preview)
  aiVoiceServices?: AiVoiceServices;
}

// The 200 response support in Delete api is deprecated,
// ArmResourceDeleteWithoutOKAsync method adheres to the updated pattern,
// returning only 202 and 204 responses. Since we give 200 OK response on successful deletion
// hence suppressing it in terms of backward compatibility
#suppress "deprecated" "For backward compatibility"
@armResourceOperations
interface CommunicationsGateways
  extends ResourceRead<CommunicationsGateway>,
    ResourceCreate<CommunicationsGateway>,
    ResourceDelete<CommunicationsGateway>,
    ResourceListBySubscription<CommunicationsGateway>,
    ResourceListByParent<CommunicationsGateway>,
    ResourceUpdateNoProperties<CommunicationsGateway> {}
