namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

alias PrivateCloudList = ResourceList<PrivateCloud>;
@armResourceOperations
interface PrivateClouds {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("PrivateClouds_List")
  list is ArmResourceListByParent<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  listInSubscription is ArmListBySubscription<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  get is ArmResourceRead<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateCloud,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // This could be modeled with ArmCustomPatchAsync if a 202 response with no body is used instead of a 201.
  // update is ArmCustomPatchAsync<PrivateCloud, PrivateCloudUpdate>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @doc("Update a PrivateCloud")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(PrivateCloud)
  @patch
  update(
    ...ResourceInstanceParameters<PrivateCloud>,

    @bodyRoot
    @doc("The private cloud properties to be updated.")
    privateCloudUpdate: PrivateCloudUpdate,
  ): ArmResponse<PrivateCloud> | {
    // @doc("Resource update request created.")
    ...CreatedResponse;

    ...Azure.Core.Foundations.RetryAfterHeader;
    ...LocationHeader;

    @bodyRoot
    @doc("The updated private cloud.")
    placementPolicy: PrivateCloud;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSyncNoRequestBody<
    PrivateCloud,
    AdminCredentials
  >;
}

@@clientName(PrivateClouds.createOrUpdate::parameters.resource, "privateCloud");

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

  #suppress "deprecated" "Legacy flatten"
  @doc("The updatable properties of a private cloud resource")
  @Azure.ClientGenerator.Core.flattenProperty
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
