import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace NotificationHubsManagementClient;

enum SkuName {
  Free,
  Basic,
  Standard,
}
@Azure.Core.fixed
enum NamespaceType {
  Messaging,
  NotificationHub,
}
@Azure.Core.fixed
enum AccessRights {
  Manage,
  Send,
  Listen,
}

@doc("""
Result of the request to list NotificationHubs operations. It contains a list
of operations and a URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("A NotificationHubs REST API operation")
model Operation {
  @doc("Operation name: {provider}/{resource}/{operation}")
  @visibility("read")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft.NotificationHubs")
  @visibility("read")
  provider?: string;

  @doc("Resource on which the operation is performed: Invoice, etc.")
  @visibility("read")
  resource?: string;

  @doc("Operation type: Read, write, delete, etc.")
  @visibility("read")
  operation?: string;
}

@doc("""
Error response indicates NotificationHubs service is not able to process the
incoming request. The reason is provided in the error message.
""")
@error
model ErrorResponse {
  @doc("Error code.")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  message?: string;
}

@doc("""
Parameters supplied to the Check Name Availability for Namespace and
NotificationHubs.
""")
model CheckAvailabilityParameters {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  name: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  location?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The sku of the created namespace")
  sku?: Sku;

  @doc("""
True if the name is available and can be used to create new
Namespace/NotificationHub. Otherwise false.
""")
  isAvailiable?: boolean;
}

@doc("The Sku description for a namespace")
model Sku {
  @doc("Name of the notification hub sku")
  name: SkuName;

  @doc("The tier of particular sku")
  tier?: string;

  @doc("The Sku size")
  size?: string;

  @doc("The Sku Family")
  family?: string;

  @doc("The capacity of the resource")
  capacity?: int32;
}

@doc("Description of a CheckAvailability resource.")
model CheckAvailabilityResult {
  ...Resource;

  @doc("""
True if the name is available and can be used to create new
Namespace/NotificationHub. Otherwise false.
""")
  isAvailiable?: boolean;
}

model Resource {
  @doc("Resource Id")
  @visibility("read")
  id?: string;

  @doc("Resource name")
  @visibility("read")
  name?: string;

  @doc("Resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  location?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The sku of the created namespace")
  sku?: Sku;
}

@doc("Parameters supplied to the CreateOrUpdate Namespace operation.")
model NamespaceCreateOrUpdateParameters {
  ...Resource;

  @doc("Properties of the Namespace.")
  properties?: NamespaceProperties;
}

@doc("Namespace properties.")
model NamespaceProperties {
  @doc("The name of the namespace.")
  name?: string;

  @doc("Provisioning state of the Namespace.")
  provisioningState?: string;

  @doc("""
Specifies the targeted region in which the namespace should be created. It can
be any of the following values: Australia East, Australia Southeast, Central
US, East US, East US 2, West US, North Central US, South Central US, East Asia,
Southeast Asia, Brazil South, Japan East, Japan West, North Europe, West Europe
""")
  region?: string;

  @doc("Identifier for Azure Insights metrics")
  @visibility("read")
  metricId?: string;

  @doc("""
Status of the namespace. It can be any of these values:1 = Created/Active2 =
Creating3 = Suspended4 = Deleting
""")
  status?: string;

  @doc("The time the namespace was created.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The time the namespace was updated.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Endpoint you can use to perform NotificationHub operations.")
  serviceBusEndpoint?: string;

  @doc("The Id of the Azure subscription associated with the namespace.")
  subscriptionId?: string;

  @doc("ScaleUnit where the namespace gets created")
  scaleUnit?: string;

  @doc("Whether or not the namespace is currently enabled.")
  enabled?: boolean;

  @doc("Whether or not the namespace is set as Critical.")
  critical?: boolean;

  @doc("Data center for the namespace")
  dataCenter?: string;

  @doc("The namespace type.")
  namespaceType?: NamespaceType;
}

@doc("Description of a Namespace resource.")
model NamespaceResource {
  ...Resource;

  @doc("Properties of the Namespace.")
  properties?: NamespaceProperties;
}

@doc("Parameters supplied to the Patch Namespace operation.")
model NamespacePatchParameters {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("The sku of the created namespace")
  sku?: Sku;
}

@doc("Parameters supplied to the CreateOrUpdate Namespace AuthorizationRules.")
model SharedAccessAuthorizationRuleCreateOrUpdateParameters {
  @doc("Properties of the Namespace AuthorizationRules.")
  properties: SharedAccessAuthorizationRuleProperties;
}

@doc("SharedAccessAuthorizationRule properties.")
model SharedAccessAuthorizationRuleProperties {
  @doc("The rights associated with the rule.")
  rights?: AccessRights[];

  @doc("A base64-encoded 256-bit primary key for signing and validating the SAS token.")
  @visibility("read")
  primaryKey?: string;

  @doc("A base64-encoded 256-bit primary key for signing and validating the SAS token.")
  @visibility("read")
  secondaryKey?: string;

  @doc("A string that describes the authorization rule.")
  @visibility("read")
  keyName?: string;

  @doc("A string that describes the claim type")
  @visibility("read")
  claimType?: string;

  @doc("A string that describes the claim value")
  @visibility("read")
  claimValue?: string;

  @doc("The last modified time for this rule")
  @visibility("read")
  modifiedTime?: string;

  @doc("The created time for this rule")
  @visibility("read")
  createdTime?: string;

  @doc("The revision number for the rule")
  @visibility("read")
  revision?: int32;
}

@doc("Description of a Namespace AuthorizationRules.")
model SharedAccessAuthorizationRuleResource {
  ...Resource;

  @doc("Properties of the Namespace AuthorizationRule.")
  properties?: SharedAccessAuthorizationRuleProperties;
}

@doc("The response of the List Namespace operation.")
model NamespaceListResult is Azure.Core.Page<NamespaceResource>;

@doc("The response of the List Namespace operation.")
model SharedAccessAuthorizationRuleListResult
  is Azure.Core.Page<SharedAccessAuthorizationRuleResource>;

@doc("Namespace/NotificationHub Connection String")
model ResourceListKeys {
  @doc("PrimaryConnectionString of the AuthorizationRule.")
  primaryConnectionString?: string;

  @doc("SecondaryConnectionString of the created AuthorizationRule")
  secondaryConnectionString?: string;

  @doc("PrimaryKey of the created AuthorizationRule.")
  primaryKey?: string;

  @doc("SecondaryKey of the created AuthorizationRule")
  secondaryKey?: string;

  @doc("KeyName of the created AuthorizationRule")
  keyName?: string;
}

@doc("Namespace/NotificationHub Regenerate Keys")
model PolicykeyResource {
  @doc("""
Name of the key that has to be regenerated for the Namespace/Notification Hub
Authorization Rule. The value can be Primary Key/Secondary Key.
""")
  policyKey?: string;
}

@doc("Parameters supplied to the CreateOrUpdate NotificationHub operation.")
model NotificationHubCreateOrUpdateParameters {
  ...Resource;

  @doc("Properties of the NotificationHub.")
  properties: NotificationHubProperties;
}

@doc("NotificationHub properties.")
model NotificationHubProperties {
  @doc("The NotificationHub name.")
  name?: string;

  @doc("The RegistrationTtl of the created NotificationHub")
  registrationTtl?: string;

  @doc("The AuthorizationRules of the created NotificationHub")
  authorizationRules?: SharedAccessAuthorizationRuleProperties[];

  @doc("The ApnsCredential of the created NotificationHub")
  apnsCredential?: ApnsCredential;

  @doc("The WnsCredential of the created NotificationHub")
  wnsCredential?: WnsCredential;

  @doc("The GcmCredential of the created NotificationHub")
  gcmCredential?: GcmCredential;

  @doc("The MpnsCredential of the created NotificationHub")
  mpnsCredential?: MpnsCredential;

  @doc("The AdmCredential of the created NotificationHub")
  admCredential?: AdmCredential;

  @doc("The BaiduCredential of the created NotificationHub")
  baiduCredential?: BaiduCredential;
}

@doc("Description of a NotificationHub ApnsCredential.")
model ApnsCredential {
  @doc("Properties of NotificationHub ApnsCredential.")
  properties?: ApnsCredentialProperties;
}

@doc("""
Description of a NotificationHub ApnsCredential. Note that there is no explicit
switch between Certificate and Token Authentication Modes. The mode is
determined based on the properties passed in.
""")
model ApnsCredentialProperties {
  @doc("The APNS certificate. Specify if using Certificate Authentication Mode.")
  apnsCertificate?: string;

  @doc("The APNS certificate password if it exists.")
  certificateKey?: string;

  @doc("""
The APNS endpoint of this credential. If using Certificate Authentication Mode
and Sandbox specify 'gateway.sandbox.push.apple.com'. If using Certificate
Authentication Mode and Production specify 'gateway.push.apple.com'. If using
Token Authentication Mode and Sandbox specify
'https://api.development.push.apple.com:443/3/device'. If using Token
Authentication Mode and Production specify
'https://api.push.apple.com:443/3/device'.
""")
  endpoint?: string;

  @doc("""
The APNS certificate thumbprint. Specify if using Certificate Authentication
Mode.
""")
  thumbprint?: string;

  @doc("""
A 10-character key identifier (kid) key, obtained from your developer account.
Specify if using Token Authentication Mode.
""")
  keyId?: string;

  @doc("""
The name of the application or BundleId. Specify if using Token Authentication
Mode.
""")
  appName?: string;

  @doc("""
The issuer (iss) registered claim key. The value is a 10-character TeamId,
obtained from your developer account. Specify if using Token Authentication
Mode.
""")
  appId?: string;

  @doc("""
Provider Authentication Token, obtained through your developer account. Specify
if using Token Authentication Mode.
""")
  token?: string;
}

@doc("Description of a NotificationHub WnsCredential.")
model WnsCredential {
  @doc("Properties of NotificationHub WnsCredential.")
  properties?: WnsCredentialProperties;
}

@doc("Description of a NotificationHub WnsCredential.")
model WnsCredentialProperties {
  @doc("The package ID for this credential.")
  packageSid?: string;

  @doc("The secret key.")
  secretKey?: string;

  @doc("The Windows Live endpoint.")
  windowsLiveEndpoint?: string;
}

@doc("Description of a NotificationHub GcmCredential.")
model GcmCredential {
  @doc("Properties of NotificationHub GcmCredential.")
  properties?: GcmCredentialProperties;
}

@doc("Description of a NotificationHub GcmCredential.")
model GcmCredentialProperties {
  @doc("The FCM legacy endpoint. Default value is 'https://fcm.googleapis.com/fcm/send'")
  gcmEndpoint?: string;

  @doc("The Google API key.")
  googleApiKey?: string;
}

@doc("Description of a NotificationHub MpnsCredential.")
model MpnsCredential {
  @doc("Properties of NotificationHub MpnsCredential.")
  properties?: MpnsCredentialProperties;
}

@doc("Description of a NotificationHub MpnsCredential.")
model MpnsCredentialProperties {
  @doc("The MPNS certificate.")
  mpnsCertificate?: string;

  @doc("The certificate key for this credential.")
  certificateKey?: string;

  @doc("The MPNS certificate Thumbprint")
  thumbprint?: string;
}

@doc("Description of a NotificationHub AdmCredential.")
model AdmCredential {
  @doc("Properties of NotificationHub AdmCredential.")
  properties?: AdmCredentialProperties;
}

@doc("Description of a NotificationHub AdmCredential.")
model AdmCredentialProperties {
  @doc("The client identifier.")
  clientId?: string;

  @doc("The credential secret access key.")
  clientSecret?: string;

  @doc("The URL of the authorization token.")
  authTokenUrl?: string;
}

@doc("Description of a NotificationHub BaiduCredential.")
model BaiduCredential {
  @doc("Properties of NotificationHub BaiduCredential.")
  properties?: BaiduCredentialProperties;
}

@doc("Description of a NotificationHub BaiduCredential.")
model BaiduCredentialProperties {
  @doc("Baidu Api Key.")
  baiduApiKey?: string;

  @doc("Baidu Endpoint.")
  baiduEndPoint?: string;

  @doc("Baidu Secret Key")
  baiduSecretKey?: string;
}

@doc("Description of a NotificationHub Resource.")
model NotificationHubResource {
  ...Resource;

  @doc("Properties of the NotificationHub.")
  properties?: NotificationHubProperties;
}

@doc("Parameters supplied to the patch NotificationHub operation.")
model NotificationHubPatchParameters {
  ...Resource;

  @doc("Properties of the NotificationHub.")
  properties?: NotificationHubProperties;
}

@doc("Description of a NotificationHub Resource.")
model DebugSendResponse {
  ...Resource;

  @doc("Properties of the NotificationHub.")
  properties?: DebugSendResult;
}

model DebugSendResult {
  @doc("successful send")
  success?: float32;

  @doc("send failure")
  failure?: float32;

  @doc("actual failure description")
  results?: unknown;
}

@doc("The response of the List NotificationHub operation.")
model NotificationHubListResult is Azure.Core.Page<NotificationHubResource>;

@doc("Description of a NotificationHub PNS Credentials.")
model PnsCredentialsResource {
  ...Resource;

  @doc("NotificationHub PNS Credentials.")
  properties?: PnsCredentialsProperties;
}

@doc("Description of a NotificationHub PNS Credentials.")
model PnsCredentialsProperties {
  @doc("The ApnsCredential of the created NotificationHub")
  apnsCredential?: ApnsCredential;

  @doc("The WnsCredential of the created NotificationHub")
  wnsCredential?: WnsCredential;

  @doc("The GcmCredential of the created NotificationHub")
  gcmCredential?: GcmCredential;

  @doc("The MpnsCredential of the created NotificationHub")
  mpnsCredential?: MpnsCredential;

  @doc("The AdmCredential of the created NotificationHub")
  admCredential?: AdmCredential;

  @doc("The BaiduCredential of the created NotificationHub")
  baiduCredential?: BaiduCredential;
}

model SubResource {
  @doc("Resource Id")
  id?: string;
}
