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

@doc("The type of AAD object the object identifier refers to.")
enum AADObjectType {
  User,
  Group,
  ServicePrincipal,
}

@doc("The intended executor of the operation.")
enum OperationOrigin {
  user,
  system,
  `user,system`,
}

@doc("The subscription state.")
enum SubscriptionState {
  Registered,
  Suspended,
  Deleted,
  Unregistered,
  Warned,
}

@doc("The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeAnalytics/accounts")
enum CheckNameAvailabilityParametersType {
  `Microsoft.DataLakeAnalytics/accounts`,
}

@doc("The provisioning status of the Data Lake Analytics account.")
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

@doc("The state of the Data Lake Analytics account.")
@fixed
enum DataLakeAnalyticsAccountState {
  Active,
  Suspended,
}

@doc("The current state of the IP address firewall for this account.")
@fixed
enum FirewallState {
  Enabled,
  Disabled,
}

@doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
@fixed
enum FirewallAllowAzureIpsState {
  Enabled,
  Disabled,
}

@doc("The commitment tier for the next month.")
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

@doc("The current state of the NestedResourceProvisioning for this account.")
@fixed
enum NestedResourceProvisioningState {
  Succeeded,
  Canceled,
  Failed,
}

@doc("The current state of the VirtualNetworkRule for this account.")
@fixed
enum VirtualNetworkRuleState {
  Active,
  NetworkSourceDeleted,
  Failed,
}

@doc("The current state of the DebugDataAccessLevel for this account.")
@fixed
enum DebugDataAccessLevel {
  All,
  Customer,
  None,
}

@doc("A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.")
model DataLakeAnalyticsAccountBasic extends Resource {
  @doc("The properties defined by Data Lake Analytics all properties are specific to each resource provider.")
  @visibility("read")
  properties?: DataLakeAnalyticsAccountPropertiesBasic;
}

@doc("The basic account specific properties that are associated with an underlying Data Lake Analytics account.")
model DataLakeAnalyticsAccountPropertiesBasic {
  @doc("The unique identifier associated with this Data Lake Analytics account.")
  @visibility("read")
  accountId?: string;

  @doc("The provisioning status of the Data Lake Analytics account.")
  @visibility("read")
  provisioningState?: DataLakeAnalyticsAccountStatus;

  @doc("The state of the Data Lake Analytics account.")
  @visibility("read")
  state?: DataLakeAnalyticsAccountState;

  @doc("The account creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The account last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("The full CName endpoint for this account.")
  @visibility("read")
  endpoint?: string;
}

@doc("The resource model definition.")
model Resource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The resource location.")
  @visibility("read")
  location?: string;

  @doc("The resource tags.")
  @visibility("read")
  tags?: Record<string>;
}

@doc("The parameters to use for creating a Data Lake Analytics account.")
model CreateDataLakeAnalyticsAccountParameters {
  @doc("The resource location.")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The Data Lake Analytics account properties to use for creating.")
  properties: CreateDataLakeAnalyticsAccountProperties;
}

model CreateDataLakeAnalyticsAccountProperties {
  @doc("The default Data Lake Store account associated with this account.")
  defaultDataLakeStoreAccount: string;

  @doc("The list of Data Lake Store accounts associated with this account.")
  dataLakeStoreAccounts: AddDataLakeStoreWithAccountParameters[];

  @doc("The list of Azure Blob Storage accounts associated with this account.")
  storageAccounts?: AddStorageAccountWithAccountParameters[];

  @doc("The list of compute policies associated with this account.")
  computePolicies?: CreateComputePolicyWithAccountParameters[];

  @doc("The list of firewall rules associated with this account.")
  firewallRules?: CreateFirewallRuleWithAccountParameters[];

  @doc("The current state of the IP address firewall for this account.")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The commitment tier for the next month.")
  newTier?: TierType;

  @doc("The maximum supported jobs running under the account at the same time.")
  @minValue(1)
  maxJobCount?: int32;

  @doc("The maximum supported degree of parallelism for this account.")
  @minValue(1)
  maxDegreeOfParallelism?: int32;

  @doc("The maximum supported degree of parallelism per job for this account.")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum supported priority per job for this account.")
  @minValue(1)
  minPriorityPerJob?: int32;

  @doc("The number of days that job metadata is retained.")
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32;
}

@doc("The parameters used to add a new Data Lake Store account while creating a new Data Lake Analytics account.")
model AddDataLakeStoreWithAccountParameters {
  @doc("The unique name of the Data Lake Store account to add.")
  name: string;

  @doc("The Data Lake Store account properties to use when adding a new Data Lake Store account.")
  properties?: AddDataLakeStoreProperties;
}

