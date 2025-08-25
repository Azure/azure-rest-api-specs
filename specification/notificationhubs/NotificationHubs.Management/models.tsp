import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NotificationHubs;

/**
 * Namespace SKU name.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Free: "Free",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
}

/**
 * Defines values for AccessRights.
 */
union AccessRights {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Manage: "Manage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Send: "Send",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Listen: "Listen",
}

/**
 * Type of Shared Access Policy Key (primary or secondary).
 */
union PolicyKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrimaryKey: "PrimaryKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SecondaryKey: "SecondaryKey",
}

/**
 * Defines values for OperationProvisioningState.
 */
union OperationProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Namespace status.
 */
union NamespaceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * Defines values for NamespaceType.
 */
union NamespaceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Messaging: "Messaging",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotificationHub: "NotificationHub",
}

/**
 * Allowed replication region
 */
union ReplicationRegion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WestUs2: "WestUs2",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NorthEurope: "NorthEurope",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AustraliaEast: "AustraliaEast",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BrazilSouth: "BrazilSouth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SouthEastAsia: "SouthEastAsia",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SouthAfricaNorth: "SouthAfricaNorth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Namespace SKU name.
 */
union ZoneRedundancyPreference {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * State of Private Endpoint Connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatingByProxy: "UpdatingByProxy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeletingByProxy: "DeletingByProxy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
}

/**
 * State of Private Link Connection.
 */
union PrivateLinkConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
}

/**
 * Type of public network access.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Parameters supplied to the Check Name Availability for Namespace and
 * NotificationHubs.
 */
model CheckAvailabilityParameters {
  /**
   * Gets resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets resource name
   */
  @minLength(1)
  name: string;

  /**
   * Gets resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Gets or sets resource location
   */
  location?: string;

  /**
   * Gets or sets resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Not used and deprecated since API version 2023-01-01-preview
   */
  isAvailiable?: boolean;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;
}

/**
 * The Sku description for a namespace
 */
model Sku {
  /**
   * Namespace SKU name.
   */
  name: SkuName;

  /**
   * Gets or sets the tier of particular sku
   */
  tier?: string;

  /**
   * Gets or sets the Sku size
   */
  size?: string;

  /**
   * Gets or sets the Sku Family
   */
  family?: string;

  /**
   * Gets or sets the capacity of the resource
   */
  capacity?: int32;
}

/**
 * Description of a CheckAvailability resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CheckAvailabilityResult
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Gets or sets true if the name is available and can be used to
   * create new Namespace/NotificationHub. Otherwise false.
   */
  isAvailiable?: boolean;

  /**
   * Deprecated - only for compatibility.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Deprecated - only for compatibility.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * NotificationHub properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NotificationHubProperties {
  /**
   * Gets or sets the NotificationHub name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;

  /**
   * Gets or sets the RegistrationTtl of the created NotificationHub
   */
  registrationTtl?: string;

  /**
   * Gets or sets the AuthorizationRules of the created NotificationHub
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["keyName"])
  authorizationRules?: SharedAccessAuthorizationRuleProperties[];

  /**
   * Description of a NotificationHub ApnsCredential.
   */
  apnsCredential?: ApnsCredential;

  /**
   * Description of a NotificationHub WnsCredential.
   */
  wnsCredential?: WnsCredential;

  /**
   * Description of a NotificationHub GcmCredential.
   */
  gcmCredential?: GcmCredential;

  /**
   * Description of a NotificationHub MpnsCredential.
   */
  mpnsCredential?: MpnsCredential;

  /**
   * Description of a NotificationHub AdmCredential.
   */
  admCredential?: AdmCredential;

  /**
   * Description of a NotificationHub BaiduCredential.
   */
  baiduCredential?: BaiduCredential;

  /**
   * Description of a NotificationHub BrowserCredential.
   */
  browserCredential?: BrowserCredential;

  /**
   * Description of a NotificationHub XiaomiCredential.
   */
  xiaomiCredential?: XiaomiCredential;

  /**
   * Description of a NotificationHub FcmV1Credential.
   */
  fcmV1Credential?: FcmV1Credential;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  dailyMaxActiveDevices?: int64;
}

