import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.CognitiveServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Gets the status of the cognitive services account at the time the operation was called.")
enum ProvisioningState {
  Accepted,
  Creating,
  Deleting,
  Moving,
  Failed,
  Succeeded,
  ResolvingDNS,
}

@doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
enum NetworkRuleAction {
  Allow,
  Deny,
}

@doc("Enumerates the possible value of keySource for Encryption")
enum KeySource {
  `Microsoft.CognitiveServices`,
  `Microsoft.KeyVault`,
}

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("Whether or not public endpoint access is allowed for this account.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Multiregion routing methods.")
enum RoutingMethods {
  Priority,
  Weighted,
  Performance,
}

@doc("The action of AbusePenalty.")
enum AbusePenaltyAction {
  Throttle,
  Block,
}

@doc("The reason for restriction.")
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

@doc("The unit of the metric.")
enum UnitType {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountPerSecond,
  BytesPerSecond,
  Milliseconds,
}

@doc("Cognitive Services account quota usage status.")
enum QuotaUsageStatus {
  Included,
  Blocked,
  InOverage,
  Unknown,
}

@doc("Model lifecycle status.")
enum ModelLifecycleStatus {
  GenerallyAvailable,
  Preview,
}

@doc("Account hosting model.")
enum HostingModel {
  Web,
  ConnectedContainer,
  DisconnectedContainer,
  ProvisionedWeb,
}

@doc("Gets the status of the resource at the time the operation was called.")
enum DeploymentProvisioningState {
  Accepted,
  Creating,
  Deleting,
  Moving,
  Failed,
  Succeeded,
  Disabled,
  Canceled,
}

@doc("Deployment scale type.")
enum DeploymentScaleType {
  Standard,
  Manual,
}

@doc("Deployment model version upgrade option.")
enum DeploymentModelVersionUpgradeOption {
  OnceNewDefaultVersionAvailable,
  OnceCurrentVersionExpired,
  NoAutoUpgrade,
}

@doc("Gets the status of the resource at the time the operation was called.")
enum CommitmentPlanProvisioningState {
  Accepted,
  Creating,
  Deleting,
  Moving,
  Failed,
  Succeeded,
  Canceled,
}

@doc("The identity type.")
@fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

@doc("key name to generate (Key1|Key2)")
@fixed
enum KeyName {
  Key1,
  Key2,
}

@doc("The type of restrictions.")
@fixed
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  name: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;

  @doc("The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. ")
  size?: string;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.")
  capacity?: int32;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The identity type.")
  type?: ResourceIdentityType;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The list of user assigned identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Properties of Cognitive Services account.")
