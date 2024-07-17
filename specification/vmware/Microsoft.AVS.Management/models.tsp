import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;

@doc("trial status")
union TrialStatus {
  string,

  @doc("is available")
  TrialAvailable: "TrialAvailable",

  @doc("is used")
  TrialUsed: "TrialUsed",

  @doc("is disabled")
  TrialDisabled: "TrialDisabled",
}

@doc("quota enabled")
union QuotaEnabled {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("private cloud provisioning state")
union PrivateCloudProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is pending")
  Pending: "Pending",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("NSX public IP quota raised")
union NsxPublicIpQuotaRaisedEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Cluster provisioning state")
union ClusterProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("Whether internet is enabled or disabled")
union InternetEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether SSL is enabled or disabled")
union SslEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether the private clouds is available in a single zone or two zones")
union AvailabilityStrategy {
  string,

  @doc("in single zone")
  SingleZone: "SingleZone",

  @doc("in two zones")
  DualZone: "DualZone",
}

@doc("Whether encryption is enabled or disabled")
union EncryptionState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether the the encryption key is connected or access denied")
union EncryptionKeyStatus {
  string,

  @doc("is connected")
  Connected: "Connected",

  @doc("is access denied")
  AccessDenied: "AccessDenied",
}

@doc("Whether the encryption version is fixed or auto-detected")
union EncryptionVersionType {
  string,

  @doc("is fixed")
  Fixed: "Fixed",

  @doc("is auto-detected")
  AutoDetected: "AutoDetected",
}

@doc("datastore provisioning state")
union DatastoreProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is pending")
  Pending: "Pending",

  @doc("is creating")
  Creating: "Creating",

  @doc("is updating")
  Updating: "Updating",

  @doc("is deleting")
  Deleting: "Deleting",
}

@doc("mount option")
union MountOptionEnum {
  string,

  @doc("is mount")
  MOUNT: "MOUNT",

  @doc("is attach")
  ATTACH: "ATTACH",
}

@doc("datastore status")
union DatastoreStatus {
  string,

  @doc("is unknown")
  Unknown: "Unknown",

  @doc("is accessible")
  Accessible: "Accessible",

  @doc("is inaccessible")
  Inaccessible: "Inaccessible",

  @doc("is attached")
  Attached: "Attached",

  @doc("is detached")
  Detached: "Detached",

  @doc("is lost communication")
  LostCommunication: "LostCommunication",

  @doc("is dead or error")
  DeadOrError: "DeadOrError",
}

@doc("HCX Enterprise Site status")
union HcxEnterpriseSiteStatus {
  string,

  @doc("is available")
  Available: "Available",

  @doc("is consumed")
  Consumed: "Consumed",

  @doc("is deactivated")
  Deactivated: "Deactivated",

  @doc("is deleted")
  Deleted: "Deleted",
}

@doc("Express Route Circuit Authorization provisioning state")
union ExpressRouteAuthorizationProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("Global Reach Connection provisioning state")
union GlobalReachConnectionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("Global Reach Connection status")
union GlobalReachConnectionStatus {
  string,

  @doc("is connected")
  Connected: "Connected",

  @doc("is connecting")
  Connecting: "Connecting",

  @doc("is disconnected")
  Disconnected: "Disconnected",
}

@doc("Segment status")
union SegmentStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network Segment provisioning state")
union WorkloadNetworkSegmentProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Workload Network DHCP provisioning state")
union WorkloadNetworkDhcpProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Port Mirroring Direction")
union PortMirroringDirectionEnum {
  string,

  @doc("is ingress")
  INGRESS: "INGRESS",

  @doc("is egress")
  EGRESS: "EGRESS",

  @doc("is bidirectional")
  BIDIRECTIONAL: "BIDIRECTIONAL",
}

@doc("Port Mirroring status")
union PortMirroringStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network Port Mirroring provisioning state")
union WorkloadNetworkPortMirroringProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("VM group status")
union VMGroupStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network VM Group provisioning state")
union WorkloadNetworkVMGroupProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("VM type")
union VMTypeEnum {
  string,

  @doc("is regular")
  REGULAR: "REGULAR",

  @doc("is edge")
  EDGE: "EDGE",

  @doc("is service")
  SERVICE: "SERVICE",
}

@doc("DNS service log level")
union DnsServiceLogLevelEnum {
  string,

  @doc("is debug")
  DEBUG: "DEBUG",

  @doc("is info")
  INFO: "INFO",

  @doc("is warning")
  WARNING: "WARNING",

  @doc("is error")
  ERROR: "ERROR",

  @doc("is fatal")
  FATAL: "FATAL",
}

@doc("DNS service status")
union DnsServiceStatusEnum {
  string,

  @doc("is success")
  SUCCESS: "SUCCESS",

  @doc("is failure")
  FAILURE: "FAILURE",
}

@doc("Workload Network DNS Service provisioning state")
union WorkloadNetworkDnsServiceProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Workload Network DNS Zone provisioning state")
union WorkloadNetworkDnsZoneProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Workload Network Public IP provisioning state")
union WorkloadNetworkPublicIPProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Cloud Link status")
union CloudLinkStatus {
  string,

  @doc("is active")
  Active: "Active",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is failed")
  Failed: "Failed",

  @doc("is disconnected")
  Disconnected: "Disconnected",
}

@doc("Addon provisioning state")
union AddonProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("Virtual Machine Restrict Movement state")
union VirtualMachineRestrictMovementState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Placement Policy state")
union PlacementPolicyState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Placement Policy provisioning state")
union PlacementPolicyProvisioningState {
  string,
  WorkloadNetworkProvisioningState,
}

@doc("Affinity Strength")
union AffinityStrength {
  string,

  @doc("is should")
  Should: "Should",

  @doc("is must")
  Must: "Must",
}

@doc("Azure Hybrid Benefit type")
union AzureHybridBenefitType {
  string,