@doc("The Data Lake Store account properties to use when adding a new Data Lake Store account.")
model AddDataLakeStoreProperties {
  @doc("The optional suffix for the Data Lake Store account.")
  suffix?: string;
}

@doc("The parameters used to add a new Azure Storage account while creating a new Data Lake Analytics account.")
model AddStorageAccountWithAccountParameters {
  @doc("The unique name of the Azure Storage account to add.")
  name: string;

  @doc("The Azure Storage account properties to use when adding a new Azure Storage account.")
  properties: AddStorageAccountProperties;
}

@doc("The Azure Storage account properties to use when adding a new Azure Storage account.")
model AddStorageAccountProperties {
  @doc("The access key associated with this Azure Storage account that will be used to connect to it.")
  accessKey: string;

  @doc("The optional suffix for the storage account.")
  suffix?: string;
}

@doc("The parameters used to create a new compute policy while creating a new Data Lake Analytics account.")
model CreateComputePolicyWithAccountParameters {
  @doc("The unique name of the compute policy to create.")
  name: string;

  @doc("The compute policy properties to use when creating a new compute policy.")
  properties: CreateOrUpdateComputePolicyProperties;
}

@doc("The compute policy properties to use when creating a new compute policy.")
model CreateOrUpdateComputePolicyProperties {
  @doc("The AAD object identifier for the entity to create a policy for.")
  objectId: string;

  @doc("The type of AAD object the object identifier refers to.")
  objectType: AADObjectType;

  @doc("The maximum degree of parallelism per job this user can use to submit jobs. This property, the min priority per job property, or both must be passed.")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum priority per job this user can use to submit jobs. This property, the max degree of parallelism per job property, or both must be passed.")
  @minValue(1)
  minPriorityPerJob?: int32;
}

@doc("The parameters used to create a new firewall rule while creating a new Data Lake Analytics account.")
model CreateFirewallRuleWithAccountParameters {
  @doc("The unique name of the firewall rule to create.")
  name: string;

  @doc("The firewall rule properties to use when creating a new firewall rule.")
  properties: CreateOrUpdateFirewallRuleProperties;
}

@doc("The firewall rule properties to use when creating a new firewall rule.")
model CreateOrUpdateFirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  startIpAddress: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  endIpAddress: string;
}

@doc("The account specific properties that are associated with an underlying Data Lake Analytics account. Returned only when retrieving a specific account.")
model DataLakeAnalyticsAccountProperties
  extends DataLakeAnalyticsAccountPropertiesBasic {
  @doc("The default Data Lake Store account associated with this account.")
  @visibility("read")
  defaultDataLakeStoreAccount?: string;

  @doc("The list of Data Lake Store accounts associated with this account.")
  @visibility("read")
  dataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  @doc("The list of Data Lake Store accounts associated with this account.")
  publicDataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  @doc("The list of Azure Blob Storage accounts associated with this account.")
  @visibility("read")
  storageAccounts?: StorageAccountInformation[];

  @doc("The list of compute policies associated with this account.")
  @visibility("read")
  computePolicies?: ComputePolicy[];

  @doc("The list of hiveMetastores associated with this account.")
  @visibility("read")
  hiveMetastores?: HiveMetastore[];

  @doc("The list of virtualNetwork rules associated with this account.")
  @visibility("read")
  virtualNetworkRules?: VirtualNetworkRule[];

  @doc("The list of firewall rules associated with this account.")
  @visibility("read")
  firewallRules?: FirewallRule[];

  @doc("The current state of the IP address firewall for this account.")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The commitment tier for the next month.")
  newTier?: TierType;

  @doc("The commitment tier in use for the current month.")
  @visibility("read")
  currentTier?: TierType;

  @doc("The maximum supported jobs running under the account at the same time.")
  @minValue(1)
  maxJobCount?: int32;

  @doc("The maximum supported active jobs under the account at the same time.")
  @visibility("read")
  maxActiveJobCountPerUser?: int32;

  @doc("The maximum supported jobs queued under the account at the same time.")
  @visibility("read")
  maxQueuedJobCountPerUser?: int32;

  @doc("The maximum supported active jobs under the account at the same time.")
  @visibility("read")
  maxJobRunningTimeInMin?: int32;

  @doc("The system defined maximum supported jobs running under the account at the same time, which restricts the maximum number of running jobs the user can set for the account.")
  @visibility("read")
  systemMaxJobCount?: int32;

  @doc("The maximum supported degree of parallelism for this account.")
  @minValue(1)
  maxDegreeOfParallelism?: int32;

  @doc("The system defined maximum supported degree of parallelism for this account, which restricts the maximum value of parallelism the user can set for the account.")
  @visibility("read")
  systemMaxDegreeOfParallelism?: int32;

  @doc("The maximum supported degree of parallelism per job for this account.")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum supported priority per job for this account.")
  @visibility("read")
  @minValue(1)
  minPriorityPerJob?: int32;

  @doc("The number of days that job metadata is retained.")
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32;

  @doc("The current state of the DebugDataAccessLevel for this account.")
  @visibility("read")
  debugDataAccessLevel?: DebugDataAccessLevel;
}

