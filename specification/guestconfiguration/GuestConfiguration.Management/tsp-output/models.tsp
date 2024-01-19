import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.GuestConfiguration;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Kind of the guest configuration. For example:DSC")
enum Kind {
  DSC,
}

@doc("Specifies the assignment type and execution of the configuration. Possible values are Audit, DeployAndAutoCorrect, ApplyAndAutoCorrect and ApplyAndMonitor.")
enum AssignmentType {
  Audit,
  DeployAndAutoCorrect,
  ApplyAndAutoCorrect,
  ApplyAndMonitor,
}

@doc("Specifies how the LCM(Local Configuration Manager) actually applies the configuration to the target nodes. Possible values are ApplyOnly, ApplyAndMonitor, and ApplyAndAutoCorrect.")
enum ConfigurationMode {
  ApplyOnly,
  ApplyAndMonitor,
  ApplyAndAutoCorrect,
}

@doc("Specifies what happens after a reboot during the application of a configuration. The possible values are ContinueConfiguration and StopConfiguration")
enum ActionAfterReboot {
  ContinueConfiguration,
  StopConfiguration,
}

@doc("A value indicating compliance status of the machine for the assigned guest configuration.")
enum ComplianceStatus {
  Compliant,
  NonCompliant,
  Pending,
}

@doc("Type of report, Consistency or Initial")
enum Type {
  Consistency,
  Initial,
}

@doc("The provisioning state, which only appears in the response.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Created,
}

