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

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Gets or sets maintenanceScope of the configuration")
enum MaintenanceScope {
  @doc("This maintenance scope controls installation of azure platform updates i.e. services on physical nodes hosting customer VMs.")
  Host,
  @doc("This maintenance scope controls the default update maintenance of the Azure Resource")
  Resource,
  @doc("This maintenance scope controls os image installation on VM/VMSS")
  OSImage,
  @doc("This maintenance scope controls extension installation on VM/VMSS")
  Extension,
  @doc("This maintenance scope controls installation of windows and linux packages on VM/VMSS")
  InGuestPatch,
  @doc("This maintenance scope controls installation of SQL server platform updates.")
  SQLDB,
  @doc("This maintenance scope controls installation of SQL managed instance platform update.")
  SQLManagedInstance,
}

@doc("Gets or sets the visibility of the configuration. The default value is 'Custom'")
enum Visibility {
  @doc("Only visible to users with permissions.") Custom,
  @doc("Visible to all users.") Public,
}

@doc("Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed.")
enum RebootOptions {
  IfRequired,
  Never,
  Always,
}

@doc("The status")
enum UpdateStatus {
  @doc("There are pending updates to be installed.") Pending,
  @doc("Updates installation are in progress.") InProgress,
  @doc("All updates are successfully applied.") Completed,
  @doc("Updates installation failed but are ready to retry again.") RetryNow,
  @doc("Updates installation failed and should be retried later.") RetryLater,
  @doc("No updates are pending.") NoUpdatesPending,
  @doc("Cancel the schedule and stop creating PMR for resources part of it. Applicable to Maintenance Configuration resource type only.")
  Cancel,
  @doc("Send the Cancelled response to the user if request came to cancel the schedule. Applicable to Maintenance Configuration resource type only.")
  Cancelled,
}

@doc("The impact type")
enum ImpactType {
  @doc("Pending updates has no impact on resource.") None,
  @doc("Pending updates can freeze network or disk io operation on resource.")
  Freeze,
  @doc("Pending updates can cause resource to restart.") Restart,
  @doc("Pending updates can redeploy resource.") Redeploy,
}

@doc("Filter VMs by Any or All specified tags.")
@fixed
enum TagOperators {
  All,
  Any,
}

@doc("Properties for maintenance configuration")
model MaintenanceConfigurationProperties {
  @doc("Gets or sets namespace of the resource")
  `namespace`?: string;

  @doc("Gets or sets extensionProperties of the maintenanceConfiguration")
  extensionProperties?: Record<string>;

  @doc("Gets or sets maintenanceScope of the configuration")
  maintenanceScope?: MaintenanceScope;

  @doc("Definition of a MaintenanceWindow")
  maintenanceWindow?: MaintenanceWindow;

  @doc("Gets or sets the visibility of the configuration. The default value is 'Custom'")
  visibility?: Visibility;

  @doc("The input parameters to be passed to the patch run operation.")
  installPatches?: InputPatchConfiguration;
}

@doc("Definition of a MaintenanceWindow")
model MaintenanceWindow {
  @doc("Effective start date of the maintenance window in YYYY-MM-DD hh:mm format. The start date can be set to either the current date or future date. The window will be created in the time zone provided and adjusted to daylight savings according to that time zone.")
  startDateTime?: string;

  @doc("Effective expiration date of the maintenance window in YYYY-MM-DD hh:mm format. The window will be created in the time zone provided and adjusted to daylight savings according to that time zone. Expiration date must be set to a future date. If not provided, it will be set to the maximum datetime 9999-12-31 23:59:59.")
  expirationDateTime?: string;

  @doc("Duration of the maintenance window in HH:mm format. If not provided, default value will be used based on maintenance scope provided. Example: 05:00.")
  duration?: string;

  @doc("Name of the timezone. List of timezones can be obtained by executing [System.TimeZoneInfo]::GetSystemTimeZones() in PowerShell. Example: Pacific Standard Time, UTC, W. Europe Standard Time, Korea Standard Time, Cen. Australia Standard Time.")
  timeZone?: string;

  @doc("Rate at which a Maintenance window is expected to recur. The rate can be expressed as daily, weekly, or monthly schedules. Daily schedule are formatted as recurEvery: [Frequency as integer]['Day(s)']. If no frequency is provided, the default frequency is 1. Daily schedule examples are recurEvery: Day, recurEvery: 3Days.  Weekly schedule are formatted as recurEvery: [Frequency as integer]['Week(s)'] [Optional comma separated list of weekdays Monday-Sunday]. Weekly schedule examples are recurEvery: 3Weeks, recurEvery: Week Saturday,Sunday. Monthly schedules are formatted as [Frequency as integer]['Month(s)'] [Comma separated list of month days] or [Frequency as integer]['Month(s)'] [Week of Month (First, Second, Third, Fourth, Last)] [Weekday Monday-Sunday] [Optional Offset(No. of days)]. Offset value must be between -6 to 6 inclusive. Monthly schedule examples are recurEvery: Month, recurEvery: 2Months, recurEvery: Month day23,day24, recurEvery: Month Last Sunday, recurEvery: Month Fourth Monday, recurEvery: Month Last Sunday Offset-3, recurEvery: Month Third Sunday Offset6.")
  recurEvery?: string;
}

