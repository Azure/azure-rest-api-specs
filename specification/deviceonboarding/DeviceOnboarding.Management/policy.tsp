import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;

// ------------------------------------------------------------------
// Section 3: Policy Service (Child resource: onboarding policy)
// ------------------------------------------------------------------
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("An onboarding policy resource.")
@parentResource(OnboardingService)
model Policy is Azure.ResourceManager.TrackedResource<PolicyProperties> {
  @doc("The name of the Policy tracked resource.")
  @maxLength(128)
  @pattern("^[a-zA-Z0-9-]{3,127}[a-zA-Z0-9]$")
  @key("policyName")
  @segment("policies")
  @path
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("Details of the OnboardingService Policy.")
model PolicyProperties {
  @doc("Description of the policy")
  description?: string;

  @doc("The policy status")
  status: PolicyStatusOptions;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @removed(Versions.v2025_05_01_preview)
  @identifiers(#["name"])
  @maxItems(1)
  allocations?: Array<AllocationRule>;

  @doc("Just-in-time rule to create the device resource.")
  @removed(Versions.v2025_05_01_preview)
  jit?: JitRule;

  @doc("Further details about the policy resource")
  resourceDetails: PolicyResourceDetails;

  @doc("The identity the OnboardingService Policy will use. Must be from the list of enabled managed identities on the resource.")
  selectedIdentity?: SelectedIdentity;
}

@doc("Options for policy status.")
union PolicyStatusOptions {
  string,

  @doc("The value indicating the policy is enabled.")
  Enabled: "Enabled",

  @doc("The value indicating the policy is disabled.")
  Disabled: "Disabled",
}

@doc("Information on the selected identity. Can be SystemAssigned or UserAssigned.")
model SelectedIdentity {
  @doc("The type of identity.")
  type: SelectedIdentityType;

  @doc("Resource id of the UserAssigned identity.")
  resourceId?: SelectedIdentityResourceId;
}

scalar SelectedIdentityResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@doc("Supported identity types.")
union SelectedIdentityType {
  string,

  @doc("System assigned identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned identity.")
  UserAssigned: "UserAssigned",
}

@doc("Type of resource being provisioned.")
union OnboardingResourceType {
  string,

  @doc("Azure device registry device. Microsoft.DeviceRegistry/devices")
  @removed(Versions.v2025_05_01_preview)
  DeviceRegistryDevice: "Microsoft.DeviceRegistry/devices",

  @doc("Azure device registry namespace device. Microsoft.DeviceRegistry/namespaces/devices")
  @added(Versions.v2024_12_01_preview)
  @removed(Versions.v2025_05_01_preview)
  DeviceRegistryNamespaceDevice: "Microsoft.DeviceRegistry/namespaces/devices",

  @doc("Arc enabled device. Microsoft.HybridCompute/machines")
  HybridComputeMachine: "Microsoft.HybridCompute/machines",
}

@doc("Common further details about the policy resource")
@discriminator("type")
model PolicyResourceDetails {
  @doc("Type of the resource being provisioned.")
  type: OnboardingResourceType;
}

@doc("Details of the OnboardingService Device Registry Policy.")
@removed(Versions.v2025_05_01_preview)
model DeviceRegistryPolicyResourceDetails extends PolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: OnboardingResourceType.DeviceRegistryDevice;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  // make this property polymorphic based on OnboardingResourceType.
  // The current definition of the identity Info is for ADR resource type.
  // AadIdentityInfo

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("Details of the OnboardingService Device Registry Namespace Policy.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model DeviceRegistryNamespacePolicyResourceDetails
  extends PolicyResourceDetails {
  @doc("The policy resource type for device registry namespace devices.")
  type: OnboardingResourceType.DeviceRegistryNamespaceDevice;

  @doc("The just-in-time connection properties for device registry namespace devices.")
  jitProperties?: DeviceRegistryNamespaceDeviceJitProperties;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("The just-in-time connection properties for device registry namespace devices.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model DeviceRegistryNamespaceDeviceJitProperties {
  @doc("Resource id of the device registry namespace, required for device type Microsoft.DeviceRegistry/namespaces/devices")
  namespaceResourceId: DeviceRegistryNamespaceResourceId;
}

@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
scalar DeviceRegistryNamespaceResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces",
    }
  ]>;

@doc("Details of the OnboardingService Hybrid Compute Machines Policy.")
@renamedFrom(Versions.v2024_12_01_preview, "DiscoveryPolicyResourceDetails")
model HybridComputePolicyResourceDetails extends PolicyResourceDetails {
  @doc("The policy resource type for hybrid compute machines.")
  type: OnboardingResourceType.HybridComputeMachine;
}

@doc("The authentication type for bootstrap.")
union BootstrapAuthenticationType {
  string,

  @doc("The X509 authentication type.")
  @removed(Versions.v2025_05_01_preview)
  X509: "X509",

  @added(Versions.v2024_11_01_preview)
  @removed(Versions.v2024_12_01_preview)
  @doc("The discovery authentication type.")
  Discovery: "Discovery",

  @added(Versions.v2024_12_01_preview)
  @doc("The FDO authentication type.")
  FDO: "FDO",
}

@doc("The FDO-based authentication rule for bootstrapping.")
@added(Versions.v2024_12_01_preview)
model FdoBootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.FDO;

  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_05_01_preview)
  @renamedFrom(Versions.v2025_05_01_preview, "publicKeys")
  @doc("Per policy public key(s) to extend ownership voucher to the customer.")
  publicKeysold?: FdoPublicKeys;

  @added(Versions.v2025_05_01_preview)
  @doc("Per policy public key(s) to extend ownership voucher to the customer.")
  publicKeys?: FdoPublicKeys;

  @doc("Ownership Voucher storage")
  ownershipVoucherStorage?: OwnershipVoucherStorage;

  @doc("Endpoint for the rendezvous service, e.g. https://contoso-rv1.contoso.com")
  rendezvousEndpoint?: url;
}

