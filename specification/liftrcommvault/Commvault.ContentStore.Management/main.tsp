import "@azure-tools/typespec-liftr-base";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-providerhub";

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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Need to remove autoroute"
@route("/providers/Commvault.ContentStore/")
interface CommvaultTenant {
  /** Configure provider */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("configure")
  @post
  @action
  configure(
    ...ApiVersionParameter,

    /** The request body for the action */
    @body body: CompanyProperties,
  ): ArmAcceptedLroResponse | ErrorResponse;

  /** Describe provider details */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "Need to remove autoroute"
  @route("describe")
  @post
  @action
  describe(
    ...ApiVersionParameter,

    /** The request body for the action */
  ): CompanyProperties | ErrorResponse;
}

@doc("The properties of Commvault Company")
model CompanyProperties {
  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Single Sign On properties for the organization")
  singleSignOnProperties?: SingleSignOnProperties;
}

@doc("A Commvault Entity Resource")
model Entity is TrackedResource<EntityProperties> {
  @key("entityName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_\\-.: ]*$")
  @segment("entities")
  @minLength(1)
  @maxLength(50)
  @doc("Name of the Entity resource")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Entities {
  get is ArmResourceRead<Entity>;
  create is ArmResourceCreateOrReplaceAsync<Entity>;
  delete is ArmResourceDeleteWithoutOkAsync<Entity>;
  listByResourceGroup is ArmResourceListByParent<Entity>;
  listBySubscription is ArmListBySubscription<Entity>;
}

@doc("Properties specific to Commvault Entity resource")
model EntityProperties is BaseResourceProperties;

@doc("A Commvault Storage Resource")
@parentResource(Entity)
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
  @doc("The type of Commvault Storage")
  @visibility("read", "create")
  storageType: "Air_Gap_Protect";

  @doc("The vendor of Commvault Storage")
  @visibility("read", "create")
  vendor: "Azure_Blob_Storage";

  @doc("The class of Commvault Storage")
  @visibility("read", "create", "update")
  class: StorageClass;

  @doc("Details of the user.")
  user: UserDetails;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("The class of Commvault Storage")
union StorageClass {
  @doc("Cool storage class")
  Cool: "COOL",

  @doc("Hot storage class")
  Hot: "HOT",

  string,
}

@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  create is ArmResourceCreateOrReplaceAsync<Storage>;
  //update is ArmResourcePatchAsync<Storage, StorageProperties>; not suppported in Private preview
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByParent is ArmResourceListByParent<Storage>;
}

@parentResource(Entity)
@doc("A Commvault Plan Resource")
model Plan is ProxyResource<PlanProperties> {
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
  @doc("The storage plans associated with the Commvault Plan")
  @visibility("read", "create")
  @minItems(1)
  @maxItems(11)
  @OpenAPI.extension("x-ms-identifiers", [])
  storagePlans: StoragePlan[];

  @doc("The Commvault Plan Schedule")
  @visibility("read", "create", "update")
  schedule: Schedule;

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

  @doc("Indicates if this is the primary storage plan")
  isPrimary: boolean;

  @doc("Indicates the retention period valid only if the type of retention chosen in CUSTOM")
  retentionPeriod?: int32;

  @doc("Indicates the retention timeframe valid only if the type of retention chosen in CUSTOM")
  retentionTime?: RetentionTime;

  @doc("Indicates the monthlyFull retention time valid only if the type of retention chosen in CUSTOM")
  monthlyRetention?: int32;

  @doc("Indicates the yearly Full retention time valid only if the type of retention chosen in CUSTOM")
  yearlyRetention?: int32;
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

  @visibility("read", "create", "update")
  @doc("FullBackUpDetails")
  fullbackupDetails?: ScheduleDetails;

  @visibility("read", "create", "update")
  @doc("IncrementalBackUpDetails")
  incrementalbackUpDetails?: ScheduleDetails;

  @doc("Type of Retention")
  retentionType: RetentionType;
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

  string,
}

@doc("A Commvault Plan Retention Model")
model Retention {
  @doc("Number of Snapshots")
  @visibility("read", "create", "update")
  numberOfSnapshots: int32;

  @doc("Type of retention")
  @visibility("read", "create", "update")
  type: RetentionType;
}

@armResourceOperations
interface Plans {
  get is ArmResourceRead<Plan>;
  create is ArmResourceCreateOrReplaceAsync<Plan>;
  update is ArmResourcePatchAsync<Plan, PlanProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Plan>;
  listByParent is ArmResourceListByParent<Plan>;
}

@parentResource(Entity)
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
  PowerState: "powerstate",

  @doc("The virtual machine of the rule")
  VirtualMachine: "virtualmachine",

  @doc("The virtual machine pattern of the rule")
  VirtualMachinePattern: "virtualmachinepattern",

  string,
}

@doc("The types of operator")
union Operator {
  @doc("The operator contains")
  Contains: "contains",

  @doc("The operator does not contains")
  DoesNotContains: "doesnotcontains",

  @doc("The operator does not equal")
  DoesNotEqual: "doesnotequal",

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
  create is ArmResourceCreateOrReplaceAsync<ProtectionGroup>;
  update is ArmResourcePatchAsync<ProtectionGroup, ProtectionGroupProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ProtectionGroup>;
  listByParent is ArmResourceListByParent<ProtectionGroup>;
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  stopBackup is ArmResourceActionNoContentAsync<
    ProtectionGroup,
    StopBackupProtectionGroupRequest
  >;
}

@parentResource(ProtectionGroup)
model ProtectedResource is ProxyResource<ProtectedResourceProperties> {
  @pattern("^[a-zA-Z0-9\\-_]{1,127}$")
  @doc("The protectedResource name")
  @segment("protectedresources")
  @key("protectedResourceName")
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("The properties of Commvault Protected Resource")
model ProtectedResourceProperties {
  @doc("The Commvault Protected Resource backup time")
  @visibility("read")
  lastBackUpTime: utcDateTime;
}

@armResourceOperations
interface ProtectedResources {
  get is ArmResourceRead<ProtectedResource>;
  listByParent is ArmResourceListByParent<ProtectedResource>;
}