@doc("Input configuration for a patch run")
model InputPatchConfiguration {
  @doc("Possible reboot preference as defined by the user based on which it would be decided to reboot the machine or not after the patch operation is completed.")
  rebootSetting?: RebootOptions;

  @doc("Input parameters specific to patching a Windows machine. For Linux machines, do not pass this property.")
  windowsParameters?: InputWindowsParameters;

  @doc("Input parameters specific to patching Linux machine. For Windows machines, do not pass this property.")
  linuxParameters?: InputLinuxParameters;
}

@doc("Input properties for patching a Windows machine.")
model InputWindowsParameters {
  @doc("Windows KBID to be excluded for patching.")
  kbNumbersToExclude?: string[];

  @doc("Windows KBID to be included for patching.")
  kbNumbersToInclude?: string[];

  @doc("Classification category of patches to be patched")
  classificationsToInclude?: string[];

  @doc("Exclude patches which need reboot")
  excludeKbsRequiringReboot?: boolean;
}

@doc("Input properties for patching a Linux machine.")
model InputLinuxParameters {
  @doc("Package names to be excluded for patching.")
  packageNameMasksToExclude?: string[];

  @doc("Package names to be included for patching.")
  packageNameMasksToInclude?: string[];

  @doc("Classification category of patches to be patched")
  classificationsToInclude?: string[];
}

@doc("Definition of a Resource")
model Resource {
  @doc("Fully qualified identifier of the resource")
  @visibility("read")
  id?: string;

  @doc("Name of the resource")
  @visibility("read")
  name?: string;

  @doc("Type of the resource")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("An error response received from the Azure Maintenance service.")
@error
model MaintenanceError {
  @doc("Details of the error")
  error?: ErrorDetails;
}

@doc("An error response details received from the Azure Maintenance service.")
model ErrorDetails {
  @doc("Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.")
  code?: string;

  @doc("Human-readable representation of the error.")
  message?: string;
}

@doc("Properties for apply update")
model ApplyUpdateProperties {
  @doc("The status")
  status?: UpdateStatus;

  @doc("The resourceId")
  resourceId?: string;

  @doc("Last Update time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdateTime?: utcDateTime;
}

@doc("Configuration Assignment")
model ConfigurationAssignment extends Resource {
  @doc("Location of the resource")
  location?: string;

  @doc("Properties of the configuration assignment")
  properties?: ConfigurationAssignmentProperties;
}

@doc("Properties for configuration assignment")
model ConfigurationAssignmentProperties {
  @doc("The maintenance configuration Id")
  maintenanceConfigurationId?: string;

  @doc("The unique resourceId")
  resourceId?: string;

  @doc("Properties of the configuration assignment")
  filter?: ConfigurationAssignmentFilterProperties;
}

@doc("Azure query for the update configuration.")
model ConfigurationAssignmentFilterProperties {
  @doc("List of allowed resources.")
  resourceTypes?: string[];

  @doc("List of allowed resource groups.")
  resourceGroups?: string[];

  @doc("List of allowed operating systems.")
  osTypes?: string[];

  @doc("List of locations to scope the query to.")
  locations?: string[];

  @doc("Tag settings for the VM.")
  tagSettings?: TagSettingsProperties;
}

@doc("Tag filter information for the VM.")
model TagSettingsProperties {
  @doc("Dictionary of tags with its list of values.")
  tags?: Record<string[]>;

  @doc("Filter VMs by Any or All specified tags.")
  filterOperator?: TagOperators;
}

@doc("Response for ConfigurationAssignments list")
@pagedResult
model ListConfigurationAssignmentsResult {
  @doc("The list of configuration Assignments")
  @items
  value?: ConfigurationAssignment[];
}

@doc("Information about an operation")
model OperationInfo {
  @doc("Name of the provider")
  provider?: string;

  @doc("Name of the resource type")
  resource?: string;

  @doc("Name of the operation")
  operation?: string;

  @doc("Description of the operation")
  description?: string;
}

@doc("Response for Updates list")
@pagedResult
model ListUpdatesResult {
  @doc("The pending updates")
  @items
  value?: Update[];
}

@doc("Maintenance update on a resource")
model Update {
  @doc("The impact area")
  maintenanceScope?: MaintenanceScope;

  @doc("The impact type")
  impactType?: ImpactType;

  @doc("The status")
  status?: UpdateStatus;

  @doc("Duration of impact in seconds")
  impactDurationInSec?: int32;

  @doc("Time when Azure will start force updates if not self-updated by customer before this time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notBefore?: utcDateTime;

  @doc("Properties of the apply update")
  properties?: UpdateProperties;
}

@doc("Properties for update")
model UpdateProperties {
  @doc("The resourceId")
  resourceId?: string;
}
