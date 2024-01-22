import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataLakeAnalytics;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The type of AAD object the object identifier refers to.
 */
enum AADObjectType {
  User,
  Group,
  ServicePrincipal,
}

/**
 * The intended executor of the operation.
 */
enum OperationOrigin {
  user,
  system,
  `user,system`,
}

/**
 * The subscription state.
 */
enum SubscriptionState {
  Registered,
  Suspended,
  Deleted,
  Unregistered,
  Warned,
}

/**
 * The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeAnalytics/accounts
 */
enum CheckNameAvailabilityParametersType {
  `Microsoft.DataLakeAnalytics/accounts`,
}

/**
 * The provisioning status of the Data Lake Analytics account.
 */
@fixed
enum DataLakeAnalyticsAccountStatus {
  Failed,
  Creating,
  Running,
  Succeeded,
  Patching,
  Suspending,
  Resuming,
  Deleting,
  Deleted,
  Undeleting,
  Canceled,
}

/**
 * The state of the Data Lake Analytics account.
 */
@fixed
enum DataLakeAnalyticsAccountState {
  Active,
  Suspended,
}

/**
 * The current state of the IP address firewall for this account.
 */
@fixed
enum FirewallState {
  Enabled,
  Disabled,
}

/**
 * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
 */
@fixed
enum FirewallAllowAzureIpsState {
  Enabled,
  Disabled,
}

/**
 * The commitment tier for the next month.
 */
@fixed
enum TierType {
  Consumption,
  Commitment_100AUHours,
  Commitment_500AUHours,
  Commitment_1000AUHours,
  Commitment_5000AUHours,
  Commitment_10000AUHours,
  Commitment_50000AUHours,
  Commitment_100000AUHours,
  Commitment_500000AUHours,
}

/**
 * The current state of the NestedResourceProvisioning for this account.
 */