@doc("The Data Lake Store account properties.")
model DataLakeStoreAccountInformationProperties {
  @doc("The optional suffix for the Data Lake Store account.")
  @visibility("read")
  suffix?: string;
}

@doc("The resource model definition for a nested resource.")
model SubResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;
}

@doc("The Azure Storage account properties.")
model StorageAccountInformationProperties {
  @doc("The optional suffix for the storage account.")
  @visibility("read")
  suffix?: string;
}

@doc("The compute policy properties.")
model ComputePolicyProperties {
  @doc("The AAD object identifier for the entity to create a policy for.")
  @visibility("read")
  objectId?: string;

  @doc("The type of AAD object the object identifier refers to.")
  @visibility("read")
  objectType?: AADObjectType;

  @doc("The maximum degree of parallelism per job this user can use to submit jobs.")
  @visibility("read")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum priority per job this user can use to submit jobs.")
  @visibility("read")
  @minValue(1)
  minPriorityPerJob?: int32;
}

model HiveMetastore extends SubResource {
  @doc("The  HiveMetastoreProperties rule properties.")
  @visibility("read")
  properties?: HiveMetastoreProperties;
}

@doc("The HiveMetastore  properties.")
model HiveMetastoreProperties {
  @doc("The serverUri for the Hive MetaStore")
  @visibility("read")
  serverUri?: string;

  @doc("The databaseName for the Hive MetaStore")
  @visibility("read")
  databaseName?: string;

  @doc("The runtimeVersion for the Hive MetaStore")
  @visibility("read")
  runtimeVersion?: string;

  @doc("The userName for the Hive MetaStore")
  @visibility("read")
  userName?: string;

  @doc("The password for the Hive MetaStore")
  @visibility("read")
  password?: string;

  @doc("The current state of the NestedResource")
  @visibility("read")
  nestedResourceProvisioningState?: NestedResourceProvisioningState;
}

@doc("Data Lake Analytics  VirtualNetwork Rule information.")
model VirtualNetworkRule extends SubResource {
  @doc("The  VirtualNetwork rule properties.")
  @visibility("read")
  properties?: VirtualNetworkRuleProperties;
}

@doc("The VirtualNetwork Rule properties.")
model VirtualNetworkRuleProperties {
  @doc("The resource identifier for the subnet")
  @visibility("read")
  subnetId?: string;

  @doc("The current state of the VirtualNetwork Rule")
  @visibility("read")
  virtualNetworkRuleState?: VirtualNetworkRuleState;
}

@doc("The firewall rule properties.")
model FirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  @visibility("read")
  startIpAddress?: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  @visibility("read")
  endIpAddress?: string;
}

@doc("The parameters that can be used to update an existing Data Lake Analytics account.")
model UpdateDataLakeAnalyticsAccountParameters {
  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("The properties that can be updated in an existing Data Lake Analytics account.")
  properties?: UpdateDataLakeAnalyticsAccountProperties;
}

@doc("The properties to update that are associated with an underlying Data Lake Analytics account.")
model UpdateDataLakeAnalyticsAccountProperties {
  @doc("The list of Data Lake Store accounts associated with this account.")
  dataLakeStoreAccounts?: UpdateDataLakeStoreWithAccountParameters[];

  @doc("The list of Azure Blob storage accounts associated with this account.")
  storageAccounts?: UpdateStorageAccountWithAccountParameters[];

  @doc("The list of compute policies associated with this account.")
  computePolicies?: UpdateComputePolicyWithAccountParameters[];

  @doc("The list of firewall rules associated with this account.")
  firewallRules?: UpdateFirewallRuleWithAccountParameters[];

  @doc("The current state of the IP address firewall for this account. Disabling the firewall does not remove existing rules, they will just be ignored until the firewall is re-enabled.")
  firewallState?: FirewallState;

  @doc("The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.")
  firewallAllowAzureIps?: FirewallAllowAzureIpsState;

  @doc("The commitment tier to use for next month.")
  newTier?: TierType;

  @doc("The maximum supported jobs running under the account at the same time.")
  @minValue(1)
  maxJobCount?: int32;

  @doc("The maximum supported degree of parallelism for this account.")
  @minValue(1)
  maxDegreeOfParallelism?: int32;

  @doc("The maximum supported degree of parallelism per job for this account.")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum supported priority per job for this account.")
  @minValue(1)
  minPriorityPerJob?: int32;

  @doc("The number of days that job metadata is retained.")
  @maxValue(180)
  @minValue(1)
  queryStoreRetention?: int32;
}