@doc("Owner public keys to extend ownership voucher to the customer.")
@added(Versions.v2024_12_01_preview)
model FdoPublicKeys {
  @doc("Public key as x5C with encryption type SECP256R1.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_05_01_preview)
  @renamedFrom(Versions.v2025_05_01_preview, "secp256R1")
  secp256R1old?: FdoPublicKey;

  @added(Versions.v2025_05_01_preview)
  @doc("Public key as x5C with encryption type SECP256R1.")
  secp256R1?: FdoPublicKey;

  @added(Versions.v2025_05_01_preview)
  @doc("Public key as x5C with encryption type SECP384R1.")
  secp384R1?: FdoPublicKey;
}

@doc("Owner public key model")
@added(Versions.v2024_12_01_preview)
model FdoPublicKey {
  @doc("x5Chain representation of the public key.")
  @visibility(Lifecycle.Read)
  default?: bytes[];

  // status: boolean; // To be added later.

  @added(Versions.v2025_05_01_preview)
  @doc("Status of the public key.")
  status?: PublicKeyStatus;
}

@added(Versions.v2025_05_01_preview)
@doc("Status of public key.")
union PublicKeyStatus {
  string,

  @doc("Key is enabled.")
  Enabled: "Enabled",

  @doc("Key is disabled.")
  Disabled: "Disabled",
}

@doc("Generic Ownership Voucher Storage type.")
@added(Versions.v2024_12_01_preview)
@discriminator("ownershipVoucherStorageType")
model OwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  ownershipVoucherStorageType: OwnershipVoucherStorageType;
}

@doc("Storage Account Ownership Voucher Storage. Policy MI is used to access this storage")
@added(Versions.v2024_12_01_preview)
model StorageAccountOwnershipVoucherStorage extends OwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  ownershipVoucherStorageType: OwnershipVoucherStorageType.AzureBlobStorage;

  @doc("The storage resource id")
  resourceId: StorageAccountResourceId;

  @doc("Endpoint URL for the storage container. e.g: https://contoso.blob.core.windows.net/mycontainer")
  containerUri: url;
}

@added(Versions.v2024_12_01_preview)
scalar StorageAccountResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts",
    }
  ]>;

@doc("The Ownership Voucher Storage Type.")
@added(Versions.v2024_12_01_preview)
union OwnershipVoucherStorageType {
  string,