@doc("Guest configuration assignment properties.")
model GuestConfigurationAssignmentProperties {
  @doc("VM resource Id.")
  @visibility("read")
  targetResourceId?: string;

  @doc("The guest configuration to assign.")
  guestConfiguration?: GuestConfigurationNavigation;

  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("Date and time when last compliance status was checked.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceStatusChecked?: utcDateTime;

  @doc("Id of the latest report for the guest configuration assignment. ")
  @visibility("read")
  latestReportId?: string;

  @doc("parameter hash for the guest configuration assignment. ")
  @visibility("read")
  parameterHash?: string;

  @doc("Last reported guest configuration assignment report.")
  latestAssignmentReport?: AssignmentReport;

  @doc("The source which initiated the guest configuration assignment. Ex: Azure Policy")
  context?: string;

  @doc("Combined hash of the configuration package and parameters.")
  @visibility("read")
  assignmentHash?: string;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Type of the resource - VMSS / VM")
  @visibility("read")
  resourceType?: string;

  @doc("The list of VM Compliance data for VMSS")
  vmssVMList?: VmssvmInfo[];
}

@doc("Guest configuration is an artifact that encapsulates DSC configuration and its dependencies. The artifact is a zip file containing DSC configuration (as MOF) and dependent resources and other dependencies like modules.")
model GuestConfigurationNavigation {
  @doc("Kind of the guest configuration. For example:DSC")
  kind?: Kind;

  @doc("Name of the guest configuration.")
  name?: string;

  @doc("Version of the guest configuration.")
  version?: string;

  @doc("Uri of the storage where guest configuration package is uploaded.")
  contentUri?: string;

  @doc("Combined hash of the guest configuration package and configuration parameters.")
  contentHash?: string;

  @doc("Specifies the assignment type and execution of the configuration. Possible values are Audit, DeployAndAutoCorrect, ApplyAndAutoCorrect and ApplyAndMonitor.")
  assignmentType?: AssignmentType;

  @doc("Specifies the origin of the configuration.")
  @visibility("read")
  assignmentSource?: string;

  @doc("Specifies the content type of the configuration. Possible values could be Builtin or Custom.")
  @visibility("read")
  contentType?: string;

  @doc("The configuration parameters for the guest configuration.")
  configurationParameter?: ConfigurationParameter[];

  @doc("The protected configuration parameters for the guest configuration.")
  configurationProtectedParameter?: ConfigurationParameter[];

  @doc("The configuration setting for the guest configuration.")
  @visibility("read")
  configurationSetting?: ConfigurationSetting;
}

@doc("Represents a configuration parameter.")
model ConfigurationParameter {
  @doc("Name of the configuration parameter.")
  name?: string;

  @doc("Value of the configuration parameter.")
  value?: string;
}

@doc("Configuration setting of LCM (Local Configuration Manager).")
model ConfigurationSetting {
  @doc("Specifies how the LCM(Local Configuration Manager) actually applies the configuration to the target nodes. Possible values are ApplyOnly, ApplyAndMonitor, and ApplyAndAutoCorrect.")
  @visibility("read")
  configurationMode?: ConfigurationMode;

  @doc("If true - new configurations downloaded from the pull service are allowed to overwrite the old ones on the target node. Otherwise, false")
  @visibility("read")
  allowModuleOverwrite?: boolean;

  @doc("Specifies what happens after a reboot during the application of a configuration. The possible values are ContinueConfiguration and StopConfiguration")
  @visibility("read")
  actionAfterReboot?: ActionAfterReboot;

  @doc("The time interval, in minutes, at which the LCM checks a pull service to get updated configurations. This value is ignored if the LCM is not configured in pull mode. The default value is 30.")
  @visibility("read")
  refreshFrequencyMins?: float32;

  @doc("Set this to true to automatically reboot the node after a configuration that requires reboot is applied. Otherwise, you will have to manually reboot the node for any configuration that requires it. The default value is false. To use this setting when a reboot condition is enacted by something other than DSC (such as Windows Installer), combine this setting with the xPendingReboot module.")
  @visibility("read")
  rebootIfNeeded?: boolean;

  @doc("How often, in minutes, the current configuration is checked and applied. This property is ignored if the ConfigurationMode property is set to ApplyOnly. The default value is 15.")
  @visibility("read")
  configurationModeFrequencyMins?: float32;
}

model AssignmentReport {
  @doc("ARM resource id of the report for the guest configuration assignment.")
  @visibility("read")
  id?: string;

  @doc("GUID that identifies the guest configuration assignment report under a subscription, resource group.")
  @visibility("read")
  reportId?: string;

  @doc("Configuration details of the guest configuration assignment.")
  assignment?: AssignmentInfo;

  @doc("Information about the VM.")
  vm?: VMInfo;

  @doc("Start date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("Type of report, Consistency or Initial")
  @visibility("read")
  operationType?: Type;

  @doc("The list of resources for which guest configuration assignment compliance is checked.")
  resources?: AssignmentReportResource[];
}

@doc("Information about the guest configuration assignment.")
model AssignmentInfo {
  @doc("Name of the guest configuration assignment.")
  @visibility("read")
  name?: string;

  @doc("Information about the configuration.")
  configuration?: ConfigurationInfo;
}

@doc("Information about the configuration.")
model ConfigurationInfo {
  @doc("Name of the configuration.")
  @visibility("read")
  name?: string;

  @doc("Version of the configuration.")
  @visibility("read")
  version?: string;
}

@doc("Information about the VM.")
model VMInfo {
  @doc("Azure resource Id of the VM.")
  @visibility("read")
  id?: string;

  @doc("UUID(Universally Unique Identifier) of the VM.")
  @visibility("read")
  uuid?: string;
}

@doc("The guest configuration assignment resource.")
model AssignmentReportResource {
  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("Name of the guest configuration assignment resource setting.")
  @visibility("read")
  resourceId?: string;

  @doc("Compliance reason and reason code for a resource.")
  reasons?: AssignmentReportResourceComplianceReason[];

  @doc("Properties of a guest configuration assignment resource.")
  @visibility("read")
  properties?: Record<unknown>;
}

@doc("Reason and code for the compliance of the guest configuration assignment resource.")
model AssignmentReportResourceComplianceReason {
  @doc("Reason for the compliance of the guest configuration assignment resource.")
  @visibility("read")
  phrase?: string;

  @doc("Code for the compliance of the guest configuration assignment resource.")
  @visibility("read")
  code?: string;
}

@doc("Information about VMSS VM")
model VmssvmInfo {
  @doc("UUID of the VM.")
  @visibility("read")
  vmId?: string;

  @doc("Azure resource Id of the VM.")
  @visibility("read")
  vmResourceId?: string;

  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("Id of the latest report for the guest configuration assignment. ")
  @visibility("read")
  latestReportId?: string;

  @doc("Date and time when last compliance status was checked.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceChecked?: utcDateTime;
}

@doc("The core properties of guest configuration resources")
model GuestConfigurationResourceData {
  @doc("ARM resource id of the guest configuration assignment.")
  @visibility("read")
  id?: string;

  @doc("Name of the guest configuration assignment.")
  name?: string;

  @doc("Region where the VM is located.")
  location?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

model ErrorResponseError {
  @doc("Error code.")
  code?: string;

  @doc("Detail error message indicating why the operation failed.")
  message?: string;
}

@doc("List of guest configuration assignment reports.")
@pagedResult
model GuestConfigurationAssignmentReportList {
  @doc("List of reports for the guest configuration. Report contains information such as compliance status, reason and more.")
  @items
  value?: GuestConfigurationAssignmentReport[];
}

@doc("Report for the guest configuration assignment. Report contains information such as compliance status, reason, and more.")
model GuestConfigurationAssignmentReport {
  @doc("ARM resource id of the report for the guest configuration assignment.")
  @visibility("read")
  id?: string;

  @doc("GUID that identifies the guest configuration assignment report under a subscription, resource group.")
  @visibility("read")
  name?: string;

  @doc("Properties of the guest configuration report.")
  properties?: GuestConfigurationAssignmentReportProperties;
}

@doc("Report for the guest configuration assignment. Report contains information such as compliance status, reason, and more.")
model GuestConfigurationAssignmentReportProperties {
  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("GUID that identifies the guest configuration assignment report under a subscription, resource group.")
  @visibility("read")
  reportId?: string;

  @doc("Configuration details of the guest configuration assignment.")
  assignment?: AssignmentInfo;

  @doc("Information about the VM.")
  vm?: VMInfo;

  @doc("Start date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Details of the assignment report.")
  details?: AssignmentReportDetails;

  @doc("Azure resource Id of the VMSS.")
  @visibility("read")
  vmssResourceId?: string;
}

@doc("Details of the guest configuration assignment report.")
model AssignmentReportDetails {
  @doc("A value indicating compliance status of the machine for the assigned guest configuration.")
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  @doc("Start date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End date and time of the guest configuration assignment compliance status check.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("GUID of the report.")
  @visibility("read")
  jobId?: string;

  @doc("Type of report, Consistency or Initial")
  @visibility("read")
  operationType?: Type;

  @doc("The list of resources for which guest configuration assignment compliance is checked.")
  resources?: AssignmentReportResource[];
}

@doc("Provider, Resource, Operation and description values.")
model OperationProperties {
  @doc("Service provider: Microsoft.GuestConfiguration")
  statusCode?: string;
}