@doc("The parameters used to update a Data Lake Store account while updating a Data Lake Analytics account.")
model UpdateDataLakeStoreWithAccountParameters {
  @doc("The unique name of the Data Lake Store account to update.")
  name: string;

  @doc("The Data Lake Store account properties to use when updating a Data Lake Store account.")
  properties?: UpdateDataLakeStoreProperties;
}

@doc("The Data Lake Store account properties to use when updating a Data Lake Store account.")
model UpdateDataLakeStoreProperties {
  @doc("The optional suffix for the Data Lake Store account.")
  suffix?: string;
}

@doc("The parameters used to update an Azure Storage account while updating a Data Lake Analytics account.")
model UpdateStorageAccountWithAccountParameters {
  @doc("The unique name of the Azure Storage account to update.")
  name: string;

  @doc("The Azure Storage account properties to use when updating an Azure Storage account.")
  properties?: UpdateStorageAccountProperties;
}

@doc("The Azure Storage account properties to use when updating an Azure Storage account.")
model UpdateStorageAccountProperties {
  @doc("The updated access key associated with this Azure Storage account that will be used to connect to it.")
  accessKey?: string;

  @doc("The optional suffix for the storage account.")
  suffix?: string;
}

@doc("The parameters used to update a compute policy while updating a Data Lake Analytics account.")
model UpdateComputePolicyWithAccountParameters {
  @doc("The unique name of the compute policy to update.")
  name: string;

  @doc("The compute policy properties to use when updating a compute policy.")
  properties?: UpdateComputePolicyProperties;
}

@doc("The compute policy properties to use when updating a compute policy.")
model UpdateComputePolicyProperties {
  @doc("The AAD object identifier for the entity to create a policy for.")
  objectId?: string;

  @doc("The type of AAD object the object identifier refers to.")
  objectType?: AADObjectType;

  @doc("The maximum degree of parallelism per job this user can use to submit jobs. This property, the min priority per job property, or both must be passed.")
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  @doc("The minimum priority per job this user can use to submit jobs. This property, the max degree of parallelism per job property, or both must be passed.")
  @minValue(1)
  minPriorityPerJob?: int32;
}

@doc("The parameters used to update a firewall rule while updating a Data Lake Analytics account.")
model UpdateFirewallRuleWithAccountParameters {
  @doc("The unique name of the firewall rule to update.")
  name: string;

  @doc("The firewall rule properties to use when updating a firewall rule.")
  properties?: UpdateFirewallRuleProperties;
}

