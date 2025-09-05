import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Maintenance;

/**
 * Gets or sets maintenanceScope of the configuration
 */
union MaintenanceScope {
  string,

  /**
   * This maintenance scope controls installation of azure platform updates i.e. services on physical nodes hosting customer VMs.
   */
  Host: "Host",

  /**
   * This maintenance scope controls the default update maintenance of the Azure Resource
   */
  Resource: "Resource",

  /**
   * This maintenance scope controls os image installation on VM/VMSS
   */
  OSImage: "OSImage",

  /**
   * This maintenance scope controls extension installation on VM/VMSS
   */
  Extension: "Extension",

  /**
   * This maintenance scope controls installation of windows and linux packages on VM/VMSS
   */
  InGuestPatch: "InGuestPatch",

  /**
   * This maintenance scope controls installation of SQL server platform updates.
   */
  SQLDB: "SQLDB",

  /**
   * This maintenance scope controls installation of SQL managed instance platform update.
   */
  SQLManagedInstance: "SQLManagedInstance",
}

/**
 * Gets or sets the visibility of the configuration. The default value is 'Custom'
 */
union Visibility {
  string,

  /**
   * Only visible to users with permissions.
   */
  Custom: "Custom",

  /**
   * Visible to all users.
   */
  Public: "Public",
}

/**
 * Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed.
 */
union RebootOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IfRequired: "IfRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Never: "Never",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Always: "Always",
}

/**
 * The status
 */
union UpdateStatus {
  string,

  /**
   * There are pending updates to be installed.
   */
  Pending: "Pending",

  /**
   * Updates installation are in progress.
   */
  InProgress: "InProgress",

  /**
   * All updates are successfully applied.
   */
  Completed: "Completed",

  /**
   * Updates installation failed but are ready to retry again.
   */
  RetryNow: "RetryNow",

  /**
   * Updates installation failed and should be retried later.
   */
  RetryLater: "RetryLater",

  /**
   * No updates are pending.
   */
  NoUpdatesPending: "NoUpdatesPending",

  /**
   * Cancel the schedule and stop creating PMR for resources part of it. Applicable to Maintenance Configuration resource type only.
   */
  Cancel: "Cancel",

  /**
   * Send the Cancelled response to the user if request came to cancel the schedule. Applicable to Maintenance Configuration resource type only.
   */
  Cancelled: "Cancelled",
}

/**
 * The impact type
 */
union ImpactType {
  string,

  /**
   * Pending updates has no impact on resource.
   */
  None: "None",

  /**
   * Pending updates can freeze network or disk io operation on resource.
   */
  Freeze: "Freeze",

  /**
   * Pending updates can cause resource to restart.
   */
  Restart: "Restart",

  /**
   * Pending updates can redeploy resource.
   */
  Redeploy: "Redeploy",
}

/**
 * Filter VMs by Any or All specified tags.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum TagOperators {
  All,
  Any,
}

/**
 * Response of scheduled event acknowledge
 */
model ScheduledEventApproveResponse {
  /**
   * Successfully Approved
   */
  value?: string;
}

/**
 * An error response received from the Azure Maintenance service.
 */
@error
model MaintenanceError {
  /**
   * Details of the error
   */
  error?: ErrorDetails;
}

/**
 * An error response details received from the Azure Maintenance service.
 */
model ErrorDetails {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;
}

/**
 * Response for MaintenanceConfigurations list
 */
model ListMaintenanceConfigurationsResult {
  /**
   * The list of maintenance Configurations
   */
  @pageItems
  value?: MaintenanceConfiguration[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}

/**
 * Properties for maintenance configuration
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MaintenanceConfigurationProperties {
  /**
   * Gets or sets namespace of the resource
   */
  `namespace`?: string;

  /**
   * Gets or sets extensionProperties of the maintenanceConfiguration
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extensionProperties?: Record<string>;

  /**
   * Gets or sets maintenanceScope of the configuration
   */
  maintenanceScope?: MaintenanceScope;

  /**
   * Definition of a MaintenanceWindow
   */
  maintenanceWindow?: MaintenanceWindow;

  /**
   * Gets or sets the visibility of the configuration. The default value is 'Custom'
   */
  visibility?: Visibility;

  /**
   * The input parameters to be passed to the patch run operation.
   */
  installPatches?: InputPatchConfiguration;
}

/**
 * Definition of a MaintenanceWindow
 */
model MaintenanceWindow {
  /**
   * Effective start date of the maintenance window in YYYY-MM-DD hh:mm format. The start date can be set to either the current date or future date. The window will be created in the time zone provided and adjusted to daylight savings according to that time zone.
   */
  startDateTime?: string;

  /**
   * Effective expiration date of the maintenance window in YYYY-MM-DD hh:mm format. The window will be created in the time zone provided and adjusted to daylight savings according to that time zone. Expiration date must be set to a future date. If not provided, it will be set to the maximum datetime 9999-12-31 23:59:59.
   */
  expirationDateTime?: string;

  /**
   * Duration of the maintenance window in HH:mm format. If not provided, default value will be used based on maintenance scope provided. Example: 05:00.
   */
  duration?: string;

  /**
   * Name of the timezone. List of timezones can be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell. Example: Pacific Standard Time, UTC, W. Europe Standard Time, Korea Standard Time, Cen. Australia Standard Time.
   */
  timeZone?: string;

  /**
   * Rate at which a Maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules. Daily schedule are formatted as recurEvery: [Frequency as integer]['Day(s)']. If no frequency is provided, the default frequency is 1. Daily schedule examples are recurEvery: Day, recurEvery: 3Days.  Weekly schedule are formatted as recurEvery: [Frequency as integer]['Week(s)'] [Optional comma separated list of weekdays Monday-Sunday]. Weekly schedule examples are recurEvery: 3Weeks, recurEvery: Week Saturday,Sunday. Monthly schedules are formatted as [Frequency as integer]['Month(s)'] [Comma separated list of month days] or [Frequency as integer]['Month(s)'] [Week of Month (First, Second, Third, Fourth, Last)] [Weekday Monday-Sunday] [Optional Offset(No. of days)]. Offset value must be between -6 to 6 inclusive. Monthly schedule examples are recurEvery: Month, recurEvery: 2Months, recurEvery: Month day23,day24, recurEvery: Month Last Sunday, recurEvery: Month Fourth Monday, recurEvery: Month Last Sunday Offset-3, recurEvery: Month Third Sunday Offset6.
   */
  recurEvery?: string;
}