  @doc("is SqlHost")
  SqlHost: "SqlHost",

  @doc("is None")
  None: "None",
}

@doc("Script Parameter types")
union ScriptParameterTypes {
  string,

  @doc("is string")
  String: "String",

  @doc("is secure string")
  SecureString: "SecureString",

  @doc("is credential")
  Credential: "Credential",

  @doc("is int")
  Int: "Int",

  @doc("is bool")
  Bool: "Bool",

  @doc("is float")
  Float: "Float",
}

@doc("Visibility Parameter")
union VisibilityParameterEnum {
  string,

  @doc("is visible")
  Visible: "Visible",

  @doc("is hidden")
  Hidden: "Hidden",
}

@doc("Optional Param")
union OptionalParamEnum {
  string,

  @doc("is optional")
  Optional: "Optional",

  @doc("is required")
  Required: "Required",
}

@doc("Script Execution provisioning state")
union ScriptExecutionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is pending")
  Pending: "Pending",

  @doc("is running")
  Running: "Running",

  @doc("is cancelling")
  Cancelling: "Cancelling",

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is deleting")
  Deleting: "Deleting",
}

@doc("Script Output Stream type")
union ScriptOutputStreamType {
  string,

  @doc("is information")
  Information: "Information",

  @doc("is warning")
  Warning: "Warning",

  @doc("is output")
  Output: "Output",

  @doc("is error")
  Error: "Error",
}

@doc("Affinity type")
union AffinityType {
  string,

  @doc("is affinity")
  Affinity: "Affinity",

  @doc("is anti-affinity")
  AntiAffinity: "AntiAffinity",
}

@doc("Subscription trial availability")
model Trial {
  @doc("Trial status")
  @visibility("read")
  status?: TrialStatus;

  @doc("Number of trial hosts available")
  @visibility("read")
  availableHosts?: int32;
}

@doc("Subscription quotas")
model Quota {
  @doc("Remaining hosts quota by sku type")
  @visibility("read")
  hostsRemaining?: Record<int32>;

  @doc("Host quota is active for current subscription")
  @visibility("read")
  quotaEnabled?: QuotaEnabled;
}

@doc("A location resource")
@subscriptionResource
model Location is ProxyResource<LocationProperties> {
  @doc("A location in a subscription")
  @pattern("^[-\\w\\._]+$")
  @key("location")
  @path
  @segment("locations")
  @Azure.ResourceManager.CommonTypes.Private.armCommonParameter(
    "LocationParameter",
    Azure.ResourceManager.CommonTypes.Versions.v5
  )
  name: string;
}

@doc("location provisioning state")
union LocationProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a location resource")
model LocationProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: LocationProvisioningState;
}

@doc("A private cloud resource")
model PrivateCloud is TrackedResource<PrivateCloudProperties> {
  ...ResourceSkuRequired;
  ...ManagedSystemAssignedIdentityProperty;

  @doc("Name of the private cloud")
  @pattern("^[-\\w\\._]+$")
  @key("privateCloudName")
  @path
  @segment("privateClouds")
  name: string;
}

@doc("Parameter for privatecloudName")
model PrivateCloudNameParameter {
  @doc("Name of the private cloud")
  @pattern("^[-\\w\\._]+$")
  @path
  privateCloudName: string;
}

@doc("An update to a private cloud resource")
model PrivateCloudUpdate {
  ...Foundations.ArmTagsProperty;
  ...ResourceSkuProperty;
  ...ManagedSystemAssignedIdentityProperty;

  @doc("The updatable properties of a private cloud resource")
  @extension("x-ms-client-flatten", true)
  properties?: PrivateCloudUpdateProperties;
}

@doc("The properties of a private cloud resource that may be updated")
model PrivateCloudUpdateProperties {
  @doc("The default cluster used for management")
  managementCluster?: ManagementCluster;

  @doc("Connectivity to internet is enabled or disabled")
  internet?: InternetEnum;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("vCenter Single Sign On Identity Sources")
  identitySources?: IdentitySource[];

  @doc("Properties describing how the cloud is distributed across availability zones")
  @visibility("create", "read")
  availability?: AvailabilityProperties;

  @doc("Customer managed key encryption, can be enabled or disabled")
  encryption?: Encryption;

  @doc("""
    Array of additional networks noncontiguous with networkBlock. Networks must be
    unique and non-overlapping across VNet in your subscription, on-premise, and
    this privateCloud networkBlock attribute. Make sure the CIDR format conforms to
    (A.B.C.D/X).
    """)
  extendedNetworkBlocks?: string[];

  @doc("The type of DNS zone to use.")
  dnsZoneType?: DnsZoneType;
}