@fixed
enum NestedResourceProvisioningState {
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The current state of the VirtualNetworkRule for this account.
 */
@fixed
enum VirtualNetworkRuleState {
  Active,
  NetworkSourceDeleted,
  Failed,
}

/**
 * The current state of the DebugDataAccessLevel for this account.
 */
@fixed
enum DebugDataAccessLevel {
  All,
  Customer,
  None,
}

/**
 * A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.
 */
model DataLakeAnalyticsAccountBasic extends Resource {
  /**
   * The properties defined by Data Lake Analytics all properties are specific to each resource provider.
   */
  @visibility("read")
  properties?: DataLakeAnalyticsAccountPropertiesBasic;
}

/**
 * The basic account specific properties that are associated with an underlying Data Lake Analytics account.
 */
model DataLakeAnalyticsAccountPropertiesBasic {
  /**
   * The unique identifier associated with this Data Lake Analytics account.
   */
  @visibility("read")
  accountId?: string;

  /**
   * The provisioning status of the Data Lake Analytics account.
   */
  @visibility("read")
  provisioningState?: DataLakeAnalyticsAccountStatus;

  /**
   * The state of the Data Lake Analytics account.
   */
  @visibility("read")
  state?: DataLakeAnalyticsAccountState;

  /**
   * The account creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The account last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The full CName endpoint for this account.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource location.
   */
  @visibility("read")
  location?: string;

  /**
   * The resource tags.
   */
  @visibility("read")
  tags?: Record<string>;
}

/**
 * The parameters to use for creating a Data Lake Analytics account.
 */
model CreateDataLakeAnalyticsAccountParameters {
  /**
   * The resource location.
   */
  location: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * The Data Lake Analytics account properties to use for creating.
   */
  properties: CreateDataLakeAnalyticsAccountProperties;
}

model CreateDataLakeAnalyticsAccountProperties {
  /**
   * The default Data Lake Store account associated with this account.
   */
  defaultDataLakeStoreAccount: string;

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  dataLakeStoreAccounts: AddDataLakeStoreWithAccountParameters[];

  /**
   * The list of Azure Blob Storage accounts associated with this account.
   */
  storageAccounts?: AddStorageAccountWithAccountParameters[];

  /**
   * The list of compute policies associated with this account.
   */
  computePolicies?: CreateComputePolicyWithAccountParameters[];

  /**
   * The list of firewall rules associated with this account.
   */
  firewallRules?: CreateFirewallRuleWithAccountParameters[];

  /**
   * The current state of the IP address firewall for this account.
   */
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The commitment tier for the next month.
   */
  newTier?: TierType;

  /**
   * The maximum supported jobs running under the account at the same time.
   */
  @minValue(1)
  maxJobCount?: int32 = 3;

  /**
   * The maximum supported degree of parallelism for this account.
   */
  @minValue(1)
  maxDegreeOfParallelism?: int32 = 30;

  /**
   * The maximum supported degree of parallelism per job for this account.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32 = 32;

  /**
   * The minimum supported priority per job for this account.
   */
  @minValue(1)
  minPriorityPerJob?: int32;

  /**
   * The number of days that job metadata is retained.
   */
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32 = 30;
}

/**
 * The parameters used to add a new Data Lake Store account while creating a new Data Lake Analytics account.
 */
model AddDataLakeStoreWithAccountParameters {
  /**
   * The unique name of the Data Lake Store account to add.
   */
  name: string;

  /**
   * The Data Lake Store account properties to use when adding a new Data Lake Store account.
   */
  properties?: AddDataLakeStoreProperties;
}

/**
 * The Data Lake Store account properties to use when adding a new Data Lake Store account.
 */
model AddDataLakeStoreProperties {
  /**
   * The optional suffix for the Data Lake Store account.
   */
  suffix?: string;
}

/**
 * The parameters used to add a new Azure Storage account while creating a new Data Lake Analytics account.
 */
model AddStorageAccountWithAccountParameters {
  /**
   * The unique name of the Azure Storage account to add.
   */
  name: string;

  /**
   * The Azure Storage account properties to use when adding a new Azure Storage account.
   */
  properties: AddStorageAccountProperties;
}

/**
 * The Azure Storage account properties to use when adding a new Azure Storage account.
 */
model AddStorageAccountProperties {
  /**
   * The access key associated with this Azure Storage account that will be used to connect to it.
   */
  accessKey: string;

  /**
   * The optional suffix for the storage account.
   */
  suffix?: string = "azuredatalakestore.net";
}

/**
 * The parameters used to create a new compute policy while creating a new Data Lake Analytics account.
 */
model CreateComputePolicyWithAccountParameters {
  /**
   * The unique name of the compute policy to create.
   */
  name: string;

  /**
   * The compute policy properties to use when creating a new compute policy.
   */
  properties: CreateOrUpdateComputePolicyProperties;
}

/**
 * The compute policy properties to use when creating a new compute policy.
 */
model CreateOrUpdateComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  objectId: string;

  /**
   * The type of AAD object the object identifier refers to.
   */
  objectType: AADObjectType;

  /**
   * The maximum degree of parallelism per job this user can use to submit jobs. This property, the min priority per job property, or both must be passed.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum priority per job this user can use to submit jobs. This property, the max degree of parallelism per job property, or both must be passed.
   */
  @minValue(1)
  minPriorityPerJob?: int32;
}

/**
 * The parameters used to create a new firewall rule while creating a new Data Lake Analytics account.
 */
model CreateFirewallRuleWithAccountParameters {
  /**
   * The unique name of the firewall rule to create.
   */
  name: string;

  /**
   * The firewall rule properties to use when creating a new firewall rule.
   */
  properties: CreateOrUpdateFirewallRuleProperties;
}

/**
 * The firewall rule properties to use when creating a new firewall rule.
 */
model CreateOrUpdateFirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  startIpAddress: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  endIpAddress: string;
}

/**
 * The account specific properties that are associated with an underlying Data Lake Analytics account. Returned only when retrieving a specific account.
 */