/**
 * SharedAccessAuthorizationRule properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SharedAccessAuthorizationRuleProperties {
  /**
   * Gets or sets the rights associated with the rule.
   */
  rights: AccessRights[];

  /**
   * Gets a base64-encoded 256-bit primary key for signing and
   * validating the SAS token.
   */
  @secret
  primaryKey?: string;

  /**
   * Gets a base64-encoded 256-bit primary key for signing and
   * validating the SAS token.
   */
  @secret
  secondaryKey?: string;

  /**
   * Gets a string that describes the authorization rule.
   */
  @visibility(Lifecycle.Read)
  keyName?: string;

  /**
   * Gets the last modified time for this rule
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedTime?: utcDateTime;

  /**
   * Gets the created time for this rule
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Gets a string that describes the claim type
   */
  @visibility(Lifecycle.Read)
  claimType?: string;

  /**
   * Gets a string that describes the claim value
   */
  @visibility(Lifecycle.Read)
  claimValue?: string;

  /**
   * Gets the revision number for the rule
   */
  @visibility(Lifecycle.Read)
  revision?: int32;
}

/**
 * Description of a NotificationHub ApnsCredential.
 */
model ApnsCredential {
  /**
   * Description of a NotificationHub ApnsCredential.
   */
  properties: ApnsCredentialProperties;
}

/**
 * Description of a NotificationHub ApnsCredential.
 */
model ApnsCredentialProperties {
  /**
   * Gets or sets the APNS certificate.
   */
  @secret
  apnsCertificate?: string;

  /**
   * Gets or sets the certificate key.
   */
  @secret
  certificateKey?: string;

  /**
   * Gets or sets the endpoint of this credential.
   */
  @minLength(1)
  @secret
  endpoint: string;

  /**
   * Gets or sets the APNS certificate Thumbprint
   */
  @secret
  thumbprint?: string;

  /**
   * Gets or sets a 10-character key identifier (kid) key, obtained from
   * your developer account
   */
  @secret
  keyId?: string;

  /**
   * Gets or sets the name of the application
   */
  @secret
  appName?: string;

  /**
   * Gets or sets the issuer (iss) registered claim key, whose value is
   * your 10-character Team ID, obtained from your developer account
   */
  @secret
  appId?: string;

  /**
   * Gets or sets provider Authentication Token, obtained through your
   * developer account
   */
  @secret
  token?: string;
}

/**
 * Description of a NotificationHub WnsCredential.
 */
model WnsCredential {
  /**
   * Description of a NotificationHub WnsCredential.
   */
  properties: WnsCredentialProperties;
}

/**
 * Description of a NotificationHub WnsCredential.
 */
model WnsCredentialProperties {
  /**
   * Gets or sets the package ID for this credential.
   */
  @secret
  packageSid?: string;

  /**
   * Gets or sets the secret key.
   */
  @secret
  secretKey?: string;

  /**
   * Gets or sets the Windows Live endpoint.
   */
  @secret
  windowsLiveEndpoint?: string;

  /**
   * Ges or sets the WNS Certificate Key.
   */
  @secret
  certificateKey?: string;

  /**
   * Gets or sets the WNS Certificate.
   */
  @secret
  wnsCertificate?: string;
}

/**
 * Description of a NotificationHub GcmCredential.
 */
model GcmCredential {
  /**
   * Description of a NotificationHub GcmCredential.
   */
  properties: GcmCredentialProperties;
}

/**
 * Description of a NotificationHub GcmCredential.
 */
model GcmCredentialProperties {
  /**
   * Gets or sets the GCM endpoint.
   */
  @secret
  gcmEndpoint?: string;

  /**
   * Gets or sets the Google API key.
   */
  @minLength(1)
  @secret
  googleApiKey: string;
}

/**
 * Description of a NotificationHub MpnsCredential.
 */
model MpnsCredential {
  /**
   * Description of a NotificationHub MpnsCredential.
   */
  properties: MpnsCredentialProperties;
}

/**
 * Description of a NotificationHub MpnsCredential.
 */
model MpnsCredentialProperties {
  /**
   * Gets or sets the MPNS certificate.
   */
  @minLength(1)
  @secret
  mpnsCertificate: string;

  /**
   * Gets or sets the certificate key for this credential.
   */
  @minLength(1)
  @secret
  certificateKey: string;

  /**
   * Gets or sets the MPNS certificate Thumbprint
   */
  @minLength(1)
  @secret
  thumbprint: string;
}