@doc("The properties of a private cloud resource")
model PrivateCloudProperties {
  @doc("The default cluster used for management")
  managementCluster: ManagementCluster;

  @doc("Connectivity to internet is enabled or disabled")
  internet?: InternetEnum = InternetEnum.Disabled;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("vCenter Single Sign On Identity Sources")
  identitySources?: IdentitySource[];

  @doc("Properties describing how the cloud is distributed across availability zones")
  @visibility("create", "read")
  availability?: AvailabilityProperties;

  @doc("Customer managed key encryption, can be enabled or disabled")
  encryption?: Encryption;

  @doc("""
    Array of additional networks noncontiguous with networkBlock. Networks must be
    unique and non-overlapping across VNet in your subscription, on-premise, and
    this privateCloud networkBlock attribute. Make sure the CIDR format conforms to
    (A.B.C.D/X).
    """)
  extendedNetworkBlocks?: string[];

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: PrivateCloudProvisioningState;

  @doc("An ExpressRoute Circuit")
  circuit?: Circuit;

  @doc("The endpoints")
  @visibility("read")
  endpoints?: Endpoints;

  @doc("""
    The block of addresses should be unique across VNet in your subscription as
    well as on-premise. Make sure the CIDR format is conformed to (A.B.C.D/X) where
    A,B,C,D are between 0 and 255, and X is between 0 and 22
    """)
  networkBlock: string;

  @doc("Network used to access vCenter Server and NSX-T Manager")
  @visibility("read")
  managementNetwork?: string;

  @doc("Used for virtual machine cold migration, cloning, and snapshot migration")
  @visibility("read")
  provisioningNetwork?: string;

  @doc("Used for live migration of virtual machines")
  @visibility("read")
  vmotionNetwork?: string;

  @doc("Optionally, set the vCenter admin password when the private cloud is created")
  @secret
  vcenterPassword?: string;

  @doc("Optionally, set the NSX-T Manager password when the private cloud is created")
  @secret
  nsxtPassword?: string;

  @doc("Thumbprint of the vCenter Server SSL certificate")
  @visibility("read")
  vcenterCertificateThumbprint?: string;

  @doc("Thumbprint of the NSX-T Manager SSL certificate")
  @visibility("read")
  nsxtCertificateThumbprint?: string;

  @doc("Array of cloud link IDs from other clouds that connect to this one")
  @visibility("read")
  externalCloudLinks?: string[];

  @doc("""
    A secondary expressRoute circuit from a separate AZ. Only present in a
    stretched private cloud
    """)
  secondaryCircuit?: Circuit;

  @doc("""
    Flag to indicate whether the private cloud has the quota for provisioned NSX
    Public IP count raised from 64 to 1024
    """)
  @visibility("read")
  nsxPublicIpQuotaRaised?: NsxPublicIpQuotaRaisedEnum;

  @doc("Azure resource ID of the virtual network")
  @visibility("create", "read")
  virtualNetworkId?: Azure.Core.armResourceIdentifier<[
    {
      type: "\\Microsoft.Network\\vnet";
    }
  ]>;

  @doc("The type of DNS zone to use.")
  dnsZoneType?: DnsZoneType;
}

@doc("An ExpressRoute Circuit")
model Circuit {
  @doc("CIDR of primary subnet")
  @visibility("read")
  primarySubnet?: string;

  @doc("CIDR of secondary subnet")
  @visibility("read")
  secondarySubnet?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("Identifier of the ExpressRoute Circuit (Microsoft Colo only)")
  @visibility("read")
  expressRouteID?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("ExpressRoute Circuit private peering identifier")
  @visibility("read")
  expressRoutePrivatePeeringID?: string;
}

@doc("Endpoint addresses")
model Endpoints {
  @doc("Endpoint FQDN for the NSX-T Data Center manager")
  @visibility("read")
  nsxtManager?: string;

  @doc("Endpoint FQDN for Virtual Center Server Appliance")
  @visibility("read")
  vcsa?: string;

  @doc("Endpoint FQDN for the HCX Cloud Manager")
  @visibility("read")
  hcxCloudManager?: string;

  @doc("Endpoint IP for the NSX-T Data Center manager")
  @visibility("read")
  nsxtManagerIp?: string;

  @doc("Endpoint IP for Virtual Center Server Appliance")
  @visibility("read")
  vcenterIp?: string;

  @doc("Endpoint IP for the HCX Cloud Manager")
  @visibility("read")
  hcxCloudManagerIp?: string;
}

@doc("The properties of a management cluster")
model ManagementCluster {
  ...CommonClusterProperties;
}

@doc("The common properties of a cluster")
model CommonClusterProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The state of the cluster provisioning")
  @visibility("read")
  provisioningState?: ClusterProvisioningState;

  @doc("The identity")
  @visibility("read")
  clusterId?: int32;

  @doc("The hosts")
  hosts?: string[];

  @doc("Name of the vsan datastore associated with the cluster")
  vsanDatastoreName?: string;
}

@doc("vCenter Single Sign On Identity Source")
model IdentitySource {
  @doc("The name of the identity source")
  name?: string;

  @doc("The domain's NetBIOS name")
  `alias`?: string;

  @doc("The domain's dns name")
  domain?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("The base distinguished name for users")
  baseUserDN?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("The base distinguished name for groups")
  baseGroupDN?: string;

  @doc("Primary server URL")
  primaryServer?: string;

  @doc("Secondary server URL")
  secondaryServer?: string;

  @doc("Protect LDAP communication using SSL certificate (LDAPS)")
  ssl?: SslEnum;

  @doc("""
    The ID of an Active Directory user with a minimum of read-only access to Base
    DN for users and group
    """)
  username?: string;

  @doc("""
    The password of the Active Directory user with a minimum of read-only access to
    Base DN for users and groups.
    """)
  @secret
  password?: string;
}

@doc("The properties describing private cloud availability zone distribution")
model AvailabilityProperties {
  @doc("The availability strategy for the private cloud")
  strategy?: AvailabilityStrategy;

  @doc("The primary availability zone for the private cloud")
  zone?: int32;

  @doc("The secondary availability zone for the private cloud")
  secondaryZone?: int32;
}

@doc("The properties of customer managed encryption key")
model Encryption {
  @doc("Status of customer managed encryption key")
  status?: EncryptionState;

  @doc("The key vault where the encryption key is stored")
  keyVaultProperties?: EncryptionKeyVaultProperties;
}

@doc("An Encryption Key")
model EncryptionKeyVaultProperties {
  @doc("The name of the key.")
  keyName?: string;

  @doc("The version of the key.")
  keyVersion?: string;

  @doc("The auto-detected version of the key if versionType is auto-detected.")
  @visibility("read")
  autoDetectedKeyVersion?: string;

  @doc("The URL of the vault.")
  keyVaultUrl?: string;

  @doc("The state of key provided")
  @visibility("read")
  keyState?: EncryptionKeyStatus;

  @doc("Property of the key if user provided or auto detected")
  @visibility("read")
  versionType?: EncryptionVersionType;
}

