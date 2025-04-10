import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.BotService;

/**
 * Microsoft App Type for the bot
 */
union MsaAppType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssignedMSI: "UserAssignedMSI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SingleTenant: "SingleTenant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiTenant: "MultiTenant",
}

/**
 * Whether the bot is in an isolated network
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Provisioning state of Network Security Perimeter configuration propagation
 */
union Severity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
}

/**
 * Direction of Access Rule
 */
union NspAccessRuleDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Outbound: "Outbound",
}

/**
 * Access Mode of the resource association
 */
union AccessMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enforced: "Enforced",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Learning: "Learning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Audit: "Audit",
}

/**
 * The name of SKU.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  F0: "F0",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S1: "S1",
}

/**
 * Indicates the type of bot service
 */
union Kind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  sdk: "sdk",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  designer: "designer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  bot: "bot",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  function: "function",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  azurebot: "azurebot",
}

/**
 * The status of the operation being performed.
 */
union OperationResultStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Requested: "Requested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RegenerateKeysChannelName {
  WebChatChannel,
  DirectLineChannel,
}

/**
 * Determines which key is to be regenerated
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Key {
  key1,
  key2,
}

/**
 * Email channel auth method. 0 Password (Default); 1 Graph.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
  iconUrl?: string = "";

  /**
   * The bot's endpoint
   */
  endpoint: string;

  /**
   * The bot's endpoint version
   */
  @visibility(Lifecycle.Read)
  endpointVersion?: string;

  /**
   * Contains resource all settings defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  allSettings?: Record<string>;

  /**
   * Contains resource parameters defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  msaAppId: string;

  /**
   * Microsoft App Tenant Id for the bot
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  msaAppTenantId?: string;

  /**
   * Microsoft App Managed Identity Resource Id for the bot
   */
  msaAppMSIResourceId?: string;

  /**
   * Collection of channels for which the bot is configured
   */
  @visibility(Lifecycle.Read)
  configuredChannels?: string[];

  /**
   * Collection of channels for which the bot is enabled
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  cmekEncryptionStatus?: string;

  /**
   * The Tenant Id for the bot
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  isDeveloperAppInsightsApiKeySet?: boolean;

  /**
   * Token used to migrate non Azure bot to azure subscription
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * List of Network Security Perimeter configurations for the bot
   */
  @visibility(Lifecycle.Read)
  networkSecurityPerimeterConfigurations?: NetworkSecurityPerimeterConfiguration[];

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

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
}

/**
 * Properties of Network Security Perimeter configuration
 */
model NetworkSecurityPerimeterConfigurationProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  provisioningState?: ProvisioningState = ProvisioningState.Succeeded;

  /**
   * List of Provisioning Issues if any
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  provisioningIssues?: ProvisioningIssue[];

  /**
   * Information about Network Security Perimeter
   */
  @visibility(Lifecycle.Read)
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * Information about resource association
   */
  @visibility(Lifecycle.Read)
  resourceAssociation?: ResourceAssociation;

  /**
   * Information about profile
   */
  @visibility(Lifecycle.Read)
  profile?: Profile;
}

/**
 * Describes Provisioning issue for given Network Security Perimeter configuration
 */