model DataLakeAnalyticsAccountProperties
  extends DataLakeAnalyticsAccountPropertiesBasic {
  /**
   * The default Data Lake Store account associated with this account.
   */
  @visibility("read")
  defaultDataLakeStoreAccount?: string;

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  @visibility("read")
  dataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  publicDataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  /**
   * The list of Azure Blob Storage accounts associated with this account.
   */
  @visibility("read")
  storageAccounts?: StorageAccountInformation[];

  /**
   * The list of compute policies associated with this account.
   */
  @visibility("read")
  computePolicies?: ComputePolicy[];

  /**
   * The list of hiveMetastores associated with this account.
   */
  @visibility("read")
  hiveMetastores?: HiveMetastore[];

  /**
   * The list of virtualNetwork rules associated with this account.
   */
  @visibility("read")
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * The list of firewall rules associated with this account.
   */
  @visibility("read")
  firewallRules?: FirewallRule[];

  /**
   * The current state of the IP address firewall for this account.
   */
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The commitment tier for the next month.
   */
  newTier?: TierType;

  /**
   * The commitment tier in use for the current month.
   */
  @visibility("read")
  currentTier?: TierType;

  /**
   * The maximum supported jobs running under the account at the same time.
   */
  @minValue(1)
  maxJobCount?: int32 = 3;

  /**
   * The maximum supported active jobs under the account at the same time.
   */
  @visibility("read")
  maxActiveJobCountPerUser?: int32;

  /**
   * The maximum supported jobs queued under the account at the same time.
   */
  @visibility("read")
  maxQueuedJobCountPerUser?: int32;

  /**
   * The maximum supported active jobs under the account at the same time.
   */
  @visibility("read")
  maxJobRunningTimeInMin?: int32;

  /**
   * The system defined maximum supported jobs running under the account at the same time, which restricts the maximum number of running jobs the user can set for the account.
   */
  @visibility("read")
  systemMaxJobCount?: int32;

  /**
   * The maximum supported degree of parallelism for this account.
   */
  @minValue(1)
  maxDegreeOfParallelism?: int32 = 30;

  /**
   * The system defined maximum supported degree of parallelism for this account, which restricts the maximum value of parallelism the user can set for the account.
   */
  @visibility("read")
  systemMaxDegreeOfParallelism?: int32;

  /**
   * The maximum supported degree of parallelism per job for this account.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum supported priority per job for this account.
   */
  @visibility("read")
  @minValue(1)
  minPriorityPerJob?: int32;

  /**
   * The number of days that job metadata is retained.
   */
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32 = 30;

  /**
   * The current state of the DebugDataAccessLevel for this account.
   */
  @visibility("read")
  debugDataAccessLevel?: DebugDataAccessLevel;
}

/**
 * The Data Lake Store account properties.
 */
model DataLakeStoreAccountInformationProperties {
  /**
   * The optional suffix for the Data Lake Store account.
   */
  @visibility("read")
  suffix?: string;
}

/**
 * The resource model definition for a nested resource.
 */
model SubResource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;
}

/**
 * The Azure Storage account properties.
 */
model StorageAccountInformationProperties {
  /**
   * The optional suffix for the storage account.
   */
  @visibility("read")
  suffix?: string;
}

/**
 * The compute policy properties.
 */
model ComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  @visibility("read")
  objectId?: string;

  /**
   * The type of AAD object the object identifier refers to.
   */
  @visibility("read")
  objectType?: AADObjectType;

  /**
   * The maximum degree of parallelism per job this user can use to submit jobs.
   */
  @visibility("read")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum priority per job this user can use to submit jobs.
   */
  @visibility("read")
  @minValue(1)
  minPriorityPerJob?: int32;
}

model HiveMetastore extends SubResource {
  /**
   * The  HiveMetastoreProperties rule properties.
   */
  @visibility("read")
  properties?: HiveMetastoreProperties;
}

