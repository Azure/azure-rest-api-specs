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

@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service(#{ title: "Commvault.ContentStore" })
@versioned(Commvault.ContentStore.Versions)
namespace Commvault.ContentStore;

@doc("Supported API versions for the Commvault.ContentStore resource provider.")
enum Versions {
  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v1_preview: "2024-10-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v2_preview: "2025-01-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v3_preview: "2026-03-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v4_preview: "2026-05-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v5_preview: "2026-06-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v3_preview")
  @useDependency(LiftrBase.Versions.v3_preview)
  v6_preview: "2026-06-02-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v7_preview: "2026-07-01-preview",

  @doc("Dependent on Azure.ResourceManager.Versions.v1_0_Preview_1, LiftrBase.Versions.v1_preview")
  @useDependency(LiftrBase.Versions.v1_preview)
  v8_preview: "2026-07-03-preview",
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
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
@doc("SaaS-related data properties")
@added(Versions.v6_preview)
model SaaSData {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
  @doc("SaaS resource id")
  saaSResourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
@doc("SaaS guid for Activate and Validate SaaS Resource")
@added(Versions.v6_preview)
model ActivateSaaSParameterRequest {
  @doc("SaaS guid for Activate and Validate SaaS Resource")
  saaSGuid: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "SaaS response model"
#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
@doc("Marketplace SaaS resource details.")
@added(Versions.v6_preview)
model SaaSResourceDetailsResponse
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  @doc("Id of the Marketplace SaaS Resource")
  saaSResourceId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
@doc("Response of get latest linked SaaS resource operation")
@added(Versions.v6_preview)
model LatestLinkedSaaSResponse {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
  @doc("SaaS resource id")
  saaSResourceId?: string;

  @doc("Flag indicating if the SaaS resource is hidden")
  isHiddenSaaS?: boolean;
}

@armResourceOperations
interface CloudAccounts {
  get is ArmResourceRead<CloudAccount>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CloudAccount>;
  #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy implicit optionality - DO NOT COPY"
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    CloudAccount,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      CloudAccount,
      CloudAccountProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CloudAccount>;
  listByResourceGroup is ArmResourceListByParent<CloudAccount>;
  listBySubscription is ArmListBySubscription<CloudAccount>;

  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "SaaS link operation"
  @doc("Links a new SaaS to the cloud account.")
  @summary("Links a new SaaS to the cloud account.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @added(Versions.v6_preview)
  linkSaaS is ArmResourceActionAsync<
    CloudAccount,
    SaaSData,
    ArmResponse<CloudAccount>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = CloudAccount> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Returns the latest SaaS linked to the cloud account.")
  @added(Versions.v6_preview)
  latestLinkedSaaS is ArmResourceActionSync<
    CloudAccount,
    void,
    ArmResponse<LatestLinkedSaaSResponse>
  >;
}

@doc("Properties specific to Commvault Cloud Account resource")
model CloudAccountProperties is BaseResourceProperties {
  @doc("SSO URL for the Commvault Cloud Account")
  @visibility(Lifecycle.Read)
  ssoUrl?: string;

  @doc("The backup administrator principal provided during CCA create. Required on create (enforced by backend), ignored on update.")
  @added(Versions.v8_preview)
  @visibility(Lifecycle.Create)
  backupAdminOnCcaCreate?: EntityInfo;

  @doc("The multi-person authorization (MPA) administrator principal provided during CCA create. Required on create (enforced by backend), ignored on update.")
  @added(Versions.v8_preview)
  @visibility(Lifecycle.Create)
  multiPersonAuthorizationOnCcaCreate?: EntityInfo;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "SaaS operation group"
#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS is a well-known acronym"
@added(Versions.v6_preview)
interface SaaSOperationGroup {
  @doc("Resolve the token to get the SaaS resource ID and activate the SaaS resource")
  @autoRoute
  @action("activateSaaS")
  activateResource is ArmProviderActionAsync<
    Request = ActivateSaaSParameterRequest,
    Response = SaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @maxLength(50)
  location: string;

  @doc("The type of Commvault Storage")
  storageType: StorageType;

  @doc("The vendor of Commvault Storage")
  vendor: Vendor;

  @doc("The class of Commvault Storage")
  class: StorageClassType;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Storage Type of Commvault Storage")
union StorageType {
  @doc("Air Gap Protect")
  AirGapProtect: "Air_Gap_Protect",

  string,
}

@doc("Vendor of Commvault Storage")
union Vendor {
  @doc("Azure Blob Storage")
  AzureBlobStorage: "Azure_Blob_Storage",

  string,
}

@doc("Class of Commvault Storage")
union StorageClassType {
  @doc("Cold storage class")
  Cool: "COLD",

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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  @maxLength(50)
  location: string;

  @doc("The storage plans associated with the Commvault Plan")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  @maxItems(11)
  @Azure.ResourceManager.identifiers(#[])
  storagePlans: StoragePlan[];

  @doc("The Commvault Plan Schedule")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minItems(1)
  @maxItems(11)
  @Azure.ResourceManager.identifiers(#[])
  schedules?: Schedule[];

  @doc("The Commvault Plan Retention")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  retention?: Retention;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The properties of Commvault Storage Plan")
model StoragePlan {
  @doc("The name of the Storage resource")
  name: string;

  @doc("Id of the Storage Pool")
  storagePoolId?: string;

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

  @doc("Extended Retention Policy")
  @Azure.ResourceManager.identifiers(#[])
  extendedRetention?: ExtendedRetentionTime[];
}

@doc("Extended Retention Time")
model ExtendedRetentionTime {
  @doc("Retention time for Extended Retention")
  retentionTime?: RetentionTime;

  @doc("Retention period for Extended Retention")
  retentionPeriod?: int32;

  @doc("Backup Rule Type for Extended Retention")
  backupRuleType?: BackupRuleType;
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

  @doc("Frequency of Retention")
  frequency?: Frequency;

  @doc("Interval of Retention")
  runsEvery?: int32;

  @doc("Week of the month")
  weekOfMonth?: WeekOfMonth;

  @doc("Day of the week")
  dayOfWeek?: DayOfWeek;

  @doc("Month of the year")
  monthOfYear?: MonthOfYear;

  @doc("Day of the month")
  dayOfMonth?: int32;

  @doc("Weekly Days List")
  weeklyDays?: WeeklyDays[];

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

@doc("The level of backup")
union BackupLevel {
  @doc("Full backup level")
  Full: "FULL",

  @doc("Incremental backup level")
  Incremental: "INCREMENTAL",

  @doc("Differential backup level")
  Differential: "DIFFERENTIAL",

  @doc("Synthetic full backup level")
  SyntheticFull: "SYNTHETIC_FULL",

  string,
}

@doc("Schedule Details")
model ScheduleDetails {
  @doc("Frequency of backups")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  frequency: Frequency;

  @doc("Time of backups")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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

@doc("The Week of Month Enum")
union WeekOfMonth {
  @doc("First Week")
  First: "FIRST",

  @doc("Second Week")
  Second: "SECOND",

  @doc("Third Week")
  Third: "THIRD",

  @doc("Fourth Week")
  Fourth: "FOURTH",

  @doc("LAST Week")
  Last: "LAST",

  string,
}

@doc("The Day of Week Enum")
union DayOfWeek {
  @doc("First Day of the Week")
  Sunday: "SUNDAY",

  @doc("Second Day of the Week")
  Monday: "MONDAY",

  @doc("Third Day of the Week")
  Tuesday: "TUESDAY",

  @doc("Fourth Day of the Week")
  Wednesday: "WEDNESDAY",

  @doc("Fifth Day of the Week")
  Thursday: "THURSDAY",

  @doc("Sixth Day of the Week")
  Friday: "FRIDAY",

  @doc("Seventh Day of the Week")
  Saturday: "SATURDAY",

  @doc("Any Day of the week")
  Day: "DAY",

  @doc("Weekday Identifier")
  Weekday: "WEEKDAY",

  @doc("Weekend Identifier")
  WeekendDays: "WEEKEND_DAYS",

  string,
}

@doc("The Month of Year Enum")
union MonthOfYear {
  @doc("First Month of the Year")
  January: "JANUARY",

  @doc("Second Month of the Year")
  February: "FEBRUARY",

  @doc("Third Month of the Year")
  March: "MARCH",

  @doc("Fourth Month of the Year")
  April: "APRIL",

  @doc("Fifth Month of the Year")
  May: "MAY",

  @doc("Sixth Month of the Year")
  June: "JUNE",

  @doc("Seventh Month of the Year")
  July: "JULY",

  @doc("Eighth Month of the Year")
  August: "AUGUST",

  @doc("Ninth Month of the Year")
  September: "SEPTEMBER",

  @doc("Tenth Month of the Year")
  October: "OCTOBER",

  @doc("Eleventh Month of the Year")
  November: "NOVEMBER",

  @doc("Twelfth Month of the Year")
  December: "DECEMBER",

  string,
}

@doc("To represent the days of the week in Weekly type")
union WeeklyDays {
  @doc("First Day of the Week")
  Sunday: "SUNDAY",

  @doc("Second Day of the Week")
  Monday: "MONDAY",

  @doc("Third Day of the Week")
  Tuesday: "TUESDAY",

  @doc("Fourth Day of the Week")
  Wednesday: "WEDNESDAY",

  @doc("Fifth Day of the Week")
  Thursday: "THURSDAY",

  @doc("Sixth Day of the Week")
  Friday: "FRIDAY",

  @doc("Seventh Day of the Week")
  Saturday: "SATURDAY",

  string,
}

@doc("A Commvault Plan Retention Model")
model Retention {
  @doc("Number of Snapshots")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  numberOfSnapshots?: int32;
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataSourceType: "AzureVM";

  @doc("The Commvault Plan to be associated with the Protection Group")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  plan: string;

  @doc("The resources to be protected under Protection Group")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  resources: ProtectionGroupResources;

  @doc("The protection group schedule")
  @visibility(Lifecycle.Read)
  protectionStatus?: ProtectionStatus; //Check what values can it have

  @doc("The number of ProtectedItems under the Protection Group")
  @visibility(Lifecycle.Read)
  numberOfProtectedItems?: int32;

  @doc("The Commvault Protection Group backup time")
  @visibility(Lifecycle.Read)
  lastBackUpTime?: int64;

  @doc("The backup activity status indicating if backup is enabled or not on the protection group")
  @visibility(Lifecycle.Read)
  backupActivityStatus?: string = "Enabled";

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The Protection Status")
union ProtectionStatus {
  @doc("The protection group status is All")
  All: "all",

  @doc("The protection group status is Protected")
  Protected: "protected",

  @doc("The protection group status is Not Protected")
  Not_Protected: "not_protected",

  @doc("The protection group status is Pending")
  Pending: "pending",

  @doc("The protection group status is backed_up_with_error")
  Backed_up_with_error: "backed_up_with_error",

  @doc("The protection group status is discovered")
  Discovered: "discovered",

  string,
}

@doc("The resources to be protected under Protection Group")
model ProtectionGroupResources {
  @doc("The items to be protected under Protection Group")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  manual?: string[];

  @doc("Rules to match resources")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  matchRules?: {
    @doc("rules to match")
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
    @Azure.ResourceManager.identifiers(#[])
    rules: Rule[];

    @doc("match Type all or any")
    @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  property: RuleProperty;

  @doc("property of the rule")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  operator: Operator;

  @doc("property of the rule")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  reason: string;

  @doc("Any further comments")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  comment?: string;
}

@doc("The properties of BackupProtectionGroupRequest")
model BackupProtectionGroupRequest {
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "identifiers not applicable across version type change"
  @doc("The vm list details.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @typeChangedFrom(Versions.v5_preview, VmList)
  vmList: VmListItem[];

  @added(Versions.v5_preview)
  @doc("The backup options for the VM backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupOptions: BackupOptions;
}

@doc("Backup job response for a Protection Group")
model BackupProtectionGroupResponse {
  @doc("The Commvault response for taskId")
  @visibility(Lifecycle.Read)
  taskId: int32;

  @doc("The jobIds returned from Commvault.")
  @visibility(Lifecycle.Read)
  jobIds: string[];
}

@doc("The VM list item for backup")
model VmListItem {
  @doc("The GUID of the VM to backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmGuid: string;
}

@doc("The VM list wrapper for backup request")
model VmList {
  @doc("The list of VM GUIDs to backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  vmGuid: VmGuid[];

  @removed(Versions.v5_preview)
  @doc("The backup options for the VM backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupOptions: BackupOptions;
}

@doc("The VM GUID identifier")
model VmGuid {
  @doc("The identifier of the VM")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  id: string;
}

@doc("The backup options for the VM backup")
model BackupOptions {
  @doc("Indicates whether to stop backup or not for the VM")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @madeOptional(Versions.v5_preview)
  @typeChangedFrom(Versions.v5_preview, string)
  backupLevel?: BackupLevel;

  @doc("The name of the backup job to be shown in Commvault")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobDescription: string;

  @doc("Indicates whether to run backup immediately or not for the VM")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  backupCopyImmediately: boolean;

  @doc("Indicates whether to run snapshot backup or not for the VM, if false, it will run regular backup")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  runSnapShotBackup: boolean;

  @doc("Indicates whether to notify the user on job completion")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  notifyUserOnJobCompletion: boolean;
}

@armResourceOperations
interface ProtectionGroups {
  get is ArmResourceRead<ProtectionGroup>;
  createOrupdate is ArmResourceCreateOrUpdateAsync<ProtectionGroup>;
  delete is ArmResourceDeleteWithoutOkAsync<ProtectionGroup>;
  listByCloudAccount is ArmResourceListByParent<ProtectionGroup>;
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "stopBackup is a long-running operation that returns 204 with no content on completion"
  @doc("Stop Backup for a Protection Group")
  @armResourceAction(ProtectionGroup)
  @post
  @OpenAPI.extension("x-ms-long-running-operation", true)
  stopBackup(
    ...ResourceInstanceParameters<ProtectionGroup>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: StopBackupProtectionGroupRequest,
  ): ArmAcceptedLroResponse | ArmNoContentResponse | ErrorResponse;

  @doc("Restore resource for a protected items in given protection group.")
  @armResourceAction(ProtectionGroup)
  @action("restore")
  @post
  @added(Versions.v2_preview)
  restore(
    ...ResourceInstanceParameters<ProtectionGroup>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: RestoreProtectionItemRequest,
  ): ArmResponse<RestoreProtectionItemResponse> | ErrorResponse;

  @doc("Resume Backup for a Protection Group.")
  @armResourceAction(ProtectionGroup)
  @action("resumeBackup")
  @post
  @added(Versions.v3_preview)
  resumeBackup(...ResourceInstanceParameters<ProtectionGroup>):
    | ArmNoContentResponse<"Resource operation accepted.">
    | ErrorResponse;

  @doc("Ad-hoc backup of protected items resource in given protection group.")
  @armResourceAction(ProtectionGroup)
  @action("backup")
  @post
  @added(Versions.v4_preview)
  backup(
    ...ResourceInstanceParameters<ProtectionGroup>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: BackupProtectionGroupRequest,
  ): ArmResponse<BackupProtectionGroupResponse> | ErrorResponse;
}

@parentResource(ProtectionGroup)
model ProtectedItem is ProxyResource<ProtectedItemProperties> {
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  @doc("The protectedItem Id, name of 2 protected items can be same under a PG if they belong to different resource group or even different data source types VM/DB/AKS, etc; and name is mandatory in Azure Typespec, hence using name parameter for id in Commvault In case of Vm it will be vmGuid")
  @segment("protectedItems")
  @key("protectedItemName")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("The properties of Commvault Protected Item")
model ProtectedItemProperties {
  @doc("The Name of the commvault protected item")
  @visibility(Lifecycle.Read)
  resourceName: string;

  @doc("The Commvault Protected Item backup time")
  @visibility(Lifecycle.Read)
  lastBackUpTime: int64;

  @doc("The resource group of the protected item")
  @visibility(Lifecycle.Read)
  resourceGroup: string;

  @doc("The location of the protected item")
  @visibility(Lifecycle.Read)
  location: string;

  @doc("The GUID of VM")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[4][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$")
  @visibility(Lifecycle.Read)
  vmGuid: string;
}

@doc("Types of Restore Supported")
union RestoreType {
  @doc("Azure In place Restore")
  None: "NONE",

  @doc("Azure Out of Place")
  VirtualMachine: "VIRTUAL_MACHINE",

  @doc("Azure Attach disk restore to existing VM")
  DiskAttach: "DISK_ATTACH",

  string,
}

@doc("The properties of VMTag for Restore Request")
model VmTag {
  @doc("The name of VM tag.")
  name: string;

  @doc("The value of VM tag.")
  value: string;
}

@doc("The properties of information of a VM")
model VmInfo {
  @doc("The GUID of VM to be restored.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceVmGuid: string;

  @doc("The storage account to be used for restore.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountId: string;

  @doc("The identifier to check if VM needs to be powered on.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  powerOnVmAfterRestore?: boolean;

  @doc("The name of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name?: string;

  @doc("The resource group of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceGroup?: string;

  @doc("The region of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  region?: string;

  @doc("The network Id of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId?: string;

  @doc("The subnet Id of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId?: string;

  @doc("The identifier to check if to attach and swap disk of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachAndSwapOsDisk?: boolean;

  @doc("The GUID of target VM used in DISK ATTACH.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetVmGuid?: string;

  @added(Versions.v1_preview)
  @removed(Versions.v3_preview)
  @doc("The vmTag of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  vmtag?: VmTag[];

  @added(Versions.v3_preview)
  @doc("The vmTag of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  vmtags?: VmTag[];
}

@doc("The properties of VmDestinationInfo")
model VmDestinationInfo {
  @doc("List of information on VMs")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @Azure.ResourceManager.identifiers(#[])
  vmInfoList: VmInfo[];
}

@doc("The properties of RestoreProtectionItemRequest")
model RestoreProtectionItemRequest {
  @doc("Check whether inplace or out of place restore.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  inPlaceRestore: boolean;

  @doc("Type of Restore")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  restoreType?: RestoreType;

  @doc("Time to restore")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  toTime?: string;

  @doc("The vm destination details of the VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmDestinationInfo: VmDestinationInfo;
}

@doc("Response for count protected items operation.")
@added(Versions.v7_preview)
model CountProtectedItemsResponse {
  @doc("The count of protected items.")
  count: string;
}

@doc("Request to count protected items for the provided CCA resource IDs across subscriptions.")
@added(Versions.v7_preview)
model CountProtectedItemsRequest {
  @doc("The list of CCA resource IDs.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
  resourceIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Commvault.ContentStore/cloudAccounts";
    }
  ]>[];
}

@armResourceOperations
interface ProtectedItems {
  get is ArmResourceRead<ProtectedItem>;
  listByProtectionGroup is ArmResourceListByParent<ProtectedItem>;

  @doc("Limits used for creation of resources.")
  @armResourceAction(ProtectedItem)
  @action("getRestorePoints")
  @post
  getRestorePoints(...ResourceInstanceParameters<ProtectedItem>):
    | ArmResponse<RestorePoints>
    | ErrorResponse;

  @doc("Restore resource for a protected item.")
  @armResourceAction(ProtectedItem)
  @action("restore")
  @post
  restore(
    ...ResourceInstanceParameters<ProtectedItem>,

    @bodyRoot
    @doc("The body type of the operation request.")
    request: RestoreProtectionItemRequest,
  ): ArmResponse<RestoreProtectionItemResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Cross-subscription protected item count operation group"
@added(Versions.v7_preview)
interface ProtectedItemsOperationGroup {
  @doc("Gets the count of protected items for provided CCA resource IDs across subscriptions.")
  @autoRoute
  @action("protectedItemCount")
  countByProtectionGroups is ArmProviderActionSync<
    Request = CountProtectedItemsRequest,
    Response = CountProtectedItemsResponse,
    Scope = TenantActionScope,
    Parameters = {}
  >;
}

@doc("Restore points of a Protected Item")
model RestorePoints {
  @doc("The Commvault Protected Item Restore points")
  @visibility(Lifecycle.Read)
  restoreTimes: int64[];
}

@doc("Restore resource response for a Protected Item")
model RestoreProtectionItemResponse {
  @doc("The Commvault response for taskId")
  @visibility(Lifecycle.Read)
  taskId: int32;

  @doc("The jobIds returned from Commvault.")
  @visibility(Lifecycle.Read)
  jobIds: string[];
}

// ──────────────────────────────────────────────────────────────────────────────
// Entity Type – represents either a user or a group in Entra ID
// ──────────────────────────────────────────────────────────────────────────────

@doc("The type of the entity")
@added(Versions.v8_preview)
union EntityType {
  @doc("The entity is an Entra user")
  User: "User",

  @doc("The entity is an Entra security group")
  Group: "Group",

  string,
}

@doc("Information about an Entra entity (user or group) assigned to a role")
@added(Versions.v8_preview)
model EntityInfo {
  @doc("The unique identifier (UUID) of the Entra entity")
  id?: string;

  @doc("The display name of the Entra entity")
  displayName?: string;

  @doc("The type of entity - user or group")
  entityType?: EntityType;
}

// ──────────────────────────────────────────────────────────────────────────────
// Role Mapping – singleton child resource of CloudAccount (one per CCA)
// Stores the mapping of Entra security groups to Commvault roles.
// Created alongside CCA via ARM template deployment (dependsOn CCA).
// Liftr translates this JSON contract to the Commvault XML `:roleMapping` API.
// Pattern reference: Dynatrace MonitoredSubscriptionProperties (@singleton)
// ──────────────────────────────────────────────────────────────────────────────

@doc("A Commvault Role Mapping Resource. Singleton per Cloud Account - maps Entra security groups to Commvault roles for RBAC enforcement.")
@parentResource(CloudAccount)
@singleton("default")
@added(Versions.v8_preview)
model RoleMapping is ProxyResource<RoleMappingProperties> {
  ...ResourceNameParameter<
    Resource = RoleMapping,
    KeyName = "roleMappingName",
    SegmentName = "roleMappings",
    NamePattern = ""
  >;
}

@doc("The properties of Commvault Role Mapping")
@added(Versions.v8_preview)
model RoleMappingProperties {
  @doc("The list of role assignments mapping roles to Entra entities (users and groups)")
  @Azure.ResourceManager.identifiers(#[])
  roles?: RoleAssignment[];

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("A role assignment mapping a Commvault role to one or more Entra entities (users or groups)")
@added(Versions.v8_preview)
model RoleAssignment {
  @doc("The name of the Commvault role")
  roleName?: RoleName;

  @doc("The Entra entities (users or groups) assigned to this role")
  @Azure.ResourceManager.identifiers(#[])
  entities?: EntityInfo[];
}

@doc("Supported Commvault role names")
@added(Versions.v8_preview)
union RoleName {
  @doc("Backup Administrator - full access to all resources")
  BackupAdmin: "BackupAdmin",

  @doc("Backup Operator - can manage resources but cannot delete storage or plans")
  BackupOperator: "BackupOperator",

  @doc("Backup User - can manage protection groups, read-only on plans and storage")
  BackupUser: "BackupUser",

  @doc("Security Administrator - can manage CCA enrollment and user management")
  SecurityAdmin: "SecurityAdmin",

  @doc("MPA Administrator - can authorize critical operations protected by MPA")
  MultiPersonAuthorization: "MultiPersonAuthorization",

  string,
}

@armResourceOperations
@added(Versions.v8_preview)
interface RoleMappings {
  get is ArmResourceRead<RoleMapping>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<RoleMapping>;
  delete is ArmResourceDeleteSync<RoleMapping>;
  list is ArmResourceListByParent<RoleMapping>;
}