@doc("A cluster resource")
@parentResource(PrivateCloud)
model Cluster is ProxyResource<ClusterProperties> {
  ...ResourceSkuRequired;

  @doc("Name of the cluster")
  @pattern("^[-\\w\\._]+$")
  @key("clusterName")
  @path
  @segment("clusters")
  name: string;
}

@doc("The properties of a cluster")
model ClusterProperties {
  ...CommonClusterProperties;
}

@doc("An update of a cluster resource")
model ClusterUpdate {
  ...ResourceSkuProperty;

  @doc("The properties of a cluster resource that may be updated")
  @extension("x-ms-client-flatten", true)
  properties?: ClusterUpdateProperties;
}

@doc("The properties of a cluster that may be updated")
model ClusterUpdateProperties {
  @doc("The cluster size")
  clusterSize?: int32;

  @doc("The hosts")
  hosts?: string[];
}

@doc("List of all zones and associated hosts for a cluster")
model ClusterZoneList {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Zone and associated hosts info")
  zones?: ClusterZone[];
}

@doc("Zone and associated hosts info")
model ClusterZone {
  @doc("List of hosts belonging to the availability zone in a cluster")
  @visibility("read")
  hosts?: string[];

  @doc("Availability zone identifier")
  @visibility("read")
  zone?: string;
}

@doc("A datastore resource")
@parentResource(Cluster)
model Datastore is ProxyResource<DatastoreProperties> {
  @doc("Name of the datastore")
  @pattern("^[-\\w\\._]+$")
  @key("datastoreName")
  @path
  @segment("datastores")
  name: string;
}

@doc("The properties of a datastore")
model DatastoreProperties {
  @doc("The state of the datastore provisioning")
  @visibility("read")
  provisioningState?: DatastoreProvisioningState;

  @doc("An Azure NetApp Files volume")
  netAppVolume?: NetAppVolume;

  @doc("An iSCSI volume")
  diskPoolVolume?: DiskPoolVolume;

  @doc("An Elastic SAN volume")
  elasticSanVolume?: ElasticSanVolume;

  @doc("The operational status of the datastore")
  @visibility("read")
  status?: DatastoreStatus;
}

@doc("An Azure NetApp Files volume from Microsoft.NetApp provider")
model NetAppVolume {
  @doc("Azure resource ID of the NetApp volume")
  id: string;
}

@doc("An iSCSI volume from Microsoft.StoragePool provider")
model DiskPoolVolume {
  @doc("Azure resource ID of the iSCSI target")
  targetId: string;

  @doc("Name of the LUN to be used for datastore")
  lunName: string;

  @doc("""
    Mode that describes whether the LUN has to be mounted as a datastore or
    attached as a LUN
    """)
  mountOption?: MountOptionEnum = MountOptionEnum.MOUNT;

  @doc("Device path")
  @visibility("read")
  path?: string;
}

scalar ClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedClusters",
    }
  ]>;

@doc("An Elastic SAN volume from Microsoft.ElasticSan provider")
model ElasticSanVolume {
  @doc("Azure resource ID of the Elastic SAN Volume")
  targetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ElasticSan/elasticSans/volumeGroups/volumes";
    }
  ]>;
}

@doc("Administrative credentials for accessing vCenter and NSX-T")
model AdminCredentials {
  @doc("NSX-T Manager username")
  @visibility("read")
  nsxtUsername?: string;

  @doc("NSX-T Manager password")
  @visibility("read")
  @secret
  nsxtPassword?: string;

  @doc("vCenter admin username")
  @visibility("read")
  vcenterUsername?: string;

  @doc("vCenter admin password")
  @visibility("read")
  @secret
  vcenterPassword?: string;
}

@doc("An HCX Enterprise Site resource")
@parentResource(PrivateCloud)
model HcxEnterpriseSite is ProxyResource<HcxEnterpriseSiteProperties> {
  @doc("Name of the HCX Enterprise Site")
  @pattern("^[-\\w\\._]+$")
  @key("hcxEnterpriseSiteName")
  @path
  @segment("hcxEnterpriseSites")
  name: string;
}

@doc("HCX Enterprise Site provisioning state")
union HcxEnterpriseSiteProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of an HCX Enterprise Site")
model HcxEnterpriseSiteProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: HcxEnterpriseSiteProvisioningState;

  @doc("The activation key")
  @visibility("read")
  activationKey?: string;

  @doc("The status of the HCX Enterprise Site")
  @visibility("read")
  status?: HcxEnterpriseSiteStatus;
}

@doc("ExpressRoute Circuit Authorization")
@parentResource(PrivateCloud)
model ExpressRouteAuthorization
  is ProxyResource<ExpressRouteAuthorizationProperties> {
  @doc("Name of the ExpressRoute Circuit Authorization")
  @pattern("^[-\\w\\._]+$")
  @key("authorizationName")
  @path
  @segment("authorizations")
  name: string;
}

@doc("The properties of an ExpressRoute Circuit Authorization resource")
model ExpressRouteAuthorizationProperties {
  @doc("The state of the ExpressRoute Circuit Authorization provisioning")
  @visibility("read")
  provisioningState?: ExpressRouteAuthorizationProvisioningState;

  @doc("The ID of the ExpressRoute Circuit Authorization")
  @visibility("read")
  expressRouteAuthorizationId?: string;

  @doc("The key of the ExpressRoute Circuit Authorization")
  @visibility("read")
  expressRouteAuthorizationKey?: string;

  @doc("The ID of the ExpressRoute Circuit")
  expressRouteId?: string;
}

@doc("A global reach connection resource")
@parentResource(PrivateCloud)
model GlobalReachConnection is ProxyResource<GlobalReachConnectionProperties> {
  @doc("Name of the global reach connection")
  @pattern("^[-\\w\\._]+$")
  @key("globalReachConnectionName")
  @path
  @segment("globalReachConnections")
  name: string;
}

