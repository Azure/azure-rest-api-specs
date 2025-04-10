import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DataLakeAnalytics;

/**
 * The type of AAD object the object identifier refers to.
 */
union AADObjectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Group: "Group",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServicePrincipal: "ServicePrincipal",
}

/**
 * The intended executor of the operation.
 */
union OperationOrigin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * The subscription state.
 */
union SubscriptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Registered: "Registered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unregistered: "Unregistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warned: "Warned",
}

/**
 * The resource type. Note: This should not be set by the user, as the constant value is Microsoft.DataLakeAnalytics/accounts
 */
union CheckNameAvailabilityParametersType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.DataLakeAnalytics/accounts`: "Microsoft.DataLakeAnalytics/accounts",
}

/**
 * The provisioning status of the Data Lake Analytics account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DataLakeAnalyticsAccountState {
  Active,
  Suspended,
}

/**
 * The current state of the IP address firewall for this account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum FirewallState {
  Enabled,
  Disabled,
}

/**
 * The current state of allowing or disallowing IPs originating within Azure through the firewall. If the firewall is disabled, this is not enforced.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum FirewallAllowAzureIpsState {
  Enabled,
  Disabled,
}

/**
 * The commitment tier for the next month.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum NestedResourceProvisioningState {
  Succeeded,
  Canceled,
  Failed,
}

/**
 * The current state of the VirtualNetworkRule for this account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum VirtualNetworkRuleState {
  Active,
  NetworkSourceDeleted,
  Failed,
}

/**
 * The current state of the DebugDataAccessLevel for this account.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DebugDataAccessLevel {
  All,
  Customer,
  None,
}

/**
 * A Data Lake Analytics account object, containing all information associated with the named Data Lake Analytics account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DataLakeAnalyticsAccountBasic extends Resource {
  /**
   * The properties defined by Data Lake Analytics all properties are specific to each resource provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DataLakeAnalyticsAccountPropertiesBasic;
}

/**
 * The basic account specific properties that are associated with an underlying Data Lake Analytics account.
 */
model DataLakeAnalyticsAccountPropertiesBasic {
  /**
   * The unique identifier associated with this Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  accountId?: string;

  /**
   * The provisioning status of the Data Lake Analytics account.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DataLakeAnalyticsAccountStatus;

  /**
   * The state of the Data Lake Analytics account.
   */
  @visibility(Lifecycle.Read)
  state?: DataLakeAnalyticsAccountState;

  /**
   * The account creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The account last modified time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The full CName endpoint for this account.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The Data Lake Analytics account properties to use for creating.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateDataLakeAnalyticsAccountProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CreateDataLakeAnalyticsAccountProperties {
  /**
   * The default Data Lake Store account associated with this account.
   */
  defaultDataLakeStoreAccount: string;

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dataLakeStoreAccounts: AddDataLakeStoreWithAccountParameters[];

  /**
   * The list of Azure Blob Storage accounts associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  storageAccounts?: AddStorageAccountWithAccountParameters[];

  /**
   * The list of compute policies associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  computePolicies?: CreateComputePolicyWithAccountParameters[];

  /**
   * The list of firewall rules associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateComputePolicyProperties;
}

/**
 * The compute policy properties to use when creating a new compute policy.
 */
model CreateOrUpdateComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataLakeAnalyticsAccountProperties
  extends DataLakeAnalyticsAccountPropertiesBasic {
  /**
   * The type of the default Data Lake Store account associated with this account.
   */
  @visibility(Lifecycle.Read)
  defaultDataLakeStoreAccountType?: string;

  /**
   * The default Data Lake Store account associated with this account.
   */
  @visibility(Lifecycle.Read)
  defaultDataLakeStoreAccount?: string;

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  @visibility(Lifecycle.Read)
  dataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  publicDataLakeStoreAccounts?: DataLakeStoreAccountInformation[];

  /**
   * The list of Azure Blob Storage accounts associated with this account.
   */
  @visibility(Lifecycle.Read)
  storageAccounts?: StorageAccountInformation[];

  /**
   * The list of compute policies associated with this account.
   */
  @visibility(Lifecycle.Read)
  computePolicies?: ComputePolicy[];

  /**
   * The list of hiveMetastores associated with this account.
   */
  @visibility(Lifecycle.Read)
  hiveMetastores?: HiveMetastore[];

  /**
   * The list of virtualNetwork rules associated with this account.
   */
  @visibility(Lifecycle.Read)
  virtualNetworkRules?: VirtualNetworkRule[];

  /**
   * The list of firewall rules associated with this account.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  currentTier?: TierType;

  /**
   * The maximum supported jobs running under the account at the same time.
   */
  @minValue(1)
  maxJobCount?: int32 = 3;

  /**
   * The maximum supported active jobs under the account at the same time.
   */
  @visibility(Lifecycle.Read)
  maxActiveJobCountPerUser?: int32;

  /**
   * The maximum supported jobs queued under the account at the same time.
   */
  @visibility(Lifecycle.Read)
  maxQueuedJobCountPerUser?: int32;

  /**
   * The maximum supported active jobs under the account at the same time.
   */
  @visibility(Lifecycle.Read)
  maxJobRunningTimeInMin?: int32;

  /**
   * The system defined maximum supported jobs running under the account at the same time, which restricts the maximum number of running jobs the user can set for the account.
   */
  @visibility(Lifecycle.Read)
  systemMaxJobCount?: int32;

  /**
   * The maximum supported degree of parallelism for this account.
   */
  @minValue(1)
  maxDegreeOfParallelism?: int32 = 30;

  /**
   * The system defined maximum supported degree of parallelism for this account, which restricts the maximum value of parallelism the user can set for the account.
   */
  @visibility(Lifecycle.Read)
  systemMaxDegreeOfParallelism?: int32;

  /**
   * The maximum supported degree of parallelism per job for this account.
   */
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum supported priority per job for this account.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  debugDataAccessLevel?: DebugDataAccessLevel;
}

/**
 * The Data Lake Store account properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DataLakeStoreAccountInformationProperties {
  /**
   * The optional suffix for the Data Lake Store account.
   */
  @visibility(Lifecycle.Read)
  suffix?: string;
}

/**
 * The resource model definition for a nested resource.
 */
model SubResource {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The Azure Storage account properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StorageAccountInformationProperties {
  /**
   * The optional suffix for the storage account.
   */
  @visibility(Lifecycle.Read)
  suffix?: string;
}

/**
 * The compute policy properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  objectId?: string;

  /**
   * The type of AAD object the object identifier refers to.
   */
  @visibility(Lifecycle.Read)
  objectType?: AADObjectType;

  /**
   * The maximum degree of parallelism per job this user can use to submit jobs.
   */
  @visibility(Lifecycle.Read)
  @minValue(1)
  maxDegreeOfParallelismPerJob?: int32;

  /**
   * The minimum priority per job this user can use to submit jobs.
   */
  @visibility(Lifecycle.Read)
  @minValue(1)
  minPriorityPerJob?: int32;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model HiveMetastore extends SubResource {
  /**
   * The  HiveMetastoreProperties rule properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: HiveMetastoreProperties;
}

/**
 * The HiveMetastore  properties.
 */
model HiveMetastoreProperties {
  /**
   * The serverUri for the Hive MetaStore
   */
  @visibility(Lifecycle.Read)
  serverUri?: string;

  /**
   * The databaseName for the Hive MetaStore
   */
  @visibility(Lifecycle.Read)
  databaseName?: string;

  /**
   * The runtimeVersion for the Hive MetaStore
   */
  @visibility(Lifecycle.Read)
  runtimeVersion?: string;

  /**
   * The userName for the Hive MetaStore
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * The password for the Hive MetaStore
   */
  @visibility(Lifecycle.Read)
  password?: string;

  /**
   * The current state of the NestedResource
   */
  @visibility(Lifecycle.Read)
  nestedResourceProvisioningState?: NestedResourceProvisioningState;
}

/**
 * Data Lake Analytics  VirtualNetwork Rule information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model VirtualNetworkRule extends SubResource {
  /**
   * The  VirtualNetwork rule properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: VirtualNetworkRuleProperties;
}

/**
 * The VirtualNetwork Rule properties.
 */
model VirtualNetworkRuleProperties {
  /**
   * The resource identifier for the subnet
   */
  @visibility(Lifecycle.Read)
  subnetId?: string;

  /**
   * The current state of the VirtualNetwork Rule
   */
  @visibility(Lifecycle.Read)
  virtualNetworkRuleState?: VirtualNetworkRuleState;
}

/**
 * The firewall rule properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model FirewallRuleProperties {
  /**
   * The start IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility(Lifecycle.Read)
  startIpAddress?: string;

  /**
   * The end IP address for the firewall rule. This can be either ipv4 or ipv6. Start and End should be in the same protocol.
   */
  @visibility(Lifecycle.Read)
  endIpAddress?: string;
}

/**
 * The parameters that can be used to update an existing Data Lake Analytics account.
 */
model UpdateDataLakeAnalyticsAccountParameters {
  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The properties that can be updated in an existing Data Lake Analytics account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateDataLakeAnalyticsAccountProperties;
}

/**
 * The properties to update that are associated with an underlying Data Lake Analytics account.
 */
model UpdateDataLakeAnalyticsAccountProperties {
  /**
   * The list of Data Lake Store accounts associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dataLakeStoreAccounts?: UpdateDataLakeStoreWithAccountParameters[];

  /**
   * The list of Azure Blob storage accounts associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  storageAccounts?: UpdateStorageAccountWithAccountParameters[];

  /**
   * The list of compute policies associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  computePolicies?: UpdateComputePolicyWithAccountParameters[];

  /**
   * The list of firewall rules associated with this account.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateComputePolicyProperties;
}

/**
 * The compute policy properties to use when updating a compute policy.
 */
model UpdateComputePolicyProperties {
  /**
   * The AAD object identifier for the entity to create a policy for.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AddDataLakeStoreProperties;
}

/**
 * The parameters used to add a new Azure Storage account.
 */
model AddStorageAccountParameters {
  /**
   * The Azure Storage account properties to use when adding a new Azure Storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: AddStorageAccountProperties;
}

/**
 * The parameters used to update an Azure Storage account.
 */
model UpdateStorageAccountParameters {
  /**
   * The Azure Storage account properties to use when updating an Azure Storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateStorageAccountProperties;
}

/**
 * Azure Storage blob container properties information.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model StorageContainerProperties {
  /**
   * The last modified time of the blob container.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  accessToken?: string;
}

/**
 * The parameters used to create a new compute policy.
 */
model CreateOrUpdateComputePolicyParameters {
  /**
   * The compute policy properties to use when creating a new compute policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateComputePolicyProperties;
}

/**
 * The parameters used to update a compute policy.
 */
model UpdateComputePolicyParameters {
  /**
   * The compute policy properties to use when updating a compute policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateComputePolicyProperties;
}

/**
 * The parameters used to create a new firewall rule.
 */
model CreateOrUpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when creating a new firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: CreateOrUpdateFirewallRuleProperties;
}

/**
 * The parameters used to update a firewall rule.
 */
model UpdateFirewallRuleParameters {
  /**
   * The firewall rule properties to use when updating a firewall rule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UpdateFirewallRuleProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationMetaPropertyInfo {
  /**
   * The operations OperationMetaServiceSpecification.
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OperationMetaServiceSpecification {
  /**
   * The metricSpecifications for OperationMetaServiceSpecification.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: OperationMetaMetricSpecification[];

  /**
   * The logSpecifications for OperationMetaServiceSpecification.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: OperationMetaLogSpecification[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  availabilities?: OperationMetaMetricAvailabilitiesSpecification[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  subscriptionId?: string;

  /**
   * The subscription state.
   */
  @visibility(Lifecycle.Read)
  state?: SubscriptionState;

  /**
   * The maximum supported number of accounts under this subscription.
   */
  @visibility(Lifecycle.Read)
  maxAccountCount?: int32;

  /**
   * The current number of accounts under this subscription.
   */
  @visibility(Lifecycle.Read)
  accountCount?: int32;

  /**
   * The Boolean value of true or false to indicate the maintenance state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason why the Data Lake Analytics account name is not available, if nameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * The message describing why the Data Lake Analytics account name is not available, if nameAvailable is false.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Data Lake Analytics VirtualNetwork rule list information.
 */
model VirtualNetworkRuleListResult {
  /**
   * The results of the list operation.
   */
  @visibility(Lifecycle.Read)
  value?: VirtualNetworkRule[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Data Lake Analytics HiveMetastore list information.
 */
model HiveMetastoreListResult {
  /**
   * The results of the list operation.
   */
  @visibility(Lifecycle.Read)
  value?: HiveMetastore[];

  /**
   * The link (url) to the next page of results.
   */
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
