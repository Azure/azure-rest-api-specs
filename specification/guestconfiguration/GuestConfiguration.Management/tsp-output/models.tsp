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

/**
 * Kind of the guest configuration. For example:DSC
 */
enum Kind {
  DSC,
}

/**
 * Specifies the assignment type and execution of the configuration. Possible values are Audit, DeployAndAutoCorrect, ApplyAndAutoCorrect and ApplyAndMonitor.
 */
enum AssignmentType {
  Audit,
  DeployAndAutoCorrect,
  ApplyAndAutoCorrect,
  ApplyAndMonitor,
}

/**
 * Specifies how the LCM(Local Configuration Manager) actually applies the configuration to the target nodes. Possible values are ApplyOnly, ApplyAndMonitor, and ApplyAndAutoCorrect.
 */
enum ConfigurationMode {
  ApplyOnly,
  ApplyAndMonitor,
  ApplyAndAutoCorrect,
}

/**
 * Specifies what happens after a reboot during the application of a configuration. The possible values are ContinueConfiguration and StopConfiguration
 */
enum ActionAfterReboot {
  ContinueConfiguration,
  StopConfiguration,
}

/**
 * A value indicating compliance status of the machine for the assigned guest configuration.
 */
enum ComplianceStatus {
  Compliant,
  NonCompliant,
  Pending,
}

/**
 * Type of report, Consistency or Initial
 */
enum Type {
  Consistency,
  Initial,
}

/**
 * The provisioning state, which only appears in the response.
 */
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Created,
}

/**
 * Guest configuration assignment properties.
 */
model GuestConfigurationAssignmentProperties {
  /**
   * VM resource Id.
   */
  @visibility("read")
  targetResourceId?: string;

  /**
   * The guest configuration to assign.
   */
  guestConfiguration?: GuestConfigurationNavigation;

  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * Date and time when last compliance status was checked.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceStatusChecked?: utcDateTime;

  /**
   * Id of the latest report for the guest configuration assignment.
   */
  @visibility("read")
  latestReportId?: string;

  /**
   * parameter hash for the guest configuration assignment.
   */
  @visibility("read")
  parameterHash?: string;

  /**
   * Last reported guest configuration assignment report.
   */
  latestAssignmentReport?: AssignmentReport;

  /**
   * The source which initiated the guest configuration assignment. Ex: Azure Policy
   */
  context?: string;

  /**
   * Combined hash of the configuration package and parameters.
   */
  @visibility("read")
  assignmentHash?: string;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Type of the resource - VMSS / VM
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The list of VM Compliance data for VMSS
   */
  vmssVMList?: VmssvmInfo[];
}

/**
 * Guest configuration is an artifact that encapsulates DSC configuration and its dependencies. The artifact is a zip file containing DSC configuration (as MOF) and dependent resources and other dependencies like modules.
 */
model GuestConfigurationNavigation {
  /**
   * Kind of the guest configuration. For example:DSC
   */
  kind?: Kind;

  /**
   * Name of the guest configuration.
   */
  name?: string;

  /**
   * Version of the guest configuration.
   */
  version?: string;

  /**
   * Uri of the storage where guest configuration package is uploaded.
   */
  contentUri?: string;

  /**
   * Combined hash of the guest configuration package and configuration parameters.
   */
  contentHash?: string;

  /**
   * Specifies the assignment type and execution of the configuration. Possible values are Audit, DeployAndAutoCorrect, ApplyAndAutoCorrect and ApplyAndMonitor.
   */
  assignmentType?: AssignmentType;

  /**
   * Specifies the origin of the configuration.
   */
  @visibility("read")
  assignmentSource?: string;

  /**
   * Specifies the content type of the configuration. Possible values could be Builtin or Custom.
   */
  @visibility("read")
  contentType?: string;

  /**
   * The configuration parameters for the guest configuration.
   */
  configurationParameter?: ConfigurationParameter[];

  /**
   * The protected configuration parameters for the guest configuration.
   */
  configurationProtectedParameter?: ConfigurationParameter[];

  /**
   * The configuration setting for the guest configuration.
   */
  @visibility("read")
  configurationSetting?: ConfigurationSetting;
}

/**
 * Represents a configuration parameter.
 */
model ConfigurationParameter {
  /**
   * Name of the configuration parameter.
   */
  name?: string;

  /**
   * Value of the configuration parameter.
   */
  value?: string;
}

/**
 * Configuration setting of LCM (Local Configuration Manager).
 */
model ConfigurationSetting {
  /**
   * Specifies how the LCM(Local Configuration Manager) actually applies the configuration to the target nodes. Possible values are ApplyOnly, ApplyAndMonitor, and ApplyAndAutoCorrect.
   */
  @visibility("read")
  configurationMode?: ConfigurationMode;

  /**
   * If true - new configurations downloaded from the pull service are allowed to overwrite the old ones on the target node. Otherwise, false
   */
  @visibility("read")
  allowModuleOverwrite?: boolean;

  /**
   * Specifies what happens after a reboot during the application of a configuration. The possible values are ContinueConfiguration and StopConfiguration
   */
  @visibility("read")
  actionAfterReboot?: ActionAfterReboot;

  /**
   * The time interval, in minutes, at which the LCM checks a pull service to get updated configurations. This value is ignored if the LCM is not configured in pull mode. The default value is 30.
   */
  @visibility("read")
  refreshFrequencyMins?: float32 = 30;

  /**
   * Set this to true to automatically reboot the node after a configuration that requires reboot is applied. Otherwise, you will have to manually reboot the node for any configuration that requires it. The default value is false. To use this setting when a reboot condition is enacted by something other than DSC (such as Windows Installer), combine this setting with the xPendingReboot module.
   */
  @visibility("read")
  rebootIfNeeded?: boolean;

  /**
   * How often, in minutes, the current configuration is checked and applied. This property is ignored if the ConfigurationMode property is set to ApplyOnly. The default value is 15.
   */
  @visibility("read")
  configurationModeFrequencyMins?: float32 = 15;
}

