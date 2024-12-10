import "@azure-tools/typespec-liftr-base";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using LiftrBase;
using Azure.Core;

@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "Commvault.ContentStore",
})
@versioned(Commvault.ContentStore.Versions)
namespace Commvault.ContentStore;

@doc("Supported API versions for the Commvault.ContentStore resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2024-10-01-preview",
}
interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Commvault Cloud Account Resource")
model CloudAccount is TrackedResource<CloudAccountProperties> {
  @key("cloudAccountName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("cloudAccounts")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Cloud Account resource")
  @example("cloudAccountName")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface CloudAccounts {
  get is ArmResourceRead<CloudAccount>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudAccount>;
  update is ArmResourcePatchAsync<CloudAccount, CloudAccountProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<CloudAccount>;
  listByResourceGroup is ArmResourceListByParent<CloudAccount>;
  listBySubscription is ArmListBySubscription<CloudAccount>;
}

@doc("Properties specific to Commvault Cloud Account resource")
model CloudAccountProperties is BaseResourceProperties;

@doc("A Commvault Storage Resource")
@parentResource(CloudAccount)
model Storage is ProxyResource<StorageProperties> {
  @key("storageName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("storages")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Storage resource")
  @path
  name: string;
}

@doc("The properties of Commvault Storage")
model StorageProperties {
  @doc("Location of the Commvault Storage")
  @visibility("read", "create")
  @minLength(1)
  @maxLength(50)
  location: string;

  @doc("The type of Commvault Storage")
  storageType: "Air_Gap_Protect";

  @doc("The vendor of Commvault Storage")
  vendor: Vendor;

  @doc("The class of Commvault Storage")
  class: StorageClassType;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Vendor of Commvault Storage")
union Vendor {
  @doc("Azure Blob Storage")
  AzureBlobStorage: "Azure_Blob_Storage",

  string,
}

@doc("Class of Commvault Storage")
union StorageClassType {
  @doc("Cool storage class")
  Cool: "COOL",

  @doc("Hot storage class")
  Hot: "HOT",

  string,
}

@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Storage>;
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByCloudAccount is ArmResourceListByParent<Storage>;
}

@parentResource(CloudAccount)
@doc("A Commvault Plan Resource")
model CommvaultPlan is ProxyResource<PlanProperties> {
  @key("planName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("plans")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Plan resource")
  @path
  name: string;
}

@doc("The properties of Commvault Plan")
model PlanProperties {
  @doc("Location of the Commvault Plan")
  @visibility("read", "create")
  @minLength(1)
  @maxLength(50)
  location: string;

  @doc("The storage plans associated with the Commvault Plan")
  @visibility("read", "create")
  @minItems(1)
  @maxItems(11)
  @OpenAPI.extension("x-ms-identifiers", [])
  storagePlans: StoragePlan[];

  @doc("The Commvault Plan Schedule")
  @visibility("read", "create", "update")
  @minItems(1)
  @maxItems(11)
  @OpenAPI.extension("x-ms-identifiers", [])
  schedules?: Schedule[];

  @doc("The Commvault Plan Retention")
  @visibility("read", "create", "update")
  retention: Retention;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The properties of Commvault Storage Plan")
model StoragePlan {
  @doc("The name of the Storage resource")
  name: string;

  @doc("Copy Name from Commvault")
  copyName?: string;

  @doc("Precedence of the Storage Plan, 1 is the highest precedence, 2 is the next highest, and so on")
  copyPrecedence?: int32;

  @doc("Indicates the retention period valid only if the type of retention chosen in CUSTOM")
  retentionPeriod?: int32;

  @doc("Indicates the retention timeframe valid only if the type of retention chosen in CUSTOM")
  retentionTime?: RetentionTime;

  @doc("Backup Rule Type")
  backupRuleType?: BackupRuleType;

  @doc("Indicates the monthlyFull retention time valid only if the type of retention chosen in CUSTOM")
  monthlyRetention?: int32;

  @doc("Indicates the yearly Full retention time valid only if the type of retention chosen in CUSTOM")
  yearlyRetention?: int32;
}

@doc("Extended Retention Time")
model ExtendedRetentionTime {
  @doc("Retention time for Extended Retention")
  retentionTime?: RetentionTime;

  @doc("Retention period for Extended Retention")
  retentionPeriod?: int32;
}

@doc("The type of backup rule")
union BackupRuleType {
  @doc("All Jobs")
  AllJobs: "ALL_JOBS",

  @doc("All Fulls")
  AllFulls: "ALL_FULLS",

  @doc("Hourly Fulls")
  HourlyFulls: "HOURLY_FULLS",

  @doc("Daily Fulls")
  DailyFulls: "DAILY_FULLS",

  @doc("Weekly Fulls")
  WeeklyFulls: "WEEKLY_FULLS",

  @doc("Monthly Fulls")
  MonthlyFulls: "MONTHLY_FULLS",

  @doc("Yearly Fulls")
  YearlyFulls: "YEARLY_FULLS",

  @doc("Quarterly Fulls")
  QuarterlyFulls: "QUARTERLY_FULLS",

  @doc("Half Yearly Fulls")
  HalfYearlyFulls: "HALF_YEARLY_FULLS",

  string,
}

@doc("The retention time for Commvault Plan")
union RetentionTime {
  @doc("Monthly retention time")
  Monthly: "monthly",

  @doc("Yearly retention time")
  Yearly: "yearly",

  string,
}

@doc("A Commvault Plan Schedule Model")
model Schedule {
  @doc("Type of Backup")
  backupType: BackUpType;

  @doc("Full BackUp Details")
  fullBackUpDetails?: ScheduleDetails;

  @doc("Incremental BackUp Details")
  incrementalBackUpDetails?: ScheduleDetails;

  @doc("Type of Retention")
  retentionType?: RetentionType;

  @doc("Frequency of Retention")
  frequency?: Frequency;

  @doc("Time of Retention")
  time?: string; //should have zone info as well

  @doc("Time Zone")
  timeZone?: string;
}

@doc("The type of backup")
union BackUpType {
  @doc("Incremental backup")
  Incremental: "INCREMENTAL",

  @doc("Full backup")
  Full: "FULL",

  @doc("Both incremental and full backups")
  Both: "BOTH",

  string,
}
@doc("The retention type for Commvault Plan")
union RetentionType {
  @doc("Standard retention type")
  Standard: "STANDARD",

  @doc("Extended retention type")
  Extended: "EXTENDED",

  @doc("Custom retention type")
  Custom: "CUSTOM",

  string,
}

@doc("Schedule Details")
model ScheduleDetails {
  @doc("Frequency of backups")
  @visibility("read", "create", "update")
  frequency: Frequency;

  @doc("Time of backups")
  @visibility("read", "create", "update")
  time: string; //should have zone info as well
}

@doc("The frequency of backups")
union Frequency {
  @doc("Daily backups")
  Daily: "daily",

  @doc("Weekly backups")
  Weekly: "weekly",

  @doc("Monthly backups")
  Monthly: "monthly",

  @doc("Yearly backups")
  Yearly: "yearly",

  @doc("Minutes backups")
  Minutes: "minutes",

  string,
}

@doc("A Commvault Plan Retention Model")
model Retention {
  @doc("Number of Snapshots")
  @visibility("read", "create", "update")
  numberOfSnapshots?: int32;

  @doc("Type of retention")
  @visibility("read", "create", "update")
  type?: RetentionType;
}

@armResourceOperations
interface Plans {
  get is ArmResourceRead<CommvaultPlan>;
  createOrupdate is ArmResourceCreateOrUpdateAsync<CommvaultPlan>;
  delete is ArmResourceDeleteWithoutOkAsync<CommvaultPlan>;
  listByCloudAccount is ArmResourceListByParent<CommvaultPlan>;
}

@parentResource(CloudAccount)
@doc("A Commvault Plan Resource")
model ProtectionGroup is ProxyResource<ProtectionGroupProperties> {
  @key("protectionGroupName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("protectionGroups")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the ProtectionGroup resource")
  @path
  name: string;
}

@doc("The properties of Commvault Protection Group")
model ProtectionGroupProperties {
  @doc("The datasource type of Commvault Protection Group")
  @visibility("read", "create")
  dataSourceType: "AzureVM";

  @doc("The Commvault Plan to be associated with the Protection Group")
  @visibility("read", "create", "update")
  plan: string;

  @doc("The resources to be protected under Protection Group")
  @visibility("read", "create", "update")
  resources: ProtectionGroupResources;

  @doc("The protection group schedule")
  @visibility("read")
  protectionStatus: ProtectionStatus; //Check what values can it have

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The Protection Status")
union ProtectionStatus {
  @doc("The protection group is active")
  Active: "active",

  @doc("The protection group is inactive")
  Inactive: "inactive",

  string,
}

@doc("The resources to be protected under Protection Group")
model ProtectionGroupResources {
  @doc("The items to be protected under Protection Group")
  @visibility("read", "create", "update")
  manual?: string[];

  @doc("Rules to match resources")
  @visibility("read", "create", "update")
  matchRules?: {
    @doc("rules to match")
    @visibility("read", "create", "update")
    @OpenAPI.extension("x-ms-identifiers", [])
    rules: Rule[];

    @doc("match Type all or any")
    @visibility("read", "create", "update")
    matchType: MatchType;
  };
}

@doc("The match type")
union MatchType {
  @doc("All rules should match")
  All: "all",

  @doc("Any rule should match")
  Any: "any",

  string,
}

@doc("The rules to match resources")
model Rule {
  @doc("property of the rule")
  @visibility("read", "create", "update")
  property: RuleProperty;

  @doc("property of the rule")
  @visibility("read", "create", "update")
  operator: Operator;

  @doc("property of the rule")
  @visibility("read", "create", "update")
  value: string;
}

@doc("The Rule property")
union RuleProperty {
  @doc("The resource group of the rule")
  ResourceGroup: "resourceGroup",

  @doc("The name of the rule")
  Name: "name",

  @doc("The tag name of the rule")
  TagName: "tagName",

  @doc("The tag value of the rule")
  TagValue: "tagValue",

  @doc("The region of the rule")
  Region: "region",

  @doc("The status of the rule")
  Status: "status",

  @doc("The power state of the rule")
  PowerState: "powerState",

  @doc("The virtual machine of the rule")
  VirtualMachine: "virtualMachine",

  @doc("The virtual machine pattern of the rule")
  VirtualMachinePattern: "virtualMachinePattern",

  string,
}

@doc("The types of operator")
union Operator {
  @doc("The operator contains")
  Contains: "contains",

  @doc("The operator does not contains")
  DoesNotContains: "doesNotContains",

  @doc("The operator does not equal")
  DoesNotEqual: "doesNotEqual",

  @doc("The operator starts with")
  StartsWith: "startsWith",

  @doc("The operator ends with")
  EndsWith: "endsWith",

  @doc("The operator equals")
  Equals: "equals",

  string,
}

@doc("The properties of StopBackupProtectionGroupRequest")
model StopBackupProtectionGroupRequest {
  @doc("The reason for stopping the backup")
  @visibility("read", "create")
  reason: string;

  @doc("Any further comments")
  @visibility("read", "create")
  comment?: string;
}

@armResourceOperations
interface ProtectionGroups {
  get is ArmResourceRead<ProtectionGroup>;
  createOrupdate is ArmResourceCreateOrUpdateAsync<ProtectionGroup>;
  delete is ArmResourceDeleteWithoutOkAsync<ProtectionGroup>;
  listByCloudAccount is ArmResourceListByParent<ProtectionGroup>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @doc("Stop Backup for a Protection Group")
  @armResourceAction(ProtectionGroup)
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  stopBackup(
    ...ResourceInstanceParameters<ProtectionGroup>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: StopBackupProtectionGroupRequest,
  ): ArmAcceptedLroResponse | ErrorResponse;
}

@parentResource(ProtectionGroup)
model ProtectedItem is ProxyResource<ProtectedItemProperties> {
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  @doc("The protectedItem name")
  @segment("protectedItems")
  @key("protectedItemName")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("The properties of Commvault Protected Item")
model ProtectedItemProperties {
  @doc("The Commvault Protected Item backup time")
  @visibility("read")
  lastBackUpTime: utcDateTime;
}

@armResourceOperations
interface ProtectedItems {
  get is ArmResourceRead<ProtectedItem>;
  listByProtectionGroup is ArmResourceListByParent<ProtectedItem>;
}