  @doc("The Storage Account Ownership Voucher Storage type.")
  AzureBlobStorage: "Microsoft.Storage/storageAccounts",
}

@doc("The authentication rule for bootstrap.")
@discriminator("type")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType;
}

@doc("X509 Certificate.")
@removed(Versions.v2025_05_01_preview)
model X509Certificate {
  @doc("The certificate.")
  certificate: bytes;

  @doc("Thumbprint extracted from the certificate.")
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  @doc("Expiry date for the certificate.")
  @visibility(Lifecycle.Read)
  expiryDate?: utcDateTime;
}

@doc("The x509-based authentication rule for bootstrapping.")
@removed(Versions.v2025_05_01_preview)
model X509BootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.X509;

  @doc("The primary certificate. B64 x509 cert")
  //@secret todo
  primaryCertificate: X509Certificate;

  @doc("The secondary certificate.")
  //@secret todo
  secondaryCertificate?: X509Certificate;
}

@added(Versions.v2024_11_01_preview)
@removed(Versions.v2024_12_01_preview)
@doc("The Discovery-based authentication rule for bootstrapping.")
model DiscoveryBootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("The rule for Just-in-time connection.")
@removed(Versions.v2025_05_01_preview)
model JitRule {
  @doc("The priority of the policy. Should be greater than 0.")
  @minValue(1)
  priority: int32;

  // @minLength(1)
  // @doc("The region.")
  // region: string; // TODO: checkout the location resource and see if we can use it here

  //...SubscriptionIdParameter;
  @minLength(1)
  @doc("The ID of the target subscription.")
  subscriptionId: string;

  //...ResourceGroupParameter;
  @minLength(1)
  @maxLength(90)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @doc("The case insensitive name of the target resource group.")
  resourceGroupName: string;
}

@doc("Type of the endpoint.")
@removed(Versions.v2025_05_01_preview)
union EndpointType {
  string,

  @doc("Azure event grid broker.")
  MicrosoftEventGridNamespace: "Microsoft.EventGrid/namespaces",

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Type of allocation rule.")
@removed(Versions.v2025_05_01_preview)
union AllocationType {
  string,

  @doc("Evenly distributed allocation.")
  EvenlyDistributed: "EvenlyDistributed",

  //@doc("Allocation based on geo-location.")
  //GeoBased,

  //@doc("Allocation based on weight.")
  //EvenlyWeighted,
}

@doc("The allocation rule.")
@removed(Versions.v2025_05_01_preview)
@discriminator("type")
model AllocationRule {
  @doc("Name of the allocation rule.")
  name: string;

  @doc("Type of endpoint.")
  endpointType: EndpointType;

  @doc("Type of the allocation rule.")
  type: AllocationType;
}

@doc("Allocation endpoint.")
@removed(Versions.v2025_05_01_preview)
model AllocationEndpoint {
  @doc("Resource id of the endpoint.")
  resourceId: AllocationEndpointResourceId;

  @doc("host name of the endpoint.")
  hostName: string;
}

@removed(Versions.v2025_05_01_preview)
scalar AllocationEndpointResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.EventGrid/namespaces",
    }
  ]>;

//@doc("GeoBased allocation endpoint.")
//model GeoBasedAllocationEndpoint {
//  @doc("Resource id of the endpoint.")
//  resourceId: string;
//
//  @doc("host name of the endpoint.")
//  hostName: string;
//
//  @doc("Region of the endpoint.")
//  region: string;
//}

//@doc("The allocation rule for geoBased allocation type.")
//model GeoBasedAllocationRule extends AllocationRule {
//  @doc("GeoBased allocation type.")
//  type: AllocationType.GeoBased;

//  @doc("List of endpoints for geoBased allocation type.")
//  @maxItems(10)
//  @minItems(1)
//  @Azure.ResourceManager.identifiers(#["resourceId"])
//  endpoints: Array<GeoBasedAllocationEndpoint>;
//}

