import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.BotService;

interface Operations extends Azure.ResourceManager.Operations {}

enum MsaAppType {
  UserAssignedMSI,
  SingleTenant,
  MultiTenant,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
  SecuredByPerimeter,
}

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum ProvisioningState {
  Creating,
  Updating,
  Accepted,
  Succeeded,
  Failed,
  Deleting,
}

enum Severity {
  Warning,
  Error,
}

enum NspAccessRuleDirection {
  Inbound,
  Outbound,
}

enum AccessMode {
  Enforced,
  Learning,
  Audit,
}

enum SkuName {
  F0,
  S1,
}

enum SkuTier {
  Free,
  Standard,
}

enum Kind {
  sdk,
  designer,
  bot,
  function,
  azurebot,
}

enum OperationResultStatus {
  Canceled,
  Succeeded,
  Failed,
  Requested,
  Running,
}
@Azure.Core.fixed
enum ChannelName {
  AlexaChannel,
  FacebookChannel,
  EmailChannel,
  KikChannel,
  TelegramChannel,
  SlackChannel,
  MsTeamsChannel,
  SkypeChannel,
  WebChatChannel,
  DirectLineChannel,
  SmsChannel,
  LineChannel,
  DirectLineSpeechChannel,
  OutlookChannel,
  Omnichannel,
  TelephonyChannel,
  AcsChatChannel,
  SearchAssistant,
  M365Extensions,
}
@Azure.Core.fixed
enum RegenerateKeysChannelName {
  WebChatChannel,
  DirectLineChannel,
}
@Azure.Core.fixed
enum Key {
  key1,
  key2,
}
@Azure.Core.fixed
enum EmailChannelAuthMethod {
  @doc("Basic authentication.") Password: 0,
  @doc("Modern authentication.") Graph: 1,
}

@doc("The parameters to provide for the Bot.")
model BotProperties {
  @doc("The Name of the bot")
  displayName: string;

  @doc("The description of the bot")
  description?: string;

  @doc("The Icon Url of the bot")
  iconUrl?: string;

  @doc("The bot's endpoint")
  endpoint: string;

  @doc("The bot's endpoint version")
  @visibility("read")
  endpointVersion?: string;

  @doc("Contains resource all settings defined as key/value pairs.")
  allSettings?: Record<string>;

  @doc("Contains resource parameters defined as key/value pairs.")
  parameters?: Record<string>;

  @doc("The bot's manifest url")
  manifestUrl?: string;

  @doc("Microsoft App Type for the bot")
  msaAppType?: MsaAppType;

  @doc("Microsoft App Id for the bot")
  @visibility("read", "create")
  msaAppId: string;

  @doc("Microsoft App Tenant Id for the bot")
  @visibility("read", "create")
  msaAppTenantId?: string;

  @doc("Microsoft App Managed Identity Resource Id for the bot")
  msaAppMSIResourceId?: string;

  @doc("Collection of channels for which the bot is configured")
  @visibility("read")
  configuredChannels?: string[];

  @doc("Collection of channels for which the bot is enabled")
  @visibility("read")
  enabledChannels?: string[];

  @doc("The Application Insights key")
  developerAppInsightKey?: string;

  @doc("The Application Insights Api Key")
  developerAppInsightsApiKey?: string;

  @doc("The Application Insights App Id")
  developerAppInsightsApplicationId?: string;

  @doc("Collection of LUIS App Ids")
  luisAppIds?: string[];

  @doc("The LUIS Key")
  luisKey?: string;

  @doc("Whether Cmek is enabled")
  isCmekEnabled?: boolean;

  @doc("The CMK Url")
  cmekKeyVaultUrl?: string;

  @doc("The CMK encryption status")
  @visibility("read")
  cmekEncryptionStatus?: string;

  @doc("The Tenant Id for the bot")
  @visibility("read", "create")
  tenantId?: string;

  @doc("Whether the bot is in an isolated network")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Whether the bot is streaming supported")
  isStreamingSupported?: boolean;

  @doc("Whether the bot is developerAppInsightsApiKey set")
  @visibility("read")
  isDeveloperAppInsightsApiKeySet?: boolean;

  @doc("Token used to migrate non Azure bot to azure subscription")
  @visibility("read")
  migrationToken?: string;

  @doc("Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.")
  disableLocalAuth?: boolean;

  @doc("The channel schema transformation version for the bot")
  schemaTransformationVersion?: string;

  @doc("The storage resourceId for the bot")
  storageResourceId?: string;

  @doc("List of Private Endpoint Connections configured for the bot")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("List of Network Security Perimeter configurations for the bot")
  @visibility("read")
  networkSecurityPerimeterConfigurations?: NetworkSecurityPerimeterConfiguration[];

  @doc("The hint to browser (e.g. protocol handler) on how to open the bot for authoring")
  openWithHint?: string;

  @doc("The hint (e.g. keyVault secret resourceId) on how to fetch the app secret")
  appPasswordHint?: string;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: string;

  @doc("Publishing credentials of the resource")
  publishingCredentials?: string;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  @doc("Group ids")
  groupIds?: string[];
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
}

