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

@doc("How this deployment connects back to the operator network")
enum Connectivity {
  @doc("This deployment connects to the operator network using a Public IP address, e.g. when using MAPS")
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

@doc("The service region configuration needed for Teams Callings.")
model ServiceRegionProperties {
  @doc("The name of the region in which the resources needed for Teams Calling will be deployed.")
  @visibility("read", "create")
  name: string;

  @doc("The configuration used in this region as primary, and other regions as backup.")
  @visibility("read", "update", "create")
  primaryRegionProperties: PrimaryRegionProperties;
}

@doc("The configuration used in this region as primary, and other regions as backup.")
model PrimaryRegionProperties {
  @doc("IP address to use to contact the operator network from this region")
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

  @doc("How to connect back to the operator network, e.g. MAPS")
  @visibility("read", "create")
  connectivity: Connectivity;

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

@armResourceOperations
interface CommunicationsGateways
  extends ResourceRead<CommunicationsGateway>,
    ResourceCreate<CommunicationsGateway>,
    ResourceDelete<CommunicationsGateway>,
    ResourceListBySubscription<CommunicationsGateway>,
    ResourceListByParent<CommunicationsGateway>,
    ResourceUpdateNoProperties<CommunicationsGateway> {}
