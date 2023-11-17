import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Autorest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.FairfieldGardens")
@service({
  title: "Microsoft.FairfieldGardens",
  version: "2023-12-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.FairfieldGardens;

interface Operations extends Azure.ResourceManager.Operations {}

// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource.")
model ProvisioningResource is TrackedResource<ProvisioningResourceProperties> {
  @doc("The name of the Provisioning Resource.")
  @maxLength(128)
  @pattern("^[a-zA-Z0-9-]{3,127}[a-zA-Z0-9]$")
  @key("provisioningResourceName")
  @segment("provisioningResources")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("Details of the EdgeProvisioning ProvisioningResource.")
model ProvisioningResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("The provisioning service endpoints.")
  deviceEndpoints?: DeviceEndpoints;

  @doc("Selecting 'yes' will enable a Microsoft managed PKI to issue certificates. Setting up of the CA and policies for certificate management will be while defining the bumblebee provisioning policy.")
  @visibility("read", "create")
  enableOperationalCertificates: boolean;
}

@doc("Device endpoints.")
model DeviceEndpoints { // TODO: follow up with DP and PM on the definition of the endpoints for ignite
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

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T>;

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating,

  @doc("Resource is being updated.")
  Updating,

  @doc("Resource is being deleted.")
  Deleting,
}

@armResourceOperations
interface ProvisioningResources {
  get is ArmResourceRead<ProvisioningResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisioningResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ProvisioningResource>;
  update is ArmResourcePatchSync<
    ProvisioningResource,
    ProvisioningResourceProperties
  >;
  listByResourceGroup is ArmResourceListByParent<ProvisioningResource>;
  listBySubscription is ArmListBySubscription<ProvisioningResource>;
}

// Child resource: provisioning policy
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning policy resource.")
@parentResource(ProvisioningResource)
model ProvisioningPolicy is TrackedResource<ProvisioningPolicyProperties> {
  @doc("The name of the Provisioning Policy tracked resource.")
  @maxLength(128)
  @pattern("^[a-zA-Z0-9-]{3,127}[a-zA-Z0-9]$")
  @key("provisioningPolicyName")
  @segment("provisioningPolicies")
  @path
  name: string;
}

@doc("Details of the ProvisioningService ProvisioningPolicy.")
model ProvisioningPolicyProperties {
  @doc("Description of the policy")
  description?: string;

  @doc("The policy status")
  status: boolean;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(1)
  allocations?: Array<AllocationRule>;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Further details about the policy resource")
  resourceDetails: ProvisioningPolicyResourceDetails;
}

@doc("Provisioning policies model for patch.")
model ProvisioningPolicyPatchProperties {
  @doc("Description of the policy")
  description?: string;

  @doc("The policy status")
  status?: boolean;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication?: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(1)
  allocations?: Array<AllocationRule>;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRuleUpdate;

  @doc("Further details about the policy resource")
  resourceDetails?: ProvisioningPolicyResourceDetails;
}

@doc("The rule for Just-in-time connection.")
model JitRuleUpdate {
  @doc("The priority of the policy. Should be greater than 0.")
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

@doc("Type of resource being provisioned.")
enum ProvisioningResourceType {
  @doc("Azure device registry device. Microsoft.DeviceRegistry/devices")
  DeviceRegistryDevice: "Microsoft.DeviceRegistry/devices",

  @doc("Arc enabled device. Microsoft.HybridCompute/machines")
  HybridComputeMachine: "Microsoft.HybridCompute/machines",
}

@doc("Common further details about the policy resource")
@discriminator("type")
model ProvisioningPolicyResourceDetails {
  @doc("Type of the resource being provisioned.")
  type: ProvisioningResourceType;
}

@doc("Details of the ProvisioningService Device Registry ProvisioningPolicy.")
model DeviceRegistryProvisioningPolicyResourceDetails
  extends ProvisioningPolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: ProvisioningResourceType.DeviceRegistryDevice;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  // make this property polymorphic based on ProvisioningResourceType.
  // The current definition of the identity Info is for ADR resource type.
  // AadIdentityInfo

  @doc("Resource metadata.")
  resourceMetadata?: ResourceMetadata; // for customer to label the devices
}

@doc("Details of the ProvisioningService Discovery ProvisioningPolicy.")
model DiscoveryProvisioningPolicyResourceDetails
  extends ProvisioningPolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: ProvisioningResourceType.HybridComputeMachine;
}

@doc("The authentication type for bootstrap.")
enum BootstrapAuthenticationType {
  @doc("The X509 authentication type.")
  X509,

  @doc("The discovery authentication type.")
  Discovery,
  // PM: how does user understand this auth type & the device behavior/requirements
  // TODO name confirmation with PMs
}

@doc("The authentication rule for bootstrap.")
@discriminator("type")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType;
}