/**
 * Input configuration for a patch run
 */
model InputPatchConfiguration {
  /**
   * Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed.
   */
  rebootSetting?: RebootOptions = RebootOptions.IfRequired;

  /**
   * Input parameters specific to patching a Windows machine. For Linux machines, do not pass this property.
   */
  windowsParameters?: InputWindowsParameters;

  /**
   * Input parameters specific to patching Linux machine. For Windows machines, do not pass this property.
   */
  linuxParameters?: InputLinuxParameters;
}

/**
 * Input properties for patching a Windows machine.
 */
model InputWindowsParameters {
  /**
   * Windows KBID to be excluded for patching.
   */
  kbNumbersToExclude?: string[];

  /**
   * Windows KBID to be included for patching.
   */
  kbNumbersToInclude?: string[];

  /**
   * Classification category of patches to be patched. Allowed values are 'Critical', 'Security', 'UpdateRollup', 'FeaturePack', 'ServicePack', 'Definition', 'Tools', and 'Updates'.
   */
  classificationsToInclude?: string[];

  /**
   * Exclude patches which need reboot
   */
  excludeKbsRequiringReboot?: boolean;
}

/**
 * Input properties for patching a Linux machine.
 */
model InputLinuxParameters {
  /**
   * Package names to be excluded for patching.
   */
  packageNameMasksToExclude?: string[];

  /**
   * Package names to be included for patching.
   */
  packageNameMasksToInclude?: string[];

  /**
   * Classification category of patches to be patched. Allowed values are 'Critical', 'Security', and 'Other'.
   */
  classificationsToInclude?: string[];
}

/**
 * Definition of a Resource
 */
model Resource {
  /**
   * Fully qualified identifier of the resource
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Type of the resource
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties for apply update
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplyUpdateProperties {
  /**
   * The status
   */
  status?: UpdateStatus;

  /**
   * The resourceId
   */
  resourceId?: string;

  /**
   * Last Update time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;
}

/**
 * Properties for configuration assignment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ConfigurationAssignmentProperties {
  /**
   * The maintenance configuration Id
   */
  maintenanceConfigurationId?: string;

  /**
   * The unique resourceId
   */
  resourceId?: string;

  /**
   * Properties of the configuration assignment
   */
  filter?: ConfigurationAssignmentFilterProperties;
}

/**
 * Azure query for the update configuration.
 */
model ConfigurationAssignmentFilterProperties {
  /**
   * List of allowed resources.
   */
  resourceTypes?: string[];

  /**
   * List of allowed resource groups.
   */
  resourceGroups?: string[];

  /**
   * List of allowed operating systems.
   */
  osTypes?: string[];

  /**
   * List of locations to scope the query to.
   */
  locations?: string[];

  /**
   * Tag settings for the VM.
   */
  tagSettings?: TagSettingsProperties;
}

/**
 * Tag filter information for the VM.
 */
model TagSettingsProperties {
  /**
   * Dictionary of tags with its list of values.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string[]>;

  /**
   * Filter VMs by Any or All specified tags.
   */
  filterOperator?: TagOperators;
}

/**
 * Response for ConfigurationAssignments list
 */
model ListConfigurationAssignmentsResult {
  /**
   * The list of configuration Assignments
   */
  @pageItems
  value?: ConfigurationAssignment[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}

/**
 * Response for ApplyUpdate list
 */
model ListApplyUpdate {
  /**
   * The list of apply updates
   */
  @pageItems
  value?: ApplyUpdate[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}

/**
 * Information about an operation
 */
model OperationInfo {
  /**
   * Name of the provider
   */
  provider?: string;

  /**
   * Name of the resource type
   */
  resource?: string;

  /**
   * Name of the operation
   */
  operation?: string;

  /**
   * Description of the operation
   */
  description?: string;
}

/**
 * Response for Updates list
 */
model ListUpdatesResult {
  /**
   * The pending updates
   */
  @pageItems
  @OpenAPI.extension("x-ms-identifiers", #[])
  value?: Update[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: ResourceLocation<Resource>;
}

/**
 * Maintenance update on a resource
 */
model Update {
  /**
   * The impact area
   */
  maintenanceScope?: MaintenanceScope;

  /**
   * The impact type
   */
  impactType?: ImpactType;

  /**
   * The status
   */
  status?: UpdateStatus;

  /**
   * Duration of impact in seconds
   */
  impactDurationInSec?: int32;

  /**
   * Time when Azure will start force updates if not self-updated by customer before this time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notBefore?: utcDateTime;

  /**
   * Properties of the apply update
   */
  properties?: UpdateProperties;
}

/**
 * Properties for update
 */
model UpdateProperties {
  /**
   * The resourceId
   */
  resourceId?: string;
}

/**
 * Result of the List Operations operation
 */
model OperationsListResult {
  /**
   * The link used to get the next page of operations.
   */
  @nextLink
  nextLink?: string;

  /**
   * A collection of operations
   */
  @pageItems
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value?: Operation[];
}
