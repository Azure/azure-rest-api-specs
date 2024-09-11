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

@armProviderNamespace
@service({
  title: "Microsoft.DeviceOnboarding",
})
@versioned(Versions)
namespace Microsoft.DeviceOnboarding;

/** Onboarding Service API versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-11-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource.")
model OnboardingService
  is Azure.ResourceManager.TrackedResource<OnboardingServiceProperties> {
  @doc("The name of the Provisioning Resource.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9-]{3,63}[a-zA-Z0-9]$")
  @key("onboardingServiceName")
  @segment("onboardingServices")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("Details of the EdgeProvisioning OnboardingService.")
model OnboardingServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The onboarding service device endpoints.")
  deviceEndpoints?: DeviceEndpoints;

  @doc("Selecting 'yes' will enable a Microsoft managed PKI to issue certificates. Setting up of the CA and policies for certificate management will be while defining the onboarding policy.")
  @visibility("read", "create")
  enableOperationalCertificates: YesNoOption;

  @doc("Allow public network access to private links.")
  @visibility("read", "create", "update")
  publicNetworkAccess?: EnableDisableOptions;

  @doc("The private endpoint connections.")
  @visibility("read")
  privateEndpointConnections?: Array<PrivateEndpointConnection>;
}

@doc("Yes/No Options for boolean values.")
union YesNoOption {
  string,

  @doc("Yes option.")
  Yes: "Yes",

  @doc("No option.")
  No: "No",
}

@doc("Device endpoints.")
model DeviceEndpoints {
  @doc("The default endpoint.")
  @visibility("read")
  default?: DeviceEndpoint;
}

@doc("The device endpoint.")
model DeviceEndpoint {
  @doc("Hostname of the Endpoint.")
  @visibility("read")
  hostName?: string;
}

@doc("Enabled/Disabled options for boolean values.")
union EnableDisableOptions {
  string,

  @doc("The boolean value indicating the option is enabled")
  Enabled: "Enabled",

  @doc("The boolean value indicating the option is disabled")
  Disabled: "Disabled",
}

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T>;

@armResourceOperations
interface OnboardingServices {
  get is ArmResourceRead<OnboardingService>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<OnboardingService>;
  delete is ArmResourceDeleteWithoutOkAsync<OnboardingService>;
  update is ArmResourcePatchSync<
    OnboardingService,
    OnboardingServiceProperties
  >;
  listByResourceGroup is ArmResourceListByParent<OnboardingService>;
  listBySubscription is ArmListBySubscription<OnboardingService>;
}

// Child resource: provisioning policy
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning policy resource.")
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
  status: EnableDisableOptions;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(1)
  allocations?: Array<AllocationRule>;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Further details about the policy resource")
  resourceDetails: PolicyResourceDetails;

  @doc("The identity the OnboardingService Policy will use. Must be from the list of enabled managed identities on the resource.")
  selectedIdentity?: SelectedIdentity;
}

@doc("Information on the selected identity. Can be SystemAssigned or UserAssigned.")
model SelectedIdentity {
  @doc("The type of identity.")
  type: SelectedIdentityType;

  @doc("Resource id of the UserAssigned identity.")
  resourceId?: SelectedIdentityResourceId;
}

@pattern("^/subscriptions/(.+?)/resourceGroups/(.+?)/providers/(.+)$")
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
  DeviceRegistryDevice: "Microsoft.DeviceRegistry/devices",

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

@doc("Details of the OnboardingService Discovery Policy.")
model DiscoveryPolicyResourceDetails extends PolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: OnboardingResourceType.HybridComputeMachine;
}

@doc("The authentication type for bootstrap.")
union BootstrapAuthenticationType {
  string,

  @doc("The X509 authentication type.")
  X509: "X509",

  @doc("The discovery authentication type.")
  Discovery: "Discovery",
  // PM: how does user understand this auth type & the device behavior/requirements
  // TODO name confirmation with PMs

  // @doc("The FDO authentication type.")
  // FDO,
}

// @doc("The FDO-based authentication rule for bootstrapping.")
// model FDOBootstrapAuthenticationRule extends BootstrapAuthenticationRule {
//   @doc("The type of authentication rule.")
//   type: BootstrapAuthenticationType.FDO;

//   @visibility("read")
//   publicKey?: bytes;

//   @doc("OV storage link")
//   ovStorage?: string;
//   // TODO: Determine if this is required field and can customers update this once created?
// }

@doc("The authentication rule for bootstrap.")
@discriminator("type")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType;
}

@doc("X509 Certificate.")
model X509Certificate {
  @doc("The certificate.")
  certificate: bytes;

  @doc("Thumbprint extracted from the certificate.")
  @visibility("read")
  thumbprint?: string;

  @doc("Expiry date for the certificate.")
  @visibility("read")
  expiryDate?: utcDateTime;
}

@doc("The x509-based authentication rule for bootstrapping.")
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

@doc("The Discovery-based authentication rule for bootstrapping.")
model DiscoveryBootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("The rule for Just-in-time connection.")
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
union EndpointType {
  string,

  @doc("Azure event grid broker.")
  MicrosoftEventGridNamespace: "Microsoft.EventGrid/namespaces",

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Type of allocation rule.")
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
model AllocationEndpoint {
  @doc("Resource id of the endpoint.")
  resourceId: AllocationEndpointResourceId;

  @doc("host name of the endpoint.")
  hostName: string;
}

@pattern("^/subscriptions/(.+?)/resourceGroups/(.+?)/providers/(.+)$")
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
//  @extension("x-ms-identifiers", ["resourceId"])
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
//  @extension("x-ms-identifiers", ["resourceId"])
//  endpoints: Array<AllocationEndpoint>;
//  // todo no optional (to be tested)
//}

@doc("The allocation rule for evenly distributed allocation type.")
model EvenlyDistributedAllocationRule extends AllocationRule {
  @doc("Evenly distributed allocation type.")
  type: AllocationType.EvenlyDistributed;

  @doc("List of endpoints for evenly distributed allocation type.")
  @maxItems(10)
  @minItems(1)
  @extension("x-ms-identifiers", ["resourceId"])
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
union SupportedKeyType {
  string,

  //@doc("Indicate the RSA key type.")
  //RSA,

  @doc("Indicate the ECC key type.")
  ECC: "ECC",
}

@doc("Supported issuing authority.")
union SupportedIssuingAuthority {
  string,

  // TODO: should we use FirstParty or match the PM spec and use MicrosoftManagedPKI?
  @doc("First party cert issuance.")
  FirstParty: "FirstParty",
}

@doc("The configuration for setting up a CA.")
model CaConfig {
  @doc("System-generated value for referencing the CA.")
  @visibility("read")
  name?: string;

  @doc("Certificate properties.")
  properties: CertificateProperties;
}

@doc("Certificate properties.")
model CertificateProperties {
  @doc("Crypto type: RSA or EC.")
  keyType: SupportedKeyType;

  @doc("Certificate subject.")
  @visibility("read")
  subject?: string;

  @doc("System-assigned validity period.")
  @visibility("read")
  @maxValue(366)
  @minValue(365)
  validityPeriodInDays?: int32;

  @doc("Certificate is valid not before this date. Format ISO8601. Generated based on on validity period.")
  @visibility("read")
  validityNotBefore?: utcDateTime;

  @doc("Certificate is valid not after this date. Format ISO8601. Generated based on validity period.")
  @visibility("read")
  validityNotAfter?: utcDateTime;
}

@doc("The configuration for setting up a policy.")
model CertPolicyConfig {
  @doc("The validity period in days.")
  @minValue(1)
  validityPeriodInDays: int32;
}

@doc("Certificate issuance configurations.")
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
model IdentityInfo {
  @doc("Certificate issuance settings.")
  certificateIssuance?: CertificateIssuanceRule; // For PKI

  @doc("Guid of the device template.")
  @visibility("read", "create")
  deviceTemplateId: string;

  @doc("Guid for static AAD group.")
  staticGroupId: string;

  //  @doc("Guid for MTLS Oauth Config.")
  //  @visibility("read", "create")
  //  mtlsOauthConfigurationId: string;

  //  @doc("Guid of the devices Tenant.")
  //  @visibility("read", "create")
  //  deviceTenantId: string;

  //@doc("The identity info to return to device.")
  //identityInfoForDevice?: DeviceIdentityInfo; // TODO check with Adarsh,Sekhar if this supports both HCI and ADR scenario
}

@doc("Resource metadata")
model ResourceMetadata {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is arbitrary JSON to provide custom attributes"
  @doc("Custom attributes")
  @visibility("read", "create")
  //  The typespec is not able to support List of Object datatype so we use Record<unknown> as datatype to generate the swagger file for now.
  //  However, this fails the providerhub generation (TypeError: Cannot read properties of undefined) hence all models are not generated.
  //  The workaround is to change the datatype of customAttributes to something like string.
  //  Or generate the swagger json file in typespec playground
  customAttributes?: Record<unknown>;
}

/** Patch Models */
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
  status?: EnableDisableOptions;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication?: PatchBootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(1)
  allocations?: Array<AllocationRulePatch>;

  @doc("Just-in-time rule to create the device resource.")
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

