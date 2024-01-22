import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NotificationHubs;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Name of the notification hub sku
 */
enum SkuName {
  Free,
  Basic,
  Standard,
}

/**
 * The namespace type.
 */
@fixed
enum NamespaceType {
  Messaging,
  NotificationHub,
}

@fixed
enum AccessRights {
  Manage,
  Send,
  Listen,
}

/**
 * Parameters supplied to the Check Name Availability for Namespace and NotificationHubs.
 */
model CheckAvailabilityParameters {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  name: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The sku of the created namespace
   */
  sku?: Sku;

  /**
   * True if the name is available and can be used to create new Namespace/NotificationHub. Otherwise false.
   */
  isAvailiable?: boolean;
}

/**
 * The Sku description for a namespace
 */
model Sku {
  /**
   * Name of the notification hub sku
   */
  name: SkuName;

  /**
   * The tier of particular sku
   */
  tier?: string;

  /**
   * The Sku size
   */
  size?: string;

  /**
   * The Sku Family
   */
  family?: string;

  /**
   * The capacity of the resource
   */
  capacity?: int32;
}

/**
 * Description of a CheckAvailability resource.
 */
model CheckAvailabilityResult extends Resource {
  /**
   * True if the name is available and can be used to create new Namespace/NotificationHub. Otherwise false.
   */
  isAvailiable?: boolean;
}

model Resource {
  /**
   * Resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  location?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The sku of the created namespace
   */
  sku?: Sku;
}

/**
 * Parameters supplied to the CreateOrUpdate Namespace operation.
 */
model NamespaceCreateOrUpdateParameters extends Resource {
  /**
   * Properties of the Namespace.
   */
  properties?: NamespaceProperties;
}

/**
 * Namespace properties.
 */
model NamespaceProperties {
  /**
   * The name of the namespace.
   */
  @projectedName("json", "name")
  namespaceName?: string;

  /**
   * Provisioning state of the Namespace.
   */
  provisioningState?: string;

  /**
   * Specifies the targeted region in which the namespace should be created. It can be any of the following values: Australia East, Australia Southeast, Central US, East US, East US 2, West US, North Central US, South Central US, East Asia, Southeast Asia, Brazil South, Japan East, Japan West, North Europe, West Europe
   */
  region?: string;

  /**
   * Identifier for Azure Insights metrics
   */
  @visibility("read")
  metricId?: string;

  /**
   * Status of the namespace. It can be any of these values:1 = Created/Active2 = Creating3 = Suspended4 = Deleting
   */
  status?: string;

  /**
   * The time the namespace was created.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform NotificationHub operations.
   */
  serviceBusEndpoint?: string;

  /**
   * The Id of the Azure subscription associated with the namespace.
   */
  subscriptionId?: string;

  /**
   * ScaleUnit where the namespace gets created
   */
  scaleUnit?: string;

  /**
   * Whether or not the namespace is currently enabled.
   */
  enabled?: boolean;

  /**
   * Whether or not the namespace is set as Critical.
   */
  critical?: boolean;

  /**
   * Data center for the namespace
   */
  dataCenter?: string;

  /**
   * The namespace type.
   */
  namespaceType?: NamespaceType;
}

/**
 * Parameters supplied to the Patch Namespace operation.
 */
model NamespacePatchParameters {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * The sku of the created namespace
   */
  sku?: Sku;
}

/**
 * Parameters supplied to the CreateOrUpdate Namespace AuthorizationRules.
 */
model SharedAccessAuthorizationRuleCreateOrUpdateParameters {
  /**
   * Properties of the Namespace AuthorizationRules.
   */
  properties: SharedAccessAuthorizationRuleProperties;
}

/**
 * SharedAccessAuthorizationRule properties.
 */
model SharedAccessAuthorizationRuleProperties {
  /**
   * The rights associated with the rule.
   */
  rights?: AccessRights[];

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  @visibility("read")
  secondaryKey?: string;

  /**
   * A string that describes the authorization rule.
   */
  @visibility("read")
  keyName?: string;

  /**
   * A string that describes the claim type
   */
  @visibility("read")
  claimType?: string;

  /**
   * A string that describes the claim value
   */
  @visibility("read")
  claimValue?: string;

  /**
   * The last modified time for this rule
   */
  @visibility("read")
  modifiedTime?: string;

  /**
   * The created time for this rule
   */
  @visibility("read")
  createdTime?: string;

  /**
   * The revision number for the rule
   */
  @visibility("read")
  revision?: int32;
}