@doc("X509 Certificate.")
model X509Certificate {
  @doc("The certificate.")
  certificate: string;

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
  priority: int32;

  // TODO: is priority required property.
  // can we avoid requirement for uniquenes
  // how can the customer swap priority for policies
  // alternate option1: Consider Provisioning Policy properties as an array
  // alternate option2: Keep the priority as separate concept outside of policy
  // Investigate options from other resources

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
enum EndpointType {
  @doc("Azure event grid broker.")
  MicrosoftEventGridNamespace: "Microsoft.EventGrid/namespaces",

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Type of allocation rule.")
enum AllocationType {
  @doc("Evenly distributed allocation.")
  EvenlyDistributed,

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
  extends ResourceIdentifier<[
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
enum SupportedKeyType {
  //@doc("Indicate the RSA key type.")
  //RSA,

  @doc("Indicate the ECC key type.")
  ECC,
}

@doc("Supported issuing authority.")
enum SupportedIssuingAuthority {
  // TODO: should we use FirstParty or match the PM spec and use MicrosoftManagedPKI?
  @doc("First party cert issuance.")
  FirstParty,
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

@doc("The provisioning rule.")
model ProvisioningRule {
  @doc("Type of the resource being provisioned.")
  type: ProvisioningResourceType;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo;

  @doc("Resource metadata.")
  @maxLength(200)
  resourceMetadata?: string; // for customer to label the devices
}

@doc("Resource metadata")
model ResourceMetadata {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is arbitrary JSON to provide custom attributes"
  @doc("Custom attributes")
  @visibility("read", "create")
  customAttributes?: Record<unknown>;
}

@armResourceOperations
interface ProvisioningPolicies {
  get is ArmResourceRead<ProvisioningPolicy>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ProvisioningPolicy>;
  delete is ArmResourceDeleteSync<ProvisioningPolicy>;
  @parameterVisibility("read")
  update is ArmResourcePatchAsync<
    ProvisioningPolicy,
    ProvisioningPolicyPatchProperties
  >;
  listByParent is ArmResourceListByParent<ProvisioningPolicy>;
}

// Extension resource: device provisioning state

@singleton
@doc("The provisioning state of a device.")
model DeviceProvisioningState
  is ExtensionResource<DeviceProvisioningStateProperties> {
  @doc("The default DeviceProvisioningState, singleton extension resource used to represent the state of the device it extends.")
  @segment("deviceProvisioningStates")
  @key
  @path
  name: string;
}

@pattern("^/subscriptions/(.+?)/resourceGroups/(.+?)/providers/(.+?)/provisioningResources/(.+?)/provisioningPolicies/(.+)$")
scalar ProvisioningPolicyResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.FairfieldGardens/ProvisioningResources/ProvisioningPolicies",
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

@doc("Details of the DeviceProvisioningState")
model DeviceProvisioningStateProperties {
  @visibility("read", "create")
  @doc("Unique identifier for the device. Allow alphanumeric and '-', '.', '_', ':' only. Last character can only be alphanumeric and '-'")
  @maxLength(128)
  @pattern("^([a-z0-9-._:]{0,127}[a-z0-9-])$")
  registrationId: string;

  @visibility("read", "create", "update")
  @doc("Onboarding status of the resource this DeviceProvisioningState extends")
  onboardingStatus: OnboardingStatus;

  @doc("Indicates if the device is enabled for discovery")
  discoveryEnabled?: boolean = false;

  @doc("The provisioning policy resource id")
  provisioningPolicyResourceId: ProvisioningPolicyResourceId;

  @doc("Array of previously allocated endpoints")
  @maxItems(1)
  @extension("x-ms-identifiers", ["name"])
  allocatedEndpoints?: Array<AllocatedEndpoint>;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("The current onboarding status.")
enum OnboardingStatus {
  @doc("Onboarding is still pending")
  Pending,

  @doc("The resource has been onboarded")
  Provisioned,

  @doc("Onboarding has failed")
  Failed,
}

@armResourceOperations
interface DeviceProvisioningStates {
  get is ArmResourceRead<DeviceProvisioningState>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<DeviceProvisioningState>;
  delete is ArmResourceDeleteSync<DeviceProvisioningState>;
  update is ArmResourcePatchSync<
    DeviceProvisioningState,
    DeviceProvisioningStateProperties
  >;
  listByParent is ArmResourceListByParent<DeviceProvisioningState>;
}
