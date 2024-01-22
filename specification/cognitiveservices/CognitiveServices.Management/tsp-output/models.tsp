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

/**
 * Gets the status of the cognitive services account at the time the operation was called.
 */
enum ProvisioningState {
  Accepted,
  Creating,
  Deleting,
  Moving,
  Failed,
  Succeeded,
  ResolvingDNS,
}

/**
 * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
 */
enum NetworkRuleAction {
  Allow,
  Deny,
}

/**
 * Enumerates the possible value of keySource for Encryption
 */
enum KeySource {
  `Microsoft.CognitiveServices`,
  `Microsoft.KeyVault`,
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
 * Whether or not public endpoint access is allowed for this account.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Multiregion routing methods.
 */
enum RoutingMethods {
  Priority,
  Weighted,
  Performance,
}

/**
 * The action of AbusePenalty.
 */
enum AbusePenaltyAction {
  Throttle,
  Block,
}

/**
 * The reason for restriction.
 */
enum ResourceSkuRestrictionsReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

/**
 * The unit of the metric.
 */
enum UnitType {
  Count,
  Bytes,
  Seconds,
  Percent,
  CountPerSecond,
  BytesPerSecond,
  Milliseconds,
}

/**
 * Cognitive Services account quota usage status.
 */
enum QuotaUsageStatus {
  Included,
  Blocked,
  InOverage,
  Unknown,
}

/**
 * Model lifecycle status.
 */
enum ModelLifecycleStatus {
  GenerallyAvailable,
  Preview,
}

/**
 * Account hosting model.
 */
enum HostingModel {
  Web,
  ConnectedContainer,
  DisconnectedContainer,
  ProvisionedWeb,
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
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

/**
 * Deployment scale type.
 */
enum DeploymentScaleType {
  Standard,
  Manual,
}

/**
 * Deployment model version upgrade option.
 */
enum DeploymentModelVersionUpgradeOption {
  OnceNewDefaultVersionAvailable,
  OnceCurrentVersionExpired,
  NoAutoUpgrade,
}

/**
 * Gets the status of the resource at the time the operation was called.
 */
enum CommitmentPlanProvisioningState {
  Accepted,
  Creating,
  Deleting,
  Moving,
  Failed,
  Succeeded,
  Canceled,
}

/**
 * The identity type.
 */
@fixed
enum ResourceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * key name to generate (Key1|Key2)
 */
@fixed
enum KeyName {
  Key1,
  Key2,
}

/**
 * The type of restrictions.
 */
@fixed
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The list of user assigned identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Properties of Cognitive Services account.
 */
model AccountProperties {
  /**
   * Gets the status of the cognitive services account at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Endpoint of the created account.
   */
  @visibility("read")
  endpoint?: string;

  /**
   * Gets the capabilities of the cognitive services account. Each item indicates the capability of a specific feature. The values are read-only and for reference only.
   */
  @visibility("read")
  capabilities?: SkuCapability[];

  /**
   * If the resource is migrated from an existing key.
   */
  @visibility("read")
  isMigrated?: boolean;

  /**
   * Resource migration token.
   */
  migrationToken?: string;

  /**
   * Sku change info of account.
   */
  @visibility("read")
  skuChangeInfo?: SkuChangeInfo;

  /**
   * Optional subdomain name used for token-based authentication.
   */
  customSubDomainName?: string;

  /**
   * A collection of rules governing the accessibility from specific network locations.
   */
  networkAcls?: NetworkRuleSet;

  /**
   * The encryption properties for this resource.
   */
  encryption?: Encryption;

  /**
   * The storage accounts for this resource.
   */
  userOwnedStorage?: UserOwnedStorage[];

  /**
   * The private endpoint connection associated with the Cognitive Services account.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Whether or not public endpoint access is allowed for this account.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The api properties for special APIs.
   */
  apiProperties?: ApiProperties;

  /**
   * Gets the date of cognitive services account creation.
   */
  @visibility("read")
  @projectedName("json", "dateCreated")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility("read")
  callRateLimit?: CallRateLimit;

  /**
   * The flag to enable dynamic throttling.
   */
  dynamicThrottlingEnabled?: boolean;

  @visibility("read")
  quotaLimit?: QuotaLimit;

  restrictOutboundNetworkAccess?: boolean;
  allowedFqdnList?: string[];
  disableLocalAuth?: boolean;

  /**
   * Dictionary of <string>
   */
  @visibility("read")
  endpoints?: Record<string>;

  @visibility("create", "update")
  restore?: boolean;

  /**
   * The deletion date, only available for deleted account.
   */
  @visibility("read")
  @projectedName("json", "deletionDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletedOn?: utcDateTime;

  /**
   * The scheduled purge date, only available for deleted account.
   */
  @visibility("read")
  scheduledPurgeDate?: string;

  /**
   * The multiregion settings of Cognitive Services account.
   */
  locations?: MultiRegionSettings;

  /**
   * The commitment plan associations of Cognitive Services account.
   */
  @visibility("read")
  commitmentPlanAssociations?: CommitmentPlanAssociation[];

  /**
   * The abuse penalty.
   */
  @visibility("read")
  abusePenalty?: AbusePenalty;
}

/**
 * SkuCapability indicates the capability of a certain feature.
 */
model SkuCapability {
  /**
   * The name of the SkuCapability.
   */
  name?: string;

  /**
   * The value of the SkuCapability.
   */
  value?: string;
}

/**
 * Sku change info of account.
 */
model SkuChangeInfo {
  /**
   * Gets the count of downgrades.
   */
  countOfDowngrades?: float32;

  /**
   * Gets the count of upgrades after downgrades.
   */
  countOfUpgradesAfterDowngrades?: float32;

  /**
   * Gets the last change date.
   */
  @projectedName("json", "lastChangeDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChangedOn?: utcDateTime;
}

/**
 * A set of rules governing the network accessibility.
 */
model NetworkRuleSet {
  /**
   * The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated.
   */
  defaultAction?: NetworkRuleAction;

  /**
   * The list of IP address rules.
   */
  ipRules?: IpRule[];

  /**
   * The list of virtual network rules.
   */
  virtualNetworkRules?: VirtualNetworkRule[];
}

/**
 * A rule governing the accessibility from a specific ip address or ip range.
 */
model IpRule {
  /**
   * An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78).
   */
  value: string;
}

/**
 * A rule governing the accessibility from a specific virtual network.
 */
model VirtualNetworkRule {
  /**
   * Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'.
   */
  id: string;

  /**
   * Gets the state of virtual network rule.
   */
  state?: string;

  /**
   * Ignore missing vnet service endpoint or not.
   */
  ignoreMissingVnetServiceEndpoint?: boolean;
}

/**
 * Properties to configure Encryption
 */
model Encryption {
  /**
   * Properties of KeyVault
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Enumerates the possible value of keySource for Encryption
   */
  keySource?: KeySource = KeySource.Microsoft.KeyVault;
}

/**
 * Properties to configure keyVault Properties
 */
model KeyVaultProperties {
  /**
   * Name of the Key from KeyVault
   */
  keyName?: string;

  /**
   * Version of the Key from KeyVault
   */
  keyVersion?: string;

  /**
   * Uri of KeyVault
   */
  keyVaultUri?: string;

  identityClientId?: string;
}

/**
 * The user owned storage for Cognitive Services account.
 */
model UserOwnedStorage {
  /**
   * Full resource id of a Microsoft.Storage resource.
   */
  resourceId?: string;

  identityClientId?: string;
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
   * The private link resource group ids.
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
 * The resource model definition for an Azure Resource Manager resource with an etag.
 */
model AzureEntityResource extends Resource {
  /**
   * Resource Etag.
   */
  @visibility("read")
  etag?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
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
 * The api properties for special APIs.
 */
model ApiProperties extends Record<Record<unknown>> {
  /**
   * (QnAMaker Only) The runtime endpoint of QnAMaker.
   */
  qnaRuntimeEndpoint?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint key of QnAMaker.
   */
  qnaAzureSearchEndpointKey?: string;

  /**
   * (QnAMaker Only) The Azure Search endpoint id of QnAMaker.
   */
  qnaAzureSearchEndpointId?: string;

  /**
   * (Bing Search Only) The flag to enable statistics of Bing Search.
   */
  statisticsEnabled?: boolean;

  /**
   * (Personalization Only) The flag to enable statistics of Bing Search.
   */
  @maxLength(1000)
  @pattern("^( *)Endpoint=sb://(.*);( *)SharedAccessKeyName=(.*);( *)SharedAccessKey=(.*)$")
  eventHubConnectionString?: string;

  /**
   * (Personalization Only) The storage account connection string.
   */
  @maxLength(1000)
  @pattern("^(( *)DefaultEndpointsProtocol=(http|https)( *);( *))?AccountName=(.*)AccountKey=(.*)EndpointSuffix=(.*)$")
  storageAccountConnectionString?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Client Id (Application Id).
   */
  @maxLength(500)
  aadClientId?: string;

  /**
   * (Metrics Advisor Only) The Azure AD Tenant Id.
   */
  @maxLength(500)
  aadTenantId?: string;

  /**
   * (Metrics Advisor Only) The super user of Metrics Advisor.
   */
  @maxLength(500)
  superUser?: string;

  /**
   * (Metrics Advisor Only) The website name of Metrics Advisor.
   */
  @maxLength(500)
  websiteName?: string;
}

/**
 * The call rate limit Cognitive Services account.
 */
model CallRateLimit {
  /**
   * The count value of Call Rate Limit.
   */
  count?: float32;

  /**
   * The renewal period in seconds of Call Rate Limit.
   */
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

/**
 * The multiregion settings Cognitive Services account.
 */
model MultiRegionSettings {
  /**
   * Multiregion routing methods.
   */
  routingMethod?: RoutingMethods;

  regions?: RegionSetting[];
}

/**
 * The call rate limit Cognitive Services account.
 */
model RegionSetting {
  /**
   * Name of the region.
   */
  name?: string;

  /**
   * A value for priority or weighted routing methods.
   */
  value?: float32;

  /**
   * Maps the region to the regional custom subdomain.
   */
  customsubdomain?: string;
}

/**
 * The commitment plan association.
 */
model CommitmentPlanAssociation {
  /**
   * The Azure resource id of the commitment plan.
   */
  commitmentPlanId?: string;

  /**
   * The location of of the commitment plan.
   */
  commitmentPlanLocation?: string;
}

/**
 * The abuse penalty.
 */
model AbusePenalty {
  /**
   * The action of AbusePenalty.
   */
  action?: AbusePenaltyAction;

  /**
   * The percentage of rate limit.
   */
  rateLimitPercentage?: float32;

  /**
   * The datetime of expiration of the AbusePenalty.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;
}

/**
 * The access keys for the cognitive services account.
 */
model ApiKeys {
  /**
   * Gets the value of key 1.
   */
  key1?: string;

  /**
   * Gets the value of key 2.
   */
  key2?: string;
}

/**
 * Regenerate key parameters.
 */
model RegenerateKeyParameters {
  /**
   * key name to generate (Key1|Key2)
   */
  keyName: KeyName;
}

/**
 * The Get Skus operation response.
 */
model ResourceSkuListResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes restrictions of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  values?: string[];

  /**
   * The information about the restriction where the SKU cannot be used.
   */
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  zones?: string[];
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountSkuListResult {
  /**
   * Gets the list of Cognitive Services accounts and their properties.
   */
  value?: AccountSku[];
}

/**
 * Cognitive Services resource type and SKU.
 */
model AccountSku {
  /**
   * Resource Namespace and Type
   */
  resourceType?: string;

  /**
   * The SKU of Cognitive Services account.
   */
  sku?: Sku;
}

/**
 * The response to a list usage request.
 */
model UsageListResult is Azure.Core.Page<Usage>;

/**
 * The usage data for a usage request.
 */
model Usage {
  /**
   * The unit of the metric.
   */
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  name?: MetricName;

  /**
   * The quota period used to summarize the usage values.
   */
  quotaPeriod?: string;

  /**
   * Maximum value for this metric.
   */
  limit?: float64;

  /**
   * Current value for this metric.
   */
  currentValue?: float64;

  /**
   * Next reset time for current quota.
   */
  nextResetTime?: string;

  /**
   * Cognitive Services account quota usage status.
   */
  status?: QuotaUsageStatus;
}

/**
 * A metric name.
 */
model MetricName {
  /**
   * The name of the metric.
   */
  value?: string;

  /**
   * The friendly name of the metric.
   */
  localizedValue?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model AccountModelListResult is Azure.Core.Page<AccountModel>;

/**
 * Cognitive Services account Model.
 */
model AccountModel extends DeploymentModel {
  /**
   * Base Model Identifier.
   */
  baseModel?: DeploymentModel;

  /**
   * If the model is default version.
   */
  isDefaultVersion?: boolean;

  /**
   * The list of Model Sku.
   */
  skus?: ModelSku[];

  /**
   * The max capacity.
   */
  maxCapacity?: int32;

  /**
   * The capabilities.
   */
  capabilities?: Record<string>;

  /**
   * The capabilities for finetune models.
   */
  finetuneCapabilities?: Record<string>;

  /**
   * Cognitive Services account ModelDeprecationInfo.
   */
  deprecation?: ModelDeprecationInfo;

  /**
   * Model lifecycle status.
   */
  lifecycleStatus?: ModelLifecycleStatus;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Properties of Cognitive Services account deployment model.
 */
model DeploymentModel {
  /**
   * Deployment model format.
   */
  format?: string;

  /**
   * Deployment model name.
   */
  name?: string;

  /**
   * Optional. Deployment model version. If version is not specified, a default version will be assigned. The default version is different for different models and might change when there is new version available for a model. Default version for a model could be found from list models API.
   */
  version?: string;

  /**
   * Optional. Deployment model source ARM resource ID.
   */
  source?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility("read")
  callRateLimit?: CallRateLimit;
}

/**
 * Describes an available Cognitive Services Model SKU.
 */
model ModelSku {
  /**
   * The name of the model SKU.
   */
  name?: string;

  /**
   * The usage name of the model SKU.
   */
  usageName?: string;

  /**
   * The datetime of deprecation of the model SKU.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deprecationDate?: utcDateTime;

  /**
   * The capacity configuration.
   */
  capacity?: CapacityConfig;

  /**
   * The list of rateLimit.
   */
  @visibility("read")
  rateLimits?: CallRateLimit[];
}

/**
 * The capacity configuration.
 */
model CapacityConfig {
  /**
   * The minimum capacity.
   */
  minimum?: int32;

  /**
   * The maximum capacity.
   */
  maximum?: int32;

  /**
   * The minimal incremental between allowed values for capacity.
   */
  step?: int32;

  /**
   * The default capacity.
   */
  default?: int32;
}

/**
 * Cognitive Services account ModelDeprecationInfo.
 */
model ModelDeprecationInfo {
  /**
   * The datetime of deprecation of the fineTune Model.
   */
  @projectedName("json", "fineTune")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fineTuneOn?: utcDateTime;

  /**
   * The datetime of deprecation of the inference Model.
   */
  @projectedName("json", "inference")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  inferenceOn?: utcDateTime;
}

/**
 * Check SKU availability parameter.
 */
model CheckSkuAvailabilityParameter {
  /**
   * The SKU of the resource.
   */
  skus: string[];

  /**
   * The Kind of the resource.
   */
  kind: string;

  /**
   * The Type of the resource.
   */
  type: string;
}

/**
 * Check SKU availability result list.
 */
model SkuAvailabilityListResult {
  /**
   * Check SKU availability result list.
   */
  value?: SkuAvailability[];
}

/**
 * SKU availability.
 */
model SkuAvailability {
  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The SKU of Cognitive Services account.
   */
  skuName?: string;

  /**
   * Indicates the given SKU is available or not.
   */
  skuAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * Additional error message.
   */
  message?: string;
}

/**
 * The list of cognitive services accounts operation response.
 */
model CommitmentTierListResult is Azure.Core.Page<CommitmentTier>;

/**
 * Cognitive Services account commitment tier.
 */
model CommitmentTier {
  /**
   * The Kind of the resource.
   */
  kind?: string;

  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  skuName?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment max count.
   */
  maxCount?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  quota?: CommitmentQuota;

  /**
   * Cognitive Services account commitment cost.
   */
  cost?: CommitmentCost;
}

/**
 * Cognitive Services account commitment quota.
 */
model CommitmentQuota {
  /**
   * Commitment quota quantity.
   */
  quantity?: int64;

  /**
   * Commitment quota unit.
   */
  unit?: string;
}

/**
 * Cognitive Services account commitment cost.
 */
model CommitmentCost {
  /**
   * Commitment meter Id.
   */
  commitmentMeterId?: string;

  /**
   * Overage meter Id.
   */
  overageMeterId?: string;
}

/**
 * The list of cognitive services models.
 */
model ModelListResult is Azure.Core.Page<Model>;

/**
 * Cognitive Services Model.
 */
model Model {
  /**
   * Model Metadata.
   */
  `model`?: AccountModel;

  /**
   * The Kind of the Model.
   */
  kind?: string;

  /**
   * The SKU of the Model.
   */
  skuName?: string;
}

/**
 * Check Domain availability parameter.
 */
model CheckDomainAvailabilityParameter {
  /**
   * The subdomain name to use.
   */
  subdomainName: string;

  /**
   * The Type of the resource.
   */
  type: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;
}

/**
 * Domain availability.
 */
model DomainAvailability {
  /**
   * Indicates the given SKU is available or not.
   */
  isSubdomainAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * The subdomain name to use.
   */
  subdomainName?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The Kind of the resource.
   */
  kind?: string;
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
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
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

  /**
   * The private link resource display name.
   */
  @visibility("read")
  displayName?: string;
}

/**
 * Properties of Cognitive Services account deployment.
 */
model DeploymentProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: DeploymentProvisioningState;

  /**
   * Properties of Cognitive Services account deployment model.
   */
  `model`?: DeploymentModel;

  /**
   * Properties of Cognitive Services account deployment model.
   */
  scaleSettings?: DeploymentScaleSettings;

  /**
   * The capabilities.
   */
  @visibility("read")
  capabilities?: Record<string>;

  /**
   * The name of RAI policy.
   */
  raiPolicyName?: string;

  /**
   * The call rate limit Cognitive Services account.
   */
  @visibility("read")
  callRateLimit?: CallRateLimit;

  @visibility("read")
  rateLimits?: ThrottlingRule[];

  /**
   * Deployment model version upgrade option.
   */
  versionUpgradeOption?: DeploymentModelVersionUpgradeOption;
}

/**
 * Properties of Cognitive Services account deployment model.
 */
model DeploymentScaleSettings {
  /**
   * Deployment scale type.
   */
  scaleType?: DeploymentScaleType;

  /**
   * Deployment capacity.
   */
  capacity?: int32;

  /**
   * Deployment active capacity. This value might be different from `capacity` if customer recently updated `capacity`.
   */
  @visibility("read")
  activeCapacity?: int32;
}

/**
 * Properties of Cognitive Services account commitment plan.
 */
model CommitmentPlanProperties {
  /**
   * Gets the status of the resource at the time the operation was called.
   */
  @visibility("read")
  provisioningState?: CommitmentPlanProvisioningState;

  /**
   * Commitment plan guid.
   */
  commitmentPlanGuid?: string;

  /**
   * Account hosting model.
   */
  hostingModel?: HostingModel;

  /**
   * Commitment plan type.
   */
  planType?: string;

  /**
   * Cognitive Services account commitment period.
   */
  current?: CommitmentPeriod;

  /**
   * AutoRenew commitment plan.
   */
  autoRenew?: boolean;

  /**
   * Cognitive Services account commitment period.
   */
  next?: CommitmentPeriod;

  /**
   * Cognitive Services account commitment period.
   */
  @visibility("read")
  last?: CommitmentPeriod;

  /**
   * The list of ProvisioningIssue.
   */
  @visibility("read")
  provisioningIssues?: string[];
}

/**
 * Cognitive Services account commitment period.
 */
model CommitmentPeriod {
  /**
   * Commitment period commitment tier.
   */
  tier?: string;

  /**
   * Commitment period commitment count.
   */
  count?: int32;

  /**
   * Cognitive Services account commitment quota.
   */
  @visibility("read")
  quota?: CommitmentQuota;

  /**
   * Commitment period start date.
   */
  @visibility("read")
  @projectedName("json", "startDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startOn?: utcDateTime;

  /**
   * Commitment period end date.
   */
  @visibility("read")
  @projectedName("json", "endDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endOn?: utcDateTime;
}

/**
 * The object being used to update tags and sku of a resource, in general used for PATCH operations.
 */
model PatchResourceTagsAndSku extends PatchResourceTags {
  /**
   * The resource model definition representing SKU
   */
  sku?: Sku;
}

/**
 * The object being used to update tags of a resource, in general used for PATCH operations.
 */
model PatchResourceTags {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * The commitment plan account association properties.
 */
model CommitmentPlanAccountAssociationProperties {
  /**
   * The Azure resource id of the account.
   */
  accountId?: string;
}