/**
 * Namespace/NotificationHub Connection String
 */
model ResourceListKeys {
  /**
   * PrimaryConnectionString of the AuthorizationRule.
   */
  primaryConnectionString?: string;

  /**
   * SecondaryConnectionString of the created AuthorizationRule
   */
  secondaryConnectionString?: string;

  /**
   * PrimaryKey of the created AuthorizationRule.
   */
  primaryKey?: string;

  /**
   * SecondaryKey of the created AuthorizationRule
   */
  secondaryKey?: string;

  /**
   * KeyName of the created AuthorizationRule
   */
  keyName?: string;
}

/**
 * Namespace/NotificationHub Regenerate Keys
 */
model PolicykeyResource {
  /**
   * Name of the key that has to be regenerated for the Namespace/Notification Hub Authorization Rule. The value can be Primary Key/Secondary Key.
   */
  policyKey?: string;
}

/**
 * Parameters supplied to the CreateOrUpdate NotificationHub operation.
 */
model NotificationHubCreateOrUpdateParameters extends Resource {
  /**
   * Properties of the NotificationHub.
   */
  properties: NotificationHubProperties;
}

/**
 * NotificationHub properties.
 */
model NotificationHubProperties {
  /**
   * The NotificationHub name.
   */
  @projectedName("json", "name")
  notificationHubName?: string;

  /**
   * The RegistrationTtl of the created NotificationHub
   */
  registrationTtl?: string;

  /**
   * The AuthorizationRules of the created NotificationHub
   */
  authorizationRules?: SharedAccessAuthorizationRuleProperties[];

  /**
   * The ApnsCredential of the created NotificationHub
   */
  apnsCredential?: ApnsCredential;

  /**
   * The WnsCredential of the created NotificationHub
   */
  wnsCredential?: WnsCredential;

  /**
   * The GcmCredential of the created NotificationHub
   */
  gcmCredential?: GcmCredential;

  /**
   * The MpnsCredential of the created NotificationHub
   */
  mpnsCredential?: MpnsCredential;

  /**
   * The AdmCredential of the created NotificationHub
   */
  admCredential?: AdmCredential;

  /**
   * The BaiduCredential of the created NotificationHub
   */
  baiduCredential?: BaiduCredential;
}

/**
 * Description of a NotificationHub ApnsCredential.
 */
model ApnsCredential {
  /**
   * Properties of NotificationHub ApnsCredential.
   */
  properties?: ApnsCredentialProperties;
}

/**
 * Description of a NotificationHub ApnsCredential. Note that there is no explicit switch between Certificate and Token Authentication Modes. The mode is determined based on the properties passed in.
 */
model ApnsCredentialProperties {
  /**
   * The APNS certificate. Specify if using Certificate Authentication Mode.
   */
  apnsCertificate?: string;

  /**
   * The APNS certificate password if it exists.
   */
  certificateKey?: string;

  /**
   * The APNS endpoint of this credential. If using Certificate Authentication Mode and Sandbox specify 'gateway.sandbox.push.apple.com'. If using Certificate Authentication Mode and Production specify 'gateway.push.apple.com'. If using Token Authentication Mode and Sandbox specify 'https://api.development.push.apple.com:443/3/device'. If using Token Authentication Mode and Production specify 'https://api.push.apple.com:443/3/device'.
   */
  endpoint?: string;

  /**
   * The APNS certificate thumbprint. Specify if using Certificate Authentication Mode.
   */
  thumbprint?: string;

  /**
   * A 10-character key identifier (kid) key, obtained from your developer account. Specify if using Token Authentication Mode.
   */
  keyId?: string;

  /**
   * The name of the application or BundleId. Specify if using Token Authentication Mode.
   */
  appName?: string;

  /**
   * The issuer (iss) registered claim key. The value is a 10-character TeamId, obtained from your developer account. Specify if using Token Authentication Mode.
   */
  appId?: string;

  /**
   * Provider Authentication Token, obtained through your developer account. Specify if using Token Authentication Mode.
   */
  token?: string;
}

/**
 * Description of a NotificationHub WnsCredential.
 */