model ProvisioningIssue {
  /**
   * Name of the issue
   */
  name?: string;

  /**
   * Properties of Provisioning Issue
   */
  @visibility(Lifecycle.Read)
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of Provisioning Issue
 */
model ProvisioningIssueProperties {
  /**
   * Type of Issue
   */
  issueType?: string;

  /**
   * Provisioning state of Network Security Perimeter configuration propagation
   */
  severity?: Severity;

  /**
   * Description of the issue
   */
  description?: string;

  /**
   * ARM IDs of resources that can be associated to the same perimeter to remediate the issue.
   */
  @visibility(Lifecycle.Read)
  suggestedResourceIds?: Azure.Core.armResourceIdentifier[];

  /**
   * Access rules that can be added to the same profile to remediate the issue.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  suggestedAccessRules?: NspAccessRule[];
}

/**
 * Information of Access Rule in a profile
 */
model NspAccessRule {
  /**
   * Name of the access rule
   */
  name?: string;

  /**
   * Properties of Access Rule
   */
  @visibility(Lifecycle.Read)
  properties?: NspAccessRuleProperties;
}

/**
 * Properties of Access Rule
 */
model NspAccessRuleProperties {
  /**
   * Direction of Access Rule
   */
  direction?: NspAccessRuleDirection;

  /**
   * Address prefixes in the CIDR format for inbound rules
   */
  addressPrefixes?: string[];

  /**
   * Subscriptions for inbound rules
   */
  subscriptions?: NspAccessRulePropertiesSubscriptionsItem[];

  /**
   * NetworkSecurityPerimeters for inbound rules
   */
  @visibility(Lifecycle.Read)
  networkSecurityPerimeters?: NetworkSecurityPerimeter[];

  /**
   * FQDN for outbound rules
   */
  @visibility(Lifecycle.Read)
  fullyQualifiedDomainNames?: string[];

  /**
   * Email addresses for outbound rules
   */
  @visibility(Lifecycle.Read)
  emailAddresses?: string[];

  /**
   * Phone numbers for outbound rules
   */
  @visibility(Lifecycle.Read)
  phoneNumbers?: string[];
}

/**
 * Subscription for inbound rule
 */
model NspAccessRulePropertiesSubscriptionsItem {
  /**
   * Fully qualified identifier of subscription
   */
  id?: string;
}

/**
 * Information about Network Security Perimeter
 */
model NetworkSecurityPerimeter {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * Guid of the Network Security Perimeter
   */
  perimeterGuid?: string;

  /**
   * Location of the Network Security Perimeter
   */
  location?: string;
}

/**
 * Information about resource association
 */
model ResourceAssociation {
  /**
   * Name of the resource association
   */
  name?: string;

  /**
   * Access Mode of the resource association
   */
  accessMode?: AccessMode;
}

/**
 * Information about profile
 */
model Profile {
  /**
   * Name of the profile
   */
  name?: string;

  /**
   * Current access rules version
   */
  accessRulesVersion?: int64;

  /**
   * List of Access Rules
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  accessRules?: NspAccessRule[];

  /**
   * Current diagnostic settings version
   */
  diagnosticSettingsVersion?: int64;

  /**
   * List of log categories
   */
  @visibility(Lifecycle.Read)
  enabledLogCategories?: string[];
}

/**
 * Azure resource
 */
model Resource {
  /**
   * Specifies the resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Specifies the name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Specifies the location of the resource.
   */
  location?: string;

  /**
   * Specifies the type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
   * Entity Tag.
   */
  etag?: string;

  /**
   * Entity zones
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
 * The list of bot service operation response.
 */
model BotResponseList is Azure.Core.Page<Bot>;

/**
 * Channel definition
 */
@discriminator("channelName")
model Channel {
  /**
   * The channel name
   */
  channelName: string;

  /**
   * Entity Tag of the resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  etag?: string;

  /**
   * Provisioning state of the resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Specifies the location of the resource.
   */
  location?: string = "global";
}

/**
 * The ARM channel of list channel with keys operation response.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  extensionKey1?: string = "";

  /**
   * The extensionKey2
   */
  extensionKey2?: string = "";

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
  @visibility(Lifecycle.Read)
  siteId?: string;

  /**
   * Site name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  siteName: string;

  /**
   * Primary key. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  @visibility(Lifecycle.Read)
  key?: string;

  /**
   * Secondary key. Value only returned through POST to the action Channel List API, otherwise empty.
   */
  @visibility(Lifecycle.Read)
  key2?: string;

  /**
   * Whether this site is enabled for DirectLine channel
   */
  isEnabled: boolean;

  /**
   * Whether this site is token enabled for channel
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
 * The list of bot service channel operation response.
 */
model ChannelResponseList is Azure.Core.Page<BotChannel>;

/**
 * Site information for WebChat or DirectLine Channels to identify which site to regenerate keys for.
 */
model SiteInfo {
  /**
   * The site name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
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
 * The list of bot service providers response.
 */
model ServiceProviderResponseList {
  /**
   * The link used to get the next page of bot service providers.
   */
  nextLink?: string;

  /**
   * Gets the list of bot service providers and their properties.
   */
  @visibility(Lifecycle.Read)
  value?: ServiceProvider[];
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Display Name of the Service Provider
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Name of the Service Provider
   */
  @visibility(Lifecycle.Read)
  serviceProviderName?: string;

  /**
   * URL of Dev Portal
   */
  @visibility(Lifecycle.Read)
  devPortalUrl?: string;

  /**
   * The URL of icon
   */
  iconUrl?: string = "";

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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the Service Provider
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Display Name of the Service Provider
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Description of the Service Provider
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Help Url for the  Service Provider
   */
  @visibility(Lifecycle.Read)
  helpUrl?: string;

  /**
   * Default Name for the Service Provider
   */
  @visibility(Lifecycle.Read)
  default?: string;

  /**
   * Meta data for the Service Provider
   */
  @visibility(Lifecycle.Read)
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
   * Id of the Connection Setting.
   */
  id?: string;

  /**
   * Name of the Connection Setting.
   */
  name?: string;

  /**
   * Client Id associated with the Connection Setting.
   */
  clientId?: string;

  /**
   * Setting Id set by the service for the Connection Setting.
   */
  @visibility(Lifecycle.Read)
  settingId?: string;

  /**
   * Client Secret associated with the Connection Setting
   */
  clientSecret?: string;

  /**
   * Scopes associated with the Connection Setting
   */
  scopes?: string = "";

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
 * The list of bot service connection settings response.
 */
model ConnectionSettingResponseList is Azure.Core.Page<ConnectionSetting>;

/**
 * The response body returned for a request to Bot Service Management to check per subscription hostSettings
 */
model HostSettingsResponse {
  /**
   * For in-conversation bot user authentication
   */
  OAuthUrl?: string;

  /**
   * For verifying incoming tokens from the channels
   */
  ToBotFromChannelOpenIdMetadataUrl?: string;

  /**
   * For verifying incoming tokens from the channels
   */
  ToBotFromChannelTokenIssuer?: string;

  /**
   * For verifying incoming tokens from bot emulator
   */
  ToBotFromEmulatorOpenIdMetadataUrl?: string;

  /**
   * For getting access token to channels from bot host
   */
  ToChannelFromBotLoginUrl?: string;

  /**
   * For getting access token to channels from bot host
   */
  ToChannelFromBotOAuthScope?: string;

  /**
   * Per cloud OAuth setting on whether authority is validated
   */
  ValidateAuthority?: boolean;

  /**
   * Same as toBotFromChannelOpenIdMetadataUrl, used by SDK < v4.12
   */
  BotOpenIdMetadata?: string;
}

/**
 * The properties indicating the operation result of an operation on a service.
 */
model OperationResultsDescription {
  /**
   * The ID of the operation returned.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the operation result.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of the operation being performed.
   */
  @visibility(Lifecycle.Read)
  status?: OperationResultStatus;

  /**
   * The time that the operation was started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;
}

/**
 * List of private endpoint connection associated with the specified storage account
 */
@pagedResult
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @items
  value?: PrivateEndpointConnection[];
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends PrivateLinkResourceBase {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Result of the List NetworkSecurityPerimeterConfiguration operation.
 */
model NetworkSecurityPerimeterConfigurationList
  is Azure.Core.Page<NetworkSecurityPerimeterConfiguration>;

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
  @visibility(Lifecycle.Read)
  urlFragment?: string;

  /**
   * Full Uri used to configured the skill in Alexa
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  deploymentEnvironment?: string = "CommercialDeployment";

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
  @visibility(Lifecycle.Read)
  webChatEmbedCode?: string;

  /**
   * The list of Web Chat sites
   */
  sites?: WebChatSite[];
}

/**
 * A site for the Webchat channel
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  extensionKey1?: string = "";

  /**
   * The extensionKey2
   */
  extensionKey2?: string = "";

  /**
   * Direct Line embed code of the resource
   */
  DirectLineEmbedCode?: string;
}

/**
 * A site for the Direct Line channel
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  redirectAction?: string;

  /**
   * The Sms auth token
   */
  @visibility(Lifecycle.Read)
  lastSubmissionId?: string;

  /**
   * Whether to register the settings before OAuth validation is performed. Recommended to True.
   */
  registerBeforeOAuthFlow?: boolean;

  /**
   * Whether this channel is validated for the bot
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  callbackUrl?: string;

  /**
   * Whether this channel is validated for the bot
   */
  @visibility(Lifecycle.Read)
  isValidated?: boolean;
}

/**
 * The properties corresponding to a line channel registration
 */
model LineRegistration {
  /**
   * Id generated for the line channel registration
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  name?: string;
}