@doc("The Discovery-based authentication rule for bootstrapping.")
model PatchDiscoveryBootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("X509 Certificate.")
model PatchX509Certificate {
  @doc("The certificate.")
  certificate?: bytes;

  @doc("Thumbprint extracted from the certificate.")
  @visibility("read")
  thumbprint?: string;

  @doc("Expiry date for the certificate.")
  @visibility("read")
  expiryDate?: utcDateTime;
}

@doc("Information on the selected identity. Can be SystemAssigned or UserAssigned.")
model PatchSelectedIdentity {
  @doc("The type of identity.")
  type?: SelectedIdentityType;

  @doc("Resource id of the UserAssigned identity.")
  resourceId?: SelectedIdentityResourceId;
}

@doc("The rule for Just-in-time connection.")
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
model PatchDeviceRegistryPolicyResourceDetails
  extends PolicyPatchResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: OnboardingResourceType.DeviceRegistryDevice;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("Details of the OnboardingService Discovery Policy.")
model PatchDiscoveryPolicyResourceDetails extends PolicyPatchResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: OnboardingResourceType.HybridComputeMachine;
}

@doc("The allocation rule patch model.")
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
model PatchEvenlyDistributedAllocationRule extends AllocationRulePatch {
  @doc("Evenly distributed allocation type.")
  type: AllocationType.EvenlyDistributed;

  @doc("List of endpoints for evenly distributed allocation type.")
  @maxItems(10)
  @minItems(1)
  @extension("x-ms-identifiers", ["resourceId"])
  endpoints?: Array<PatchAllocationEndpoint>;
}