//@doc("The allocation rule for evenly weighted allocation type.")
//model EvenlyWeightedAllocationRule extends AllocationRule {
//  @doc("weighted allocation type.")
//  type: AllocationType.EvenlyWeighted;
//
//  @doc("List of endpoints for evenly weighted allocation type.")
//  @maxItems(10)
//  @minItems(1)
//  @Azure.ResourceManager.identifiers(#["resourceId"])
//  endpoints: Array<AllocationEndpoint>;
//  // todo no optional (to be tested)
//}

@doc("The allocation rule for evenly distributed allocation type.")
@removed(Versions.v2025_05_01_preview)
model EvenlyDistributedAllocationRule extends AllocationRule {
  @doc("Evenly distributed allocation type.")
  type: AllocationType.EvenlyDistributed;

  @doc("List of endpoints for evenly distributed allocation type.")
  @maxItems(10)
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["resourceId"])
  endpoints: Array<AllocationEndpoint>;
}

// @doc("The identity info to return to device.")
// model DeviceIdentityInfo {
//   @doc("If uuid need to be returned.")
//   uuid: boolean;

//   @doc("If accessTokenUrl need to be returned.")
//   accessTokenUrl: boolean;

//   @doc("If externalDeviceId need to be returned.")
//   externalDeviceId: boolean;
// }

// @doc("Potential sources for cert issuance config.")
// enum SourceType {
//   @doc("From certificate signing request.")
//   CSR,

//   @doc("From the enrollment policy.")
//   Policy,

//   @doc("From the substitute.")
//   Substitute,
// }

@doc("Supported key types.")
@removed(Versions.v2025_05_01_preview)
union SupportedKeyType {
  string,

  //@doc("Indicate the RSA key type.")
  //RSA,

  @doc("Indicate the ECC key type.")
  ECC: "ECC",
}

@doc("Supported issuing authority.")
@removed(Versions.v2025_05_01_preview)
union SupportedIssuingAuthority {
  string,

  // TODO: should we use FirstParty or match the PM spec and use MicrosoftManagedPKI?
  @doc("First party cert issuance.")
  FirstParty: "FirstParty",
}

@doc("The configuration for setting up a CA.")
@removed(Versions.v2025_05_01_preview)
model CaConfig {
  @doc("System-generated value for referencing the CA.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Certificate properties.")
  properties: CertificateProperties;
}

@doc("Certificate properties.")
@removed(Versions.v2025_05_01_preview)
model CertificateProperties {
  @doc("Crypto type: RSA or EC.")
  keyType: SupportedKeyType;

  @doc("Certificate subject.")
  @visibility(Lifecycle.Read)
  subject?: string;

  @doc("System-assigned validity period.")
  @visibility(Lifecycle.Read)
  @maxValue(366)
  @minValue(365)
  validityPeriodInDays?: int32;

  @doc("Certificate is valid not before this date. Format ISO8601. Generated based on on validity period.")
  @visibility(Lifecycle.Read)
  validityNotBefore?: utcDateTime;

  @doc("Certificate is valid not after this date. Format ISO8601. Generated based on validity period.")
  @visibility(Lifecycle.Read)
  validityNotAfter?: utcDateTime;
}

@doc("The configuration for setting up a policy.")
@removed(Versions.v2025_05_01_preview)
model CertPolicyConfig {
  @doc("The validity period in days.")
  @minValue(1)
  validityPeriodInDays: int32;
}

@doc("Certificate issuance configurations.")
@removed(Versions.v2025_05_01_preview)
model CertificateIssuanceRule {
  @doc("The type of authority for cert issuance.")
  issuingAuthority: SupportedIssuingAuthority; //enum, FirstParty, BYO

  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration: CaConfig; // set by the customers

  @doc("The leaf certificate configuration.")
  leafCertificateConfiguration: CertPolicyConfig; // same type as the ica config

  @doc("Cert renewal interval.")
  @minValue(1)
  renewalInterval: int32; // A number of percentage. An example for renewal interval is - renew at 80%
}

