import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;

@doc("Management mode for the Fabric.")
@added(Versions.v2026_01_15_preview)
union ManagementMode {
  string,

  @doc("Customer manages devices.")
  unmanaged: "unmanaged",

  @doc("RP manages devices.")
  managed: "managed",
}

@doc("Fabric kind: which party drives the switches. Set at create time and immutable.")
@added(Versions.v2026_07_15_preview)
union FabricKind {
  string,

  @doc("The Arc-for-Fabric RP drives devices directly (no external controller).")
  platformManaged: "PlatformManaged",

  @doc("An external SDN controller (Cisco ACI or Arista CloudVision) owns the devices; the RP integrates through it.")
  controllerManaged: "ControllerManaged",

  @doc("The customer drives devices; the RP observes only.")
  userManaged: "UserManaged",
}

@doc("External SDN controller implementation kind for a controller-managed Fabric.")
@added(Versions.v2026_07_15_preview)
union ControllerKind {
  string,

  @doc("Cisco Application Centric Infrastructure (APIC).")
  ciscoAci: "CiscoACI",

  @doc("Arista CloudVision (CVP).")
  aristaCloudVision: "AristaCloudVision",
}

@doc("Whether controller-side resources are discovered and adopted as hydrated read-only child resources.")
@added(Versions.v2026_07_15_preview)
union HydrationMode {
  string,

  @doc("Discover and adopt controller-side objects as read-only children.")
  enabled: "Enabled",

  @doc("Do not discover or adopt controller-side objects.")
  disabled: "Disabled",
}

@doc("VLAN allocation mode for a Cisco ACI VLAN pool.")
@added(Versions.v2026_07_15_preview)
union VlanAllocationType {
  string,

  @doc("VLAN IDs are assigned explicitly by the operator.")
  static: "Static",

  @doc("VLAN IDs are assigned automatically from the pool range.")
  dynamic: "Dynamic",
}

@doc("Live connection state between the RP/operator and an external SDN controller.")
@added(Versions.v2026_07_15_preview)
union ConnectionState {
  string,

  @doc("The controller endpoint is reachable and authenticated.")
  connected: "Connected",

  @doc("The controller endpoint is unreachable or authentication failed.")
  disconnected: "Disconnected",
}

@doc("Layout used for CloudVision Static Configuration Studio workspaces.")
@added(Versions.v2026_07_15_preview)
union StudioWorkspaceLayout {
  string,

  @doc("A single shared workspace for the fabric.")
  singleton: "Singleton",

  @doc("A per-device base workspace plus an overlay workspace.")
  perDeviceBaseAndOverlay: "PerDeviceBaseAndOverlay",
}