@doc("Allocation endpoint.")
model PatchAllocationEndpoint {
  @doc("Resource id of the endpoint.")
  resourceId?: AllocationEndpointResourceId;

  @doc("host name of the endpoint.")
  hostName?: string;
}

// End Patch Models

@armResourceOperations
interface Policies {
  get is ArmResourceRead<Policy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Policy>;
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;
  @parameterVisibility
  update is ArmCustomPatchAsync<Policy, PolicyPatch>;
  listByParent is ArmResourceListByParent<Policy>;
}

// Extension resource: device state

@singleton
@doc("The provisioning state of a device.")
model DeviceState
  is Azure.ResourceManager.ExtensionResource<DeviceStateProperties> {
  @doc("The default DeviceState, singleton extension resource used to represent the state of the device it extends.")
  @segment("deviceStates")
  @key
  @path
  @pattern("^[a-zA-Z0-9-]{3,127}[a-zA-Z0-9]$")
  name: string;
}

@pattern("^/subscriptions/(.+?)/resourceGroups/(.+?)/providers/(.+?)/onboardingServices/(.+?)/policies/(.+)$")
scalar PolicyResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.DeviceOnboarding/onboardingServices/policies",
    }
  ]>;

@doc("Representation of a previously allocated endpoint")
model AllocatedEndpoint {
  @doc("Name of the endpoint.")
  name: string;

  @doc("Type of the endpoint.")
  endpointType: EndpointType;

  @doc("Hostname of the endpoint.")
  hostName: string;
}

@doc("Details of the DeviceState")
model DeviceStateProperties {
  @visibility("read", "create")
  @doc("Unique identifier for the device. Allow alphanumeric and '-', '.', '_', ':' only. Last character can only be alphanumeric and '-'")
  @maxLength(128)
  @pattern("^([a-z0-9-._:]{0,127}[a-z0-9-])$")
  registrationId: string;

  @visibility("read", "create", "update")
  @doc("Onboarding status of the resource this DeviceState extends")
  onboardingStatus: OnboardingStatus;

  @doc("Indicates if the device is enabled for discovery")
  discoveryEnabled?: YesNoOption;

  @doc("The onboarding policy resource id")
  policyResourceId: PolicyResourceId;

  @doc("Array of previously allocated endpoints")
  @maxItems(1)
  @extension("x-ms-identifiers", ["name"])
  allocatedEndpoints?: Array<AllocatedEndpoint>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  // @visibility("read")
  // @doc("TTL until the device can be discovered.")
  // discoverableUntilDate?: string;
}

@doc("The current onboarding status.")
union OnboardingStatus {
  string,

  @doc("Onboarding is still pending")
  Pending: "Pending",

  @doc("The resource has been onboarded")
  Provisioned: "Provisioned",

  @doc("Onboarding has failed")
  Failed: "Failed",
}

@armResourceOperations
interface DeviceStates {
  get is ArmResourceRead<DeviceState>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DeviceState>;
  delete is ArmResourceDeleteSync<DeviceState>;
  update is ArmResourcePatchSync<DeviceState, DeviceStateProperties>;
  listByParent is ArmResourceListByParent<DeviceState>;
}