/**
 * Description of a NotificationHub AdmCredential.
 */
model AdmCredential {
  /**
   * Description of a NotificationHub AdmCredential.
   */
  properties: AdmCredentialProperties;
}

/**
 * Description of a NotificationHub AdmCredential.
 */
model AdmCredentialProperties {
  /**
   * Gets or sets the client identifier.
   */
  @minLength(1)
  @secret
  clientId: string;

  /**
   * Gets or sets the credential secret access key.
   */
  @minLength(1)
  @secret
  clientSecret: string;

  /**
   * Gets or sets the URL of the authorization token.
   */
  @minLength(1)
  @secret
  authTokenUrl: string;
}

/**
 * Description of a NotificationHub BaiduCredential.
 */
model BaiduCredential {
  /**
   * Description of a NotificationHub BaiduCredential.
   */
  properties: BaiduCredentialProperties;
}

/**
 * Description of a NotificationHub BaiduCredential.
 */
model BaiduCredentialProperties {
  /**
   * Gets or sets baidu Api Key.
   */
  @minLength(1)
  @secret
  baiduApiKey: string;

  /**
   * Gets or sets baidu Endpoint.
   */
  @minLength(1)
  @secret
  baiduEndPoint: string;

  /**
   * Gets or sets baidu Secret Key
   */
  @minLength(1)
  @secret
  baiduSecretKey: string;
}

/**
 * Description of a NotificationHub BrowserCredential.
 */
model BrowserCredential {
  /**
   * Description of a NotificationHub BrowserCredential.
   */
  properties: BrowserCredentialProperties;
}

/**
 * Description of a NotificationHub BrowserCredential.
 */
model BrowserCredentialProperties {
  /**
   * Gets or sets web push subject.
   */
  @minLength(1)
  @secret
  subject: string;

  /**
   * Gets or sets VAPID private key.
   */
  @minLength(1)
  @secret
  vapidPrivateKey: string;

  /**
   * Gets or sets VAPID public key.
   */
  @minLength(1)
  @secret
  vapidPublicKey: string;
}

/**
 * Description of a NotificationHub XiaomiCredential.
 */
model XiaomiCredential {
  /**
   * Description of a NotificationHub XiaomiCredentialProperties.
   */
  properties: XiaomiCredentialProperties;
}

/**
 * Description of a NotificationHub XiaomiCredentialProperties.
 */
model XiaomiCredentialProperties {
  /**
   * Gets or sets app secret.
   */
  @secret
  appSecret?: string;

  /**
   * Gets or sets xiaomi service endpoint.
   */
  @secret
  endpoint?: string;
}

/**
 * Description of a NotificationHub FcmV1Credential.
 */
model FcmV1Credential {
  /**
   * Description of a NotificationHub FcmV1Credential.
   */
  properties: FcmV1CredentialProperties;
}

/**
 * Description of a NotificationHub FcmV1Credential.
 */
model FcmV1CredentialProperties {
  /**
   * Gets or sets client email.
   */
  @minLength(1)
  @secret
  clientEmail: string;

  /**
   * Gets or sets private key.
   */
  @minLength(1)
  @secret
  privateKey: string;

  /**
   * Gets or sets project id.
   */
  @minLength(1)
  @secret
  projectId: string;
}

/**
 * Patch parameter for NamespaceResource.
 */