@doc("Controller connection configuration for controller-managed Fabrics. Required when kind is controllerManaged.")
@added(Versions.v2026_07_15_preview)
model ControllerManagedConfig {
  @doc("Controller implementation kind (Cisco ACI or Arista CloudVision). Selects which vendor config bag applies.")
  controllerKind: ControllerKind;

  @doc("Controller API endpoints the RP connects to. At least one is required; additional entries provide standby endpoints.")
  @minItems(1)
  @maxItems(5)
  @Azure.ResourceManager.identifiers(#["url"])
  endpoints: ControllerEndpoint[];

  @doc("Kubernetes Secret reference used by the RP to authenticate to the controller.")
  credentialSecretRef?: CredentialSecretReference;

  @doc("Cisco ACI-specific configuration. Required when controllerKind is CiscoACI; must be omitted otherwise.")
  ciscoAciConfig?: CiscoAciConfig;

  @doc("Arista CloudVision-specific configuration. Required when controllerKind is AristaCloudVision; must be omitted otherwise.")
  aristaCloudVisionConfig?: AristaCloudVisionConfig;

  @doc("Whether controller-side resources are discovered and adopted as hydrated read-only child resources. Defaults to Enabled.")
  hydration?: HydrationMode = HydrationMode.enabled;
}

@doc("Controller endpoint entry.")
@added(Versions.v2026_07_15_preview)
model ControllerEndpoint {
  @doc("Controller API endpoint URL. Must use the https scheme.")
  @minLength(1)
  @pattern("^[Hh][Tt][Tt][Pp][Ss]://")
  url: url;

  @doc("Free-form endpoint role, such as primary or standby.")
  role?: string;
}

@doc("Reference to the stored secret containing controller credentials.")
@added(Versions.v2026_07_15_preview)
model CredentialSecretReference {
  @doc("Name of the stored secret.")
  @minLength(1)
  name?: string;
}

@doc("Cisco ACI controller configuration.")
@added(Versions.v2026_07_15_preview)
model CiscoAciConfig {
  @doc("Name of the ACI physical domain used for Azure Local workloads.")
  @minLength(1)
  physicalDomainName: string;

  @doc("Name of the Attachable Access Entity Profile.")
  @minLength(1)
  aaepName: string;

  @doc("VLAN pool used for workload encapsulation.")
  vlanPool: AciVlanPoolConfig;

  @doc("Name of the ACI tenant for Azure Local objects.")
  @minLength(1)
  tenant: string;

  @doc("Name of the ACI application profile for Azure Local EPGs.")
  @minLength(1)
  appProfile: string;

  @doc("ACI authentication login domain / realm (for example a RADIUS or TACACS+ login domain).")
  loginDomain?: string;
}

@doc("Cisco ACI VLAN pool configuration.")
@added(Versions.v2026_07_15_preview)
model AciVlanPoolConfig {
  @doc("Name of the VLAN pool.")
  @minLength(1)
  name: string;

  @doc("First VLAN ID in the pool range.")
  @minValue(1)
  @maxValue(4094)
  rangeStart: int32;

  @doc("Last VLAN ID in the pool range.")
  @minValue(1)
  @maxValue(4094)
  rangeEnd: int32;

  @doc("VLAN allocation mode.")
  allocationType?: VlanAllocationType = VlanAllocationType.static;
}

@doc("Arista CloudVision controller configuration.")
@added(Versions.v2026_07_15_preview)
model AristaCloudVisionConfig {
  @doc("CloudVision container path containing Azure Local-managed devices.")
  @minLength(1)
  defaultContainerPath: string;

  @doc("Prefix for generated CloudVision configlets.")
  configletPrefix?: string = "AzureLocal_";

  @doc("CloudVision tag label used to identify managed devices.")
  tagLabel?: string = "AzureLocal-Managed";

  @doc("CloudVision tag value used to identify managed devices.")
  tagValue?: string = "true";

  @doc("Whether the provider automatically approves CloudVision change controls.")
  autoApproveChangeControls?: BooleanEnumProperty = BooleanEnumProperty.True;

  @doc("Prefix for CloudVision workspaces created by the provider.")
  workspacePrefix?: string = "azurelocal-";

  @doc("Layout used for CloudVision Static Configuration Studio workspaces.")
  studioWorkspaceLayout?: StudioWorkspaceLayout = StudioWorkspaceLayout.singleton;

  @doc("Prefix for per-device baseline configlets in CloudVision.")
  externalBaselineConfigletPrefix?: string;
}

@doc("Controller runtime status reported by the operator.")
@added(Versions.v2026_07_15_preview)
model ControllerStatus {
  @doc("Detected controller software version.")
  @visibility(Lifecycle.Read)
  controllerVersion?: string;

  @doc("Current connection state to the controller.")
  @visibility(Lifecycle.Read)
  connectionState?: ConnectionState;

  @doc("Currently active endpoint URL.")
  @visibility(Lifecycle.Read)
  activeEndpoint?: url;

  @doc("Whether hydration is active after the operator has observed the requested mode.")
  @visibility(Lifecycle.Read)
  hydrationState?: HydrationMode;
}

@doc("Controller-managed connection config for PATCH. All fields optional so any single field can be updated independently.")
@added(Versions.v2026_07_15_preview)
model PatchControllerManagedConfig {
  @doc("Controller implementation kind (Cisco ACI or Arista CloudVision).")
  controllerKind?: ControllerKind;

  @doc("Controller API endpoints (1-5). Supplying this replaces the endpoint list.")
  @minItems(1)
  @maxItems(5)
  @Azure.ResourceManager.identifiers(#["url"])
  endpoints?: ControllerEndpoint[];

  @doc("Kubernetes Secret reference to update the controller credential.")
  credentialSecretRef?: CredentialSecretReference;

  @doc("Cisco ACI-specific configuration fields to update.")
  ciscoAciConfig?: PatchCiscoAciConfig;

  @doc("Arista CloudVision-specific configuration fields to update.")
  aristaCloudVisionConfig?: PatchAristaCloudVisionConfig;

  @doc("Whether controller-side resources are hydrated as read-only children.")
  hydration?: HydrationMode;
}

@doc("Cisco ACI configuration for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchCiscoAciConfig {
  @doc("Name of the ACI physical domain used for Azure Local workloads.")
  physicalDomainName?: string;

  @doc("Name of the Attachable Access Entity Profile.")
  aaepName?: string;

  @doc("VLAN pool used for workload encapsulation.")
  vlanPool?: PatchAciVlanPoolConfig;

  @doc("Name of the ACI tenant for Azure Local objects.")
  tenant?: string;

  @doc("Name of the ACI application profile for Azure Local EPGs.")
  appProfile?: string;

  @doc("ACI authentication login domain / realm.")
  loginDomain?: string;
}

@doc("Cisco ACI VLAN pool configuration for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchAciVlanPoolConfig {
  @doc("Name of the VLAN pool.")
  name?: string;

  @doc("First VLAN ID in the pool range.")
  @minValue(1)
  @maxValue(4094)
  rangeStart?: int32;

  @doc("Last VLAN ID in the pool range.")
  @minValue(1)
  @maxValue(4094)
  rangeEnd?: int32;

  @doc("VLAN allocation mode.")
  allocationType?: VlanAllocationType;
}

@doc("Arista CloudVision configuration for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchAristaCloudVisionConfig {
  @doc("CloudVision container path containing Azure Local-managed devices.")
  defaultContainerPath?: string;

  @doc("Prefix for generated CloudVision configlets.")
  configletPrefix?: string;

  @doc("CloudVision tag label used to identify managed devices.")
  tagLabel?: string;

  @doc("CloudVision tag value used to identify managed devices.")
  tagValue?: string;

  @doc("Whether the provider automatically approves CloudVision change controls.")
  autoApproveChangeControls?: BooleanEnumProperty;

  @doc("Prefix for CloudVision workspaces created by the provider.")
  workspacePrefix?: string;

  @doc("Layout used for CloudVision Static Configuration Studio workspaces.")
  studioWorkspaceLayout?: StudioWorkspaceLayout;

  @doc("Prefix for per-device baseline configlets in CloudVision.")
  externalBaselineConfigletPrefix?: string;
}

@doc("Controller type for device interaction.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
union ControllerType {
  string,

  @doc("Cisco ACI APIC REST API.")
  ciscoAci: "ciscoAci",

  @doc("Arista CloudVision API.")
  aristaCloudVision: "aristaCloudVision",

  @doc("Direct gNMI/SSH.")
  direct: "direct",
}

@doc("Operation policy for device interaction.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
union OperationPolicy {
  string,

  @doc("Read device state and report drift.")
  validateOnly: "validateOnly",

  @doc("Read, write, and remediate drift.")
  fullControl: "fullControl",
}

@doc("Infrastructure network definition.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model InfraNetwork {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet: string;

  @doc("Default gateway IP.")
  ipv4Gateway: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Infrastructure network with optional IP fields.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model InfraNetworkOptionalIp {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("Default gateway IP.")
  ipv4Gateway?: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr?: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr?: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Named infrastructure network definitions.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model InfrastructureNetworks {
  @doc("OAM management network. Typical VLAN: 39.")
  management: InfraNetwork;

  @doc("PXE boot network. Typical VLAN: 40.")
  pxe: InfraNetwork;

  @doc("BMC/iDRAC network. Typical VLAN: 41.")
  bmc: InfraNetwork;

  @doc("Storage data plane network. Typical VLAN: 42.")
  storage: InfraNetwork;

  @doc("Storage management plane network. Typical VLAN: 37.")
  storageMgmt?: InfraNetworkOptionalIp;

  @doc("PDU management network. Typical VLAN: 43.")
  pdu?: InfraNetwork;
}

@doc("Platform proxy configuration.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model PlatformProxy {
  @doc("HTTP proxy endpoint URL.")
  httpProxy: string;

  @doc("HTTPS proxy endpoint URL.")
  httpsProxy: string;

  @doc("CIDRs, hostnames, and domain suffixes that bypass the proxy.")
  noProxy: string[];
}

@doc("Infrastructure service endpoints.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model InfrastructureServices {
  @doc("Platform proxy configuration.")
  platformProxy: PlatformProxy;

  @doc("NTP server IPs or hostnames.")
  @minItems(1)
  ntpServers: string[];

  @doc("DNS server IPs.")
  @minItems(1)
  dnsServers: string[];
}

@doc("Extensible network purpose identifier. Known values: management, pxe, bmc, pdu, storage, storageMgmt, ovn, vmLiveMigration.")
@added(Versions.v2026_07_15_preview)
union NetworkPurpose {
  string,

  @doc("OAM / out-of-band management network (VRF: INFRA-MGMT).")
  management: "management",

  @doc("PXE boot provisioning network (VRF: INFRA-MGMT).")
  pxe: "pxe",

  @doc("BMC / iDRAC management network (VRF: INFRA-MGMT).")
  bmc: "bmc",

  @doc("PDU power management network (VRF: INFRA-MGMT).")
  pdu: "pdu",

  @doc("Storage data-plane network (VRF: STORAGE-DATA).")
  storage: "storage",

  @doc("Storage management-plane network (VRF: STORAGE-MGMT).")
  storageMgmt: "storageMgmt",

  @doc("OVN virtual networking management network.")
  ovn: "ovn",

  @doc("VM live-migration data-plane network.")
  vmLiveMigration: "vmLiveMigration",
}

@doc("Extensible proxy config purpose identifier.")
@added(Versions.v2026_07_15_preview)
union ProxyConfigPurpose {
  string,

  @doc("Infrastructure-plane proxy for platform services.")
  platformProxy: "platformProxy",
}

@doc("Network definition for an infrastructure network.")
@added(Versions.v2026_07_15_preview)
model NetworkDefinition {
  @doc("Extensible network role identifier.")
  purpose: NetworkPurpose;

  @doc("Human-readable immutable correlation key.")
  @minLength(1)
  @maxLength(253)
  name: string;

  @doc("VLAN identifier (1-4094). Must be unique across all networks.")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation (e.g. '10.49.6.0/24'). At least one of ipv4Subnet or ipv6Subnet must be provided.")
  ipv4Subnet?: string;

  @doc("IPv4 default gateway address.")
  ipv4Gateway?: string;

  @doc("First usable IPv4 address in the pool.")
  ipv4StartAddr?: string;

  @doc("Last usable IPv4 address in the pool.")
  ipv4EndAddr?: string;

  @doc("IPv6 subnet in CIDR notation. At least one of ipv4Subnet or ipv6Subnet must be provided.")
  ipv6Subnet?: string;

  @doc("IPv6 default gateway address.")
  ipv6Gateway?: string;

  @doc("First usable IPv6 address in the pool.")
  ipv6StartAddr?: string;

  @doc("Last usable IPv6 address in the pool.")
  ipv6EndAddr?: string;

  @doc("IPv4 maximum transmission unit (68-9216). Default: 1500.")
  @minValue(68)
  @maxValue(9216)
  ipv4Mtu?: int32 = 1500;

  @doc("IPv6 maximum transmission unit (1280-9216). Default: 1500.")
  @minValue(1280)
  @maxValue(9216)
  ipv6Mtu?: int32 = 1500;

  @doc("Enables DHCP addressing. Valid only for management purpose.")
  useDhcp?: BooleanEnumProperty = BooleanEnumProperty.False;
}

@doc("Proxy configuration for a traffic scope.")
@added(Versions.v2026_07_15_preview)
model ProxyConfigEntry {
  @doc("Extensible traffic scope identifier. Known values: platformProxy.")
  purpose: ProxyConfigPurpose;

  @doc("HTTP proxy endpoint. IPv4 address with port (e.g. 'http://172.16.1.10:3128').")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint. Same format as httpProxy.")
  httpsProxy?: string;

  @doc("Destinations that bypass the proxy. Each entry is a CIDR, hostname suffix, or IP address.")
  noProxy?: string[];
}

@doc("Proxy configuration for tenant traffic scope.")
@added(Versions.v2026_07_15_preview)
model TenantProxyConfig {
  @doc("HTTP proxy endpoint. IPv4 address with port. Can be the same as infrastructure platformProxy.")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint. Same format as httpProxy.")
  httpsProxy?: string;

  @doc("Destinations that bypass the proxy.")
  noProxy?: string[];
}

@doc("Tenant network definition for workload proxy networking.")
@added(Versions.v2026_07_15_preview)
model TenantNetworkDefinition {
  @doc("Human-readable immutable correlation key.")
  @minLength(1)
  @maxLength(253)
  name: string;

  @doc("VLAN identifier (1-4094).")
  @minValue(1)
  @maxValue(4094)
  vlanId: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("IPv4 default gateway address.")
  ipv4Gateway?: string;

  @doc("First usable IPv4 address in the pool.")
  ipv4StartAddr?: string;

  @doc("Last usable IPv4 address in the pool.")
  ipv4EndAddr?: string;

  @doc("IPv6 subnet in CIDR notation.")
  ipv6Subnet?: string;

  @doc("IPv6 default gateway address.")
  ipv6Gateway?: string;

  @doc("First usable IPv6 address in the pool.")
  ipv6StartAddr?: string;

  @doc("Last usable IPv6 address in the pool.")
  ipv6EndAddr?: string;

  @doc("IPv4 maximum transmission unit (68-9216). Default: 1500.")
  @minValue(68)
  @maxValue(9216)
  ipv4Mtu?: int32 = 1500;

  @doc("IPv6 maximum transmission unit (1280-9216). Default: 1500.")
  @minValue(1280)
  @maxValue(9216)
  ipv6Mtu?: int32 = 1500;
}

@doc("Infrastructure configuration: networks, proxy, DNS, and NTP.")
@added(Versions.v2026_07_15_preview)
model InfrastructureConfig {
  @doc("Infrastructure networks. Flat array with extensible purpose.")
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["purpose"])
  networks: NetworkDefinition[];

  @doc("Proxy configurations. At least one entry with purpose 'platformProxy' required.")
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["purpose"])
  proxyConfigs: ProxyConfigEntry[];

  @doc("Infrastructure DNS resolver IPv4 addresses.")
  dnsServers?: string[];

  @doc("Infrastructure NTP server IPv4 addresses.")
  ntpServers?: string[];
}

@doc("Tenant/workload configuration: proxy network and proxy endpoint.")
@added(Versions.v2026_07_15_preview)
model TenantConfig {
  @doc("Tenant proxy network definition. Typically VLAN 50, VRF WORKLOAD-MGMT.")
  network?: TenantNetworkDefinition;

  @doc("Tenant proxy endpoint configuration. Consumed by CSN as upstream proxy peer.")
  proxyConfig?: TenantProxyConfig;
}

// --- Patch variants (all fields optional for PATCH operations) ---

@doc("Infrastructure network definition for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model PatchInfraNetwork {
  @doc("802.1Q VLAN ID.")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("Default gateway IP.")
  ipv4Gateway?: string;

  @doc("Start of allocatable IP range.")
  ipv4StartAddr?: string;

  @doc("End of allocatable IP range.")
  ipv4EndAddr?: string;

  @doc("Maximum Transmission Unit.")
  mtu?: int32;
}

@doc("Infrastructure network definitions for PATCH. No networks required.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model PatchInfrastructureNetworks {
  @doc("OAM management network.")
  management?: PatchInfraNetwork;

  @doc("PXE boot network.")
  pxe?: PatchInfraNetwork;

  @doc("BMC/iDRAC network.")
  bmc?: PatchInfraNetwork;

  @doc("Storage data plane network.")
  storage?: PatchInfraNetwork;

  @doc("Storage management plane network.")
  storageMgmt?: PatchInfraNetwork;

  @doc("PDU management network.")
  pdu?: PatchInfraNetwork;
}

@doc("Platform proxy configuration for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model PatchPlatformProxy {
  @doc("HTTP proxy endpoint URL.")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint URL.")
  httpsProxy?: string;

  @doc("CIDRs, hostnames, and domain suffixes that bypass the proxy.")
  noProxy?: string[];
}

@doc("Infrastructure service endpoints for PATCH. All fields optional.")
@added(Versions.v2026_01_15_preview)
@removed(Versions.v2026_07_15_preview)
model PatchInfrastructureServices {
  @doc("Platform proxy configuration.")
  platformProxy?: PatchPlatformProxy;

  @doc("NTP server IPs or hostnames.")
  ntpServers?: string[];

  @doc("DNS server IPs.")
  dnsServers?: string[];
}

@doc("Network definition for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchNetworkDefinition {
  @doc("Extensible network role identifier.")
  purpose?: NetworkPurpose;

  @doc("Human-readable immutable correlation key.")
  @minLength(1)
  @maxLength(253)
  name?: string;

  @doc("VLAN identifier (1-4094).")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("IPv4 default gateway address.")
  ipv4Gateway?: string;

  @doc("First usable IPv4 address in the pool.")
  ipv4StartAddr?: string;

  @doc("Last usable IPv4 address in the pool.")
  ipv4EndAddr?: string;

  @doc("IPv6 subnet in CIDR notation.")
  ipv6Subnet?: string;

  @doc("IPv6 default gateway address.")
  ipv6Gateway?: string;

  @doc("First usable IPv6 address in the pool.")
  ipv6StartAddr?: string;

  @doc("Last usable IPv6 address in the pool.")
  ipv6EndAddr?: string;

  @doc("IPv4 MTU (68-9216).")
  @minValue(68)
  @maxValue(9216)
  ipv4Mtu?: int32;

  @doc("IPv6 MTU (1280-9216).")
  @minValue(1280)
  @maxValue(9216)
  ipv6Mtu?: int32;

  @doc("Enables DHCP addressing. Valid only for management purpose.")
  useDhcp?: BooleanEnumProperty;
}

@doc("Proxy config entry for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchProxyConfigEntry {
  @doc("Extensible traffic scope identifier.")
  purpose?: ProxyConfigPurpose;

  @doc("HTTP proxy endpoint.")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint.")
  httpsProxy?: string;

  @doc("Destinations that bypass the proxy.")
  noProxy?: string[];
}

@doc("Infrastructure configuration for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchInfrastructureConfig {
  @doc("Infrastructure networks.")
  @Azure.ResourceManager.identifiers(#["purpose"])
  networks?: PatchNetworkDefinition[];

  @doc("Proxy configurations.")
  @Azure.ResourceManager.identifiers(#["purpose"])
  proxyConfigs?: PatchProxyConfigEntry[];

  @doc("DNS resolver IPv4 addresses.")
  dnsServers?: string[];

  @doc("NTP server IPv4 addresses.")
  ntpServers?: string[];
}

@doc("Tenant network definition for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchTenantNetworkDefinition {
  @doc("Human-readable immutable correlation key.")
  @minLength(1)
  @maxLength(253)
  name?: string;

  @doc("VLAN identifier (1-4094).")
  @minValue(1)
  @maxValue(4094)
  vlanId?: int32;

  @doc("IPv4 subnet in CIDR notation.")
  ipv4Subnet?: string;

  @doc("IPv4 default gateway address.")
  ipv4Gateway?: string;

  @doc("First usable IPv4 address in the pool.")
  ipv4StartAddr?: string;

  @doc("Last usable IPv4 address in the pool.")
  ipv4EndAddr?: string;

  @doc("IPv6 subnet in CIDR notation.")
  ipv6Subnet?: string;

  @doc("IPv6 default gateway address.")
  ipv6Gateway?: string;

  @doc("First usable IPv6 address in the pool.")
  ipv6StartAddr?: string;

  @doc("Last usable IPv6 address in the pool.")
  ipv6EndAddr?: string;

  @doc("IPv4 MTU (68-9216).")
  @minValue(68)
  @maxValue(9216)
  ipv4Mtu?: int32;

  @doc("IPv6 MTU (1280-9216).")
  @minValue(1280)
  @maxValue(9216)
  ipv6Mtu?: int32;
}

@doc("Tenant proxy config for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchTenantProxyConfig {
  @doc("HTTP proxy endpoint.")
  httpProxy?: string;

  @doc("HTTPS proxy endpoint.")
  httpsProxy?: string;

  @doc("Destinations that bypass the proxy.")
  noProxy?: string[];
}

@doc("Tenant configuration for PATCH. All fields optional.")
@added(Versions.v2026_07_15_preview)
model PatchTenantConfig {
  @doc("Tenant proxy network definition.")
  network?: PatchTenantNetworkDefinition;

  @doc("Tenant proxy endpoint configuration.")
  proxyConfig?: PatchTenantProxyConfig;
}

@doc("Fabric patchable properties.")
@added(Versions.v2026_01_15_preview)
model FabricPatchableProperties {
  @doc("Free-text description. Max 1024 characters.")
  @added(Versions.v2026_07_15_preview)
  @maxLength(1024)
  description?: string;

  @doc("Infrastructure network definitions.")
  @removed(Versions.v2026_07_15_preview)
  infrastructureNetworks?: PatchInfrastructureNetworks;

  @doc("Infrastructure service endpoints.")
  @removed(Versions.v2026_07_15_preview)
  infrastructureServices?: PatchInfrastructureServices;

  @doc("Operation policy for device interaction.")
  @removed(Versions.v2026_07_15_preview)
  operationPolicy?: OperationPolicy;

  @doc("URL of the SDN controller API endpoint.")
  @removed(Versions.v2026_07_15_preview)
  controllerEndpoint?: string;

  @doc("ARM resource ID of the Key Vault secret for controller credentials.")
  @removed(Versions.v2026_07_15_preview)
  controllerCredentialRef?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults/secrets";
    }
  ]>;

  @doc("Infrastructure configuration.")
  @added(Versions.v2026_07_15_preview)
  infrastructure?: PatchInfrastructureConfig;

  @doc("Tenant/workload configuration.")
  @added(Versions.v2026_07_15_preview)
  tenant?: PatchTenantConfig;

  @doc("SDN-controller connection configuration to update on a controllerManaged fabric. All fields optional; kind is immutable and cannot be changed by PATCH.")
  @added(Versions.v2026_07_15_preview)
  controllerManagedConfig?: PatchControllerManagedConfig;

  @doc("ARM resource ID of the custom location where controller-managed child resources are projected.")
  @added(Versions.v2026_07_15_preview)
  customLocationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("Fabric patch body.")
@added(Versions.v2026_01_15_preview)
model FabricPatch {
  ...TagsUpdate;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  @doc("Resource properties.")
  properties?: FabricPatchableProperties;
}

@@added(FabricPatch.identity, Versions.v2026_07_15_preview);

@doc("FabricProperties defines the resource properties.")
@added(Versions.v2026_01_15_preview)
model FabricProperties {
  @doc("Free-text description. Max 1024 characters.")
  @added(Versions.v2026_07_15_preview)
  @maxLength(1024)
  description?: string;

  @doc("Infrastructure network definitions.")
  @removed(Versions.v2026_07_15_preview)
  infrastructureNetworks?: InfrastructureNetworks;

  @doc("Infrastructure service endpoints.")
  @removed(Versions.v2026_07_15_preview)
  infrastructureServices?: InfrastructureServices;

  @doc("Operation policy for device interaction.")
  @removed(Versions.v2026_07_15_preview)
  operationPolicy?: OperationPolicy;

  @doc("URL of the SDN controller API endpoint.")
  @removed(Versions.v2026_07_15_preview)
  controllerEndpoint?: string;

  @doc("ARM resource ID of the Key Vault secret for controller credentials.")
  @removed(Versions.v2026_07_15_preview)
  controllerCredentialRef?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults/secrets";
    }
  ]>;

  @doc("ARM resource ID of the EdgeConnector.")
  @removed(Versions.v2026_07_15_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  edgeConnectorId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/edgeConnectors";
    }
  ]>;

  @doc("Management mode.")
  @removed(Versions.v2026_07_15_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managementMode: ManagementMode;

  @doc("SDN-controller connection configuration. Required when kind is controllerManaged; must be omitted otherwise.")
  @added(Versions.v2026_07_15_preview)
  controllerManagedConfig?: ControllerManagedConfig;

  @doc("ARM resource ID of the custom location where controller-managed child resources are projected.")
  @added(Versions.v2026_07_15_preview)
  customLocationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;

  @doc("Controller type for device interaction.")
  @removed(Versions.v2026_07_15_preview)
  controllerType?: ControllerType;

  @doc("Number of physical racks.")
  @removed(Versions.v2026_07_15_preview)
  rackCount?: int32;

  @doc("Infrastructure configuration: networks, proxy, DNS, and NTP.")
  @added(Versions.v2026_07_15_preview)
  infrastructure?: InfrastructureConfig;

  @doc("Tenant/workload configuration: proxy network and proxy endpoint.")
  @added(Versions.v2026_07_15_preview)
  tenant?: TenantConfig;

  @doc("Predefined topology identifier.")
  fabricSku?: string;

  @doc("ARM ID of the customer's Azure VNet.")
  @removed(Versions.v2026_07_15_preview)
  customerVnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  @doc("ARM ID of the customer's subnet.")
  @removed(Versions.v2026_07_15_preview)
  customerSubnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("Live controller runtime status reported by the operator. Populated only when kind is controllerManaged.")
  @added(Versions.v2026_07_15_preview)
  @visibility(Lifecycle.Read)
  controllerStatus?: ControllerStatus;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