model WnsCredential {
  /**
   * Properties of NotificationHub WnsCredential.
   */
  properties?: WnsCredentialProperties;
}

/**
 * Description of a NotificationHub WnsCredential.
 */
model WnsCredentialProperties {
  /**
   * The package ID for this credential.
   */
  packageSid?: string;

  /**
   * The secret key.
   */
  secretKey?: string;

  /**
   * The Windows Live endpoint.
   */
  windowsLiveEndpoint?: string;
}

/**
 * Description of a NotificationHub GcmCredential.
 */
model GcmCredential {
  /**
   * Properties of NotificationHub GcmCredential.
   */
  properties?: GcmCredentialProperties;
}

/**
 * Description of a NotificationHub GcmCredential.
 */
model GcmCredentialProperties {
  /**
   * The FCM legacy endpoint. Default value is 'https://fcm.googleapis.com/fcm/send'
   */
  gcmEndpoint?: string;

  /**
   * The Google API key.
   */
  googleApiKey?: string;
}

/**
 * Description of a NotificationHub MpnsCredential.
 */
model MpnsCredential {
  /**
   * Properties of NotificationHub MpnsCredential.
   */
  properties?: MpnsCredentialProperties;
}

/**
 * Description of a NotificationHub MpnsCredential.
 */
model MpnsCredentialProperties {
  /**
   * The MPNS certificate.
   */
  mpnsCertificate?: string;

  /**
   * The certificate key for this credential.
   */
  certificateKey?: string;

  /**
   * The MPNS certificate Thumbprint
   */
  thumbprint?: string;
}

/**
 * Description of a NotificationHub AdmCredential.
 */
model AdmCredential {
  /**
   * Properties of NotificationHub AdmCredential.
   */
  properties?: AdmCredentialProperties;
}

/**
 * Description of a NotificationHub AdmCredential.
 */
model AdmCredentialProperties {
  /**
   * The client identifier.
   */
  clientId?: string;

  /**
   * The credential secret access key.
   */
  clientSecret?: string;

  /**
   * The URL of the authorization token.
   */
  authTokenUrl?: string;
}

/**
 * Description of a NotificationHub BaiduCredential.
 */
model BaiduCredential {
  /**
   * Properties of NotificationHub BaiduCredential.
   */
  properties?: BaiduCredentialProperties;
}

/**
 * Description of a NotificationHub BaiduCredential.
 */
model BaiduCredentialProperties {
  /**
   * Baidu Api Key.
   */
  baiduApiKey?: string;

  /**
   * Baidu Endpoint.
   */
  baiduEndPoint?: string;

  /**
   * Baidu Secret Key
   */
  baiduSecretKey?: string;
}

/**
 * Parameters supplied to the patch NotificationHub operation.
 */
model NotificationHubPatchParameters extends Resource {
  /**
   * Properties of the NotificationHub.
   */
  properties?: NotificationHubProperties;
}

/**
 * Description of a NotificationHub Resource.
 */
model DebugSendResponse extends Resource {
  /**
   * Properties of the NotificationHub.
   */
  properties?: DebugSendResult;
}

model DebugSendResult {
  /**
   * successful send
   */
  success?: int32;

  /**
   * send failure
   */
  failure?: int32;

  /**
   * actual failure description
   */
  results?: Record<unknown>;
}

/**
 * Description of a NotificationHub PNS Credentials.
 */
model PnsCredentialsResource extends Resource {
  /**
   * NotificationHub PNS Credentials.
   */
  properties?: PnsCredentialsProperties;
}

/**
 * Description of a NotificationHub PNS Credentials.
 */
model PnsCredentialsProperties {
  /**
   * The ApnsCredential of the created NotificationHub
   */
  apnsCredential?: ApnsCredential;

  /**
   * The WnsCredential of the created NotificationHub
   */
  wnsCredential?: WnsCredential;

  /**
   * The GcmCredential of the created NotificationHub
   */
  gcmCredential?: GcmCredential;

  /**
   * The MpnsCredential of the created NotificationHub
   */
  mpnsCredential?: MpnsCredential;

  /**
   * The AdmCredential of the created NotificationHub
   */
  admCredential?: AdmCredential;

  /**
   * The BaiduCredential of the created NotificationHub
   */
  baiduCredential?: BaiduCredential;
}

model SubResource {
  /**
   * Resource Id
   */
  id?: string;
}