@doc("The information related to device identity.")
@removed(Versions.v2025_05_01_preview)
model IdentityInfo {
  @doc("Certificate issuance settings.")
  certificateIssuance?: CertificateIssuanceRule; // For PKI

  @doc("Guid of the device template.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceTemplateId: string;

  @doc("Guid for static AAD group.")
  staticGroupId: string;

  //  @doc("Guid for MTLS Oauth Config.")
  // @visibility(Lifecycle.Read, Lifecycle.Create)
  //  mtlsOauthConfigurationId: string;

  //  @doc("Guid of the devices Tenant.")
  // @visibility(Lifecycle.Read, Lifecycle.Create)
  //  deviceTenantId: string;

  //@doc("The identity info to return to device.")
  //identityInfoForDevice?: DeviceIdentityInfo; // TODO check with Adarsh,Sekhar if this supports both HCI and ADR scenario
}

@doc("Resource metadata")
@removed(Versions.v2025_05_01_preview)
model ResourceMetadata {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is arbitrary JSON to provide custom attributes"
  @doc("Custom attributes")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  //  The typespec is not able to support List of Object datatype so we use Record<unknown> as datatype to generate the swagger file for now.
  //  However, this fails the providerhub generation (TypeError: Cannot read properties of undefined) hence all models are not generated.
  //  The workaround is to change the datatype of customAttributes to something like string.
  //  Or generate the swagger json file in typespec playground
  customAttributes?: Record<unknown>;
}

@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<Policy, PolicyPatch>;
  listByParent is ArmResourceListByParent<Policy>;
}

// ------------------------------------------------------------------
// Section 3.1: Policy Service Patch Models
// ------------------------------------------------------------------
@doc("Onboarding policy model for patch.")
model PolicyPatch {
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("Policy Patch Properties.")
  properties?: PolicyPatchProperties;
}

@doc("Onboarding policies properties model for patch.")
model PolicyPatchProperties {
  @doc("Description of the policy")
  description?: string;

  @doc("The policy status")
  status?: PolicyStatusOptions;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication?: PatchBootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @removed(Versions.v2025_05_01_preview)
  @identifiers(#["name"])
  @maxItems(1)
  allocations?: Array<AllocationRulePatch>;

  @doc("Just-in-time rule to create the device resource.")
  @removed(Versions.v2025_05_01_preview)
  jit?: JitRulePatchUpdate;

  @doc("Further details about the policy resource")
  resourceDetails?: PolicyPatchResourceDetails;

  @doc("The identity the OnboardingService Policy will use. Must be from the list of enabled managed identities on the resource.")
  selectedIdentity?: PatchSelectedIdentity;
}

@doc("The bootstrap authentication rule for patch.")
@discriminator("type")
model PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType;
}

@doc("The x509-based authentication rule for bootstrapping.")
@removed(Versions.v2025_05_01_preview)
model PatchX509BootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.X509;

  @doc("The primary certificate. B64 x509 cert")
  //@secret todo
  primaryCertificate?: PatchX509Certificate;

  @doc("The secondary certificate.")
  //@secret todo
  secondaryCertificate?: PatchX509Certificate;
}

@doc("X509 Certificate.")
@removed(Versions.v2025_05_01_preview)
model PatchX509Certificate {
  @doc("The certificate.")
  certificate?: bytes;

  @doc("Thumbprint extracted from the certificate.")
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  @doc("Expiry date for the certificate.")
  @visibility(Lifecycle.Read)
  expiryDate?: utcDateTime;
}

@doc("Information on the selected identity. Can be SystemAssigned or UserAssigned.")
model PatchSelectedIdentity {
  @doc("The type of identity.")
  type?: SelectedIdentityType;

  @doc("Resource id of the UserAssigned identity.")
  resourceId?: SelectedIdentityResourceId;
}

@added(Versions.v2024_11_01_preview)
@removed(Versions.v2024_12_01_preview)
@doc("The Discovery-based authentication rule for bootstrapping.")
model PatchDiscoveryBootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("The FDO-based authentication rule for bootstrapping.")
@added(Versions.v2024_12_01_preview)
model PatchFdoBootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.FDO;

  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_05_01_preview)
  @renamedFrom(Versions.v2025_05_01_preview, "publicKeys")
  @doc("Per policy public keys to represent this policy")
  publicKeysold?: FdoPublicKeys;

  @added(Versions.v2025_05_01_preview)
  @doc("Per policy public keys to represent this policy")
  publicKeys?: FdoPublicKeys;

  @doc("Ownership Voucher storage link")
  ownershipVoucherStorage?: OwnershipVoucherStorage;

  @doc("Endpoint for the rendezvous service, e.g. https://contoso-rv1.contoso.com")
  rendezvousEndpoint?: url;
}