@doc("Common fields that are returned in the response for all BotService Private Link Resources")
model PrivateLinkResourceBase {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Properties of Network Security Perimeter configuration")
model NetworkSecurityPerimeterConfigurationProperties {
  provisioningState?: ProvisioningState;

  @doc("List of Provisioning Issues if any")
  provisioningIssues?: ProvisioningIssue[];

  @doc("Information about Network Security Perimeter")
  @visibility("read")
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  @doc("Information about resource association")
  @visibility("read")
  resourceAssociation?: ResourceAssociation;

  @doc("Information about profile")
  @visibility("read")
  profile?: Profile;
}

@doc("Describes Provisioning issue for given Network Security Perimeter configuration")
model ProvisioningIssue {
  @doc("Name of the issue")
  name?: string;

  @doc("Properties of Provisioning Issue")
  @visibility("read")
  properties?: ProvisioningIssueProperties;
}

@doc("Properties of Provisioning Issue")
model ProvisioningIssueProperties {
  @doc("Type of Issue")
  issueType?: string;

  @doc("Provisioning state of Network Security Perimeter configuration propagation")
  severity?: Severity;

  @doc("Description of the issue")
  description?: string;

  @doc("ARM IDs of resources that can be associated to the same perimeter to remediate the issue.")
  @visibility("read")
  suggestedResourceIds?: ResourceIdentifier[];

  @doc("Access rules that can be added to the same profile to remediate the issue.")
  suggestedAccessRules?: NspAccessRule[];
}

@doc("Information of Access Rule in a profile")
model NspAccessRule {
  @doc("Name of the access rule")
  name?: string;

  @doc("Properties of Access Rule")
  @visibility("read")
  properties?: NspAccessRuleProperties;
}

@doc("Properties of Access Rule")
model NspAccessRuleProperties {
  @doc("Direction of Access Rule")
  direction?: NspAccessRuleDirection;

  @doc("Address prefixes in the CIDR format for inbound rules")
  addressPrefixes?: string[];

  @doc("Subscriptions for inbound rules")
  subscriptions?: NspAccessRulePropertiesSubscriptionsItem[];

  @doc("NetworkSecurityPerimeters for inbound rules")
  @visibility("read")
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  @doc("FQDN for outbound rules")
  @visibility("read")
  fullyQualifiedDomainNames?: string[];

  @doc("Email addresses for outbound rules")
  @visibility("read")
  emailAddresses?: string[];

  @doc("Phone numbers for outbound rules")
  @visibility("read")
  phoneNumbers?: string[];
}

@doc("Subscription for inbound rule")
model NspAccessRulePropertiesSubscriptionsItem {
  @doc("Fully qualified identifier of subscription")
  id?: string;
}

@doc("Information about Network Security Perimeter")
model NetworkSecurityPerimeter {
  @doc("Fully qualified resource ID for the resource. E.g. \"/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}\"")
  @visibility("read")
  id?: ResourceIdentifier;

  @doc("Guid of the Network Security Perimeter")
  perimeterGuid?: string;

  @doc("Location of the Network Security Perimeter")
  location?: string;
}

@doc("Information about resource association")
model ResourceAssociation {
  @doc("Name of the resource association")
  name?: string;

  @doc("Access Mode of the resource association")
  accessMode?: AccessMode;
}

@doc("Information about profile")
model Profile {
  @doc("Name of the profile")
  name?: string;

  @doc("Current access rules version")
  accessRulesVersion?: int32;

  @doc("List of Access Rules")
  accessRules?: NspAccessRule[];

  @doc("Current diagnostic settings version")
  diagnosticSettingsVersion?: int32;

  @doc("List of log categories")
  @visibility("read")
  enabledLogCategories?: string[];
}

@doc("The SKU of the cognitive services account.")
model Sku {
  @doc("The sku name")
  name: SkuName;

  @doc("Gets the sku tier. This is based on the SKU name.")
  @visibility("read")
  tier?: SkuTier;
}

@doc("Bot Service error object.")
@error
model Error {
  @doc("The error body.")
  error?: ErrorBody;
}

@doc("Bot Service error body.")
model ErrorBody {
  @doc("error code")
  code: string;

  @doc("error message")
  message: string;
}

@doc("Channel definition")
@discriminator("channelName")
model Channel {
  @doc("Entity Tag of the resource")
  @visibility("read", "create")
  etag?: string;

  @doc("Provisioning state of the resource")
  @visibility("read")
  provisioningState?: string;

  @doc("Specifies the location of the resource.")
  location?: string;
}

@doc("The ARM channel of list channel with keys operation response.")
model ListChannelWithKeysResponse {
  ...BotChannel;

  @doc("The set of properties specific to bot channel resource")
  resource?: Channel;

  @doc("Channel settings")
  setting?: ChannelSettings;

  @doc("Provisioning state of the resource")
  provisioningState?: string;

  @doc("Entity tag of the resource")
  entityTag?: string;

  @doc("Changed time of the resource")
  changedTime?: string;
}

@doc("Channel settings definition")
model ChannelSettings {
  @doc("The extensionKey1")
  extensionKey1?: string;

  @doc("The extensionKey2")
  extensionKey2?: string;

  @doc("The list of sites")
  sites?: Site[];

  @doc("The channel id")
  channelId?: string;

  @doc("The channel display name")
  channelDisplayName?: string;

  @doc("The bot id")
  botId?: string;

  @doc("The bot icon url")
  botIconUrl?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled?: boolean;

  @doc("Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.")
  disableLocalAuth?: boolean;

  @doc("Whether customer needs to agree to new terms.")
  requireTermsAgreement?: boolean;
}

@doc("A site for the channel")
model Site {
  @doc("Tenant Id")
  tenantId?: string;

  @doc("Site Id")
  @visibility("read")
  siteId?: string;

  @doc("Site name")
  @visibility("read", "create")
  siteName: string;

  @doc("Primary key. Value only returned through POST to the action Channel List API, otherwise empty.")
  @visibility("read")
  key?: string;

  @doc("Secondary key. Value only returned through POST to the action Channel List API, otherwise empty.")
  @visibility("read")
  key2?: string;

  @doc("Whether this site is enabled for DirectLine channel")
  isEnabled: boolean;

  @doc("Whether this site is token enabled for channel")
  @visibility("read")
  isTokenEnabled?: boolean;

  @doc("Whether this site is EndpointParameters enabled for channel")
  isEndpointParametersEnabled?: boolean;

  @doc("Whether this site is disabled detailed logging for")
  isDetailedLoggingEnabled?: boolean;

  @doc("Whether this site is enabled for block user upload.")
  isBlockUserUploadEnabled?: boolean;

  @doc("Whether this no-storage site is disabled detailed logging for")
  isNoStorageEnabled?: boolean;

  @doc("Entity Tag")
  eTag?: string;

  @doc("DirectLine application id")
  appId?: string;

  @doc("Whether this site is enabled for Bot Framework V1 protocol.")
  @visibility("read", "create")
  isV1Enabled?: boolean;

  @doc("Whether this site is enabled for Bot Framework V3 protocol.")
  isV3Enabled?: boolean;

  @doc("Whether this site is enabled for authentication with Bot Framework.")
  isSecureSiteEnabled?: boolean;

  @doc("List of Trusted Origin URLs for this site. This field is applicable only if isSecureSiteEnabled is True.")
  trustedOrigins?: string[];

  @doc("Whether this site is enabled for Webchat Speech")
  isWebChatSpeechEnabled?: boolean;

  @doc("Whether this site is enabled for preview versions of Webchat")
  isWebchatPreviewEnabled?: boolean;
}

@doc("Site information for WebChat or DirectLine Channels to identify which site to regenerate keys for.")
model SiteInfo {
  @doc("The site name")
  @visibility("read", "create")
  siteName: string;

  @doc("Determines which key is to be regenerated")
  key: Key;
}

@doc("The ARM create email sign in url operation response.")
model CreateEmailSignInUrlResponse {
  @doc("Specifies the resource ID.")
  @visibility("read")
  id?: string;

  @doc("Specifies the location of the resource.")
  location?: string;

  @doc("The set of properties specific to sign in url")
  properties?: CreateEmailSignInUrlResponseProperties;
}

@doc("The set of properties specific to sign in url")
model CreateEmailSignInUrlResponseProperties {
  @doc("Sign in url.")
  url?: string;
}

@doc("The request body for a request to Bot Service Management to check availability of a bot name.")
model CheckNameAvailabilityRequestBody {
  @doc("the name of the bot for which availability needs to be checked.")
  name?: string;

  @doc("the type of the bot for which availability needs to be checked")
  type?: string;
}

@doc("The response body returned for a request to Bot Service Management to check availability of a bot name.")
model CheckNameAvailabilityResponseBody {
  @doc("indicates if the bot name is valid.")
  valid?: boolean;

  @doc("additional message from the bot management api showing why a bot name is not available")
  message?: string;

  @doc("response code from ABS")
  absCode?: string;
}

@doc("The list of bot service operation response.")
model OperationEntityListResult is Azure.Core.Page<OperationEntity>;

@doc("The operations supported by Bot Service Management.")
model OperationEntity {
  @doc("Operation name: {provider}/{resource}/{operation}.")
  name?: string;

  @doc("The operation supported by Bot Service Management.")
  display?: OperationDisplayInfo;

  @doc("The origin of the operation.")
  origin?: string;

  @doc("Additional properties.")
  properties?: Record<unknown>;
}

@doc("The operation supported by Bot Service Management.")
model OperationDisplayInfo {
  @doc("The description of the operation.")
  description?: string;

  @doc("The action that users can perform, based on their permission level.")
  operation?: string;

  @doc("Service provider: Microsoft Bot Service.")
  provider?: string;

  @doc("Resource on which the operation is performed.")
  resource?: string;
}

@doc("Service Provider Definition")
model ServiceProvider {
  @doc("The Properties of a Service Provider Object")
  properties?: ServiceProviderProperties;
}

@doc("The Object used to describe a Service Provider supported by Bot Service")
model ServiceProviderProperties {
  @doc("Id for Service Provider")
  @visibility("read")
  id?: string;

  @doc("Display Name of the Service Provider")
  @visibility("read")
  displayName?: string;

  @doc("Name of the Service Provider")
  @visibility("read")
  serviceProviderName?: string;

  @doc("URL of Dev Portal")
  @visibility("read")
  devPortalUrl?: string;

  @doc("The URL of icon")
  iconUrl?: string;

  @doc("The list of parameters for the Service Provider")
  parameters?: ServiceProviderParameter[];
}

@doc("Extra Parameters specific to each Service Provider")
model ServiceProviderParameter {
  @doc("Name of the Service Provider")
  @visibility("read")
  name?: string;

  @doc("Type of the Service Provider")
  @visibility("read")
  type?: string;

  @doc("Display Name of the Service Provider")
  @visibility("read")
  displayName?: string;

  @doc("Description of the Service Provider")
  @visibility("read")
  description?: string;

  @doc("Help Url for the  Service Provider")
  @visibility("read")
  helpUrl?: string;

  @doc("Default Name for the Service Provider")
  @visibility("read")
  default?: string;

  @doc("Meta data for the Service Provider")
  @visibility("read")
  metadata?: ServiceProviderParameterMetadata;
}

@doc("Meta data for the Service Provider")
model ServiceProviderParameterMetadata {
  @doc("the constraints of the bot meta data.")
  constraints?: ServiceProviderParameterMetadataConstraints;
}

@doc("the constraints of the bot meta data.")
model ServiceProviderParameterMetadataConstraints {
  @doc("Whether required the constraints of the bot meta data.")
  required?: boolean;
}

@doc("The request body for a request to Bot Service Management to list QnA Maker endpoint keys.")
model QnAMakerEndpointKeysRequestBody {
  @doc("the host name of the QnA Maker endpoint")
  hostname?: string;

  @doc("Subscription key which provides access to this API.")
  authkey?: string;
}

@doc("Schema for EndpointKeys generate/refresh operations.")
model QnAMakerEndpointKeysResponse {
  @doc("Primary Access Key.")
  primaryEndpointKey?: string;

  @doc("Secondary Access Key.")
  secondaryEndpointKey?: string;

  @doc("Current version of runtime.")
  installedVersion?: string;

  @doc("Latest version of runtime.")
  lastStableVersion?: string;
}

@doc("Properties for a Connection Setting Item")
model ConnectionSettingProperties {
  @doc("Id of the Connection Setting.")
  id?: string;

  @doc("Name of the Connection Setting.")
  name?: string;

  @doc("Client Id associated with the Connection Setting.")
  clientId?: string;

  @doc("Setting Id set by the service for the Connection Setting.")
  @visibility("read")
  settingId?: string;

  @doc("Client Secret associated with the Connection Setting")
  clientSecret?: string;

  @doc("Scopes associated with the Connection Setting")
  scopes?: string;

  @doc("Service Provider Id associated with the Connection Setting")
  serviceProviderId?: string;

  @doc("Service Provider Display Name associated with the Connection Setting")
  serviceProviderDisplayName?: string;

  @doc("Service Provider Parameters associated with the Connection Setting")
  parameters?: ConnectionSettingParameter[];

  @doc("Provisioning state of the resource")
  provisioningState?: string;
}

@doc("Extra Parameter in a Connection Setting Properties to indicate service provider specific properties")
model ConnectionSettingParameter {
  @doc("Key for the Connection Setting Parameter.")
  key?: string;

  @doc("Value associated with the Connection Setting Parameter.")
  value?: string;
}

@doc("The response body returned for a request to Bot Service Management to check per subscription hostSettings")
model HostSettingsResponse {
  @doc("For in-conversation bot user authentication")
  @projectedName("json", "OAuthUrl")
  oAuthUrl?: string;

  @doc("For verifying incoming tokens from the channels")
  @projectedName("json", "ToBotFromChannelOpenIdMetadataUrl")
  toBotFromChannelOpenIdMetadataUrl?: string;

  @doc("For verifying incoming tokens from the channels")
  @projectedName("json", "ToBotFromChannelTokenIssuer")
  toBotFromChannelTokenIssuer?: string;

  @doc("For verifying incoming tokens from bot emulator")
  @projectedName("json", "ToBotFromEmulatorOpenIdMetadataUrl")
  toBotFromEmulatorOpenIdMetadataUrl?: string;

  @doc("For getting access token to channels from bot host")
  @projectedName("json", "ToChannelFromBotLoginUrl")
  toChannelFromBotLoginUrl?: string;

  @doc("For getting access token to channels from bot host")
  @projectedName("json", "ToChannelFromBotOAuthScope")
  toChannelFromBotOAuthScope?: string;

  @doc("Per cloud OAuth setting on whether authority is validated")
  @projectedName("json", "ValidateAuthority")
  validateAuthority?: boolean;

  @doc("Same as toBotFromChannelOpenIdMetadataUrl, used by SDK < v4.12")
  @projectedName("json", "BotOpenIdMetadata")
  botOpenIdMetadata?: string;
}

@doc("The properties indicating the operation result of an operation on a service.")
model OperationResultsDescription {
  @doc("The ID of the operation returned.")
  @visibility("read")
  id?: string;

  @doc("The name of the operation result.")
  @visibility("read")
  name?: string;

  @doc("The status of the operation being performed.")
  @visibility("read")
  status?: OperationResultStatus;

  @doc("The time that the operation was started.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource {
  ...PrivateLinkResourceBase;

  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Alexa channel definition")
model AlexaChannel extends Channel {
  @doc("The set of properties specific to Alexa channel resource")
  properties?: AlexaChannelProperties;

  @doc("The channel name")
  channelName: "AlexaChannel";
}

@doc("The parameters to provide for the Alexa channel.")
model AlexaChannelProperties {
  @doc("The Alexa skill Id")
  alexaSkillId: string;

  @doc("Url fragment used in part of the Uri configured in Alexa")
  @visibility("read")
  urlFragment?: string;

  @doc("Full Uri used to configured the skill in Alexa")
  @visibility("read")
  serviceEndpointUri?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Facebook channel definition")
model FacebookChannel extends Channel {
  @doc("The set of properties specific to bot facebook channel")
  properties?: FacebookChannelProperties;

  @doc("The channel name")
  channelName: "FacebookChannel";
}

@doc("The parameters to provide for the Facebook channel.")
model FacebookChannelProperties {
  @doc("Verify token. Value only returned through POST to the action Channel List API, otherwise empty.")
  @visibility("read")
  verifyToken?: string;

  @doc("The list of Facebook pages")
  pages?: FacebookPage[];

  @doc("Facebook application id")
  appId: string;

  @doc("Facebook application secret. Value only returned through POST to the action Channel List API, otherwise empty.")
  appSecret?: string;

  @doc("Callback Url")
  @visibility("read")
  callbackUrl?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("A Facebook page for Facebook channel registration")
model FacebookPage {
  @doc("Page id")
  id: string;

  @doc("Facebook application access token. Value only returned through POST to the action Channel List API, otherwise empty.")
  accessToken?: string;
}

@doc("Email channel definition")
model EmailChannel extends Channel {
  @doc("The set of properties specific to email channel resource")
  properties?: EmailChannelProperties;

  @doc("The channel name")
  channelName: "EmailChannel";
}

@doc("The parameters to provide for the Email channel.")
model EmailChannelProperties {
  @doc("The email address")
  emailAddress: string;

  @doc("Email channel auth method. 0 Password (Default); 1 Graph.")
  authMethod?: EmailChannelAuthMethod;

  @doc("The password for the email address. Value only returned through POST to the action Channel List API, otherwise empty.")
  password?: string;

  @doc("The magic code for setting up the modern authentication.")
  magicCode?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Outlook channel definition")
model OutlookChannel extends Channel {
  @doc("The channel name")
  channelName: "OutlookChannel";
}

@doc("Microsoft Teams channel definition")
model MsTeamsChannel extends Channel {
  @doc("The set of properties specific to Microsoft Teams channel resource")
  properties?: MsTeamsChannelProperties;

  @doc("The channel name")
  channelName: "MsTeamsChannel";
}

@doc("The parameters to provide for the Microsoft Teams channel.")
model MsTeamsChannelProperties {
  @doc("Enable calling for Microsoft Teams channel")
  enableCalling?: boolean;

  @doc("Webhook for Microsoft Teams channel calls")
  callingWebhook?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;

  @doc("Webhook for Microsoft Teams channel calls")
  incomingCallRoute?: string;

  @doc("Deployment environment for Microsoft Teams channel calls")
  deploymentEnvironment?: string;

  @doc("Whether this channel accepted terms")
  acceptedTerms?: boolean;
}

@doc("Skype channel definition")
model SkypeChannel extends Channel {
  @doc("The set of properties specific to Skype channel resource")
  properties?: SkypeChannelProperties;

  @doc("The channel name")
  channelName: "SkypeChannel";
}

@doc("The parameters to provide for the Microsoft Teams channel.")
model SkypeChannelProperties {
  @doc("Enable messaging for Skype channel")
  enableMessaging?: boolean;

  @doc("Enable media cards for Skype channel")
  enableMediaCards?: boolean;

  @doc("Enable video for Skype channel")
  enableVideo?: boolean;

  @doc("Enable calling for Skype channel")
  enableCalling?: boolean;

  @doc("Enable screen sharing for Skype channel")
  enableScreenSharing?: boolean;

  @doc("Enable groups for Skype channel")
  enableGroups?: boolean;

  @doc("Group mode for Skype channel")
  groupsMode?: string;

  @doc("Calling web hook for Skype channel")
  callingWebHook?: string;

  @doc("Incoming call route for Skype channel")
  incomingCallRoute?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Kik channel definition")
model KikChannel extends Channel {
  @doc("The set of properties specific to Kik channel resource")
  properties?: KikChannelProperties;

  @doc("The channel name")
  channelName: "KikChannel";
}

@doc("The parameters to provide for the Kik channel.")
model KikChannelProperties {
  @doc("The Kik user name")
  userName: string;

  @doc("Kik API key. Value only returned through POST to the action Channel List API, otherwise empty.")
  apiKey?: string;

  @doc("Whether this channel is validated for the bot")
  isValidated?: boolean;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Web Chat channel definition")
model WebChatChannel extends Channel {
  @doc("The set of properties specific to Web Chat channel resource")
  properties?: WebChatChannelProperties;

  @doc("The channel name")
  channelName: "WebChatChannel";
}

@doc("The parameters to provide for the Web Chat channel.")
model WebChatChannelProperties {
  @doc("Web chat control embed code")
  @visibility("read")
  webChatEmbedCode?: string;

  @doc("The list of Web Chat sites")
  sites?: WebChatSite[];
}

@doc("A site for the Webchat channel")
model WebChatSite {
  ...Site;
}

@doc("Direct Line channel definition")
model DirectLineChannel extends Channel {
  @doc("The set of properties specific to Direct Line channel resource")
  properties?: DirectLineChannelProperties;

  @doc("The channel name")
  channelName: "DirectLineChannel";
}

@doc("The parameters to provide for the Direct Line channel.")
model DirectLineChannelProperties {
  @doc("The list of Direct Line sites")
  sites?: DirectLineSite[];

  @doc("The extensionKey1")
  extensionKey1?: string;

  @doc("The extensionKey2")
  extensionKey2?: string;

  @doc("Direct Line embed code of the resource")
  @projectedName("json", "DirectLineEmbedCode")
  directLineEmbedCode?: string;
}

@doc("A site for the Direct Line channel")
model DirectLineSite {
  ...Site;
}

@doc("Telegram channel definition")
model TelegramChannel extends Channel {
  @doc("The set of properties specific to Telegram channel resource")
  properties?: TelegramChannelProperties;

  @doc("The channel name")
  channelName: "TelegramChannel";
}

@doc("The parameters to provide for the Telegram channel.")
model TelegramChannelProperties {
  @doc("The Telegram access token. Value only returned through POST to the action Channel List API, otherwise empty.")
  accessToken?: string;

  @doc("Whether this channel is validated for the bot")
  isValidated?: boolean;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Sms channel definition")
model SmsChannel extends Channel {
  @doc("The set of properties specific to Sms channel resource")
  properties?: SmsChannelProperties;

  @doc("The channel name")
  channelName: "SmsChannel";
}

@doc("The parameters to provide for the Sms channel.")
model SmsChannelProperties {
  @doc("The Sms phone")
  phone: string;

  @doc("The Sms account SID. Value only returned through POST to the action Channel List API, otherwise empty.")
  accountSID: string;

  @doc("The Sms auth token. Value only returned through POST to the action Channel List API, otherwise empty.")
  authToken?: string;

  @doc("Whether this channel is validated for the bot")
  isValidated?: boolean;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Slack channel definition")
model SlackChannel extends Channel {
  @doc("The set of properties specific to Slack channel resource")
  properties?: SlackChannelProperties;

  @doc("The channel name")
  channelName: "SlackChannel";
}

@doc("The parameters to provide for the Slack channel.")
model SlackChannelProperties {
  @doc("The Slack client id")
  clientId?: string;

  @doc("The Slack client secret. Value only returned through POST to the action Channel List API, otherwise empty.")
  clientSecret?: string;

  @doc("The Slack verification token. Value only returned through POST to the action Channel List API, otherwise empty.")
  verificationToken?: string;

  @doc("The Slack permission scopes.")
  scopes?: string;

  @doc("The Slack landing page Url")
  landingPageUrl?: string;

  @doc("The Slack redirect action")
  @visibility("read")
  redirectAction?: string;

  @doc("The Sms auth token")
  @visibility("read")
  lastSubmissionId?: string;

  @doc("Whether to register the settings before OAuth validation is performed. Recommended to True.")
  registerBeforeOAuthFlow?: boolean;

  @doc("Whether this channel is validated for the bot")
  @visibility("read")
  IsValidated?: boolean;

  @doc("The Slack signing secret.")
  signingSecret?: string;

  @doc("Whether this channel is enabled for the bot")
  isEnabled: boolean;
}

@doc("Line channel definition")
model LineChannel extends Channel {
  @doc("The set of properties specific to line channel resource")
  properties?: LineChannelProperties;

  @doc("The channel name")
  channelName: "LineChannel";
}

@doc("The parameters to provide for the Line channel.")
model LineChannelProperties {
  @doc("The list of line channel registrations")
  lineRegistrations: LineRegistration[];

  @doc("Callback Url to enter in line registration.")
  @visibility("read")
  callbackUrl?: string;

  @doc("Whether this channel is validated for the bot")
  @visibility("read")
  isValidated?: boolean;
}

@doc("The properties corresponding to a line channel registration")
model LineRegistration {
  @doc("Id generated for the line channel registration")
  @visibility("read")
  generatedId?: string;

  @doc("Secret for the line channel registration")
  channelSecret?: string;

  @doc("Access token for the line channel registration")
  channelAccessToken?: string;
}

@doc("DirectLine Speech channel definition")
model DirectLineSpeechChannel extends Channel {
  @doc("The set of properties specific to DirectLine Speech channel resource")
  properties?: DirectLineSpeechChannelProperties;

  @doc("The channel name")
  channelName: "DirectLineSpeechChannel";
}

@doc("The parameters to provide for the DirectLine Speech channel.")
model DirectLineSpeechChannelProperties {
  @doc("The cognitive service id with this channel registration.")
  cognitiveServiceResourceId?: string;

  @doc("The cognitive service region with this channel registration.")
  cognitiveServiceRegion?: string;

  @doc("The cognitive service subscription key to use with this channel registration.")
  cognitiveServiceSubscriptionKey?: string;

  @doc("Whether this channel is enabled or not.")
  isEnabled?: boolean;

  @doc("Custom speech model id (optional).")
  customVoiceDeploymentId?: string;

  @doc("Custom voice deployment id (optional).")
  customSpeechModelId?: string;

  @doc("Make this a default bot for chosen cognitive service account.")
  isDefaultBotForCogSvcAccount?: boolean;
}

@doc("Omnichannel channel definition")
model Omnichannel extends Channel {
  @doc("The channel name")
  channelName: "Omnichannel";
}

@doc("Telephony channel definition")
model TelephonyChannel extends Channel {
  @doc("The set of properties specific to Telephony channel resource")
  properties?: TelephonyChannelProperties;

  @doc("The channel name")
  channelName: "TelephonyChannel";
}

@doc("The parameters to provide for the Direct Line channel.")
model TelephonyChannelProperties {
  @doc("The list of Telephony phone numbers")
  phoneNumbers?: TelephonyPhoneNumbers[];

  @doc("The list of Telephony api configuration")
  apiConfigurations?: TelephonyChannelResourceApiConfiguration[];

  @doc("The extensionKey1")
  cognitiveServiceSubscriptionKey?: string;

  @doc("The extensionKey2")
  cognitiveServiceRegion?: string;

  @doc("The default locale of the channel")
  defaultLocale?: string;

  @doc("The premium SKU applied to the channel")
  premiumSKU?: string;

  @doc("Whether the channel is enabled")
  isEnabled?: boolean;
}

@doc("A telephone number for the Telephony channel")
model TelephonyPhoneNumbers {
  @doc("The element id.")
  id?: string;

  @doc("The phone number.")
  phoneNumber?: string;

  @doc("The endpoint of ACS.")
  acsEndpoint?: string;

  @doc("The secret of ACS.")
  acsSecret?: string;

  @doc("The resource id of ACS.")
  acsResourceId?: string;

  @doc("The subscription key of cognitive service.")
  cognitiveServiceSubscriptionKey?: string;

  @doc("The service region of cognitive service.")
  cognitiveServiceRegion?: string;

  @doc("The resource id of cognitive service.")
  cognitiveServiceResourceId?: string;

  @doc("The default locale of the phone number.")
  defaultLocale?: string;

  @doc("Optional Property that will determine the offering type of the phone.")
  offerType?: string;
}

@doc("A resource Api configuration for the Telephony channel")
model TelephonyChannelResourceApiConfiguration {
  @doc("The id of config.")
  id?: string;

  @doc("The provider name.")
  providerName?: string;

  @doc("The cognitive service subscription key.")
  cognitiveServiceSubscriptionKey?: string;

  @doc("The cognitive service region.")
  cognitiveServiceRegion?: string;

  @doc("The cognitive service resourceId.")
  cognitiveServiceResourceId?: string;

  @doc("The default locale.")
  defaultLocale?: string;
}

@doc("AcsChat channel definition")
model AcsChatChannel extends Channel {
  @doc("The channel name")
  channelName: "AcsChatChannel";
}

@doc("SearchAssistant definition")
model SearchAssistant extends Channel {
  @doc("The channel name")
  channelName: "SearchAssistant";
}

@doc("M365 Extensions definition")
model M365Extensions extends Channel {
  @doc("The channel name")
  channelName: "M365Extensions";
}

@doc("The display name of a connection Item Setting registered with the Bot")
model ConnectionItemName {
  @doc("Connection Item name that has been added in the API")
  @visibility("read")
  name?: string;
}