@doc("The properties of a global reach connection")
model GlobalReachConnectionProperties {
  @doc("The state of the  ExpressRoute Circuit Authorization provisioning")
  @visibility("read")
  provisioningState?: GlobalReachConnectionProvisioningState;

  @doc("""
    The network used for global reach carved out from the original network block
    provided for the private cloud
    """)
  @visibility("read")
  addressPrefix?: string;

  @doc("""
    Authorization key from the peer express route used for the global reach
    connection
    """)
  authorizationKey?: string;

  @doc("The connection status of the global reach connection")
  @visibility("read")
  circuitConnectionStatus?: GlobalReachConnectionStatus;

  @doc("""
    Identifier of the ExpressRoute Circuit to peer with in the global reach
    connection
    """)
  peerExpressRouteCircuit?: string;

  @doc("""
    The ID of the Private Cloud's ExpressRoute Circuit that is participating in the
    global reach connection
    """)
  expressRouteId?: string;
}

@doc("Workload Network")
@parentResource(PrivateCloud)
@singleton
model WorkloadNetwork is ProxyResource<WorkloadNetworkProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("Name of the global reach connection")
  @key("workloadNetworkName")
  @path
  @segment("workloadNetworks")
  name: string;
}

@doc("base Workload Network provisioning state")
union WorkloadNetworkProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("The properties of a workload network")
model WorkloadNetworkProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;
}

@doc("NSX Segment")
@parentResource(WorkloadNetwork)
model WorkloadNetworkSegment
  is ProxyResource<WorkloadNetworkSegmentProperties> {
  @doc("The ID of the NSX Segment")
  @pattern("^[-\\w\\._]+$")
  @key("segmentId")
  @path
  @segment("segments")
  name: string;
}

@doc("NSX Segment Properties")
model WorkloadNetworkSegmentProperties {
  @doc("Display name of the segment.")
  displayName?: string;

  @doc("Gateway which to connect segment to.")
  connectedGateway?: string;

  @doc("Subnet which to connect segment to.")
  subnet?: WorkloadNetworkSegmentSubnet;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Port Vif which segment is associated with.")
  @visibility("read")
  portVif?: WorkloadNetworkSegmentPortVif[];

  @doc("Segment status.")
  @visibility("read")
  status?: SegmentStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkSegmentProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("Subnet configuration for segment")
model WorkloadNetworkSegmentSubnet {
  @doc("DHCP Range assigned for subnet.")
  dhcpRanges?: string[];

  @doc("Gateway address.")
  gatewayAddress?: string;
}

@doc("Ports and any VIF attached to segment.")
model WorkloadNetworkSegmentPortVif {
  @doc("Name of port or VIF attached to segment.")
  portName?: string;
}

@doc("NSX DHCP")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDhcp is ProxyResource<WorkloadNetworkDhcpEntity> {
  @doc("The ID of the DHCP configuration")
  @pattern("^[-\\w\\._]+$")
  @key("dhcpId")
  @path
  @segment("dhcpConfigurations")
  name: string;
}

@doc("Parameter for dhcpId")
model DhcpIdParameter {
  @doc("The ID of the DHCP configuration")
  @pattern("^[-\\w\\._]+$")
  @path
  dhcpId: string;
}

@doc("Type of DHCP: SERVER or RELAY.")
union DhcpTypeEnum {
  SERVER: "SERVER",
  RELAY: "RELAY",
  string,
}
@doc("""
  Base class for WorkloadNetworkDhcpServer and WorkloadNetworkDhcpRelay to
  inherit from
  """)
@discriminator("dhcpType")
model WorkloadNetworkDhcpEntity {
  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum;

  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Segments consuming DHCP.")
  @visibility("read")
  segments?: string[];

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDhcpProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("NSX DHCP Server")
model WorkloadNetworkDhcpServer extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Server Address.")
  serverAddress?: string;

  @doc("DHCP Server Lease Time.")
  leaseTime?: int64;

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum.SERVER;
}

@doc("NSX DHCP Relay")
model WorkloadNetworkDhcpRelay extends WorkloadNetworkDhcpEntity {
  @doc("DHCP Relay Addresses. Max 3.")
  @minItems(1)
  @maxItems(3)
  serverAddresses?: string[];

  @doc("Type of DHCP: SERVER or RELAY.")
  dhcpType: DhcpTypeEnum.RELAY;
}

@doc("NSX Gateway.")
@parentResource(WorkloadNetwork)
model WorkloadNetworkGateway
  is ProxyResource<WorkloadNetworkGatewayProperties> {
  @doc("The ID of the NSX Gateway")
  @pattern("^[-\\w\\._]+$")
  @key("gatewayId")
  @path
  @segment("gateways")
  name: string;
}

@doc("Properties of a NSX Gateway.")
model WorkloadNetworkGatewayProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the DHCP entity.")
  displayName?: string;

  @doc("NSX Gateway Path.")
  @visibility("read")
  path?: string;
}

@doc("NSX Port Mirroring")
@parentResource(WorkloadNetwork)
model WorkloadNetworkPortMirroring
  is ProxyResource<WorkloadNetworkPortMirroringProperties> {
  @doc("ID of the NSX port mirroring profile.")
  @pattern("^[-\\w\\._]+$")
  @key("portMirroringId")
  @path
  @segment("portMirroringProfiles")
  name: string;
}

@doc("Parameter for portMirroringId")
model PortMirroringProfileParameter {
  @doc("ID of the NSX port mirroring profile.")
  @pattern("^[-\\w\\._]+$")
  @path
  portMirroringId: string;
}

