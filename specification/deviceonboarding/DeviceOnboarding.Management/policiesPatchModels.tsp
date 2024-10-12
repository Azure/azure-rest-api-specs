using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.DeviceOnboarding;
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

@added(Versions.v2024_11_01_preview)
@removed(Versions.v2024_12_01_preview)
@doc("The Discovery-based authentication rule for bootstrapping.")
model PatchDiscoveryBootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("The Fdo101-based authentication rule for bootstrapping.")
@added(Versions.v2024_12_01_preview)
model PatchFdo101BootstrapAuthenticationRule
  extends PatchBootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Fdo101;

  @visibility("read")
  @doc("Per policy public key to represent this policy")
  publicKey?: bytes;

  @doc("Ownership Voucher storage link")
  ownershipVoucherStorage?: OwnershipVoucherStorage;

  @doc("Endpoint for the rendezvous service, e.g. https://contoso-rv1.contoso.com")
  rendezvousEndpoint?: string;
}

@doc("Generic Ownership Voucher Storage type.")
@added(Versions.v2024_12_01_preview)
@discriminator("type")
model PatchOwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  type: OwnershipVoucherStorageType;
}

@doc("Storage Account Ownership Voucher Storage. Policy MI is used to access this storage")
@added(Versions.v2024_12_01_preview)
model PatchStorageAccountOwnershipVoucherStorage
  extends PatchOwnershipVoucherStorage {
  @doc("The Ownership Voucher Storage type.")
  type: OwnershipVoucherStorageType.AzureBlobStorage;

  @doc("The storage resource id")
  resourceId?: StorageAccountResourceId;

  @doc("Endpoint for the storage account") // TODO: determine correct example here
  containerUri?: string;
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