/**
 * The HiveMetastore  properties.
 */
model HiveMetastoreProperties {
  /**
   * The serverUri for the Hive MetaStore
   */
  @visibility("read")
  serverUri?: string;

  /**
   * The databaseName for the Hive MetaStore
   */
  @visibility("read")
  databaseName?: string;

  /**
   * The runtimeVersion for the Hive MetaStore
   */
  @visibility("read")
  runtimeVersion?: string;

  /**
   * The userName for the Hive MetaStore
   */
  @visibility("read")
  userName?: string;

  /**
   * The password for the Hive MetaStore
   */
  @visibility("read")
  password?: string;

  /**
   * The current state of the NestedResource
   */
  @visibility("read")
  nestedResourceProvisioningState?: NestedResourceProvisioningState;
}

/**
 * Data Lake Analytics  VirtualNetwork Rule information.
 */
model VirtualNetworkRule extends SubResource {
  /**
   * The  VirtualNetwork rule properties.
   */
  @visibility("read")
  properties?: VirtualNetworkRuleProperties;
}

/**
 * The VirtualNetwork Rule properties.
 */
model VirtualNetworkRuleProperties {
  /**
   * The resource identifier for the subnet
   */
  @visibility("read")
  subnetId?: string;

  /**
   * The current state of the VirtualNetwork Rule
   */
  @visibility("read")
  virtualNetworkRuleState?: VirtualNetworkRuleState;
}

/**
 * The firewall rule properties.
 */
model FirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility("read")
  startIpAddress?: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility("read")
  endIpAddress?: string;
}

/**
 * The parameters that can be used to update an existing Data Lake Analytics account.
 */
model UpdateDataLakeAnalyticsAccountParameters {
  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * The properties that can be updated in an existing Data Lake Analytics account.
   */
  properties?: UpdateDataLakeAnalyticsAccountProperties;
}

/**
 * The properties to update that are associated with an underlying Data Lake Analytics account.
 */
model UpdateDataLakeAnalyticsAccountProperties {
  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  dataLakeStoreAccounts?: UpdateDataLakeStoreWithAccountParameters[];

  /**
   * The list of Azure Blob storage accounts associated with this account.
   */
  storageAccounts?: UpdateStorageAccountWithAccountParameters[];

  /**
   * The list of compute policies associated with this account.
   */
  computePolicies?: UpdateComputePolicyWithAccountParameters[];

  /**
   * The list of firewall rules associated with this account.
   */
  firewallRules?: UpdateFirewallRuleWithAccountParameters[];

  /**
   * The current state of the IP address firewall for this account. Disabling the firewall does not remove existing rules, they will just be ignored until the firewall is re-enabled.
   */
  firewallState?: FirewallState;

  /**
   * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
   */
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  /**
   * The commitment tier to use for next month.
   */
  newTier?: TierType;

  /**
   * The maximum supported jobs running under the account at the same time.
   */
  @minValue(1)
  maxJobCount?: int32;

  /**
   * The maximum supported degree of parallelism for this account.
   */
  @minValue(1)
  maxDegreeOfParallelism?: int32;

  /**
   * The maximum supported degree of parallelism per job for this account.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum supported priority per job for this account.
   */
  @minValue(1)
  minPriorityPerJob?: int32;

  /**
   * The number of days that job metadata is retained.
   */
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32;
}

/**
 * The parameters used to update a Data Lake Store account while updating a Data Lake Analytics account.
 */
model UpdateDataLakeStoreWithAccountParameters {
  /**
   * The unique name of the Data Lake Store account to update.
   */
  name: string;

  /**
   * The Data Lake Store account properties to use when updating a Data Lake Store account.
   */
  properties?: UpdateDataLakeStoreProperties;
}

/**
 * The Data Lake Store account properties to use when updating a Data Lake Store account.
 */
model UpdateDataLakeStoreProperties {
  /**
   * The optional suffix for the Data Lake Store account.
   */
  suffix?: string;
}

