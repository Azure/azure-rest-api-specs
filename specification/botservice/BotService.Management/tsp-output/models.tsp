import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.BotService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Microsoft App Type for the bot
 */
enum MsaAppType {
  UserAssignedMSI,
  SingleTenant,
  MultiTenant,
}

/**
 * Whether the bot is in an isolated network
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * The name of SKU.
 */
enum SkuName {
  F0,
  S1,
}

/**
 * Indicates the type of bot service
 */
enum Kind {
  sdk,
  designer,
  bot,
  function,
  azurebot,
}

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

/**
 * The status of the operation being performed.
 */
enum OperationResultStatus {
  Canceled,
  Succeeded,
  Failed,
  Requested,
  Running,
}

@fixed
enum RegenerateKeysChannelName {
  WebChatChannel,
  DirectLineChannel,
}

/**
 * Determines which key is to be regenerated
 */
@fixed
enum Key {
  key1,
  key2,
}

/**
 * Email channel auth method. 0 Password (Default); 1 Graph.
 */
@fixed
enum EmailChannelAuthMethod {
  /**
   * Basic authentication.
   */
  Password: 0,

  /**
   * Modern authentication.
   */
  Graph: 1,
}

/**
 * The parameters to provide for the Bot.
 */
model BotProperties {
  /**
   * The Name of the bot
   */
  displayName: string;

  /**
   * The description of the bot
   */
  description?: string;

  /**
   * The Icon Url of the bot
   */
  iconUrl?: string;

  /**
   * The bot's endpoint
   */
  endpoint: string;

  /**
   * The bot's endpoint version
   */
  @visibility("read")
  endpointVersion?: string;

  /**
   * Contains resource all settings defined as key/value pairs.
   */
  allSettings?: Record<string>;

  /**
   * Contains resource parameters defined as key/value pairs.
   */
  parameters?: Record<string>;

  /**
   * The bot's manifest url
   */
  manifestUrl?: string;

  /**
   * Microsoft App Type for the bot
   */
  msaAppType?: MsaAppType;

  /**
   * Microsoft App Id for the bot
   */
  @visibility("read", "create")
  msaAppId: string;

  /**
   * Microsoft App Tenant Id for the bot
   */
  @visibility("read", "create")
  msaAppTenantId?: string;

  /**
   * Microsoft App Managed Identity Resource Id for the bot
   */
  msaAppMSIResourceId?: string;

  /**
   * Collection of channels for which the bot is configured
   */
  @visibility("read")
  configuredChannels?: string[];

  /**
   * Collection of channels for which the bot is enabled
   */
  @visibility("read")
  enabledChannels?: string[];

  /**
   * The Application Insights key
   */
  developerAppInsightKey?: string;

  /**
   * The Application Insights Api Key
   */
  developerAppInsightsApiKey?: string;

  /**
   * The Application Insights App Id
   */
  developerAppInsightsApplicationId?: string;

  /**
   * Collection of LUIS App Ids
   */
  luisAppIds?: string[];

  /**
   * The LUIS Key
   */
  luisKey?: string;

  /**
   * Whether Cmek is enabled
   */
  isCmekEnabled?: boolean;

  /**
   * The CMK Url
   */
  cmekKeyVaultUrl?: string;

  /**
   * The CMK encryption status
   */
  @visibility("read")
  cmekEncryptionStatus?: string;

  /**
   * The Tenant Id for the bot
   */
  @visibility("read", "create")
  tenantId?: string;

  /**
   * Whether the bot is in an isolated network
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * Whether the bot is streaming supported
   */
  isStreamingSupported?: boolean;

  /**
   * Whether the bot is developerAppInsightsApiKey set
   */
  @visibility("read")
  isDeveloperAppInsightsApiKeySet?: boolean;

  /**
   * Token used to migrate non Azure bot to azure subscription
   */
  @visibility("read")
  migrationToken?: string;

  /**
   * Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * The channel schema transformation version for the bot
   */
  schemaTransformationVersion?: string;

  /**
   * The storage resourceId for the bot
   */
  storageResourceId?: string;

  /**
   * List of Private Endpoint Connections configured for the bot
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The hint to browser (e.g. protocol handler) on how to open the bot for authoring
   */
  openWithHint?: string;

  /**
   * The hint (e.g. keyVault secret resourceId) on how to fetch the app secret
   */
  appPasswordHint?: string;

  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Publishing credentials of the resource
   */
  publishingCredentials?: string;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;

  /**
   * Group ids
   */
  groupIds?: string[];
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Common fields that are returned in the response for all BotService Private Link Resources
 */
model PrivateLinkResourceBase {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Azure resource
 */
model Resource {
  /**
   * Specifies the resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Specifies the name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Specifies the location of the resource.
   */
  location?: string;

  /**
   * Specifies the type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  tags?: Record<string>;

  /**
   * Gets or sets the SKU of the resource.
   */
  sku?: Sku;

  /**
   * Required. Gets or sets the Kind of the resource.
   */
  kind?: Kind;

  /**
   * Entity Tag
   */
  etag?: string;

  /**
   * Entity zones
   */
  @visibility("read")
  zones?: string[];
}

/**
 * The SKU of the cognitive services account.
 */
model Sku {
  /**
   * The sku name
   */
  name: SkuName;

  /**
   * Gets the sku tier. This is based on the SKU name.
   */
  @visibility("read")
  tier?: SkuTier;
}

/**
 * Bot Service error object.
 */
@error
model Error {
  /**
   * The error body.
   */
  error?: ErrorBody;
}

/**
 * Bot Service error body.
 */
model ErrorBody {
  /**
   * error code
   */
  code: string;

  /**
   * error message
   */
  message: string;
}

/**
 * Channel definition
 */
@discriminator("channelName")
model Channel {
  /**
   * Entity Tag of the resource
   */
  @visibility("read", "create")
  etag?: string;

  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Specifies the location of the resource.
   */
  location?: string = "global";
}

/**
 * The ARM channel of list channel with keys operation response.
 */
model ListChannelWithKeysResponse extends BotChannel {
  /**
   * The set of properties specific to bot channel resource
   */
  resource?: Channel;

  /**
   * Channel settings
   */
  setting?: ChannelSettings;

  /**
   * Provisioning state of the resource
   */
  provisioningState?: string;

  /**
   * Entity tag of the resource
   */
  entityTag?: string;

  /**
   * Changed time of the resource
   */
  changedTime?: string;
}

/**
 * Channel settings definition
 */
model ChannelSettings {
  /**
   * The extensionKey1
   */
  extensionKey1?: string;

  /**
   * The extensionKey2
   */
  extensionKey2?: string;

  /**
   * The list of sites
   */
  sites?: Site[];

  /**
   * The channel id
   */
  channelId?: string;

  /**
   * The channel display name
   */
  channelDisplayName?: string;

  /**
   * The bot id
   */
  botId?: string;

  /**
   * The bot icon url
   */
  botIconUrl?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled?: boolean;

  /**
   * Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication.
   */
  disableLocalAuth?: boolean;

  /**
   * Whether customer needs to agree to new terms.
   */
  requireTermsAgreement?: boolean;
}

/**
 * A site for the channel
 */
model Site {
  /**
   * Tenant Id
   */
  tenantId?: string;

  /**
   * Site Id
   */
  @visibility("read")
  siteId?: string;

  /**
   * Site name
   */
  @visibility("read", "create")
  siteName: string;

  /**
   * Primary key. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  @visibility("read")
  key?: string;

  /**
   * Secondary key. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  @visibility("read")
  key2?: string;

  /**
   * Whether this site is enabled for DirectLine channel
   */
  isEnabled: boolean;

  /**
   * Whether this site is token enabled for channel
   */
  @visibility("read")
  isTokenEnabled?: boolean;

  /**
   * Whether this site is EndpointParameters enabled for channel
   */
  isEndpointParametersEnabled?: boolean;

  /**
   * Whether this site is disabled detailed logging for
   */
  isDetailedLoggingEnabled?: boolean;

  /**
   * Whether this site is enabled for block user upload.
   */
  isBlockUserUploadEnabled?: boolean;

  /**
   * Whether this no-storage site is disabled detailed logging for
   */
  isNoStorageEnabled?: boolean;

  /**
   * Entity Tag
   */
  eTag?: string;

  /**
   * DirectLine application id
   */
  appId?: string;

  /**
   * Whether this site is enabled for Bot Framework V1 protocol.
   */
  @visibility("read", "create")
  isV1Enabled?: boolean;

  /**
   * Whether this site is enabled for Bot Framework V3 protocol.
   */
  isV3Enabled?: boolean;

  /**
   * Whether this site is enabled for authentication with Bot Framework.
   */
  isSecureSiteEnabled?: boolean;

  /**
   * List of Trusted Origin URLs for this site. This field is applicable only if isSecureSiteEnabled is True.
   */
  trustedOrigins?: string[];

  /**
   * Whether this site is enabled for Webchat Speech
   */
  isWebChatSpeechEnabled?: boolean;

  /**
   * Whether this site is enabled for preview versions of Webchat
   */
  isWebchatPreviewEnabled?: boolean;
}

/**
 * Site information for WebChat or DirectLine Channels to identify which site to regenerate keys for.
 */
model SiteInfo {
  /**
   * The site name
   */
  @visibility("read", "create")
  siteName: string;

  /**
   * Determines which key is to be regenerated
   */
  key: Key;
}

/**
 * The ARM create email sign in url operation response.
 */
model CreateEmailSignInUrlResponse {
  /**
   * Specifies the resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Specifies the location of the resource.
   */
  location?: string;

  /**
   * The set of properties specific to sign in url
   */
  properties?: CreateEmailSignInUrlResponseProperties;
}

/**
 * The set of properties specific to sign in url
 */
model CreateEmailSignInUrlResponseProperties {
  /**
   * Sign in url.
   */
  url?: string;
}

/**
 * The request body for a request to Bot Service Management to check availability of a bot name.
 */
model CheckNameAvailabilityRequestBody {
  /**
   * the name of the bot for which availability needs to be checked.
   */
  name?: string;

  /**
   * the type of the bot for which availability needs to be checked
   */
  type?: string;
}

/**
 * The response body returned for a request to Bot Service Management to check availability of a bot name.
 */
model CheckNameAvailabilityResponseBody {
  /**
   * indicates if the bot name is valid.
   */
  valid?: boolean;

  /**
   * additional message from the bot management api showing why a bot name is not available
   */
  message?: string;

  /**
   * response code from ABS
   */
  absCode?: string;
}

/**
 * The operations supported by Bot Service Management.
 */
model OperationEntity {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The operation supported by Bot Service Management.
   */
  display?: OperationDisplayInfo;

  /**
   * The origin of the operation.
   */
  origin?: string;

  /**
   * Additional properties.
   */
  properties?: Record<unknown>;
}

/**
 * The operation supported by Bot Service Management.
 */
model OperationDisplayInfo {
  /**
   * The description of the operation.
   */
  description?: string;

  /**
   * The action that users can perform, based on their permission level.
   */
  operation?: string;

  /**
   * Service provider: Microsoft Bot Service.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;
}

/**
 * Service Provider Definition
 */
model ServiceProvider {
  /**
   * The Properties of a Service Provider Object
   */
  properties?: ServiceProviderProperties;
}

/**
 * The Object used to describe a Service Provider supported by Bot Service
 */
model ServiceProviderProperties {
  /**
   * Id for Service Provider
   */
  @visibility("read")
  id?: string;

  /**
   * Display Name of the Service Provider
   */
  @visibility("read")
  displayName?: string;

  /**
   * Name of the Service Provider
   */
  @visibility("read")
  serviceProviderName?: string;

  /**
   * URL of Dev Portal
   */
  @visibility("read")
  devPortalUrl?: string;

  /**
   * The URL of icon
   */
  iconUrl?: string;

  /**
   * The list of parameters for the Service Provider
   */
  parameters?: ServiceProviderParameter[];
}

/**
 * Extra Parameters specific to each Service Provider
 */
model ServiceProviderParameter {
  /**
   * Name of the Service Provider
   */
  @visibility("read")
  name?: string;

  /**
   * Type of the Service Provider
   */
  @visibility("read")
  type?: string;

  /**
   * Display Name of the Service Provider
   */
  @visibility("read")
  displayName?: string;

  /**
   * Description of the Service Provider
   */
  @visibility("read")
  description?: string;

  /**
   * Help Url for the  Service Provider
   */
  @visibility("read")
  helpUrl?: string;

  /**
   * Default Name for the Service Provider
   */
  @visibility("read")
  default?: string;

  /**
   * Meta data for the Service Provider
   */
  @visibility("read")
  metadata?: ServiceProviderParameterMetadata;
}

/**
 * Meta data for the Service Provider
 */
model ServiceProviderParameterMetadata {
  /**
   * the constraints of the bot meta data.
   */
  constraints?: ServiceProviderParameterMetadataConstraints;
}

/**
 * the constraints of the bot meta data.
 */
model ServiceProviderParameterMetadataConstraints {
  /**
   * Whether required the constraints of the bot meta data.
   */
  required?: boolean;
}

/**
 * The request body for a request to Bot Service Management to list QnA Maker endpoint keys.
 */
model QnAMakerEndpointKeysRequestBody {
  /**
   * the host name of the QnA Maker endpoint
   */
  hostname?: string;

  /**
   * Subscription key which provides access to this API.
   */
  authkey?: string;
}

/**
 * Schema for EndpointKeys generate/refresh operations.
 */
model QnAMakerEndpointKeysResponse {
  /**
   * Primary Access Key.
   */
  primaryEndpointKey?: string;

  /**
   * Secondary Access Key.
   */
  secondaryEndpointKey?: string;

  /**
   * Current version of runtime.
   */
  installedVersion?: string;

  /**
   * Latest version of runtime.
   */
  lastStableVersion?: string;
}

/**
 * Properties for a Connection Setting Item
 */
model ConnectionSettingProperties {
  /**
   * Client Id associated with the Connection Setting.
   */
  clientId?: string;

  /**
   * Setting Id set by the service for the Connection Setting.
   */
  @visibility("read")
  settingId?: string;

  /**
   * Client Secret associated with the Connection Setting
   */
  clientSecret?: string;

  /**
   * Scopes associated with the Connection Setting
   */
  scopes?: string;

  /**
   * Service Provider Id associated with the Connection Setting
   */
  serviceProviderId?: string;

  /**
   * Service Provider Display Name associated with the Connection Setting
   */
  serviceProviderDisplayName?: string;

  /**
   * Service Provider Parameters associated with the Connection Setting
   */
  parameters?: ConnectionSettingParameter[];

  /**
   * Provisioning state of the resource
   */
  provisioningState?: string;
}

/**
 * Extra Parameter in a Connection Setting Properties to indicate service provider specific properties
 */
model ConnectionSettingParameter {
  /**
   * Key for the Connection Setting Parameter.
   */
  key?: string;

  /**
   * Value associated with the Connection Setting Parameter.
   */
  value?: string;
}

/**
 * The response body returned for a request to Bot Service Management to check per subscription hostSettings
 */
model HostSettingsResponse {
  /**
   * For in-conversation bot user authentication
   */
  @projectedName("json", "OAuthUrl")
  oAuthUrl?: string;

  /**
   * For verifying incoming tokens from the channels
   */
  @projectedName("json", "ToBotFromChannelOpenIdMetadataUrl")
  toBotFromChannelOpenIdMetadataUrl?: string;

  /**
   * For verifying incoming tokens from the channels
   */
  @projectedName("json", "ToBotFromChannelTokenIssuer")
  toBotFromChannelTokenIssuer?: string;

  /**
   * For verifying incoming tokens from bot emulator
   */
  @projectedName("json", "ToBotFromEmulatorOpenIdMetadataUrl")
  toBotFromEmulatorOpenIdMetadataUrl?: string;

  /**
   * For getting access token to channels from bot host
   */
  @projectedName("json", "ToChannelFromBotLoginUrl")
  toChannelFromBotLoginUrl?: string;

  /**
   * For getting access token to channels from bot host
   */
  @projectedName("json", "ToChannelFromBotOAuthScope")
  toChannelFromBotOAuthScope?: string;

  /**
   * Per cloud OAuth setting on whether authority is validated
   */
  @projectedName("json", "ValidateAuthority")
  validateAuthority?: boolean;

  /**
   * Same as toBotFromChannelOpenIdMetadataUrl, used by SDK < v4.12
   */
  @projectedName("json", "BotOpenIdMetadata")
  botOpenIdMetadata?: string;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends PrivateLinkResourceBase {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Alexa channel definition
 */
model AlexaChannel extends Channel {
  /**
   * The set of properties specific to Alexa channel resource
   */
  properties?: AlexaChannelProperties;

  /**
   * The channel name
   */
  channelName: "AlexaChannel";
}

/**
 * The parameters to provide for the Alexa channel.
 */
model AlexaChannelProperties {
  /**
   * The Alexa skill Id
   */
  alexaSkillId: string;

  /**
   * Url fragment used in part of the Uri configured in Alexa
   */
  @visibility("read")
  urlFragment?: string;

  /**
   * Full Uri used to configured the skill in Alexa
   */
  @visibility("read")
  serviceEndpointUri?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Facebook channel definition
 */
model FacebookChannel extends Channel {
  /**
   * The set of properties specific to bot facebook channel
   */
  properties?: FacebookChannelProperties;

  /**
   * The channel name
   */
  channelName: "FacebookChannel";
}

/**
 * The parameters to provide for the Facebook channel.
 */
model FacebookChannelProperties {
  /**
   * Verify token. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  @visibility("read")
  verifyToken?: string;

  /**
   * The list of Facebook pages
   */
  pages?: FacebookPage[];

  /**
   * Facebook application id
   */
  appId: string;

  /**
   * Facebook application secret. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  appSecret?: string;

  /**
   * Callback Url
   */
  @visibility("read")
  callbackUrl?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * A Facebook page for Facebook channel registration
 */
model FacebookPage {
  /**
   * Page id
   */
  id: string;

  /**
   * Facebook application access token. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  accessToken?: string;
}

/**
 * Email channel definition
 */
model EmailChannel extends Channel {
  /**
   * The set of properties specific to email channel resource
   */
  properties?: EmailChannelProperties;

  /**
   * The channel name
   */
  channelName: "EmailChannel";
}

/**
 * The parameters to provide for the Email channel.
 */
model EmailChannelProperties {
  /**
   * The email address
   */
  emailAddress: string;

  /**
   * Email channel auth method. 0 Password (Default); 1 Graph.
   */
  authMethod?: EmailChannelAuthMethod;

  /**
   * The password for the email address. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  password?: string;

  /**
   * The magic code for setting up the modern authentication.
   */
  magicCode?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Outlook channel definition
 */
model OutlookChannel extends Channel {
  /**
   * The channel name
   */
  channelName: "OutlookChannel";
}

/**
 * Microsoft Teams channel definition
 */
model MsTeamsChannel extends Channel {
  /**
   * The set of properties specific to Microsoft Teams channel resource
   */
  properties?: MsTeamsChannelProperties;

  /**
   * The channel name
   */
  channelName: "MsTeamsChannel";
}

/**
 * The parameters to provide for the Microsoft Teams channel.
 */
model MsTeamsChannelProperties {
  /**
   * Enable calling for Microsoft Teams channel
   */
  enableCalling?: boolean;

  /**
   * Webhook for Microsoft Teams channel calls
   */
  callingWebhook?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;

  /**
   * Webhook for Microsoft Teams channel calls
   */
  incomingCallRoute?: string;

  /**
   * Deployment environment for Microsoft Teams channel calls
   */
  deploymentEnvironment?: string = "FallbackDeploymentEnvironment";

  /**
   * Whether this channel accepted terms
   */
  acceptedTerms?: boolean;
}

/**
 * Skype channel definition
 */
model SkypeChannel extends Channel {
  /**
   * The set of properties specific to Skype channel resource
   */
  properties?: SkypeChannelProperties;

  /**
   * The channel name
   */
  channelName: "SkypeChannel";
}

/**
 * The parameters to provide for the Microsoft Teams channel.
 */
model SkypeChannelProperties {
  /**
   * Enable messaging for Skype channel
   */
  enableMessaging?: boolean;

  /**
   * Enable media cards for Skype channel
   */
  enableMediaCards?: boolean;

  /**
   * Enable video for Skype channel
   */
  enableVideo?: boolean;

  /**
   * Enable calling for Skype channel
   */
  enableCalling?: boolean;

  /**
   * Enable screen sharing for Skype channel
   */
  enableScreenSharing?: boolean;

  /**
   * Enable groups for Skype channel
   */
  enableGroups?: boolean;

  /**
   * Group mode for Skype channel
   */
  groupsMode?: string;

  /**
   * Calling web hook for Skype channel
   */
  callingWebHook?: string;

  /**
   * Incoming call route for Skype channel
   */
  incomingCallRoute?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Kik channel definition
 */
model KikChannel extends Channel {
  /**
   * The set of properties specific to Kik channel resource
   */
  properties?: KikChannelProperties;

  /**
   * The channel name
   */
  channelName: "KikChannel";
}

/**
 * The parameters to provide for the Kik channel.
 */
model KikChannelProperties {
  /**
   * The Kik user name
   */
  userName: string;

  /**
   * Kik API key. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  apiKey?: string;

  /**
   * Whether this channel is validated for the bot
   */
  isValidated?: boolean;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Web Chat channel definition
 */
model WebChatChannel extends Channel {
  /**
   * The set of properties specific to Web Chat channel resource
   */
  properties?: WebChatChannelProperties;

  /**
   * The channel name
   */
  channelName: "WebChatChannel";
}

/**
 * The parameters to provide for the Web Chat channel.
 */
model WebChatChannelProperties {
  /**
   * Web chat control embed code
   */
  @visibility("read")
  webChatEmbedCode?: string;

  /**
   * The list of Web Chat sites
   */
  sites?: WebChatSite[];
}

/**
 * A site for the Webchat channel
 */
model WebChatSite extends Site {}

/**
 * Direct Line channel definition
 */
model DirectLineChannel extends Channel {
  /**
   * The set of properties specific to Direct Line channel resource
   */
  properties?: DirectLineChannelProperties;

  /**
   * The channel name
   */
  channelName: "DirectLineChannel";
}

/**
 * The parameters to provide for the Direct Line channel.
 */
model DirectLineChannelProperties {
  /**
   * The list of Direct Line sites
   */
  sites?: DirectLineSite[];

  /**
   * The extensionKey1
   */
  extensionKey1?: string;

  /**
   * The extensionKey2
   */
  extensionKey2?: string;

  /**
   * Direct Line embed code of the resource
   */
  @projectedName("json", "DirectLineEmbedCode")
  directLineEmbedCode?: string;
}

/**
 * A site for the Direct Line channel
 */
model DirectLineSite extends Site {}

/**
 * Telegram channel definition
 */
model TelegramChannel extends Channel {
  /**
   * The set of properties specific to Telegram channel resource
   */
  properties?: TelegramChannelProperties;

  /**
   * The channel name
   */
  channelName: "TelegramChannel";
}

/**
 * The parameters to provide for the Telegram channel.
 */
model TelegramChannelProperties {
  /**
   * The Telegram access token. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  accessToken?: string;

  /**
   * Whether this channel is validated for the bot
   */
  isValidated?: boolean;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Sms channel definition
 */
model SmsChannel extends Channel {
  /**
   * The set of properties specific to Sms channel resource
   */
  properties?: SmsChannelProperties;

  /**
   * The channel name
   */
  channelName: "SmsChannel";
}

/**
 * The parameters to provide for the Sms channel.
 */
model SmsChannelProperties {
  /**
   * The Sms phone
   */
  phone: string;

  /**
   * The Sms account SID. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  accountSID: string;

  /**
   * The Sms auth token. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  authToken?: string;

  /**
   * Whether this channel is validated for the bot
   */
  isValidated?: boolean;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Slack channel definition
 */
model SlackChannel extends Channel {
  /**
   * The set of properties specific to Slack channel resource
   */
  properties?: SlackChannelProperties;

  /**
   * The channel name
   */
  channelName: "SlackChannel";
}

/**
 * The parameters to provide for the Slack channel.
 */
model SlackChannelProperties {
  /**
   * The Slack client id
   */
  clientId?: string;

  /**
   * The Slack client secret. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  clientSecret?: string;

  /**
   * The Slack verification token. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  verificationToken?: string;

  /**
   * The Slack permission scopes.
   */
  scopes?: string;

  /**
   * The Slack landing page Url
   */
  landingPageUrl?: string;

  /**
   * The Slack redirect action
   */
  @visibility("read")
  redirectAction?: string;

  /**
   * The Sms auth token
   */
  @visibility("read")
  lastSubmissionId?: string;

  /**
   * Whether to register the settings before OAuth validation is performed. Recommended to True.
   */
  registerBeforeOAuthFlow?: boolean;

  /**
   * Whether this channel is validated for the bot
   */
  @visibility("read")
  IsValidated?: boolean;

  /**
   * The Slack signing secret.
   */
  signingSecret?: string;

  /**
   * Whether this channel is enabled for the bot
   */
  isEnabled: boolean;
}

/**
 * Line channel definition
 */
model LineChannel extends Channel {
  /**
   * The set of properties specific to line channel resource
   */
  properties?: LineChannelProperties;

  /**
   * The channel name
   */
  channelName: "LineChannel";
}

/**
 * The parameters to provide for the Line channel.
 */
model LineChannelProperties {
  /**
   * The list of line channel registrations
   */
  lineRegistrations: LineRegistration[];

  /**
   * Callback Url to enter in line registration.
   */
  @visibility("read")
  callbackUrl?: string;

  /**
   * Whether this channel is validated for the bot
   */
  @visibility("read")
  isValidated?: boolean;
}

/**
 * The properties corresponding to a line channel registration
 */
model LineRegistration {
  /**
   * Id generated for the line channel registration
   */
  @visibility("read")
  generatedId?: string;

  /**
   * Secret for the line channel registration
   */
  channelSecret?: string;

  /**
   * Access token for the line channel registration
   */
  channelAccessToken?: string;
}

/**
 * DirectLine Speech channel definition
 */
model DirectLineSpeechChannel extends Channel {
  /**
   * The set of properties specific to DirectLine Speech channel resource
   */
  properties?: DirectLineSpeechChannelProperties;

  /**
   * The channel name
   */
  channelName: "DirectLineSpeechChannel";
}

/**
 * The parameters to provide for the DirectLine Speech channel.
 */
model DirectLineSpeechChannelProperties {
  /**
   * The cognitive service id with this channel registration.
   */
  cognitiveServiceResourceId?: string;

  /**
   * The cognitive service region with this channel registration.
   */
  cognitiveServiceRegion?: string;

  /**
   * The cognitive service subscription key to use with this channel registration.
   */
  cognitiveServiceSubscriptionKey?: string;

  /**
   * Whether this channel is enabled or not.
   */
  isEnabled?: boolean;

  /**
   * Custom speech model id (optional).
   */
  customVoiceDeploymentId?: string;

  /**
   * Custom voice deployment id (optional).
   */
  customSpeechModelId?: string;

  /**
   * Make this a default bot for chosen cognitive service account.
   */
  isDefaultBotForCogSvcAccount?: boolean;
}

/**
 * Omnichannel channel definition
 */
model Omnichannel extends Channel {
  /**
   * The channel name
   */
  channelName: "Omnichannel";
}

/**
 * Telephony channel definition
 */
model TelephonyChannel extends Channel {
  /**
   * The set of properties specific to Telephony channel resource
   */
  properties?: TelephonyChannelProperties;

  /**
   * The channel name
   */
  channelName: "TelephonyChannel";
}

/**
 * The parameters to provide for the Direct Line channel.
 */
model TelephonyChannelProperties {
  /**
   * The list of Telephony phone numbers
   */
  phoneNumbers?: TelephonyPhoneNumbers[];

  /**
   * The list of Telephony api configuration
   */
  apiConfigurations?: TelephonyChannelResourceApiConfiguration[];

  /**
   * The extensionKey1
   */
  cognitiveServiceSubscriptionKey?: string;

  /**
   * The extensionKey2
   */
  cognitiveServiceRegion?: string;

  /**
   * The default locale of the channel
   */
  defaultLocale?: string;

  /**
   * The premium SKU applied to the channel
   */
  premiumSKU?: string;

  /**
   * Whether the channel is enabled
   */
  isEnabled?: boolean;
}

/**
 * A telephone number for the Telephony channel
 */
model TelephonyPhoneNumbers {
  /**
   * The element id.
   */
  id?: string;

  /**
   * The phone number.
   */
  phoneNumber?: string;

  /**
   * The endpoint of ACS.
   */
  acsEndpoint?: string;

  /**
   * The secret of ACS.
   */
  acsSecret?: string;

  /**
   * The resource id of ACS.
   */
  acsResourceId?: string;

  /**
   * The subscription key of cognitive service.
   */
  cognitiveServiceSubscriptionKey?: string;

  /**
   * The service region of cognitive service.
   */
  cognitiveServiceRegion?: string;

  /**
   * The resource id of cognitive service.
   */
  cognitiveServiceResourceId?: string;

  /**
   * The default locale of the phone number.
   */
  defaultLocale?: string;

  /**
   * Optional Property that will determine the offering type of the phone.
   */
  offerType?: string;
}

/**
 * A resource Api configuration for the Telephony channel
 */
model TelephonyChannelResourceApiConfiguration {
  /**
   * The id of config.
   */
  id?: string;

  /**
   * The provider name.
   */
  providerName?: string;

  /**
   * The cognitive service subscription key.
   */
  cognitiveServiceSubscriptionKey?: string;

  /**
   * The cognitive service region.
   */
  cognitiveServiceRegion?: string;

  /**
   * The cognitive service resourceId.
   */
  cognitiveServiceResourceId?: string;

  /**
   * The default locale.
   */
  defaultLocale?: string;
}

/**
 * AcsChat channel definition
 */
model AcsChatChannel extends Channel {
  /**
   * The channel name
   */
  channelName: "AcsChatChannel";
}

/**
 * SearchAssistant definition
 */
model SearchAssistant extends Channel {
  /**
   * The channel name
   */
  channelName: "SearchAssistant";
}

/**
 * M365 Extensions definition
 */
model M365Extensions extends Channel {
  /**
   * The channel name
   */
  channelName: "M365Extensions";
}

/**
 * The display name of a connection Item Setting registered with the Bot
 */
model ConnectionItemName {
  /**
   * Connection Item name that has been added in the API
   */
  @visibility("read")
  name?: string;
}

/**
 * The properties indicating the operation result of an operation on a service.
 */
model OperationResultsDescription {
  /**
   * The ID of the operation returned.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the operation result.
   */
  @visibility("read")
  name?: string;

  /**
   * The status of the operation being performed.
   */
  @visibility("read")
  status?: OperationResultStatus;

  /**
   * The time that the operation was started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}