@doc("Generic Ownership Voucher Storage type.")
@added(Versions.v2024_12_01_preview)
@discriminator("ownershipVoucherStorageType")
model PatchOwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  ownershipVoucherStorageType: OwnershipVoucherStorageType;
}

@doc("Storage Account Ownership Voucher Storage. Policy MI is used to access this storage")
@added(Versions.v2024_12_01_preview)
model PatchStorageAccountOwnershipVoucherStorage
  extends PatchOwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  ownershipVoucherStorageType: OwnershipVoucherStorageType.AzureBlobStorage;

  @doc("The storage resource id")
  resourceId?: StorageAccountResourceId;

  @doc("Endpoint URI for the storage account") // TODO: determine correct example here
  containerUri?: url;
}

@doc("The rule for Just-in-time connection.")
@removed(Versions.v2025_05_01_preview)
model JitRulePatchUpdate {
  @doc("The priority of the policy. Should be greater than 0.")
  @minValue(1)
  priority?: int32;

  //...SubscriptionIdParameter;
  @minLength(1)
  @doc("The ID of the target subscription.")
  subscriptionId?: string;

  //...ResourceGroupParameter;
  @minLength(1)
  @maxLength(90)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @doc("The case insensitive name of the target resource group.")
  resourceGroupName?: string;
}

@doc("Common further details about the policy resource for patch")
@discriminator("type")
model PolicyPatchResourceDetails {
  @doc("Type of the resource being provisioned.")
  type: OnboardingResourceType;
}

@doc("Details of the OnboardingService Device Registry Policy.")
@removed(Versions.v2025_05_01_preview)
model PatchDeviceRegistryPolicyResourceDetails
  extends PolicyPatchResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: OnboardingResourceType.DeviceRegistryDevice;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("Details of the OnboardingService Device Registry Namespace Policy.")
@added(Versions.v2024_12_01_preview)
@removed(Versions.v2025_05_01_preview)
model PatchDeviceRegistryNamespacePolicyResourceDetails
  extends PolicyPatchResourceDetails {
  @doc("The policy resource type for device registry namespace devices.")
  type: OnboardingResourceType.DeviceRegistryNamespaceDevice;

  @doc("The just-in-time connection properties for device registry namespace devices.")
  jitProperties?: DeviceRegistryNamespaceDeviceJitProperties;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("Details of the OnboardingService Hybrid Compute Machines Policy.")
@renamedFrom(
  Versions.v2024_12_01_preview,
  "PatchDiscoveryPolicyResourceDetails"
)
model PatchHybridComputePolicyResourceDetails
  extends PolicyPatchResourceDetails {
  @doc("The policy resource type for hybrid compute machines.")
  type: OnboardingResourceType.HybridComputeMachine;
}

@doc("The allocation rule patch model.")
@removed(Versions.v2025_05_01_preview)
@discriminator("type")
model AllocationRulePatch {
  @doc("Name of the allocation rule.")
  name?: string;

  @doc("Type of endpoint.")
  endpointType?: EndpointType;

  @doc("Type of the allocation rule.")
  type: AllocationType;
}

@doc("The allocation rule for evenly distributed allocation type.")
@removed(Versions.v2025_05_01_preview)
model PatchEvenlyDistributedAllocationRule extends AllocationRulePatch {
  @doc("Evenly distributed allocation type.")
  type: AllocationType.EvenlyDistributed;

  @doc("List of endpoints for evenly distributed allocation type.")
  @maxItems(10)
  @minItems(1)
  @Azure.ResourceManager.identifiers(#["resourceId"])
  endpoints?: Array<PatchAllocationEndpoint>;
}

@doc("Allocation endpoint.")
@removed(Versions.v2025_05_01_preview)
model PatchAllocationEndpoint {
  @doc("Resource id of the endpoint.")
  resourceId?: AllocationEndpointResourceId;

  @doc("host name of the endpoint.")
  hostName?: string;
}

// End Patch Models