/**
 * The parameters used to update an Azure Storage account while updating a Data Lake Analytics account.
 */
model UpdateStorageAccountWithAccountParameters {
  /**
   * The unique name of the Azure Storage account to update.
   */
  name: string;

  /**
   * The Azure Storage account properties to use when updating an Azure Storage account.
   */
  properties?: UpdateStorageAccountProperties;
}

/**
 * The Azure Storage account properties to use when updating an Azure Storage account.
 */
model UpdateStorageAccountProperties {
  /**
   * The updated access key associated with this Azure Storage account that will be used to connect to it.
   */
  accessKey?: string;

  /**
   * The optional suffix for the storage account.
   */
  suffix?: string;
}

/**
 * The parameters used to update a compute policy while updating a Data Lake Analytics account.
 */
model UpdateComputePolicyWithAccountParameters {
  /**
   * The unique name of the compute policy to update.
   */
  name: string;

  /**
   * The compute policy properties to use when updating a compute policy.
   */
  properties?: UpdateComputePolicyProperties;
}

/**
 * The compute policy properties to use when updating a compute policy.
 */
model UpdateComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  objectId?: string;

  /**
   * The type of AAD object the object identifier refers to.
   */
  objectType?: AADObjectType;

  /**
   * The maximum degree of parallelism per job this user can use to submit jobs. This property, the min priority per job property, or both must be passed.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum priority per job this user can use to submit jobs. This property, the max degree of parallelism per job property, or both must be passed.
   */
  @minValue(1)
  minPriorityPerJob?: int32;
}

/**
 * The parameters used to update a firewall rule while updating a Data Lake Analytics account.
 */
model UpdateFirewallRuleWithAccountParameters {
  /**
   * The unique name of the firewall rule to update.
   */
  name: string;

  /**
   * The firewall rule properties to use when updating a firewall rule.
   */
  properties?: UpdateFirewallRuleProperties;
}

/**
 * The firewall rule properties to use when updating a firewall rule.
 */
model UpdateFirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  startIpAddress?: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  endIpAddress?: string;
}

/**
 * The parameters used to add a new Data Lake Store account.
 */
model AddDataLakeStoreParameters {
  /**
   * The Data Lake Store account properties to use when adding a new Data Lake Store account.
   */
  properties?: AddDataLakeStoreProperties;
}

/**
 * The parameters used to add a new Azure Storage account.
 */
model AddStorageAccountParameters {
  /**
   * The Azure Storage account properties to use when adding a new Azure Storage account.
   */
  properties: AddStorageAccountProperties;
}

/**
 * The parameters used to update an Azure Storage account.
 */
model UpdateStorageAccountParameters {
  /**
   * The Azure Storage account properties to use when updating an Azure Storage account.
   */
  properties?: UpdateStorageAccountProperties;
}

/**
 * Azure Storage blob container properties information.
 */
model StorageContainerProperties {
  /**
   * The last modified time of the blob container.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

/**
 * The SAS response that contains the storage account, container and associated SAS token for connection use.
 */
model SasTokenInformationListResult is Azure.Core.Page<SasTokenInformation>;

/**
 * SAS token information.
 */
model SasTokenInformation {
  /**
   * The access token for the associated Azure Storage Container.
   */
  @visibility("read")
  accessToken?: string;
}

/**
 * The parameters used to create a new compute policy.
 */
model CreateOrUpdateComputePolicyParameters {
  /**
   * The compute policy properties to use when creating a new compute policy.
   */
  properties: CreateOrUpdateComputePolicyProperties;
}

/**
 * The parameters used to update a compute policy.
 */
model UpdateComputePolicyParameters {
  /**
   * The compute policy properties to use when updating a compute policy.
   */
  properties?: UpdateComputePolicyProperties;
}

/**
 * The parameters used to create a new firewall rule.
 */
model CreateOrUpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when creating a new firewall rule.
   */
  properties: CreateOrUpdateFirewallRuleProperties;
}