model AssignmentReport {
  /**
   * ARM resource id of the report for the guest configuration assignment.
   */
  @visibility("read")
  id?: string;

  /**
   * GUID that identifies the guest configuration assignment report under a subscription, resource group.
   */
  @visibility("read")
  reportId?: string;

  /**
   * Configuration details of the guest configuration assignment.
   */
  assignment?: AssignmentInfo;

  /**
   * Information about the VM.
   */
  vm?: VMInfo;

  /**
   * Start date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * Type of report, Consistency or Initial
   */
  @visibility("read")
  operationType?: Type;

  /**
   * The list of resources for which guest configuration assignment compliance is checked.
   */
  resources?: AssignmentReportResource[];
}

/**
 * Information about the guest configuration assignment.
 */
model AssignmentInfo {
  /**
   * Name of the guest configuration assignment.
   */
  @visibility("read")
  name?: string;

  /**
   * Information about the configuration.
   */
  configuration?: ConfigurationInfo;
}

/**
 * Information about the configuration.
 */
model ConfigurationInfo {
  /**
   * Name of the configuration.
   */
  @visibility("read")
  name?: string;

  /**
   * Version of the configuration.
   */
  @visibility("read")
  version?: string;
}

/**
 * Information about the VM.
 */
model VMInfo {
  /**
   * Azure resource Id of the VM.
   */
  @visibility("read")
  id?: string;

  /**
   * UUID(Universally Unique Identifier) of the VM.
   */
  @visibility("read")
  uuid?: string;
}

/**
 * The guest configuration assignment resource.
 */
model AssignmentReportResource {
  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * Name of the guest configuration assignment resource setting.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * Compliance reason and reason code for a resource.
   */
  reasons?: AssignmentReportResourceComplianceReason[];

  /**
   * Properties of a guest configuration assignment resource.
   */
  @visibility("read")
  properties?: Record<unknown>;
}

/**
 * Reason and code for the compliance of the guest configuration assignment resource.
 */
model AssignmentReportResourceComplianceReason {
  /**
   * Reason for the compliance of the guest configuration assignment resource.
   */
  @visibility("read")
  phrase?: string;

  /**
   * Code for the compliance of the guest configuration assignment resource.
   */
  @visibility("read")
  code?: string;
}

/**
 * Information about VMSS VM
 */
model VmssvmInfo {
  /**
   * UUID of the VM.
   */
  @visibility("read")
  vmId?: string;

  /**
   * Azure resource Id of the VM.
   */
  @visibility("read")
  vmResourceId?: string;

  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * Id of the latest report for the guest configuration assignment.
   */
  @visibility("read")
  latestReportId?: string;

  /**
   * Date and time when last compliance status was checked.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastComplianceChecked?: utcDateTime;
}

/**
 * The core properties of guest configuration resources
 */
model GuestConfigurationResourceData {
  /**
   * ARM resource id of the guest configuration assignment.
   */
  @visibility("read")
  id?: string;

  /**
   * Name of the guest configuration assignment.
   */
  name?: string;

  /**
   * Region where the VM is located.
   */
  location?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

model ErrorResponseError {
  /**
   * Error code.
   */
  code?: string;

  /**
   * Detail error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * List of guest configuration assignment reports.
 */
@pagedResult
model GuestConfigurationAssignmentReportList {
  /**
   * List of reports for the guest configuration. Report contains information such as compliance status, reason and more.
   */
  @items
  value?: GuestConfigurationAssignmentReport[];
}

/**
 * Report for the guest configuration assignment. Report contains information such as compliance status, reason, and more.
 */
model GuestConfigurationAssignmentReport {
  /**
   * ARM resource id of the report for the guest configuration assignment.
   */
  @visibility("read")
  id?: string;

  /**
   * GUID that identifies the guest configuration assignment report under a subscription, resource group.
   */
  @visibility("read")
  name?: string;

  /**
   * Properties of the guest configuration report.
   */
  properties?: GuestConfigurationAssignmentReportProperties;
}

/**
 * Report for the guest configuration assignment. Report contains information such as compliance status, reason, and more.
 */
model GuestConfigurationAssignmentReportProperties {
  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * GUID that identifies the guest configuration assignment report under a subscription, resource group.
   */
  @visibility("read")
  reportId?: string;

  /**
   * Configuration details of the guest configuration assignment.
   */
  assignment?: AssignmentInfo;

  /**
   * Information about the VM.
   */
  vm?: VMInfo;

  /**
   * Start date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Details of the assignment report.
   */
  details?: AssignmentReportDetails;

  /**
   * Azure resource Id of the VMSS.
   */
  @visibility("read")
  vmssResourceId?: string;
}

/**
 * Details of the guest configuration assignment report.
 */
model AssignmentReportDetails {
  /**
   * A value indicating compliance status of the machine for the assigned guest configuration.
   */
  @visibility("read")
  complianceStatus?: ComplianceStatus;

  /**
   * Start date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End date and time of the guest configuration assignment compliance status check.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * GUID of the report.
   */
  @visibility("read")
  jobId?: string;

  /**
   * Type of report, Consistency or Initial
   */
  @visibility("read")
  operationType?: Type;

  /**
   * The list of resources for which guest configuration assignment compliance is checked.
   */
  resources?: AssignmentReportResource[];
}

/**
 * Provider, Resource, Operation and description values.
 */
model OperationProperties {
  /**
   * Service provider: Microsoft.GuestConfiguration
   */
  statusCode?: string;
}