model AccountProperties {
  @doc("Gets the status of the cognitive services account at the time the operation was called.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Endpoint of the created account.")
  @visibility("read")
  endpoint?: string;

  @doc("Gets the capabilities of the cognitive services account. Each item indicates the capability of a specific feature. The values are read-only and for reference only.")
  @visibility("read")
  capabilities?: SkuCapability[];

  @doc("If the resource is migrated from an existing key.")
  @visibility("read")
  isMigrated?: boolean;

  @doc("Resource migration token.")
  migrationToken?: string;

  @doc("Sku change info of account.")
  @visibility("read")
  skuChangeInfo?: SkuChangeInfo;

  @doc("Optional subdomain name used for token-based authentication.")
  customSubDomainName?: string;

  @doc("A collection of rules governing the accessibility from specific network locations.")
  networkAcls?: NetworkRuleSet;

  @doc("The encryption properties for this resource.")
  encryption?: Encryption;

  @doc("The storage accounts for this resource.")
  userOwnedStorage?: UserOwnedStorage[];

  @doc("The private endpoint connection associated with the Cognitive Services account.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Whether or not public endpoint access is allowed for this account.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The api properties for special APIs.")
  apiProperties?: ApiProperties;

  @doc("Gets the date of cognitive services account creation.")
  @visibility("read")
  @projectedName("json", "dateCreated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("The call rate limit Cognitive Services account.")
  @visibility("read")
  callRateLimit?: CallRateLimit;

  @doc("The flag to enable dynamic throttling.")
  dynamicThrottlingEnabled?: boolean;

  @visibility("read")
  quotaLimit?: QuotaLimit;

  restrictOutboundNetworkAccess?: boolean;
  allowedFqdnList?: string[];
  disableLocalAuth?: boolean;

  @doc("Dictionary of <string>")
  @visibility("read")
  endpoints?: Record<string>;

  @visibility("create", "update")
  restore?: boolean;

  @doc("The deletion date, only available for deleted account.")
  @visibility("read")
  @projectedName("json", "deletionDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletedOn?: utcDateTime;

  @doc("The scheduled purge date, only available for deleted account.")
  @visibility("read")
  scheduledPurgeDate?: string;

  @doc("The multiregion settings of Cognitive Services account.")
  locations?: MultiRegionSettings;

  @doc("The commitment plan associations of Cognitive Services account.")
  @visibility("read")
  commitmentPlanAssociations?: CommitmentPlanAssociation[];

  @doc("The abuse penalty.")
  @visibility("read")
  abusePenalty?: AbusePenalty;
}

@doc("SkuCapability indicates the capability of a certain feature.")
model SkuCapability {
  @doc("The name of the SkuCapability.")
  name?: string;

  @doc("The value of the SkuCapability.")
  value?: string;
}

@doc("Sku change info of account.")
model SkuChangeInfo {
  @doc("Gets the count of downgrades.")
  countOfDowngrades?: float32;

  @doc("Gets the count of upgrades after downgrades.")
  countOfUpgradesAfterDowngrades?: float32;

  @doc("Gets the last change date.")
  @projectedName("json", "lastChangeDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChangedOn?: utcDateTime;
}

@doc("A set of rules governing the network accessibility.")
model NetworkRuleSet {
  @doc("The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.")
  defaultAction?: NetworkRuleAction;

  @doc("The list of IP address rules.")
  ipRules?: IpRule[];

  @doc("The list of virtual network rules.")
  virtualNetworkRules?: VirtualNetworkRule[];
}

@doc("A rule governing the accessibility from a specific ip address or ip range.")
model IpRule {
  @doc("An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).")
  value: string;
}

@doc("A rule governing the accessibility from a specific virtual network.")
model VirtualNetworkRule {
  @doc("Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.")
  id: string;

  @doc("Gets the state of virtual network rule.")
  state?: string;

  @doc("Ignore missing vnet service endpoint or not.")
  ignoreMissingVnetServiceEndpoint?: boolean;
}

@doc("Properties to configure Encryption")
model Encryption {
  @doc("Properties of KeyVault")
  keyVaultProperties?: KeyVaultProperties;

  @doc("Enumerates the possible value of keySource for Encryption")
  keySource?: KeySource;
}

@doc("Properties to configure keyVault Properties")
model KeyVaultProperties {
  @doc("Name of the Key from KeyVault")
  keyName?: string;

  @doc("Version of the Key from KeyVault")
  keyVersion?: string;

  @doc("Uri of KeyVault")
  keyVaultUri?: string;

  identityClientId?: string;
}

@doc("The user owned storage for Cognitive Services account.")
model UserOwnedStorage {
  @doc("Full resource id of a Microsoft.Storage resource.")
  resourceId?: string;

  identityClientId?: string;
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

  @doc("The private link resource group ids.")
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

@doc("The resource model definition for an Azure Resource Manager resource with an etag.")
model AzureEntityResource extends Resource {
  @doc("Resource Etag.")
  @visibility("read")
  etag?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
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

@doc("The api properties for special APIs.")
model ApiProperties extends Record<Record<unknown>> {
  @doc("(QnAMaker Only) The runtime endpoint of QnAMaker.")
  qnaRuntimeEndpoint?: string;

  @doc("(QnAMaker Only) The Azure Search endpoint key of QnAMaker.")
  qnaAzureSearchEndpointKey?: string;

  @doc("(QnAMaker Only) The Azure Search endpoint id of QnAMaker.")
  qnaAzureSearchEndpointId?: string;

  @doc("(Bing Search Only) The flag to enable statistics of Bing Search.")
  statisticsEnabled?: boolean;

  @doc("(Personalization Only) The flag to enable statistics of Bing Search.")
  @maxLength(1000)
  @pattern("^( *)Endpoint=sb://(.*);( *)SharedAccessKeyName=(.*);( *)SharedAccessKey=(.*)$")
  eventHubConnectionString?: string;

  @doc("(Personalization Only) The storage account connection string.")
  @maxLength(1000)
  @pattern("^(( *)DefaultEndpointsProtocol=(http|https)( *);( *))?AccountName=(.*)AccountKey=(.*)EndpointSuffix=(.*)$")
  storageAccountConnectionString?: string;

  @doc("(Metrics Advisor Only) The Azure AD Client Id (Application Id).")
  @maxLength(500)
  aadClientId?: string;

  @doc("(Metrics Advisor Only) The Azure AD Tenant Id.")
  @maxLength(500)
  aadTenantId?: string;

  @doc("(Metrics Advisor Only) The super user of Metrics Advisor.")
  @maxLength(500)
  superUser?: string;

  @doc("(Metrics Advisor Only) The website name of Metrics Advisor.")
  @maxLength(500)
  websiteName?: string;
}

@doc("The call rate limit Cognitive Services account.")
model CallRateLimit {
  @doc("The count value of Call Rate Limit.")
  count?: float32;

  @doc("The renewal period in seconds of Call Rate Limit.")
  renewalPeriod?: float32;

  rules?: ThrottlingRule[];
}

model ThrottlingRule {
  key?: string;
  renewalPeriod?: float32;
  count?: float32;
  minCount?: float32;
  dynamicThrottlingEnabled?: boolean;
  matchPatterns?: RequestMatchPattern[];
}

model RequestMatchPattern {
  path?: string;
  method?: string;
}

model QuotaLimit {
  count?: float32;
  renewalPeriod?: float32;
  rules?: ThrottlingRule[];
}

@doc("The multiregion settings Cognitive Services account.")
model MultiRegionSettings {
  @doc("Multiregion routing methods.")
  routingMethod?: RoutingMethods;

  regions?: RegionSetting[];
}

@doc("The call rate limit Cognitive Services account.")
model RegionSetting {
  @doc("Name of the region.")
  name?: string;

  @doc("A value for priority or weighted routing methods.")
  value?: float32;

  @doc("Maps the region to the regional custom subdomain.")
  customsubdomain?: string;
}

@doc("The commitment plan association.")
model CommitmentPlanAssociation {
  @doc("The Azure resource id of the commitment plan.")
  commitmentPlanId?: string;

  @doc("The location of of the commitment plan.")
  commitmentPlanLocation?: string;
}

@doc("The abuse penalty.")
model AbusePenalty {
  @doc("The action of AbusePenalty.")
  action?: AbusePenaltyAction;

  @doc("The percentage of rate limit.")
  rateLimitPercentage?: float32;

  @doc("The datetime of expiration of the AbusePenalty.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;
}

@doc("The access keys for the cognitive services account.")
model ApiKeys {
  @doc("Gets the value of key 1.")
  key1?: string;

  @doc("Gets the value of key 2.")
  key2?: string;
}

@doc("Regenerate key parameters.")
model RegenerateKeyParameters {
  @doc("key name to generate (Key1|Key2)")
  keyName: KeyName;
}

@doc("The Get Skus operation response.")
model ResourceSkuListResult is Azure.Core.Page<ResourceSku>;

@doc("Describes restrictions of a SKU.")
model ResourceSkuRestrictions {
  @doc("The type of restrictions.")
  type?: ResourceSkuRestrictionsType;

  @doc("The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.")
  values?: string[];

  @doc("The information about the restriction where the SKU cannot be used.")
  restrictionInfo?: ResourceSkuRestrictionInfo;

  @doc("The reason for restriction.")
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

model ResourceSkuRestrictionInfo {
  @doc("Locations where the SKU is restricted")
  locations?: string[];

  @doc("List of availability zones where the SKU is restricted.")
  zones?: string[];
}

@doc("The list of cognitive services accounts operation response.")
model AccountSkuListResult {
  @doc("Gets the list of Cognitive Services accounts and their properties.")
  value?: AccountSku[];
}

@doc("Cognitive Services resource type and SKU.")
model AccountSku {
  @doc("Resource Namespace and Type")
  resourceType?: string;

  @doc("The SKU of Cognitive Services account.")
  sku?: Sku;
}

@doc("The response to a list usage request.")
model UsageListResult is Azure.Core.Page<Usage>;

@doc("The usage data for a usage request.")
model Usage {
  @doc("The unit of the metric.")
  unit?: UnitType;

  @doc("The name information for the metric.")
  name?: MetricName;

  @doc("The quota period used to summarize the usage values.")
  quotaPeriod?: string;

  @doc("Maximum value for this metric.")
  limit?: float32;

  @doc("Current value for this metric.")
  currentValue?: float32;

  @doc("Next reset time for current quota.")
  nextResetTime?: string;

  @doc("Cognitive Services account quota usage status.")
  status?: QuotaUsageStatus;
}

@doc("A metric name.")
model MetricName {
  @doc("The name of the metric.")
  value?: string;

  @doc("The friendly name of the metric.")
  localizedValue?: string;
}

@doc("The list of cognitive services accounts operation response.")
model AccountModelListResult is Azure.Core.Page<AccountModel>;

@doc("Cognitive Services account Model.")
model AccountModel extends DeploymentModel {
  @doc("Base Model Identifier.")
  baseModel?: DeploymentModel;

  @doc("If the model is default version.")
  isDefaultVersion?: boolean;

  @doc("The list of Model Sku.")
  skus?: ModelSku[];

  @doc("The max capacity.")
  maxCapacity?: int32;

  @doc("The capabilities.")
  capabilities?: Record<string>;

  @doc("The capabilities for finetune models.")
  finetuneCapabilities?: Record<string>;

  @doc("Cognitive Services account ModelDeprecationInfo.")
  deprecation?: ModelDeprecationInfo;

  @doc("Model lifecycle status.")
  lifecycleStatus?: ModelLifecycleStatus;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Properties of Cognitive Services account deployment model.")
model DeploymentModel {
  @doc("Deployment model format.")
  format?: string;

  @doc("Deployment model name.")
  name?: string;

  @doc("Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.")
  version?: string;

  @doc("Optional. Deployment model source ARM resource ID.")
  source?: string;

  @doc("The call rate limit Cognitive Services account.")
  @visibility("read")
  callRateLimit?: CallRateLimit;
}

@doc("Describes an available Cognitive Services Model SKU.")
model ModelSku {
  @doc("The name of the model SKU.")
  name?: string;

  @doc("The usage name of the model SKU.")
  usageName?: string;

  @doc("The datetime of deprecation of the model SKU.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deprecationDate?: utcDateTime;

  @doc("The capacity configuration.")
  capacity?: CapacityConfig;

  @doc("The list of rateLimit.")
  @visibility("read")
  rateLimits?: CallRateLimit[];
}

@doc("The capacity configuration.")
model CapacityConfig {
  @doc("The minimum capacity.")
  minimum?: int32;

  @doc("The maximum capacity.")
  maximum?: int32;

  @doc("The minimal incremental between allowed values for capacity.")
  step?: int32;

  @doc("The default capacity.")
  default?: int32;
}

@doc("Cognitive Services account ModelDeprecationInfo.")
model ModelDeprecationInfo {
  @doc("The datetime of deprecation of the fineTune Model.")
  @projectedName("json", "fineTune")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fineTuneOn?: utcDateTime;

  @doc("The datetime of deprecation of the inference Model.")
  @projectedName("json", "inference")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inferenceOn?: utcDateTime;
}

@doc("Check SKU availability parameter.")
model CheckSkuAvailabilityParameter {
  @doc("The SKU of the resource.")
  skus: string[];

  @doc("The Kind of the resource.")
  kind: string;

  @doc("The Type of the resource.")
  type: string;
}

@doc("Check SKU availability result list.")
model SkuAvailabilityListResult {
  @doc("Check SKU availability result list.")
  value?: SkuAvailability[];
}

@doc("SKU availability.")
model SkuAvailability {
  @doc("The Kind of the resource.")
  kind?: string;

  @doc("The Type of the resource.")
  type?: string;

  @doc("The SKU of Cognitive Services account.")
  skuName?: string;

  @doc("Indicates the given SKU is available or not.")
  skuAvailable?: boolean;

  @doc("Reason why the SKU is not available.")
  reason?: string;

  @doc("Additional error message.")
  message?: string;
}

@doc("The list of cognitive services accounts operation response.")
model CommitmentTierListResult is Azure.Core.Page<CommitmentTier>;

@doc("Cognitive Services account commitment tier.")
model CommitmentTier {
  @doc("The Kind of the resource.")
  kind?: string;

  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  skuName?: string;

  @doc("Account hosting model.")
  hostingModel?: HostingModel;

  @doc("Commitment plan type.")
  planType?: string;

  @doc("Commitment period commitment tier.")
  tier?: string;

  @doc("Commitment period commitment max count.")
  maxCount?: int32;

  @doc("Cognitive Services account commitment quota.")
  quota?: CommitmentQuota;

  @doc("Cognitive Services account commitment cost.")
  cost?: CommitmentCost;
}

@doc("Cognitive Services account commitment quota.")
model CommitmentQuota {
  @doc("Commitment quota quantity.")
  quantity?: int32;

  @doc("Commitment quota unit.")
  unit?: string;
}

@doc("Cognitive Services account commitment cost.")
model CommitmentCost {
  @doc("Commitment meter Id.")
  commitmentMeterId?: string;

  @doc("Overage meter Id.")
  overageMeterId?: string;
}

@doc("The list of cognitive services models.")
model ModelListResult is Azure.Core.Page<Model>;

@doc("Cognitive Services Model.")
model Model {
  @doc("Model Metadata.")
  `model`?: AccountModel;

  @doc("The Kind of the Model.")
  kind?: string;

  @doc("The SKU of the Model.")
  skuName?: string;
}

@doc("Check Domain availability parameter.")
model CheckDomainAvailabilityParameter {
  @doc("The subdomain name to use.")
  subdomainName: string;

  @doc("The Type of the resource.")
  type: string;

  @doc("The Kind of the resource.")
  kind?: string;
}

@doc("Domain availability.")
model DomainAvailability {
  @doc("Indicates the given SKU is available or not.")
  isSubdomainAvailable?: boolean;

  @doc("Reason why the SKU is not available.")
  reason?: string;

  @doc("The subdomain name to use.")
  subdomainName?: string;

  @doc("The Type of the resource.")
  type?: string;

  @doc("The Kind of the resource.")
  kind?: string;
}

@doc("A list of private link resources")
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends Resource {
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

  @doc("The private link resource display name.")
  @visibility("read")
  displayName?: string;
}

@doc("Properties of Cognitive Services account deployment.")
model DeploymentProperties {
  @doc("Gets the status of the resource at the time the operation was called.")
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  @doc("Properties of Cognitive Services account deployment model.")
  `model`?: DeploymentModel;

  @doc("Properties of Cognitive Services account deployment model.")
  scaleSettings?: DeploymentScaleSettings;

  @doc("The capabilities.")
  @visibility("read")
  capabilities?: Record<string>;

  @doc("The name of RAI policy.")
  raiPolicyName?: string;

  @doc("The call rate limit Cognitive Services account.")
  @visibility("read")
  callRateLimit?: CallRateLimit;

  @visibility("read")
  rateLimits?: ThrottlingRule[];

  @doc("Deployment model version upgrade option.")
  versionUpgradeOption?: DeploymentModelVersionUpgradeOption;
}

@doc("Properties of Cognitive Services account deployment model.")
model DeploymentScaleSettings {
  @doc("Deployment scale type.")
  scaleType?: DeploymentScaleType;

  @doc("Deployment capacity.")
  capacity?: int32;

  @doc("Deployment active capacity. This value might be different from `capacity` if customer recently updated `capacity`.")
  @visibility("read")
  activeCapacity?: int32;
}

@doc("Properties of Cognitive Services account commitment plan.")
model CommitmentPlanProperties {
  @doc("Gets the status of the resource at the time the operation was called.")
  @visibility("read")
  provisioningState?: CommitmentPlanProvisioningState;

  @doc("Commitment plan guid.")
  commitmentPlanGuid?: string;

  @doc("Account hosting model.")
  hostingModel?: HostingModel;

  @doc("Commitment plan type.")
  planType?: string;

  @doc("Cognitive Services account commitment period.")
  current?: CommitmentPeriod;

  @doc("AutoRenew commitment plan.")
  autoRenew?: boolean;

  @doc("Cognitive Services account commitment period.")
  next?: CommitmentPeriod;

  @doc("Cognitive Services account commitment period.")
  @visibility("read")
  last?: CommitmentPeriod;

  @doc("The list of ProvisioningIssue.")
  @visibility("read")
  provisioningIssues?: string[];
}

@doc("Cognitive Services account commitment period.")
model CommitmentPeriod {
  @doc("Commitment period commitment tier.")
  tier?: string;

  @doc("Commitment period commitment count.")
  count?: int32;

  @doc("Cognitive Services account commitment quota.")
  @visibility("read")
  quota?: CommitmentQuota;

  @doc("Commitment period start date.")
  @visibility("read")
  @projectedName("json", "startDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startOn?: utcDateTime;

  @doc("Commitment period end date.")
  @visibility("read")
  @projectedName("json", "endDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOn?: utcDateTime;
}

@doc("The object being used to update tags and sku of a resource, in general used for PATCH operations.")
model PatchResourceTagsAndSku extends PatchResourceTags {
  @doc("The resource model definition representing SKU")
  sku?: Sku;
}

@doc("The object being used to update tags of a resource, in general used for PATCH operations.")
model PatchResourceTags {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("The commitment plan account association properties.")
model CommitmentPlanAccountAssociationProperties {
  @doc("The Azure resource id of the account.")
  accountId?: string;
}