@doc("The firewall rule properties to use when updating a firewall rule.")
model UpdateFirewallRuleProperties {
  @doc("The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  startIpAddress?: string;

  @doc("The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.")
  endIpAddress?: string;
}

@doc("The parameters used to add a new Data Lake Store account.")
model AddDataLakeStoreParameters {
  @doc("The Data Lake Store account properties to use when adding a new Data Lake Store account.")
  properties?: AddDataLakeStoreProperties;
}

@doc("The parameters used to add a new Azure Storage account.")
model AddStorageAccountParameters {
  @doc("The Azure Storage account properties to use when adding a new Azure Storage account.")
  properties: AddStorageAccountProperties;
}

@doc("The parameters used to update an Azure Storage account.")
model UpdateStorageAccountParameters {
  @doc("The Azure Storage account properties to use when updating an Azure Storage account.")
  properties?: UpdateStorageAccountProperties;
}

@doc("Azure Storage blob container properties information.")
model StorageContainerProperties {
  @doc("The last modified time of the blob container.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

@doc("The SAS response that contains the storage account, container and associated SAS token for connection use.")
model SasTokenInformationListResult is Azure.Core.Page<SasTokenInformation>;

@doc("SAS token information.")
model SasTokenInformation {
  @doc("The access token for the associated Azure Storage Container.")
  @visibility("read")
  accessToken?: string;
}

@doc("The parameters used to create a new compute policy.")
model CreateOrUpdateComputePolicyParameters {
  @doc("The compute policy properties to use when creating a new compute policy.")
  properties: CreateOrUpdateComputePolicyProperties;
}

@doc("The parameters used to update a compute policy.")
model UpdateComputePolicyParameters {
  @doc("The compute policy properties to use when updating a compute policy.")
  properties?: UpdateComputePolicyProperties;
}

@doc("The parameters used to create a new firewall rule.")
model CreateOrUpdateFirewallRuleParameters {
  @doc("The firewall rule properties to use when creating a new firewall rule.")
  properties: CreateOrUpdateFirewallRuleProperties;
}

@doc("The parameters used to update a firewall rule.")
model UpdateFirewallRuleParameters {
  @doc("The firewall rule properties to use when updating a firewall rule.")
  properties?: UpdateFirewallRuleProperties;
}

model OperationMetaPropertyInfo {
  @doc("The operations OperationMetaServiceSpecification.")
  serviceSpecification?: OperationMetaServiceSpecification;
}

model OperationMetaServiceSpecification {
  @doc("The metricSpecifications for OperationMetaServiceSpecification.")
  metricSpecifications?: OperationMetaMetricSpecification[];

  @doc("The logSpecifications for OperationMetaServiceSpecification.")
  logSpecifications?: OperationMetaLogSpecification[];
}

model OperationMetaMetricSpecification {
  @doc("The name for OperationMetaMetricSpecification.")
  name?: string;

  @doc("The displayName for OperationMetaMetricSpecification.")
  displayDescription?: string;

  @doc("The displayName for OperationMetaMetricSpecification.")
  displayName?: string;

  @doc("The unit for OperationMetaMetricSpecification.")
  unit?: string;

  @doc("The aggregationType for OperationMetaMetricSpecification.")
  aggregationType?: string;

  @doc("The availabilities for OperationMetaMetricSpecification.")
  availabilities?: OperationMetaMetricAvailabilitiesSpecification[];
}

model OperationMetaMetricAvailabilitiesSpecification {
  @doc("The timegrain for OperationMetaMetricAvailabilitiesSpecification.")
  timeGrain?: string;

  @doc("The blobDuration for OperationMetaMetricAvailabilitiesSpecification.")
  blobDuration?: string;
}

model OperationMetaLogSpecification {
  @doc("The name for OperationMetaLogSpecification.")
  name?: string;

  @doc("The displayName for OperationMetaLogSpecification.")
  displayName?: string;

  @doc("The blobDuration for OperationMetaLogSpecification.")
  blobDuration?: string;
}

@doc("Subscription-level properties and limits for Data Lake Analytics.")
model CapabilityInformation {
  @doc("The subscription credentials that uniquely identifies the subscription.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The subscription state.")
  @visibility("read")
  state?: SubscriptionState;

  @doc("The maximum supported number of accounts under this subscription.")
  @visibility("read")
  maxAccountCount?: int32;

  @doc("The current number of accounts under this subscription.")
  @visibility("read")
  accountCount?: int32;

  @doc("The Boolean value of true or false to indicate the maintenance state.")
  @visibility("read")
  migrationState?: boolean;
}

@doc("Data Lake Analytics account name availability check parameters.")
model CheckNameAvailabilityParameters {
  @doc("The Data Lake Analytics name to check availability for.")
  name: string;

  @doc("The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeAnalytics/accounts")
  type: CheckNameAvailabilityParametersType;
}

@doc("Data Lake Analytics account name availability result information.")
model NameAvailabilityInformation {
  @doc("The Boolean value of true or false to indicate whether the Data Lake Analytics account name is available or not.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason why the Data Lake Analytics account name is not available, if nameAvailable is false.")
  @visibility("read")
  reason?: string;

  @doc("The message describing why the Data Lake Analytics account name is not available, if nameAvailable is false.")
  @visibility("read")
  message?: string;
}

@doc("Data Lake Analytics VirtualNetwork rule list information.")
model VirtualNetworkRuleListResult {
  @doc("The results of the list operation.")
  @visibility("read")
  value?: VirtualNetworkRule[];

  @doc("The link (url) to the next page of results.")
  @visibility("read")
  nextLink?: string;
}

@doc("Data Lake Analytics HiveMetastore list information.")
model HiveMetastoreListResult {
  @doc("The results of the list operation.")
  @visibility("read")
  value?: HiveMetastore[];

  @doc("The link (url) to the next page of results.")
  @visibility("read")
  nextLink?: string;
}