model NotificationHubPatchParameters {
  /**
   * NotificationHub properties.
   */
  properties?: NotificationHubProperties;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Description of a NotificationHub Resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DebugSendResponse
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Result of DebugSend operations.
   */
  properties?: DebugSendResult;

  /**
   * Deprecated - only for compatibility.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Deprecated - only for compatibility.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Result of DebugSend operations.
 */
model DebugSendResult {
  /**
   * Gets or sets successful send
   */
  @visibility(Lifecycle.Read)
  success?: int64;

  /**
   * Gets or sets send failure
   */
  @visibility(Lifecycle.Read)
  failure?: int64;

  /**
   * Gets or sets actual failure description
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  results?: RegistrationResult[];
}

/**
 * Notification result for a single registration.
 */
model RegistrationResult {
  /**
   * PNS type.
   */
  @visibility(Lifecycle.Read)
  applicationPlatform?: string;

  /**
   * PNS handle.
   */
  @visibility(Lifecycle.Read)
  pnsHandle?: string;

  /**
   * Registration id.
   */
  @visibility(Lifecycle.Read)
  registrationId?: string;

  /**
   * Notification outcome.
   */
  @visibility(Lifecycle.Read)
  outcome?: string;
}

/**
 * Response for the POST request that returns Namespace or NotificationHub access keys (connection strings).
 */
model ResourceListKeys {
  /**
   * Gets or sets primaryConnectionString of the AuthorizationRule.
   */
  @visibility(Lifecycle.Read)
  @secret
  primaryConnectionString?: string;

  /**
   * Gets or sets secondaryConnectionString of the created
   * AuthorizationRule
   */
  @visibility(Lifecycle.Read)
  @secret
  secondaryConnectionString?: string;

  /**
   * Gets or sets primaryKey of the created AuthorizationRule.
   */
  @visibility(Lifecycle.Read)
  @secret
  primaryKey?: string;

  /**
   * Gets or sets secondaryKey of the created AuthorizationRule
   */
  @visibility(Lifecycle.Read)
  @secret
  secondaryKey?: string;

  /**
   * Gets or sets keyName of the created AuthorizationRule
   */
  @visibility(Lifecycle.Read)
  keyName?: string;
}

/**
 * Namespace / NotificationHub Regenerate Keys request.
 */
model PolicyKeyResource {
  /**
   * Type of Shared Access Policy Key (primary or secondary).
   */
  policyKey: PolicyKeyType;
}

/**
 * Description of a NotificationHub PNS Credentials. This is a response of the POST requests that return namespace or hubs
 * PNS credentials.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PnsCredentialsResource
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Collection of Notification Hub or Notification Hub Namespace PNS credentials.
   */
  properties?: PnsCredentials;

  /**
   * Deprecated - only for compatibility.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Deprecated - only for compatibility.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Collection of Notification Hub or Notification Hub Namespace PNS credentials.
 */
model PnsCredentials {
  /**
   * Description of a NotificationHub AdmCredential.
   */
  admCredential?: AdmCredential;

  /**
   * Description of a NotificationHub ApnsCredential.
   */
  apnsCredential?: ApnsCredential;

  /**
   * Description of a NotificationHub BaiduCredential.
   */
  baiduCredential?: BaiduCredential;

  /**
   * Description of a NotificationHub BrowserCredential.
   */
  browserCredential?: BrowserCredential;

  /**
   * Description of a NotificationHub GcmCredential.
   */
  gcmCredential?: GcmCredential;

  /**
   * Description of a NotificationHub MpnsCredential.
   */
  mpnsCredential?: MpnsCredential;

  /**
   * Description of a NotificationHub WnsCredential.
   */
  wnsCredential?: WnsCredential;

  /**
   * Description of a NotificationHub XiaomiCredential.
   */
  xiaomiCredential?: XiaomiCredential;

  /**
   * Description of a NotificationHub FcmV1Credential.
   */
  fcmV1Credential?: FcmV1Credential;
}

/**
 * Represents namespace properties.
 */
model NamespaceProperties {
  /**
   * Name of the Notification Hubs namespace. This is immutable property, set automatically
   * by the service when the namespace is created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Defines values for OperationProvisioningState.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: OperationProvisioningState;

  /**
   * Namespace status.
   */
  status?: NamespaceStatus;

  /**
   * Gets or sets whether or not the namespace is currently enabled.
   */
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  /**
   * Gets or sets whether or not the namespace is set as Critical.
   */
  @visibility(Lifecycle.Read)
  critical?: boolean;

  /**
   * Namespace subscription id.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * Region. The value is always set to the same value as Namespace.Location, so we are deprecating
   * this property.
   */
  @visibility(Lifecycle.Read)
  region?: string;

  /**
   * Azure Insights Metrics id.
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * Time when the namespace was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Time when the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Defines values for NamespaceType.
   */
  namespaceType?: NamespaceType;

  /**
   * Allowed replication region
   */
  replicationRegion?: ReplicationRegion;

  /**
   * Namespace SKU name.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundancy?: ZoneRedundancyPreference = ZoneRedundancyPreference.Disabled;

  /**
   * A collection of network authorization rules.
   */
  networkAcls?: NetworkAcls;

  /**
   * Collection of Notification Hub or Notification Hub Namespace PNS credentials.
   */
  pnsCredentials?: PnsCredentials;

  /**
   * Gets or sets endpoint you can use to perform NotificationHub
   * operations.
   */
  @visibility(Lifecycle.Read)
  serviceBusEndpoint?: string;

  /**
   * Private Endpoint Connections for namespace
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionResource[];

  /**
   * Gets or sets scaleUnit where the namespace gets created
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scaleUnit?: string;

  /**
   * Deprecated.
   */
  dataCenter?: string;

  /**
   * Type of public network access.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;
}

/**
 * A collection of network authorization rules.
 */
model NetworkAcls {
  /**
   * List of IP rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IpRule[];

  /**
   * A default (public Internet) network authorization rule, which contains rights if no other network rule matches.
   */
  publicNetworkRule?: PublicInternetAuthorizationRule;
}

/**
 * A network authorization rule that filters traffic based on IP address.
 */
model IpRule {
  /**
   * IP mask.
   */
  @minLength(1)
  ipMask: string;

  /**
   * List of access rights.
   */
  rights: AccessRights[];
}

/**
 * A default (public Internet) network authorization rule, which contains rights if no other network rule matches.
 */
model PublicInternetAuthorizationRule {
  /**
   * List of access rights.
   */
  rights: AccessRights[];
}

/**
 * Private Endpoint Connection properties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * State of Private Endpoint Connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  /**
   * Represents a Private Endpoint that is connected to Notification Hubs namespace using Private Endpoint Connection.
   */
  privateEndpoint?: RemotePrivateEndpointConnection;

  /**
   * List of group ids. For Notification Hubs, it always contains a single "namespace" element.
   */
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * State of the Private Link Service connection.
   */
  privateLinkServiceConnectionState?: RemotePrivateLinkServiceConnectionState;
}

/**
 * Represents a Private Endpoint that is connected to Notification Hubs namespace using Private Endpoint Connection.
 */
model RemotePrivateEndpointConnection {
  /**
   * ARM resource ID of the Private Endpoint. This may belong to different subscription and resource group than a Notification Hubs namespace.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * State of the Private Link Service connection.
 */
model RemotePrivateLinkServiceConnectionState {
  /**
   * State of Private Link Connection.
   */
  status?: PrivateLinkConnectionStatus;

  /**
   * Human-friendly description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Human-friendly description of required actions.
   */
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * Patch parameter for NamespaceResource.
 */
model NamespacePatchParameters {
  /**
   * The Sku description for a namespace
   */
  sku?: Sku;

  /**
   * Represents namespace properties.
   */
  properties?: NamespaceProperties;

  /**
   * Dictionary of <string>
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Optional operation properties.
 */
model OperationProperties {
  /**
   * Optional service specification used in Operations API.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Optional service specification used in Operations API.
 */
model ServiceSpecification {
  /**
   * Log specifications.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: LogSpecification[];

  /**
   * Metric specification.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name", "unit"])
  metricSpecifications?: MetricSpecification[];
}

/**
 * A single log category specification.
 */
model LogSpecification {
  /**
   * Name of the log category.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Display name of the log category.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Duration of data written to a single blob.
   */
  @visibility(Lifecycle.Read)
  blobDuration?: string;

  /**
   * Category group for the log specification.
   */
  categoryGroups?: string[];
}

/**
 * A metric specification.
 */
model MetricSpecification {
  /**
   * Metric name / id.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * User-visible metric name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description of the metric.
   */
  @visibility(Lifecycle.Read)
  displayDescription?: string;

  /**
   * Metric unit.
   */
  @visibility(Lifecycle.Read)
  unit?: string;

  /**
   * Type of the aggregation (Average, Minimum, Maximum, Total or Count).
   */
  @visibility(Lifecycle.Read)
  aggregationType?: string;

  /**
   * List of availabilities.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  availabilities?: Availability[];

  /**
   * List of supported time grain types.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedTimeGrainTypes?: string[];

  /**
   * The matching regex pattern to be applied to the field pointed by the "metricsFilterPathSelector" flag in the ARM manifest.
   */
  @visibility(Lifecycle.Read)
  metricFilterPattern?: string;

  /**
   * Optional property. If set to true, then zero will be returned for time duration where no metric is emitted / published.
   */
  @visibility(Lifecycle.Read)
  fillGapWithZero?: boolean;
}

/**
 * Represents metric availability (part of RP operation descriptions).
 */
model Availability {
  /**
   * Time grain of the availability.
   */
  @visibility(Lifecycle.Read)
  timeGrain?: string;

  /**
   * Duration of the availability blob.
   */
  @visibility(Lifecycle.Read)
  blobDuration?: string;
}

/**
 * Represents properties of Private Link Resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * A Group Id for Private Link. For Notification Hubs, it is always set to "namespace".
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Required members. For Notification Hubs, it's always a collection with a single "namespace" item.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * Required DNS zone names. For Notification Hubs, it contains two CNames for Service Bus and Notification Hubs zones.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

/**
 * Part of Private Endpoint description that stores information about a connection between Private Endpoint and Notification Hubs namespace.
 * This is internal class, not visible to customers, and we use it only to discover the link identifier.
 */
model ConnectionDetails {
  /**
   * A unique ID of the connection. This is not the ARM id, but rather an internal identifier set by the Networking RP. Notification Hubs code
   * does not analyze it.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * IP address of the Private Endpoint. This is not used by Notification Hubs.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * Link identifier. This is a string representation of an integer that is also encoded in every IPv6 frame received by Front Door,
   * and we use it to create implicit authorization rule that allows connection from the associated Private Endpoint.
   */
  @visibility(Lifecycle.Read)
  linkIdentifier?: string;

  /**
   * Group name. Always "namespace" for Notification Hubs.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Member name. Always "namespace" for Notification Hubs.
   */
  @visibility(Lifecycle.Read)
  memberName?: string;
}

/**
 * Represents a connectivity information to Notification Hubs namespace. This is part of PrivateLinkService proxy that tell
 * the Networking RP how to connect to the Notification Hubs namespace.
 */
model GroupConnectivityInformation {
  /**
   * Group id. Always set to "namespace".
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Member name. Always set to "namespace".
   */
  @visibility(Lifecycle.Read)
  memberName?: string;

  /**
   * List of customer-visible domain names that point to a Notification Hubs namespace.
   */
  @visibility(Lifecycle.Read)
  customerVisibleFqdns?: string[];

  /**
   * One of the domain name from the customer-visible names; this is used internally by Private Link service to make connection to Notification Hubs
   * namespace.
   */
  @visibility(Lifecycle.Read)
  internalFqdn?: string;

  /**
   * Not used by Notification Hubs.
   */
  @visibility(Lifecycle.Read)
  redirectMapId?: string;

  /**
   * ARM region for Private Link Service. We use the region that contains the connected Notification Hubs namespace.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceArmRegion?: string;
}

/**
 * A customer-visible sub-resource of Private Endpoint, which describe the connection between Private Endpoint and Notification Hubs namespace.
 */
model PrivateLinkServiceConnection {
  /**
   * Name of the Private Link Service connection.
   */
  name?: string;

  /**
   * List of group ids. Always contains a single element - "namespace" - for Notification Hub Namespace.
   */
  groupIds?: string[];

  /**
   * Request message provided by the user that created the connection. This is usually used when the connection requires manual approval.
   */
  requestMessage?: string;
}

model OperationListResult is Azure.Core.Page<Operation>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OperationDisplay {
  /** 
  The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /** 
    The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
     */
  @visibility(Lifecycle.Read)
  resource?: string;

  /** 
    The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
     */
  @visibility(Lifecycle.Read)
  operation?: string;

  /** The short, localized friendly description of the operation; suitable for tool tips and detailed views. */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Result of the request to list SQL operations.
 */
model Operation {
  /** 
    The name of the operation being performed on this particular object."
     */
  @visibility(Lifecycle.Read)
  name?: string;

  /** he localized display information for this particular operation / action. */
  display?: OperationDisplay;

  /** 
    The intended executor of the operation."
     */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /** 
    Additional descriptions for the operation.
     */
  properties?: OperationProperties;
}

model NamespaceListResult is Azure.Core.Page<NamespaceResource>;
model SharedAccessAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessAuthorizationRuleResource>;

model NotificationHubListResult is Azure.Core.Page<NotificationHubResource>;
@@visibility(Azure.Core.Page.value, Lifecycle.Read);
@@OpenAPI.extension(OperationListResult.value, "x-ms-identifiers", #["name"]);