@doc("NSX Port Mirroring Properties")
model WorkloadNetworkPortMirroringProperties {
  @doc("Display name of the port mirroring profile.")
  displayName?: string;

  @doc("Direction of port mirroring profile.")
  direction?: PortMirroringDirectionEnum;

  @doc("Source VM Group.")
  source?: string;

  @doc("Destination VM Group.")
  destination?: string;

  @doc("Port Mirroring Status.")
  @visibility("read")
  status?: PortMirroringStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkPortMirroringProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX VM Group")
@parentResource(WorkloadNetwork)
model WorkloadNetworkVMGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  @doc("ID of the VM group.")
  @pattern("^[-\\w\\._]+$")
  @key("vmGroupId")
  @path
  @segment("vmGroups")
  name: string;
}

@doc("Parameter for vmGroupId")
model VmGroupIdParameter {
  @doc("ID of the VM group.")
  @pattern("^[-\\w\\._]+$")
  @path
  vmGroupId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX VM Group Properties")
model WorkloadNetworkVMGroupProperties {
  @doc("Display name of the VM group.")
  displayName?: string;

  @doc("Virtual machine members of this group.")
  members?: string[];

  @doc("VM Group status.")
  @visibility("read")
  status?: VMGroupStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkVMGroupProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("NSX Virtual Machine")
@parentResource(WorkloadNetwork)
model WorkloadNetworkVirtualMachine
  is ProxyResource<WorkloadNetworkVirtualMachineProperties> {
  @doc("ID of the virtual machine.")
  @pattern("^[-\\w\\._]+$")
  @key("virtualMachineId")
  @path
  @segment("virtualMachines")
  name: string;
}

@doc("NSX Virtual Machine Properties")
model WorkloadNetworkVirtualMachineProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: WorkloadNetworkProvisioningState;

  @doc("Display name of the VM.")
  displayName?: string;

  @doc("Virtual machine type.")
  @visibility("read")
  vmType?: VMTypeEnum;
}

@doc("NSX DNS Service")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsService
  is ProxyResource<WorkloadNetworkDnsServiceProperties> {
  @doc("ID of the DNS service.")
  @pattern("^[-\\w\\._]+$")
  @key("dnsServiceId")
  @path
  @segment("dnsServices")
  name: string;
}

@doc("Parameter for dnsServiceId")
model DnsServiceIdParameter {
  @doc("ID of the DNS service.")
  @pattern("^[-\\w\\._]+$")
  @path
  dnsServiceId: string;
}

@doc("NSX DNS Service Properties")
model WorkloadNetworkDnsServiceProperties {
  @doc("Display name of the DNS Service.")
  displayName?: string;

  @doc("DNS service IP of the DNS Service.")
  dnsServiceIp?: string;

  @doc("Default DNS zone of the DNS Service.")
  defaultDnsZone?: string;

  @doc("FQDN zones of the DNS Service.")
  fqdnZones?: string[];

  @doc("DNS Service log level.")
  logLevel?: DnsServiceLogLevelEnum;

  @doc("DNS Service status.")
  @visibility("read")
  status?: DnsServiceStatusEnum;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsServiceProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

@doc("NSX DNS Zone")
@parentResource(WorkloadNetwork)
model WorkloadNetworkDnsZone
  is ProxyResource<WorkloadNetworkDnsZoneProperties> {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @key("dnsZoneId")
  @path
  @segment("dnsZones")
  name: string;
}

@doc("Parameter for dnsZoneId")
model DnsZoneIdParameter {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @path
  dnsZoneId: string;
}

@doc("NSX DNS Zone Properties")
model WorkloadNetworkDnsZoneProperties {
  @doc("Display name of the DNS Zone.")
  displayName?: string;

  @doc("Domain names of the DNS Zone.")
  domain?: string[];

  @doc("DNS Server IP array of the DNS Zone.")
  dnsServerIps?: string[];

  @doc("Source IP of the DNS Zone.")
  sourceIp?: string;

  @doc("Number of DNS Services using the DNS zone.")
  dnsServices?: int64;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkDnsZoneProvisioningState;

  @doc("NSX revision number.")
  revision?: int64;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX Public IP Block")
@parentResource(WorkloadNetwork)
model WorkloadNetworkPublicIP
  is ProxyResource<WorkloadNetworkPublicIPProperties> {
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @key("publicIPId")
  @path
  @segment("publicIPs")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("Parameter for publicIPId")
model PublicIPIdParameter {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
  @doc("ID of the DNS zone.")
  @pattern("^[-\\w\\._]+$")
  @path
  publicIPId: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("NSX Public IP Block Properties")
model WorkloadNetworkPublicIPProperties {
  @doc("Display name of the Public IP Block.")
  displayName?: string;

  @doc("Number of Public IPs requested.")
  numberOfPublicIPs?: int64;

  @doc("CIDR Block of the Public IP Block.")
  @visibility("read")
  publicIPBlock?: string;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: WorkloadNetworkPublicIPProvisioningState;
}

@doc("A cloud link resource")
@parentResource(PrivateCloud)
model CloudLink is ProxyResource<CloudLinkProperties> {
  @doc("Name of the cloud link.")
  @pattern("^[-\\w\\._]+$")
  @key("cloudLinkName")
  @path
  @segment("cloudLinks")
  name: string;
}

@doc("cloud link provisioning state")
union CloudLinkProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a cloud link.")
model CloudLinkProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: CloudLinkProvisioningState;

  @doc("The state of the cloud link.")
  @visibility("read")
  status?: CloudLinkStatus;

  @doc("Identifier of the other private cloud participating in the link.")
  linkedCloud?: string;
}

@doc("An addon resource")
@parentResource(PrivateCloud)
model Addon is ProxyResource<AddonProperties> {
  @doc("Name of the addon.")
  @pattern("^[-\\w\\._]+$")
  @key("addonName")
  @path
  @segment("addons")
  name: string;
}

@doc("Addon type")
union AddonType {
  SRM: "SRM",
  VR: "VR",
  HCX: "HCX",
  Arc: "Arc",
  string,
}

@doc("The properties of an addon")
@discriminator("addonType")
model AddonProperties {
  @doc("Addon type")
  addonType: AddonType;

  @doc("The state of the addon provisioning")
  @visibility("read")
  provisioningState?: AddonProvisioningState;
}

@doc("Virtual Machine")
@parentResource(Cluster)
model VirtualMachine is ProxyResource<VirtualMachineProperties> {
  @doc("ID of the virtual machine.")
  @pattern("^[-\\w\\._]+$")
  @key("virtualMachineId")
  @path
  @segment("virtualMachines")
  name: string;
}

@doc("Virtual Machine provisioning state")
union VirtualMachineProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Virtual Machine Properties")
model VirtualMachineProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: VirtualMachineProvisioningState;

  @doc("Display name of the VM.")
  @visibility("read")
  displayName?: string;

  @doc("Virtual machine managed object reference id")
  @visibility("read")
  moRefId?: string;

  @doc("Path to virtual machine's folder starting from datacenter virtual machine folder")
  @visibility("read")
  folderPath?: string;

  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  @visibility("read")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("Set VM DRS-driven movement to restricted (enabled) or not (disabled)")
model VirtualMachineRestrictMovement {
  @doc("Whether VM DRS-driven movement is restricted (enabled) or not (disabled)")
  restrictMovement?: VirtualMachineRestrictMovementState;
}

@doc("A vSphere Distributed Resource Scheduler (DRS) placement policy")
@parentResource(Cluster)
model PlacementPolicy is ProxyResource<PlacementPolicyProperties> {
  @doc("Name of the placement policy.")
  @pattern("^[-\\w\\._]+$")
  @key("placementPolicyName")
  @path
  @segment("placementPolicies")
  name: string;
}

@doc("Placement Policy type")
union PlacementPolicyType {
  VmVm: "VmVm",
  VmHost: "VmHost",
  string,
}

@doc("Abstract placement policy properties")
@discriminator("type")
model PlacementPolicyProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("Placement Policy type")
  type: PlacementPolicyType;

  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Display name of the placement policy")
  displayName?: string;

  @doc("The provisioning state")
  @visibility("read")
  provisioningState?: PlacementPolicyProvisioningState;
}

@doc("An update of a DRS placement policy resource")
model PlacementPolicyUpdate {
  @doc("The properties of a placement policy resource that may be updated")
  @extension("x-ms-client-flatten", true)
  properties?: PlacementPolicyUpdateProperties;
}

@doc("The properties of a placement policy resource that may be updated")
model PlacementPolicyUpdateProperties {
  @doc("Whether the placement policy is enabled or disabled")
  state?: PlacementPolicyState;

  @doc("Virtual machine members list")
  vmMembers?: string[];

  @doc("Host members list")
  hostMembers?: string[];

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;
}

@doc("Script Package resources available for execution")
@parentResource(PrivateCloud)
model ScriptPackage is ProxyResource<ScriptPackageProperties> {
  @doc("Name of the script package.")
  @pattern("^[-\\w\\._@]+$")
  @key("scriptPackageName")
  @path
  @segment("scriptPackages")
  name: string;
}

@doc("Script Package provisioning state")
union ScriptPackageProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Properties of a Script Package subresource")
model ScriptPackageProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ScriptPackageProvisioningState;

  @doc("User friendly description of the package")
  @visibility("read")
  description?: string;

  @doc("Module version")
  @visibility("read")
  version?: string;

  @doc("Company that created and supports the package")
  @visibility("read")
  company?: string;

  @doc("Link to support by the package vendor")
  @visibility("read")
  uri?: string;
}

@doc("A cmdlet available for script execution")
@parentResource(ScriptPackage)
model ScriptCmdlet is ProxyResource<ScriptCmdletProperties> {
  @doc("Name of the script cmdlet.")
  @pattern("^[-\\w\\._]+$")
  @key("scriptCmdletName")
  @path
  @segment("scriptCmdlets")
  name: string;
}

@doc("A script cmdlet provisioning state")
union ScriptCmdletProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Properties of a pre-canned script")
model ScriptCmdletProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ScriptCmdletProvisioningState;

  @doc("Description of the scripts functionality")
  @visibility("read")
  description?: string;

  @doc("Recommended time limit for execution")
  @visibility("read")
  timeout?: string;

  @doc("Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers")
  @visibility("read")
  audience?: ScriptCmdletAudience;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Parameters the script will accept")
  @visibility("read")
  parameters?: ScriptParameter[];
}

@doc("Specifies whether a script cmdlet is intended to be invoked only through automation or visible to customers")
union ScriptCmdletAudience {
  string,

  @doc("is automation")
  Automation: "Automation",

  @doc("is any")
  Any: "Any",
}

@doc("An parameter that the script will accept")
model ScriptParameter {
  @doc("""
    The type of parameter the script is expecting. psCredential is a
    PSCredentialObject
    """)
  @visibility("read")
  type?: ScriptParameterTypes;

  @doc("The parameter name that the script will expect a parameter value for")
  name?: string;

  @doc("User friendly description of the parameter")
  @visibility("read")
  description?: string;

  @doc("""
    Should this parameter be visible to arm and passed in the parameters argument
    when executing
    """)
  @visibility("read")
  visibility?: VisibilityParameterEnum;

  @doc("Is this parameter required or optional")
  @visibility("read")
  optional?: OptionalParamEnum;
}

@doc("An instance of a script executed by a user - custom or AVS")
@parentResource(PrivateCloud)
model ScriptExecution is ProxyResource<ScriptExecutionProperties> {
  @doc("Name of the script cmdlet.")
  @pattern("^[-\\w\\._]+$")
  @key("scriptExecutionName")
  @path
  @segment("scriptExecutions")
  name: string;
}

@doc("Properties of a user-invoked script")
model ScriptExecutionProperties {
  @doc("A reference to the script cmdlet resource if user is running a AVS script")
  scriptCmdletId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("Parameters the script will accept")
  parameters?: ScriptExecutionParameter[];

  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers"
  @doc("""
    Parameters that will be hidden/not visible to ARM, such as passwords and
    credentials
    """)
  hiddenParameters?: ScriptExecutionParameter[];

  @doc("""
    Error message if the script was able to run, but if the script itself had
    errors or powershell threw an exception
    """)
  failureReason?: string;

  @doc("Time limit for execution")
  timeout: string;

  @doc("Time to live for the resource. If not provided, will be available for 60 days")
  retention?: string;

  @doc("Time the script execution was submitted")
  @visibility("read")
  submittedAt?: utcDateTime;

  @doc("Time the script execution was started")
  @visibility("read")
  startedAt?: utcDateTime;

  @doc("Time the script execution was finished")
  @visibility("read")
  finishedAt?: utcDateTime;

  @doc("The state of the script execution resource")
  @visibility("read")
  provisioningState?: ScriptExecutionProvisioningState;

  @doc("Standard output stream from the powershell execution")
  output?: string[];

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "It is unknown."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "It is unknown."
  @doc("User-defined dictionary.")
  namedOutputs?: Record<{}>;

  @doc("Standard information out stream from the powershell execution")
  @visibility("read")
  information?: string[];

  @doc("Standard warning out stream from the powershell execution")
  @visibility("read")
  warnings?: string[];

  @doc("Standard error output stream from the powershell execution")
  @visibility("read")
  errors?: string[];
}

@doc("script execution parameter type")
union ScriptExecutionParameterType {
  Value: "Value",
  SecureValue: "SecureValue",
  Credential: "Credential",
  string,
}

@doc("The arguments passed in to the execution")
@discriminator("type")
model ScriptExecutionParameter {
  @doc("script execution parameter type")
  type: ScriptExecutionParameterType;

  @doc("The parameter name")
  name: string;
}

@doc("The properties of a Site Recovery Manager (SRM) addon")
model AddonSrmProperties extends AddonProperties {
  @doc("The Site Recovery Manager (SRM) license")
  licenseKey?: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.SRM;
}

@doc("The properties of a vSphere Replication (VR) addon")
model AddonVrProperties extends AddonProperties {
  @doc("The vSphere Replication Server (VRS) count")
  vrsCount: int32;

  @doc("The type of private cloud addon")
  addonType: AddonType.VR;
}

@doc("The properties of an HCX addon")
model AddonHcxProperties extends AddonProperties {
  @doc("The HCX offer, example VMware MaaS Cloud Provider (Enterprise)")
  offer: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.HCX;
}

@doc("The properties of an Arc addon")
model AddonArcProperties extends AddonProperties {
  @doc("The VMware vCenter resource ID")
  vCenter?: string;

  @doc("The type of private cloud addon")
  addonType: AddonType.Arc;
}

@doc("VM-VM placement policy properties")
model VmVmPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("placement policy type")
  type: PlacementPolicyType.VmVm;
}