/**
 * The parameters used to update a firewall rule.
 */
model UpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when updating a firewall rule.
   */
  properties?: UpdateFirewallRuleProperties;
}

model OperationMetaPropertyInfo {
  /**
   * The operations OperationMetaServiceSpecification.
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

model OperationMetaServiceSpecification {
  /**
   * The metricSpecifications for OperationMetaServiceSpecification.
   */
  metricSpecifications?: OperationMetaMetricSpecification[];

  /**
   * The logSpecifications for OperationMetaServiceSpecification.
   */
  logSpecifications?: OperationMetaLogSpecification[];
}

model OperationMetaMetricSpecification {
  /**
   * The name for OperationMetaMetricSpecification.
   */
  name?: string;

  /**
   * The displayName for OperationMetaMetricSpecification.
   */
  displayDescription?: string;

  /**
   * The displayName for OperationMetaMetricSpecification.
   */
  displayName?: string;

  /**
   * The unit for OperationMetaMetricSpecification.
   */
  unit?: string;

  /**
   * The aggregationType for OperationMetaMetricSpecification.
   */
  aggregationType?: string;

  /**
   * The availabilities for OperationMetaMetricSpecification.
   */
  availabilities?: OperationMetaMetricAvailabilitiesSpecification[];
}

model OperationMetaMetricAvailabilitiesSpecification {
  /**
   * The timegrain for OperationMetaMetricAvailabilitiesSpecification.
   */
  timeGrain?: string;

  /**
   * The blobDuration for OperationMetaMetricAvailabilitiesSpecification.
   */
  blobDuration?: string;
}

model OperationMetaLogSpecification {
  /**
   * The name for OperationMetaLogSpecification.
   */
  name?: string;

  /**
   * The displayName for OperationMetaLogSpecification.
   */
  displayName?: string;

  /**
   * The blobDuration for OperationMetaLogSpecification.
   */
  blobDuration?: string;
}

/**
 * Subscription-level properties and limits for Data Lake Analytics.
 */
model CapabilityInformation {
  /**
   * The subscription credentials that uniquely identifies the subscription.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The subscription state.
   */
  @visibility("read")
  state?: SubscriptionState;

  /**
   * The maximum supported number of accounts under this subscription.
   */
  @visibility("read")
  maxAccountCount?: int32;

  /**
   * The current number of accounts under this subscription.
   */
  @visibility("read")
  accountCount?: int32;

  /**
   * The Boolean value of true or false to indicate the maintenance state.
   */
  @visibility("read")
  migrationState?: boolean;
}

/**
 * Data Lake Analytics account name availability check parameters.
 */
model CheckNameAvailabilityParameters {
  /**
   * The Data Lake Analytics name to check availability for.
   */
  name: string;

  /**
   * The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeAnalytics/accounts
   */
  type: CheckNameAvailabilityParametersType;
}

/**
 * Data Lake Analytics account name availability result information.
 */
model NameAvailabilityInformation {
  /**
   * The Boolean value of true or false to indicate whether the Data Lake Analytics account name is available or not.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason why the Data Lake Analytics account name is not available, if nameAvailable is false.
   */
  @visibility("read")
  reason?: string;

  /**
   * The message describing why the Data Lake Analytics account name is not available, if nameAvailable is false.
   */
  @visibility("read")
  message?: string;
}

/**
 * Data Lake Analytics VirtualNetwork rule list information.
 */
model VirtualNetworkRuleListResult {
  /**
   * The results of the list operation.
   */
  @visibility("read")
  value?: VirtualNetworkRule[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility("read")
  nextLink?: string;
}

/**
 * Data Lake Analytics HiveMetastore list information.
 */
model HiveMetastoreListResult {
  /**
   * The results of the list operation.
   */
  @visibility("read")
  value?: HiveMetastore[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility("read")
  nextLink?: string;
}