@doc("VM-Host placement policy properties")
model VmHostPlacementPolicyProperties extends PlacementPolicyProperties {
  @doc("Virtual machine members list")
  vmMembers: string[];

  @doc("Host members list")
  hostMembers: string[];

  @doc("placement policy affinity type")
  affinityType: AffinityType;

  @doc("vm-host placement policy affinity strength (should/must)")
  affinityStrength?: AffinityStrength;

  @doc("placement policy azure hybrid benefit opt-in type")
  azureHybridBenefitType?: AzureHybridBenefitType;

  @doc("placement policy type")
  type: PlacementPolicyType.VmHost;
}

@doc("a plain text value execution parameter")
model ScriptSecureStringExecutionParameter extends ScriptExecutionParameter {
  @doc("A secure value for the passed parameter, not to be stored in logs")
  @secret
  secureValue?: string;

  @doc("The type of execution parameter")
  type: ScriptExecutionParameterType.SecureValue;
}

@doc("a plain text value execution parameter")
model ScriptStringExecutionParameter extends ScriptExecutionParameter {
  @doc("The value for the passed parameter")
  value?: string;

  @doc("The type of execution parameter")
  type: ScriptExecutionParameterType.Value;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Can not change existing name."
@doc("a powershell credential object")
model PSCredentialExecutionParameter extends ScriptExecutionParameter {
  @doc("username for login")
  username?: string;

  @doc("password for login")
  @secret
  password?: string;

  @doc("The type of execution parameter")
  type: "Credential";
}

@doc("The type of DNS zone.")
union DnsZoneType {
  string,

  @doc("Primary DNS zone.")
  Public: "Public",

  @doc("Private DNS zone.")
  Private: "Private",
}

@doc("An iSCSI path resource")
@parentResource(PrivateCloud)
@singleton
model IscsiPath is ProxyResource<IscsiPathProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api"
  @doc("Name of the iSCSI path resource")
  @key("iscsiPathName")
  @path
  @segment("iscsiPaths")
  name: string;
}

@doc("The properties of an iSCSI path resource")
model IscsiPathProperties {
  @doc("The state of the iSCSI path provisioning")
  @visibility("read")
  provisioningState?: IscsiPathProvisioningState;

  @doc("CIDR Block for iSCSI path.")
  @visibility("create", "read")
  networkBlock: string;
}

@doc("private cloud provisioning state")
union IscsiPathProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is pending")
  Pending: "Pending",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
@doc("The SKU (Stock Keeping Unit) assigned to this resource.")
model ResourceSkuRequired {
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku: Foundations.Sku;
}

@doc("The response of a {name} list operation.", Resource)
@friendlyName(FriendlyNameFormat, Resource)
model ResourceList<
  Resource extends Foundations.Resource,
  FriendlyNameFormat extends valueof string = "{name}List"
> is Azure.Core.Page<Resource>;
