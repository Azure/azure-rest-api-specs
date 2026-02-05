import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

/**
 * Provisioning state of the ArcSetting proxy resource.
 */
union ProvisioningState {
  string,

  /**
   * The provisioning state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * An error occurred during provisioning.
   */
  Error: "Error",

  /**
   * Provisioning completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning failed.
   */
  Failed: "Failed",

  /**
   * Provisioning was canceled.
   */
  Canceled: "Canceled",

  /**
   * The resource is connected.
   */
  Connected: "Connected",

  /**
   * The resource is disconnected.
   */
  Disconnected: "Disconnected",

  /**
   * The resource has been deleted.
   */
  Deleted: "Deleted",

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource is being moved.
   */
  Moving: "Moving",

  /**
   * Provisioning partially succeeded.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The resource is partially connected.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * Provisioning is in progress.
   */
  InProgress: "InProgress",

  /**
   * Provisioning request has been accepted.
   */
  Accepted: "Accepted",

  /**
   * The resource is currently provisioning.
   */
  Provisioning: "Provisioning",

  /**
   * The resource is being disabled.
   */
  DisableInProgress: "DisableInProgress",
}

/**
 * Aggregate state of Arc agent across the nodes in this HCI cluster.
 */
union ArcSettingAggregateState {
  string,

  /**
   * The aggregate state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * An error occurred in the aggregate state.
   */
  Error: "Error",

  /**
   * The operation successfully completed across all nodes.
   */
  Succeeded: "Succeeded",

  /**
   * The operation was canceled across the nodes.
   */
  Canceled: "Canceled",

  /**
   * The operation failed on all or most nodes.
   */
  Failed: "Failed",

  /**
   * All nodes are connected.
   */
  Connected: "Connected",

  /**
   * All nodes are disconnected.
   */
  Disconnected: "Disconnected",

  /**
   * The Arc agent has been deleted from all nodes.
   */
  Deleted: "Deleted",

  /**
   * The Arc agent is being created across the nodes.
   */
  Creating: "Creating",

  /**
   * The Arc agent is being updated across the nodes.
   */
  Updating: "Updating",

  /**
   * The Arc agent is being deleted across the nodes.
   */
  Deleting: "Deleting",

  /**
   * The Arc agent is being moved across the nodes.
   */
  Moving: "Moving",

  /**
   * The operation succeeded on some nodes.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * Some nodes are connected, others are not.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * The operation is currently in progress across the nodes.
   */
  InProgress: "InProgress",

  /**
   * The operation has been accepted and is pending execution.
   */
  Accepted: "Accepted",

  /**
   * The Arc agent is being provisioned across the nodes.
   */
  Provisioning: "Provisioning",

  /**
   * The Arc agent is being disabled across the nodes.
   */
  DisableInProgress: "DisableInProgress",
}

/**
 * State of the Arc agent in this node. Indicates the current lifecycle status of the agent, such as whether it's being provisioned, connected, updated, or has encountered an error.
 */
union NodeArcState {
  string,

  /**
   * The state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * An error occurred during the agent's lifecycle.
   */
  Error: "Error",

  /**
   * The operation completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The operation was canceled before completion.
   */
  Canceled: "Canceled",

  /**
   * The operation failed.
   */
  Failed: "Failed",

  /**
   * The Arc agent is connected on this node.
   */
  Connected: "Connected",

  /**
   * The Arc agent is disconnected on this node.
   */
  Disconnected: "Disconnected",

  /**
   * The Arc agent has been deleted from this node.
   */
  Deleted: "Deleted",

  /**
   * The Arc agent is being created on this node.
   */
  Creating: "Creating",

  /**
   * The Arc agent is being updated on this node.
   */
  Updating: "Updating",

  /**
   * The Arc agent is being deleted from this node.
   */
  Deleting: "Deleting",

  /**
   * The Arc agent is being moved on this node.
   */
  Moving: "Moving",

  /**
   * The operation partially succeeded.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The Arc agent is partially connected on this node.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * The operation is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * The operation has been accepted and is pending execution.
   */
  Accepted: "Accepted",

  /**
   * The Arc agent is currently being provisioned on this node.
   */
  Provisioning: "Provisioning",

  /**
   * The Arc agent is in the process of being disabled on this node.
   */
  DisableInProgress: "DisableInProgress",
}

/**
 * Status of the cluster agent. Indicates the current connectivity, validation, and deployment state of the agent within the cluster.
 */
union Status {
  string,

  /**
   * The cluster agent has not yet registered with Azure.
   */
  NotYetRegistered: "NotYetRegistered",

  /**
   * The cluster agent has connected to Azure recently.
   */
  ConnectedRecently: "ConnectedRecently",

  /**
   * The cluster agent has not connected to Azure recently.
   */
  NotConnectedRecently: "NotConnectedRecently",

  /**
   * The cluster agent is currently disconnected from Azure.
   */
  Disconnected: "Disconnected",

  /**
   * An error occurred in the cluster agent's operation.
   */
  Error: "Error",

  /**
   * The status of the cluster agent is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * Validation of the cluster agent is currently in progress.
   */
  ValidationInProgress: "ValidationInProgress",

  /**
   * Validation of the cluster agent completed successfully.
   */
  ValidationSuccess: "ValidationSuccess",

  /**
   * Validation of the cluster agent failed.
   */
  ValidationFailed: "ValidationFailed",

  /**
   * Deployment of the cluster agent is currently in progress.
   */
  DeploymentInProgress: "DeploymentInProgress",

  /**
   * Deployment of the cluster agent failed.
   */
  DeploymentFailed: "DeploymentFailed",

  /**
   * Deployment of the cluster agent completed successfully.
   */
  DeploymentSuccess: "DeploymentSuccess",
}

/**
 * Overall connectivity status for the cluster resource. Indicates whether the cluster is connected to Azure, partially connected, or has not recently communicated.
 */
union ConnectivityStatus {
  string,

  /**
   * The cluster has not yet registered with Azure.
   */
  NotYetRegistered: "NotYetRegistered",

  /**
   * The cluster is fully connected to Azure.
   */
  Connected: "Connected",

  /**
   * The cluster has not connected to Azure recently.
   */
  NotConnectedRecently: "NotConnectedRecently",

  /**
   * Some components of the cluster are connected, while others are not.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * The cluster is not connected to Azure.
   */
  Disconnected: "Disconnected",

  /**
   * The connectivity status is not specified.
   */
  NotSpecified: "NotSpecified",
}

/**
 * Indicates whether the cluster is under support.
 */
@removed(Versions.v2026_02_01)
union SupportStatus {
  string,

  /**
   * The cluster is under support.
   */
  InSupport: "InSupport",

  /**
   * The cluster is out of support.
   */
  OutOfSupport: "OutOfSupport",

  /**
   * The support status is not specified.
   */
  NotSpecified: "NotSpecified",
}

/**
 * Status of the Software Assurance for the cluster.
 */
union SoftwareAssuranceStatus {
  string,

  /**
   * Software Assurance is enabled for the cluster.
   */
  Enabled: "Enabled",

  /**
   * Software Assurance is disabled for the cluster.
   */
  Disabled: "Disabled",
}

/**
 * Customer Intent for Software Assurance Benefit.
 */
union SoftwareAssuranceIntent {
  string,

  /**
   * Customer intends to enable the Software Assurance benefit.
   */
  Enable: "Enable",

  /**
   * Customer intends to disable the Software Assurance benefit.
   */
  Disable: "Disable",
}

/**
 * LogCollection status
 */
union LogCollectionStatus {
  string,

  /**
   * No log collection has been initiated.
   */
  None: "None",

  /**
   * Log collection is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * Log collection has failed.
   */
  Failed: "Failed",

  /**
   * Log collection completed successfully.
   */
  Succeeded: "Succeeded",
}

/**
 * Specifies the type of log collection job. Determines whether the logs are collected immediately on demand or as part of a scheduled operation.
 */
union LogCollectionJobType {
  string,

  /**
   * Log collection is triggered manually and executed immediately.
   */
  OnDemand: "OnDemand",

  /**
   * Log collection is scheduled to run at a predefined time or interval.
   */
  Scheduled: "Scheduled",
}

/**
 * Remote Support Access Level
 */
union AccessLevel {
  string,

  /**
   * Allows remote diagnostics operations only.
   */
  Diagnostics: "Diagnostics",

  /**
   * Allows both remote diagnostics and repair operations.
   */
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/**
 * Remote Support Type for cluster
 */
union RemoteSupportType {
  string,

  /**
   * Enable remote support for the cluster.
   */
  Enable: "Enable",

  /**
   * Revoke previously enabled remote support for the cluster.
   */
  Revoke: "Revoke",
}

/**
 * Desired state of Windows Server Subscription.
 */
union WindowsServerSubscription {
  string,

  /**
   * Windows Server Subscription is disabled.
   */
  Disabled: "Disabled",

  /**
   * Windows Server Subscription is enabled.
   */
  Enabled: "Enabled",
}

/**
 * Desired level of diagnostic data emitted by the cluster.
 */
union DiagnosticLevel {
  string,

  /**
   * No diagnostic data will be emitted.
   */
  Off: "Off",

  /**
   * Basic diagnostic data will be emitted, including essential health metrics.
   */
  Basic: "Basic",

  /**
   * Enhanced diagnostic data will be emitted, including detailed performance and usage metrics.
   */
  Enhanced: "Enhanced",
}

/**
 * Specifies the type of hardware vendor for all nodes in the cluster. Indicates whether the nodes are provided by Microsoft or a third-party vendor.
 */
union ClusterNodeType {
  string,

  /**
   * All nodes in the cluster are provided and managed by Microsoft.
   */
  FirstParty: "FirstParty",

  /**
   * All nodes in the cluster are provided and managed by a third-party vendor.
   */
  ThirdParty: "ThirdParty",
}

/**
 * OEM activation status of the cluster.
 */
union OemActivation {
  string,

  /**
   * OEM activation is disabled for the cluster.
   */
  Disabled: "Disabled",

  /**
   * OEM activation is enabled for the cluster.
   */
  Enabled: "Enabled",
}

/**
 * IMDS attestation status of the cluster.
 */
union ImdsAttestation {
  string,

  /**
   * IMDS attestation is disabled for the cluster.
   */
  Disabled: "Disabled",

  /**
   * IMDS attestation is enabled for the cluster.
   */
  Enabled: "Enabled",
}

/**
 * Hardware class of the cluster.
 */
union HardwareClass {
  string,

  /**
   * The hardware class is small.
   */
  Small: "Small",

  /**
   * The hardware class is medium. This corresponds to the default
   */
  Medium: "Medium",

  /**
   * The hardware class is large.
   */
  Large: "Large",
}

/**
 * Type of secrets to store
 */
union SecretsType {
  string,

  /**
   * Backup secrets type
   */
  BackupSecrets: "BackupSecrets",
}

/**
 * Supported Storage Pattern for HCI Cluster
 */
union ClusterPattern {
  string,

  /**
   * Standard cluster.
   */
  Standard: "Standard",

  /**
   * RackAware cluster.
   */
  RackAware: "RackAware",
}

/**
 * Identity Provider for the cluster
 */
union IdentityProvider {
  string,

  /**
   * Uses Active Directory as the identity provider, enabling domain-based authentication and centralized identity management. This is the default option.
   */
  ActiveDirectory: "ActiveDirectory",

  /**
   * Uses a local identity system integrated with Azure Key Vault for authentication. Suitable for AD-less environments where Active Directory is not available or required.
   */
  LocalIdentity: "LocalIdentity",
}

/**
 * Deployment mode to trigger job.
 */
union DeploymentMode {
  string,

  /**
   * Validate ECE action deployment for a cluster.
   */
  Validate: "Validate",

  /**
   * Deploy ECE action deployment for a cluster.
   */
  Deploy: "Deploy",
}

/**
 * The intended operation for a cluster.
 */
union OperationType {
  string,

  /**
   * Cluster provisioning operation.
   */
  ClusterProvisioning: "ClusterProvisioning",

  /**
   * Cluster upgrade operation.
   */
  ClusterUpgrade: "ClusterUpgrade",
}

/**
 * Specifies how DNS servers are configured for the infrastructure network. Allowed values are 'UseDnsServer' to use the provided DNS servers, and 'UseForwarder' to use DNS forwarders.
 */
union DnsServerConfig {
  string,

  /**
   * Use the provided DNS servers for the infrastructure network.
   */
  UseDnsServer: "UseDnsServer",

  /**
   * Use DNS forwarders for the infrastructure network.
   */
  UseForwarder: "UseForwarder",
}

/**
 * Secret names allowed for Enterprise Cloud Engine (ECE) deployment.
 */
union EceSecrets {
  string,

  /**
   * AzureStackLCMUserCredential used for LCM operations for AzureStackHCI cluster.
   */
  AzureStackLCMUserCredential: "AzureStackLCMUserCredential",

  /**
   * DefaultARBApplication used to manage Azure Arc resource bridge (ARB) for AzureStackHCI cluster.
   */
  DefaultARBApplication: "DefaultARBApplication",

  /**
   * LocalAdminCredential used for admin operations for AzureStackHCI cluster.
   */
  LocalAdminCredential: "LocalAdminCredential",

  /**
   * WitnessStorageKey used for setting up a cloud witness for AzureStackHCI cluster.
   */
  WitnessStorageKey: "WitnessStorageKey",
}

/**
 * Edge device kind.
 */
union EdgeDeviceKind {
  string,

  /**
   * Arc-enabled edge device with HCI OS.
   */
  HCI: "HCI",
}

/**
 * Edge device kind.
 */
union DeviceKind {
  string,

  /**
   * Arc-enabled edge device with HCI OS.
   */
  HCI: "HCI",
}

/**
 * Aggregate state of Arc Extensions across the nodes in this HCI cluster. This reflects the overall status of the extension deployment and operation across all nodes.
 */
union ExtensionAggregateState {
  string,

  /**
   * The aggregate state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * An error occurred in the aggregate state.
   */
  Error: "Error",

  /**
   * The operation succeeded across all nodes.
   */
  Succeeded: "Succeeded",

  /**
   * The operation was canceled across the nodes.
   */
  Canceled: "Canceled",

  /**
   * The operation failed on all or most nodes.
   */
  Failed: "Failed",

  /**
   * All nodes are connected.
   */
  Connected: "Connected",

  /**
   * All nodes are disconnected.
   */
  Disconnected: "Disconnected",

  /**
   * The extension has been deleted from all nodes.
   */
  Deleted: "Deleted",

  /**
   * The extension is being created across the nodes.
   */
  Creating: "Creating",

  /**
   * The extension is being updated across the nodes.
   */
  Updating: "Updating",

  /**
   * The extension is being deleted across the nodes.
   */
  Deleting: "Deleting",

  /**
   * The extension is being moved across the nodes.
   */
  Moving: "Moving",

  /**
   * The operation succeeded on some nodes.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * Some nodes are connected, others are not.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * The operation is currently in progress across the nodes.
   */
  InProgress: "InProgress",

  /**
   * The operation has been accepted and is pending execution.
   */
  Accepted: "Accepted",

  /**
   * The extension is currently being provisioned across the nodes.
   */
  Provisioning: "Provisioning",

  /**
   * Extension upgrade failed, but rollback succeeded across the nodes.
   */
  UpgradeFailedRollbackSucceeded: "UpgradeFailedRollbackSucceeded",
}

/**
 * State of Arc Extension in this node. Reflects the current lifecycle status of the extension on the individual node, such as whether it's being created, updated, deleted, or has encountered an error.
 */
union NodeExtensionState {
  string,

  /**
   * The state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * An error occurred during the extension lifecycle.
   */
  Error: "Error",

  /**
   * The extension operation completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The extension operation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The extension operation failed.
   */
  Failed: "Failed",

  /**
   * The extension is connected on the node.
   */
  Connected: "Connected",

  /**
   * The extension is disconnected on the node.
   */
  Disconnected: "Disconnected",

  /**
   * The extension has been deleted from the node.
   */
  Deleted: "Deleted",

  /**
   * The extension is being created on the node.
   */
  Creating: "Creating",

  /**
   * The extension is being updated on the node.
   */
  Updating: "Updating",

  /**
   * The extension is being deleted from the node.
   */
  Deleting: "Deleting",

  /**
   * The extension is being moved on the node.
   */
  Moving: "Moving",

  /**
   * The extension operation partially succeeded.
   */
  PartiallySucceeded: "PartiallySucceeded",

  /**
   * The extension is partially connected on the node.
   */
  PartiallyConnected: "PartiallyConnected",

  /**
   * The extension operation is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * The extension operation has been accepted and is pending execution.
   */
  Accepted: "Accepted",

  /**
   * The extension is currently being provisioned on the node.
   */
  Provisioning: "Provisioning",
}

/**
 * The level code. Indicates the severity or importance of the status message.
 */
union StatusLevelTypes {
  string,

  /**
   * Informational message indicating normal operation.
   */
  Info: "Info",

  /**
   * Warning message indicating a potential issue or non-critical problem.
   */
  Warning: "Warning",

  /**
   * Error message indicating a failure or critical issue.
   */
  Error: "Error",
}

/**
 * Indicates whether the extension is managed by the user or by Azure.
 */
union ExtensionManagedBy {
  string,

  /**
   * The extension is managed by the user.
   */
  User: "User",

  /**
   * The extension is managed by Azure.
   */
  Azure: "Azure",
}

/**
 * Represents the compliance assignment type of a resource.
 */
union ComplianceAssignmentType {
  string,

  /**
   * Report on the state of the machine, but don't make changes.
   */
  Audit: "Audit",

  /**
   * Applied to the machine. If it drifts, the local service inside the machine makes a correction at the next evaluation.
   */
  ApplyAndAutoCorrect: "ApplyAndAutoCorrect",
}

/**
 * Represents the compliance status of a resource.
 */
union ComplianceStatus {
  string,

  /**
   * The resource is compliant
   */
  Compliant: "Compliant",

  /**
   * The resource is non-compliant
   */
  NonCompliant: "NonCompliant",

  /**
   * The resource compliance status is pending
   */
  Pending: "Pending",
}

/**
 * Represents the current state of the update run. Indicates whether the update is in progress, has completed successfully, failed, or is in an unknown state.
 */
union UpdateRunPropertiesState {
  string,

  /**
   * The state of the update run is not known.
   */
  Unknown: "Unknown",

  /**
   * The update run completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * The update run is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * The update run failed to complete successfully.
   */
  Failed: "Failed",
}

/**
 * Represents the current state of the update as it relates to this stamp. This includes phases such as preparation, installation, scanning, and error handling, providing insight into the update's progress and any issues encountered.
 */
union State {
  string,

  /**
   * The update has prerequisites that must be fulfilled before it can proceed.
   */
  HasPrerequisite: "HasPrerequisite",

  /**
   * The update is obsolete and no longer applicable.
   */
  Obsolete: "Obsolete",

  /**
   * The update is ready to be installed.
   */
  Ready: "Ready",

  /**
   * The update cannot be applied because another update is currently in progress.
   */
  NotApplicableBecauseAnotherUpdateIsInProgress: "NotApplicableBecauseAnotherUpdateIsInProgress",

  /**
   * The update is currently in the preparation phase.
   */
  Preparing: "Preparing",

  /**
   * The update is currently being installed.
   */
  Installing: "Installing",

  /**
   * The update has been successfully installed.
   */
  Installed: "Installed",

  /**
   * The update preparation phase failed.
   */
  PreparationFailed: "PreparationFailed",

  /**
   * The update installation failed.
   */
  InstallationFailed: "InstallationFailed",

  /**
   * The update is invalid and cannot be applied.
   */
  Invalid: "Invalid",

  /**
   * The update has been recalled and should not be applied.
   */
  Recalled: "Recalled",

  /**
   * The update is currently being downloaded.
   */
  Downloading: "Downloading",

  /**
   * The update download failed.
   */
  DownloadFailed: "DownloadFailed",

  /**
   * A health check is being performed before applying the update.
   */
  HealthChecking: "HealthChecking",

  /**
   * The health check failed, preventing the update from proceeding.
   */
  HealthCheckFailed: "HealthCheckFailed",

  /**
   * The update is ready to be installed after successful preparation and checks.
   */
  ReadyToInstall: "ReadyToInstall",

  /**
   * The system is scanning for updates.
   */
  ScanInProgress: "ScanInProgress",

  /**
   * The scan for updates failed.
   */
  ScanFailed: "ScanFailed",

  /**
   * Additional content is required to proceed with the update.
   */
  AdditionalContentRequired: "AdditionalContentRequired",
}

/**
 * Indicates whether a reboot is required after the update or operation. Helps determine if a system restart is necessary to complete the process.
 */
union RebootRequirement {
  string,

  /**
   * It is not known whether a reboot is required.
   */
  Unknown: "Unknown",

  /**
   * A reboot is required to complete the operation.
   */
  True: "True",

  /**
   * No reboot is required after the operation.
   */
  False: "False",
}

/**
 * Overall health state for update-specific health checks. Indicates whether the system is functioning correctly, has warnings or errors, or is undergoing a health evaluation.
 */
union HealthState {
  string,

  /**
   * The health state is not known or cannot be determined.
   */
  Unknown: "Unknown",

  /**
   * The health check completed successfully and the system is healthy.
   */
  Success: "Success",

  /**
   * The health check failed, indicating a critical issue.
   */
  Failure: "Failure",

  /**
   * The health check detected a non-critical issue that may require attention.
   */
  Warning: "Warning",

  /**
   * An error occurred during the health check process.
   */
  Error: "Error",

  /**
   * The health check is currently in progress.
   */
  InProgress: "InProgress",
}

/**
 * Indicates the importance or impact level of the result. Determines whether the result is informational, a warning, or a critical issue that may block updates.
 */
union Severity {
  string,

  /**
   * A critical issue that blocks updates and requires immediate attention.
   */
  Critical: "Critical",

  /**
   * A warning that may indicate a potential issue but does not block updates.
   */
  Warning: "Warning",

  /**
   * General information that does not indicate any issue.
   */
  Informational: "Informational",

  /**
   * The result is hidden and not shown in the output.
   */
  Hidden: "Hidden",
}

/**
 * Indicates how the update content is made available for download. This determines whether the update is sourced locally, from an online repository, or requires user notification.
 */
union AvailabilityType {
  string,

  /**
   * The update content is available locally within the environment.
   */
  Local: "Local",

  /**
   * The update content is available from an online source.
   */
  Online: "Online",

  /**
   * The system will notify the user when update content becomes available.
   */
  Notify: "Notify",
}

/**
 * Overall update state of the stamp. Indicates the current status of update deployment across the stamp, including preparation, application, and any issues encountered.
 */
union UpdateSummariesPropertiesState {
  string,

  /**
   * The update state is not known.
   */
  Unknown: "Unknown",

  /**
   * Updates have been successfully applied to the stamp.
   */
  AppliedSuccessfully: "AppliedSuccessfully",

  /**
   * Updates are available but have not yet been applied.
   */
  UpdateAvailable: "UpdateAvailable",

  /**
   * Updates are currently being applied to the stamp.
   */
  UpdateInProgress: "UpdateInProgress",

  /**
   * The update process failed.
   */
  UpdateFailed: "UpdateFailed",

  /**
   * The update process requires user intervention or has encountered issues needing attention.
   */
  NeedsAttention: "NeedsAttention",

  /**
   * Preparation for the update is currently in progress.
   */
  PreparationInProgress: "PreparationInProgress",

  /**
   * Preparation for the update failed.
   */
  PreparationFailed: "PreparationFailed",
}

/**
 * Specifies the name of the service associated with the update or operation. This helps identify which system component or tool is involved.
 */
union ServiceName {
  string,

  /**
   * Windows Admin Center (WAC) is the service associated with this operation.
   */
  WAC: "WAC",
}

/**
 * Represents the status of a log collection operation.
 */
union DeviceLogCollectionStatus {
  string,

  /**
   * Log collection operation has not been initiated.
   */
  NotStarted: "NotStarted",

  /**
   * Indicates that the log collection operation is currently running.
   */
  Running: "Running",

  /**
   * Indicates that the log collection operation has failed.
   */
  Failed: "Failed",

  /**
   * Indicates that the log collection operation has completed successfully.
   */
  Succeeded: "Succeeded",

  /**
   * Indicates that the log collection operation has completed successfully.
   */
  Canceled: "Canceled",
}

/**
 * Represents the various statuses a job can have throughout its lifecycle.
 */
union JobStatus {
  string,

  /**
   * The job status has not been specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * The job is currently undergoing validation.
   */
  ValidationInProgress: "ValidationInProgress",

  /**
   * The job has successfully passed validation.
   */
  ValidationSuccess: "ValidationSuccess",

  /**
   * The job has failed validation.
   */
  ValidationFailed: "ValidationFailed",

  /**
   * The job's deployment is currently in progress.
   */
  DeploymentInProgress: "DeploymentInProgress",

  /**
   * The job's deployment has failed.
   */
  DeploymentFailed: "DeploymentFailed",

  /**
   * The job has been successfully deployed.
   */
  DeploymentSuccess: "DeploymentSuccess",

  /**
   * The job has succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The job has failed.
   */
  Failed: "Failed",

  /**
   * The job has been canceled.
   */
  Canceled: "Canceled",

  /**
   * The job is paused.
   */
  Paused: "Paused",

  /**
   * The job is scheduled to run.
   */
  Scheduled: "Scheduled",
}

/**
 * Job Type supported.
 */
union HciEdgeDeviceJobType {
  string,

  /**
   * Job to collect logs from the device.
   */
  CollectLog: "CollectLog",

  /**
   * Job to provide remote support to the device.
   */
  RemoteSupport: "RemoteSupport",
}

/**
 * Defines the level of remote support access granted.
 */
union RemoteSupportAccessLevel {
  string,

  /**
   * No remote support access is granted.
   */
  None: "None",

  /**
   * Access is limited to diagnostics information only.
   */
  Diagnostics: "Diagnostics",

  /**
   * Access includes diagnostics information and the ability to perform repairs.
   */
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/**
 * Arc extension installation state.
 */
union ArcExtensionState {
  string,

  /**
   * Arc extension state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * Arc extension state is Succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Arc extension state is Failed.
   */
  Failed: "Failed",

  /**
   * Arc extension state is Canceled.
   */
  Canceled: "Canceled",

  /**
   * Arc extension state is Accepted when extension installation triggered.
   */
  Accepted: "Accepted",

  /**
   * Arc extension is in Creating State.
   */
  Creating: "Creating",

  /**
   * Arc extension is in Updating State.
   */
  Updating: "Updating",

  /**
   * Arc extension is in Moving State.
   */
  Moving: "Moving",

  /**
   * Arc extension is in Deleting State.
   */
  Deleting: "Deleting",

  /**
   * Arc extension is in Deleted State.
   */
  Deleted: "Deleted",
}

/**
 * Describes the RDMA capability of the network adapter.
 */
union RdmaCapability {
  string,

  /**
   * Network Adapter on the device is RDMA Capable
   */
  Enabled: "Enabled",

  /**
   * Network Adapter on the device is RDMA Capable
   */
  Disabled: "Disabled",
}

/**
 * The edge device state.
 */
union DeviceState {
  string,

  /**
   * The edge device state is not specified.
   */
  NotSpecified: "NotSpecified",

  /**
   * The edge device state is in connected state.
   */
  Connected: "Connected",

  /**
   * The edge device state is in disconnected state.
   */
  Disconnected: "Disconnected",

  /**
   * The edge device state is in repairing state.
   */
  Repairing: "Repairing",

  /**
   * The edge device state is in draining state.
   */
  Draining: "Draining",

  /**
   * The edge device state is in maintenance state.
   */
  InMaintenance: "InMaintenance",

  /**
   * The edge device state is in resuming state.
   */
  Resuming: "Resuming",

  /**
   * The edge device state is in processing state.
   */
  Processing: "Processing",
}

/**
 * Common Job Types supported.
 */
union EdgeDeviceJobType {
  string,

  /**
   * Job to collect logs from the device.
   */
  CollectLog: "CollectLog",

  /**
   * Job to provide remote support to the device.
   */
  RemoteSupport: "RemoteSupport",
}

/**
 * Edge solution type.
 */
union EdgeSolutionType {
  string,

  /**
   * Edge solution for Windows based edge devices.
   */
  WindowsServer: "WindowsServer",
}

/**
 * List of ArcSetting proxy resources for the HCI cluster.
 */
model ArcSettingList is Azure.Core.Page<ArcSetting>;

/**
 * ArcSetting properties.
 */
model ArcSettingProperties {
  /**
   * Provisioning state of the ArcSetting proxy resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource group that hosts the Arc agents, ie. Hybrid Compute Machine resources.
   */
  arcInstanceResourceGroup?: string;

  /**
   * App id of arc AAD identity.
   */
  arcApplicationClientId?: string;

  /**
   * Tenant id of arc AAD identity.
   */
  arcApplicationTenantId?: string;

  /**
   * Object id of arc AAD service principal.
   */
  arcServicePrincipalObjectId?: string;

  /**
   * Object id of arc AAD identity.
   */
  arcApplicationObjectId?: string;

  /**
   * Aggregate state of Arc agent across the nodes in this HCI cluster.
   */
  @visibility(Lifecycle.Read)
  aggregateState?: ArcSettingAggregateState;

  /**
   * State of Arc agent in each of the nodes.
   */
  @visibility(Lifecycle.Read)
  perNodeDetails?: PerNodeState[];

  /**
   * contains connectivity related configuration for ARC resources
   */
  connectivityProperties?: ArcConnectivityProperties;

  /**
   * Properties for each of the default extensions category
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["category"])
  defaultExtensions?: DefaultExtensionDetails[];
}

/**
 * Status of Arc agent for a particular node in HCI Cluster.
 */
model PerNodeState {
  /**
   * Name of the Node in HCI Cluster
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Fully qualified resource ID for the Arc agent of this node.
   */
  @visibility(Lifecycle.Read)
  arcInstance?: string;

  /**
   * The service principal id of the arc for server node
   */
  @visibility(Lifecycle.Read)
  arcNodeServicePrincipalObjectId?: string;

  /**
   * State of the Arc agent in this node. Indicates the current lifecycle status of the agent, such as whether it's being provisioned, connected, updated, or has encountered an error.
   */
  @visibility(Lifecycle.Read)
  state?: NodeArcState;
}

/**
 * Properties for a particular default extension category.
 */
model DefaultExtensionDetails {
  /**
   * Default extension category
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * Consent time for extension category
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  consentTime?: utcDateTime;
}

/**
 * ArcSetting details to update.
 */
model ArcSettingsPatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * ArcSettings properties.
   */
  properties?: ArcSettingsPatchProperties;
}

/**
 * ArcSettings properties.
 */
model ArcSettingsPatchProperties {
  /**
   * contains connectivity related configuration for ARC resources
   */
  connectivityProperties?: ArcConnectivityProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PasswordCredential {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretText?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  keyId?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  startDateTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  endDateTime?: utcDateTime;
}

/**
 * ArcIdentity details.
 */
model ArcIdentityResponse {
  /**
   * ArcIdentity properties.
   */
  @visibility(Lifecycle.Read)
  properties?: ArcIdentityResponseProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ArcIdentityResponseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arcApplicationClientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arcApplicationTenantId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arcServicePrincipalObjectId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  arcApplicationObjectId?: string;
}

/**
 * Request for reconciling Arc Settings.
 */
model ReconcileArcSettingsRequest {
  /**
   * List of Arc Nodes in the cluster
   */
  properties?: ReconcileArcSettingsRequestProperties;
}

/**
 * List of Arc Nodes in the cluster
 */
model ReconcileArcSettingsRequestProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterNodes?: string[];
}

/**
 * List of clusters.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * Cluster properties.
 */
model ClusterProperties {
  /**
   * Provisioning state. Indicates the current lifecycle status of the resource, including creation, update, deletion, connectivity, and error states.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Status of the cluster agent. Indicates the current connectivity, validation, and deployment state of the agent within the cluster.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Overall connectivity status for the cluster resource. Indicates whether the cluster is connected to Azure, partially connected, or has not recently communicated.
   */
  @visibility(Lifecycle.Read)
  connectivityStatus?: ConnectivityStatus;

  /**
   * Indicates whether the cluster is under support.
   */
  @visibility(Lifecycle.Read)
  @removed(Versions.v2026_02_01)
  supportStatus?: SupportStatus;

  /**
   * Unique, immutable resource id.
   */
  @visibility(Lifecycle.Read)
  cloudId?: string;

  /**
   * The ring to which this cluster belongs to.
   */
  @visibility(Lifecycle.Read)
  @removed(Versions.v2026_02_01)
  ring?: string;

  /**
   * Endpoint configured for management from the Azure portal.
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Object id of cluster AAD identity.
   */
  aadApplicationObjectId?: string;

  /**
   * Id of cluster identity service principal.
   */
  aadServicePrincipalObjectId?: string;

  /**
   * Software Assurance properties of the cluster.
   */
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  /**
   * Is Management Cluster, when true indicates that the cluster is used for managing other clusters
   */
  @visibility(Lifecycle.Read)
  isManagementCluster?: boolean;

  /**
   * Log Collection properties of the cluster.
   */
  logCollectionProperties?: LogCollectionProperties;

  /**
   * RemoteSupport properties of the cluster.
   */
  remoteSupportProperties?: RemoteSupportProperties;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;

  /**
   * Properties reported by cluster agent.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: ClusterReportedProperties;

  /**
   * Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.
   */
  @visibility(Lifecycle.Read)
  isolatedVmAttestationConfiguration?: IsolatedVmAttestationConfiguration;

  /**
   * Number of days remaining in the trial period.
   */
  @visibility(Lifecycle.Read)
  trialDaysRemaining?: float32;

  /**
   * Type of billing applied to the resource.
   */
  @visibility(Lifecycle.Read)
  billingModel?: string;

  /**
   * First cluster sync timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTimestamp?: utcDateTime;

  /**
   * Most recent cluster sync timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  /**
   * Most recent billing meter timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBillingTimestamp?: utcDateTime;

  /**
   * Region specific DataPath Endpoint of the cluster.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Object id of RP Service Principal
   */
  @visibility(Lifecycle.Read)
  resourceProviderObjectId?: string;

  /**
   * List of secret locations.
   */
  @identifiers(#[])
  secretsLocations?: SecretsLocationDetails[];

  /**
   * Supported Storage Type for HCI Cluster
   */
  @visibility(Lifecycle.Read)
  clusterPattern?: ClusterPattern;

  /**
   * Represents the Confidential Virtual Machine (CVM) support intent and current status for the cluster resource.
   */
  @added(Versions.v2025_12_01_preview)
  @removed(Versions.v2026_02_01)
  @visibility(Lifecycle.Read)
  confidentialVmProperties?: ConfidentialVmProperties;

  /**
   * Software Defined Networking Properties of the cluster
   */
  @added(Versions.v2025_12_01_preview)
  @removed(Versions.v2026_02_01)
  @visibility(Lifecycle.Read)
  sdnProperties?: ClusterSdnProperties;

  /**
   * Local Availability Zone information for HCI cluster
   */
  @identifiers(#["localAvailabilityZoneName"])
  localAvailabilityZones?: LocalAvailabilityZones[];

  /**
   * Identity Provider for the cluster
   */
  @visibility(Lifecycle.Read)
  identityProvider?: IdentityProvider = IdentityProvider.ActiveDirectory;
}

/**
 * Software Assurance properties of the cluster.
 */
model SoftwareAssuranceProperties {
  /**
   * Status of the Software Assurance for the cluster.
   */
  @visibility(Lifecycle.Read)
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  /**
   * Customer Intent for Software Assurance Benefit.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  /**
   * TimeStamp denoting the latest SA benefit applicability is validated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

/**
 * Log Collection properties of the cluster.
 */
model LogCollectionProperties {
  /**
   * From DateTimeStamp from when logs need to be connected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate?: utcDateTime;

  /**
   * To DateTimeStamp till when logs need to be connected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate?: utcDateTime;

  /**
   * Recent DateTimeStamp where logs are successfully generated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  logCollectionSessionDetails?: LogCollectionSession[];
}

/**
 * Log Collection Session details of the cluster.
 */
model LogCollectionSession {
  /**
   * Start Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logStartTime?: utcDateTime;

  /**
   * End Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logEndTime?: utcDateTime;

  /**
   * Duration of logs collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCollected?: utcDateTime;

  /**
   * Size of the logs collected
   */
  @visibility(Lifecycle.Read)
  logSize?: int64;

  /**
   * LogCollection status
   */
  @visibility(Lifecycle.Read)
  logCollectionStatus?: LogCollectionStatus;

  /**
   * CorrelationId of the log collection
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * Specifies the type of log collection job. Determines whether the logs are collected immediately on demand or as part of a scheduled operation.
   */
  @visibility(Lifecycle.Read)
  logCollectionJobType?: LogCollectionJobType;

  /**
   * End Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeCollected?: utcDateTime;

  /**
   * Log Collection Error details of the cluster.
   */
  @visibility(Lifecycle.Read)
  logCollectionError?: LogCollectionError;
}

/**
 * Log Collection Error details of the cluster.
 */
model LogCollectionError {
  /**
   * Error Code of the log collection
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Error Message of the log collection
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * Remote Support properties of the cluster.
 */
model RemoteSupportProperties {
  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;

  /**
   * Expiration DateTimeStamp when Remote Support Access will be expired
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;

  /**
   * Remote Support Type for cluster
   */
  @visibility(Lifecycle.Read)
  remoteSupportType?: RemoteSupportType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  remoteSupportNodeSettings?: RemoteSupportNodeSettings[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  remoteSupportSessionDetails?: PerNodeRemoteSupportSession[];
}

/**
 * Remote Support Node Settings of the cluster.
 */
model RemoteSupportNodeSettings {
  /**
   * Arc ResourceId of the Node
   */
  @visibility(Lifecycle.Read)
  arcResourceId?: string;

  /**
   * Remote Support Access Connection State on the Node
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Remote Support Enablement Request Created TimeStamp on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Remote Support Enablement Request Updated TimeStamp on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Remote Support Access Connection Status on the Node
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /**
   * Remote Support Access Connection Error Message on the Node
   */
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;

  /**
   * Remote Support Transcript location on the node
   */
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

/**
 * Remote Support Node Session Details on the Node.
 */
model PerNodeRemoteSupportSession {
  /**
   * Remote Support Session StartTime on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionStartTime?: utcDateTime;

  /**
   * Remote Support Session EndTime on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionEndTime?: utcDateTime;

  /**
   * Name of the node
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Duration of Remote Support Enablement
   */
  @visibility(Lifecycle.Read)
  duration?: int64;

  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;
}

/**
 * Desired properties of the cluster.
 */
model ClusterDesiredProperties {
  /**
   * Desired state of Windows Server Subscription.
   */
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Desired level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;
}

/**
 * Properties reported by cluster agent.
 */
model ClusterReportedProperties {
  /**
   * Name of the on-prem cluster connected to this resource.
   */
  @visibility(Lifecycle.Read)
  clusterName?: string;

  /**
   * Unique id generated by the on-prem cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * Version of the cluster software.
   */
  @visibility(Lifecycle.Read)
  clusterVersion?: string;

  /**
   * List of nodes reported by the cluster.
   */
  @visibility(Lifecycle.Read)
  nodes?: ClusterNode[];

  /**
   * Last time the cluster reported the data.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * Specifies the expiration timestamp of the cluster's Managed Service Identity (MSI). The value is expressed in Coordinated Universal Time (UTC).
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  msiExpirationTimeStamp?: utcDateTime;

  /**
   * IMDS attestation status of the cluster.
   */
  @visibility(Lifecycle.Read)
  imdsAttestation?: ImdsAttestation;

  /**
   * Level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;

  /**
   * Capabilities supported by the cluster.
   */
  @visibility(Lifecycle.Read)
  supportedCapabilities?: string[];

  /**
   * Specifies the type of hardware vendor for all nodes in the cluster. Indicates whether the nodes are provided by Microsoft or a third-party vendor.
   */
  @visibility(Lifecycle.Read)
  clusterType?: ClusterNodeType;

  /**
   * The manufacturer of all the nodes of the cluster.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * OEM activation status of the cluster.
   */
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;

  /**
   * Hardware class of the cluster.
   */
  @visibility(Lifecycle.Read)
  hardwareClass?: HardwareClass = HardwareClass.Medium;
}

/**
 * Cluster node details.
 */
model ClusterNode {
  /**
   * Name of the cluster node.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Id of the node in the cluster.
   */
  @visibility(Lifecycle.Read)
  id?: float32;

  /**
   * State of Windows Server Subscription.
   */
  @visibility(Lifecycle.Read)
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Type of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  nodeType?: ClusterNodeType;

  /**
   * Edge Hardware Center Resource Id
   */
  @visibility(Lifecycle.Read)
  ehcResourceId?: string;

  /**
   * Manufacturer of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * Model name of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * Operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Version of the operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /**
   * Display version of the operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osDisplayVersion?: string;

  /**
   * Immutable id of the cluster node.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Number of physical cores on the cluster node.
   */
  @visibility(Lifecycle.Read)
  coreCount?: float32;

  /**
   * Total available memory on the cluster node (in GiB).
   */
  @visibility(Lifecycle.Read)
  memoryInGiB?: float32;

  /**
   * Most recent licensing timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLicensingTimestamp?: utcDateTime;

  /**
   * OEM activation status of the node.
   */
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;
}

/**
 * Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.
 */
model IsolatedVmAttestationConfiguration {
  /**
   * Fully qualified Azure resource id of the Microsoft Azure attestation resource associated with this cluster.
   */
  @visibility(Lifecycle.Read)
  attestationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Attestation/attestationProviders";
      scopes: ["Tenant"];
    }
  ]>;

  /**
   * Region specific endpoint for relying party service.
   */
  @visibility(Lifecycle.Read)
  relyingPartyServiceEndpoint?: string;

  /**
   * Region specific endpoint for Microsoft Azure Attestation service for the cluster
   */
  @visibility(Lifecycle.Read)
  attestationServiceEndpoint?: string;
}

/**
 * Secrets location details
 */
model SecretsLocationDetails {
  /**
   * Type of secrets to store
   */
  secretsType: SecretsType;

  /**
   * secrets location
   */
  secretsLocation: string;
}

/**
 * Local Availability Zone information for HCI cluster
 */
model LocalAvailabilityZones {
  /**
   * Local Availability Zone name for HCI cluster
   */
  localAvailabilityZoneName?: string;

  /**
   * Nodes belonging to a particular zone
   */
  nodes?: string[];
}

/**
 * Cluster details to update.
 */
model ClusterPatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Identity of Cluster resource
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Cluster properties.
   */
  properties?: ClusterPatchProperties;
}

/**
 * Cluster properties.
 */
model ClusterPatchProperties {
  /**
   * Endpoint configured for management from the Azure portal
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;
}

/**
 * Update secrets locations change  Request.
 */
model SecretsLocationsChangeRequest {
  /**
   * List of secret locations
   */
  @identifiers(#[])
  properties?: SecretsLocationDetails[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UploadCertificateRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RawCertificateData;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RawCertificateData {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificates?: string[];
}

/**
 * Cluster Identity details.
 */
model ClusterIdentityResponse {
  /**
   * Cluster identity properties.
   */
  @visibility(Lifecycle.Read)
  properties?: ClusterIdentityResponseProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ClusterIdentityResponseProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadClientId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadTenantId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadServicePrincipalObjectId?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  aadApplicationObjectId?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SoftwareAssuranceChangeRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SoftwareAssuranceChangeRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SoftwareAssuranceChangeRequestProperties {
  /**
   * Customer Intent for Software Assurance Benefit. This indicates whether the customer wishes to opt in or out of the Software Assurance program, which provides licensing and support benefits.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@removed(Versions.v2026_02_01)
model ChangeRingRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ChangeRingRequestProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@removed(Versions.v2026_02_01)
model ChangeRingRequestProperties {
  /**
   * The target ring for the cluster.
   */
  targetRing?: string;
}

/**
 * Log Collection Request
 */
model LogCollectionRequest {
  /**
   * Properties for Log Collection Request
   */
  properties?: LogCollectionRequestProperties;
}

/**
 * Properties for Log Collection Request
 */
model LogCollectionRequestProperties {
  /**
   * From DateTimeStamp from when logs need to be connected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To DateTimeStamp till when logs need to be connected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;
}

/**
 * Remote Support Request
 */
model RemoteSupportRequest {
  /**
   * Properties for Remote Support Request
   */
  properties?: RemoteSupportRequestProperties;
}

/**
 * Properties for Remote Support Request
 */
model RemoteSupportRequestProperties {
  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;

  /**
   * Expiration DateTimeStamp when Remote Support Access will be expired
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;

  /**
   * Remote Support Type for cluster
   */
  remoteSupportType?: RemoteSupportType;
}

/**
 * DeploymentSetting properties
 */
model DeploymentSettingsProperties {
  /**
   * DeploymentSetting provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Azure resource ids of Arc machines to be part of cluster.
   */
  arcNodeResourceIds: string[];

  /**
   * The deployment mode for cluster deployment.
   */
  deploymentMode: DeploymentMode;

  /**
   * The intended operation for a cluster.
   */
  operationType?: OperationType = OperationType.ClusterProvisioning;

  /**
   * Scale units will contains list of deployment data
   */
  deploymentConfiguration: DeploymentConfiguration;

  /**
   * Deployment Status reported from cluster.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: EceReportedProperties;
}

/**
 * Deployment Configuration
 */
model DeploymentConfiguration {
  /**
   * deployment template version
   */
  version?: string;

  /**
   * Scale units will contains list of deployment data
   */
  @identifiers(#[])
  scaleUnits: ScaleUnits[];
}

/**
 * Scale units will contains list of deployment data
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@OpenAPI.externalDocs(
  "https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-tool-existing-file",
  "Deploy Azure Stack HCI using an existing configuration file"
)
model ScaleUnits {
  /**
   * Deployment Data to deploy AzureStackHCI Cluster.
   */
  deploymentData: DeploymentData;

  /**
   * Solution builder extension (SBE) partner properties
   */
  sbePartnerInfo?: SbePartnerInfo;
}

/**
 * The Deployment data of AzureStackHCI Cluster.
 */
model DeploymentData {
  /**
   * SecuritySettings to deploy AzureStackHCI Cluster.
   */
  securitySettings?: DeploymentSecuritySettings;

  /**
   * Observability config to deploy AzureStackHCI Cluster.
   */
  observability?: Observability;

  /**
   * Observability config to deploy AzureStackHCI Cluster.
   */
  cluster?: DeploymentCluster;

  /**
   * Identity Provider for the cluster
   */
  identityProvider?: IdentityProvider;

  /**
   * Storage config to deploy AzureStackHCI Cluster.
   */
  storage?: Storage;

  /**
   * naming prefix to deploy cluster.
   */
  @pattern("^[a-zA-Z0-9-]{1,8}$")
  namingPrefix?: string;

  /**
   * FQDN to deploy cluster
   */
  domainFqdn?: string;

  /**
   * InfrastructureNetwork config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#[])
  infrastructureNetwork?: InfrastructureNetwork[];

  /**
   * list of physical nodes config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#["name"])
  physicalNodes?: PhysicalNodes[];

  /**
   * HostNetwork config to deploy AzureStackHCI Cluster.
   */
  hostNetwork?: DeploymentSettingHostNetwork;

  /**
   * SDN Integration config to deploy AzureStackHCI Cluster.
   */
  sdnIntegration?: SdnIntegration;

  /**
   * Is Management Cluster, when true indicates that the cluster is used for managing other clusters
   */
  isManagementCluster?: boolean;

  /**
   * The path to the Active Directory Organizational Unit container object prepared for the deployment.
   */
  adouPath?: string;

  /**
   * Azure key vault endpoint. This property is deprecated from 2023-12-01-preview. Please use secrets property instead.
   */
  secretsLocation?: string;

  /**
   * secrets used for cloud deployment.
   */
  @identifiers(#["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * OptionalServices config to deploy AzureStackHCI Cluster.
   */
  optionalServices?: OptionalServices;

  /**
   * Local Availability Zone information for HCI cluster
   */
  @identifiers(#["localAvailabilityZoneName"])
  localAvailabilityZones?: LocalAvailabilityZones[];

  /**
   * Assembly Package details for Validated Solution Recipe for AzureStackHCI Cluster
   */
  assemblyInfo?: AssemblyInfo;
}

/**
 * The SecuritySettings of AzureStackHCI Cluster.
 */
model DeploymentSecuritySettings {
  /**
   * By default, Hypervisor-protected Code Integrity is enabled on your Azure HCI cluster.
   */
  hvciProtection?: boolean = true;

  /**
   * By default, Secure Boot is enabled on your Azure HCI cluster. This setting is hardware dependent.
   */
  drtmProtection?: boolean = true;

  /**
   * When set to true, the security baseline is re-applied regularly.
   */
  driftControlEnforced?: boolean = true;

  /**
   * When set to true, Credential Guard is enabled.
   */
  credentialGuardEnforced?: boolean = false;

  /**
   * When set to true, the SMB default instance requires sign in for the client and server services.
   */
  smbSigningEnforced?: boolean = true;

  /**
   * When set to true, cluster east-west traffic is encrypted.
   */
  smbClusterEncryption?: boolean = false;

  /**
   * When set to true, all the side channel mitigations are enabled
   */
  sideChannelMitigationEnforced?: boolean = true;

  /**
   * When set to true, BitLocker XTS_AES 256-bit encryption is enabled for all data-at-rest on the OS volume of your Azure Stack HCI cluster. This setting is TPM-hardware dependent.
   */
  bitlockerBootVolume?: boolean = true;

  /**
   * When set to true, BitLocker XTS-AES 256-bit encryption is enabled for all data-at-rest on your Azure Stack HCI cluster shared volumes.
   */
  bitlockerDataVolumes?: boolean = true;

  /**
   * WDAC is enabled by default and limits the applications and the code that you can run on your Azure Stack HCI cluster.
   */
  wdacEnforced?: boolean = true;
}

/**
 * The Observability of AzureStackHCI Cluster.
 */
model Observability {
  /**
   * Enables telemetry data to be sent to Microsoft
   */
  streamingDataClient?: boolean = true;

  /**
   * Location of your cluster. The log and diagnostic data is sent to the appropriate diagnostics servers depending upon where your cluster resides. Setting this to false results in all data sent to Microsoft to be stored outside of the EU.
   */
  euLocation?: boolean = false;

  /**
   * When set to true, collects log data to facilitate quicker issue resolution.
   */
  episodicDataUpload?: boolean = true;
}

/**
 * AzureStackHCI Cluster deployment properties.
 */
model DeploymentCluster {
  /**
   * The cluster name provided when preparing Active Directory.
   */
  name?: string;

  /**
   * Use a cloud witness if you have internet access and if you use an Azure Storage account to provide a vote on cluster quorum. A cloud witness uses Azure Blob Storage to read or write a blob file and then uses it to arbitrate in split-brain resolution. Only allowed values are 'Cloud', 'FileShare'.
   */
  witnessType?: string;

  /**
   * Specify the fileshare path for the local witness for your Azure Stack HCI cluster.
   */
  witnessPath?: string;

  /**
   * Specify the Azure Storage account name for cloud witness for your Azure Stack HCI cluster.
   */
  cloudAccountName?: string;

  /**
   * For Azure blob service endpoint type, select either Default or Custom domain. If you selected **Custom domain, enter the domain for the blob service in this format core.windows.net.
   */
  azureServiceEndpoint?: string;

  /**
   * Hardware class of the cluster.
   */
  @visibility(Lifecycle.Read)
  hardwareClass?: HardwareClass = HardwareClass.Medium;

  /**
   * Cluster Pattern supported.
   */
  clusterPattern?: ClusterPattern;
}

/**
 * The Storage config of AzureStackHCI Cluster.
 */
model Storage {
  /**
   * By default, this mode is set to Express and your storage is configured as per best practices based on the number of nodes in the cluster. Allowed values are 'Express','InfraOnly', 'KeepStorage'
   */
  configurationMode?: string = "Express";
}

/**
 * The InfrastructureNetwork of a AzureStackHCI Cluster.
 */
model InfrastructureNetwork {
  /**
   * Subnet mask that matches the provided IP address space.
   */
  subnetMask?: string;

  /**
   * Default gateway that should be used for the provided IP address space.
   */
  gateway?: string;

  /**
   * Range of IP addresses from which addresses are allocated for nodes within a subnet.
   */
  @identifiers(#[])
  ipPools?: IpPools[];

  /**
   * Specifies how DNS servers are configured for the infrastructure network. Allowed values are 'UseDnsServer' to use the provided DNS servers, and 'UseForwarder' to use DNS forwarders.
   */
  dnsServerConfig?: DnsServerConfig = DnsServerConfig.UseDnsServer;

  /**
   * Details of the DNS Zones to be configured.
   */
  @identifiers(#["dnsZoneName"])
  dnsZones?: DnsZones[];

  /**
   * IPv4 address of the DNS servers in your environment.
   */
  dnsServers?: string[];

  /**
   * Allows customers to use DHCP for Hosts and Cluster IPs. If not declared, the deployment will default to static IPs. When true, GW and DNS servers are not required
   */
  useDhcp?: boolean;
}

/**
 * The dnsServers of a device.
 */
model IpPools {
  /**
   * Starting IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.
   */
  startingAddress?: string;

  /**
   * Ending IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.
   */
  endingAddress?: string;
}

/**
 * Details of the DNS Zones to be configured.
 */
model DnsZones {
  /**
   * Name of the DNS Zone to be configured.
   */
  dnsZoneName?: string;

  /**
   * Forwarder details of the DNS Zone to be configured.
   */
  dnsForwarder?: string[];
}

/**
 * The PhysicalNodes of a cluster.
 */
model PhysicalNodes {
  /**
   * NETBIOS name of each physical server on your Azure Stack HCI cluster.
   */
  name?: string;

  /**
   * The IPv4 address assigned to each physical server on your Azure Stack HCI cluster.
   */
  ipv4Address?: string;
}

/**
 * The HostNetwork of a cluster.
 */
model DeploymentSettingHostNetwork {
  /**
   * The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.
   */
  @identifiers(#["name"])
  intents?: DeploymentSettingIntents[];

  /**
   * List of StorageNetworks config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#["name"])
  storageNetworks?: DeploymentSettingStorageNetworks[];

  /**
   * Defines how the storage adapters between nodes are connected either switch or switch less..
   */
  storageConnectivitySwitchless?: boolean = false;

  /**
   * Optional parameter required only for 3 Nodes Switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.
   */
  enableStorageAutoIp?: boolean = false;
}

/**
 * The Intents of a cluster.
 */
model DeploymentSettingIntents {
  /**
   * Name of the network intent you wish to create.
   */
  name?: string;

  /**
   * List of network traffic types. Only allowed values are 'Compute', 'Storage', 'Management'.
   */
  trafficType?: string[];

  /**
   * Array of network interfaces used for the network intent.
   */
  adapter?: string[];

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideVirtualSwitchConfiguration?: boolean = false;

  /**
   * Set virtualSwitch ConfigurationOverrides for cluster.
   */
  virtualSwitchConfigurationOverrides?: DeploymentSettingVirtualSwitchConfigurationOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideQosPolicy?: boolean = false;

  /**
   * Set QoS PolicyOverrides for cluster.
   */
  qosPolicyOverrides?: QosPolicyOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideAdapterProperty?: boolean = false;

  /**
   * Set Adapter PropertyOverrides for cluster.
   */
  adapterPropertyOverrides?: DeploymentSettingAdapterPropertyOverrides;
}

/**
 * The VirtualSwitchConfigurationOverrides of a cluster.
 */
model DeploymentSettingVirtualSwitchConfigurationOverrides {
  /**
   * Enable IoV for Virtual Switch
   */
  enableIov?: string;

  /**
   * Load Balancing Algorithm for Virtual Switch
   */
  loadBalancingAlgorithm?: string;
}

/**
 * The QoSPolicyOverrides of a cluster.
 */
model QosPolicyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  priorityValue8021Action_Cluster?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  priorityValue8021Action_SMB?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  bandwidthPercentage_SMB?: string;
}

/**
 * The AdapterPropertyOverrides of a cluster.
 */
model DeploymentSettingAdapterPropertyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  jumboPacket?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  networkDirect?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'
   */
  networkDirectTechnology?: string;
}

/**
 * The StorageNetworks of a cluster.
 */
model DeploymentSettingStorageNetworks {
  /**
   * Name of the storage network.
   */
  name?: string;

  /**
   * Name of the storage network adapter.
   */
  networkAdapterName?: string;

  /**
   * ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic.
   */
  vlanId?: string;

  /**
   * List of Storage adapter physical nodes config to deploy AzureStackHCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["physicalNode"])
  storageAdapterIPInfo?: DeploymentSettingStorageAdapterIPInfo[];
}

/**
 * The StorageAdapter physical nodes of a cluster.
 */
model DeploymentSettingStorageAdapterIPInfo {
  /**
   * storage adapter physical node name.
   */
  physicalNode?: string;

  /**
   * The IPv4 address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  ipv4Address?: string;

  /**
   * The SubnetMask address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  subnetMask?: string;
}

/**
 * SDN Integration config to deploy AzureStackHCI Cluster.
 */
model SdnIntegration {
  /**
   * network controller config for SDN Integration to deploy AzureStackHCI Cluster.
   */
  networkController?: NetworkController;
}

/**
 * network controller config for SDN Integration to deploy AzureStackHCI Cluster.
 */
model NetworkController {
  /**
   * macAddressPoolStart of network controller used for SDN Integration.
   */
  macAddressPoolStart?: string;

  /**
   * macAddressPoolStop of network controller used for SDN Integration.
   */
  macAddressPoolStop?: string;

  /**
   * NetworkVirtualizationEnabled of network controller used for SDN Integration.
   */
  networkVirtualizationEnabled?: boolean;
}

/**
 * Protected parameters list stored in keyvault.
 */
model EceDeploymentSecrets {
  /**
   * Secret name stored in keyvault.
   */
  secretName?: string;

  /**
   * Secret name expected for Enterprise Cloud Engine (ECE) deployment.
   */
  eceSecretName?: EceSecrets;

  /**
   * Secret URI stored in keyvault.
   */
  secretLocation?: url;
}

/**
 * The OptionalServices of AzureStackHCI Cluster.
 */
model OptionalServices {
  /**
   * The name of custom location.
   */
  customLocation?: string;
}

/**
 * Assembly Package details for Validated Solution Recipe for AzureStackHCI Cluster
 */
model AssemblyInfo {
  /**
   * Assembly Package version for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  packageVersion?: string;

  /**
   * Payload properties for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  payload?: AssemblyInfoPayload[];
}

/**
 * Payload properties for Validated Solution Recipe for AzureStackHCI Cluster
 */
model AssemblyInfoPayload {
  /**
   * assembly identifier for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  identifier?: string;

  /**
   * Hash of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  hash?: string;

  /**
   * File name of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * Url of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * The solution builder extension (SBE) partner deployment info for cluster.
 */
model SbePartnerInfo {
  /**
   * SBE package and manifest information for the solution Builder Extension staged for AzureStackHCI cluster deployment.
   */
  sbeDeploymentInfo?: SbeDeploymentInfo;

  /**
   * List of SBE partner properties for AzureStackHCI cluster deployment.
   */
  @identifiers(#[])
  partnerProperties?: SbePartnerProperties[];

  /**
   * SBE credentials list for AzureStackHCI cluster deployment.
   */
  @identifiers(#["secretName"])
  credentialList?: SbeCredentials[];
}

/**
 * Solution builder extension (SBE) package and manifest information for the solution builder extension staged for AzureStackHCI cluster deployment.
 */
model SbeDeploymentInfo {
  /**
   * SBE package version.
   */
  version?: string;

  /**
   * SBE family name.
   */
  family?: string;

  /**
   * SBE manifest publisher.
   */
  publisher?: string;

  /**
   * SBE Manifest Source.
   */
  sbeManifestSource?: string;

  /**
   * SBE Manifest Creation Date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sbeManifestCreationDate?: utcDateTime;
}

/**
 * Solution builder extension (SBE) partner properties object.
 */
model SbePartnerProperties {
  /**
   * SBE partner property name.
   */
  name?: string;

  /**
   * SBE partner property value.
   */
  value?: string;
}

/**
 * secrets used for solution builder extension (SBE) partner extensibility.
 */
model SbeCredentials {
  /**
   * secret name stored in keyvault.
   */
  secretName?: string;

  /**
   * secret name expected for Enterprise Cloud Engine (ECE).
   */
  eceSecretName?: string;

  /**
   * secret URI stored in keyvault.
   */
  secretLocation?: url;
}

/**
 * The DeploymentStatus of AzureStackHCI Cluster.
 */
model EceReportedProperties {
  /**
   * validation status of AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;
}

/**
 * The ECE action plan deployment status for AzureStackHCI Cluster.
 */
model EceActionStatus {
  /**
   * Status of ECE action AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * List of steps of AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  steps?: DeploymentStep[];
}

/**
 * The Step of AzureStackHCI Cluster.
 */
model DeploymentStep {
  /**
   * Name of step.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Description of step.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * FullStepIndex of step.
   */
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  /**
   * Start time of step.
   */
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  /**
   * End time of step.
   */
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  /**
   * Status of step. Allowed values are 'Error', 'Success', 'InProgress'
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * List of nested steps of AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  steps?: DeploymentStep[];

  /**
   * List of exceptions in AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  exception?: string[];
}

/**
 * The validate request for Edge Device.
 */
model ValidateRequest {
  /**
   * Node Ids against which, current node has to be validated.
   */
  edgeDeviceIds: string[];

  /**
   * Additional info required for validation.
   */
  additionalInfo?: string;
}

/**
 * An Accepted response with an Operation-Location header.
 */
model ValidateResponse {
  /**
   * edge device validation status
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * List of Extensions in HCI cluster.
 */
model ExtensionList is Azure.Core.Page<Extension>;

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
model ExtensionProperties {
  /**
   * Provisioning state of the Extension proxy resource. Indicates the current lifecycle status of the resource, such as whether it's being created, updated, deleted, or has encountered an error.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Parameters specific to this extension type.
   */
  extensionParameters?: ExtensionParameters;

  /**
   * Aggregate state of Arc Extensions across the nodes in this HCI cluster. This reflects the overall status of the extension deployment and operation across all nodes.
   */
  @visibility(Lifecycle.Read)
  aggregateState?: ExtensionAggregateState;

  /**
   * State of Arc Extension in each of the nodes.
   */
  @visibility(Lifecycle.Read)
  perNodeExtensionDetails?: PerNodeExtensionState[];

  /**
   * Indicates if the extension is managed by Azure or the user. This determines who controls the deployment and lifecycle of the extension.
   */
  @visibility(Lifecycle.Read)
  managedBy?: ExtensionManagedBy;
}

/**
 * Describes the properties of a Machine Extension. This object mirrors the definition in HybridCompute.
 */
model ExtensionParameters {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler. Latest version would be used if not specified.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: unknown;

  /**
   * Protected settings (may contain secrets).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  protectedSettings?: unknown;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;
}

/**
 * Status of Arc Extension for a particular node in HCI Cluster.
 */
model PerNodeExtensionState {
  /**
   * Name of the node in HCI Cluster.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Fully qualified resource ID for the particular Arc Extension on this node.
   */
  @visibility(Lifecycle.Read)
  extension?: string;

  /**
   * Specifies the version of the script handler.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * State of Arc Extension in this node. Reflects the current lifecycle status of the extension on the individual node, such as whether it's being created, updated, deleted, or has encountered an error.
   */
  @visibility(Lifecycle.Read)
  state?: NodeExtensionState;

  /**
   * The extension instance view.
   */
  @visibility(Lifecycle.Read)
  instanceView?: ExtensionInstanceView;
}

/**
 * Describes the Extension Instance View.
 */
model ExtensionInstanceView {
  /**
   * The extension name.
   */
  name?: string;

  /**
   * Specifies the type of the extension; an example is "MicrosoftMonitoringAgent".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Instance view status.
   */
  status?: ExtensionInstanceViewStatus;
}

/**
 * Instance view status.
 */
model ExtensionInstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code. Indicates the severity or importance of the status message.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Extension Details to update
 */
model ExtensionPatch {
  /**
   * Describes Machine Extension Properties that can be updated.
   */
  properties?: ExtensionPatchProperties;
}

/**
 * Describes Machine Extension Properties that can be updated.
 */
model ExtensionPatchProperties {
  /**
   * Describes the properties of a Machine Extension that can be updated.
   */
  extensionParameters?: ExtensionPatchParameters;
}

/**
 * Describes the properties of a Machine Extension that can be updated.
 */
model ExtensionPatchParameters {
  /**
   * Specifies the version of the script handler. Latest version would be used if not specified.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  settings?: unknown;

  /**
   * Protected settings (may contain secrets).
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  protectedSettings?: unknown;
}

/**
 * Describes the parameters for Extension upgrade.
 */
model ExtensionUpgradeParameters {
  /**
   * Extension Upgrade Target Version.
   */
  targetVersion?: string;
}

/**
 * List of Offer proxy resources for the HCI cluster.
 */
model OfferList is Azure.Core.Page<Offer>;

/**
 * Publisher properties.
 */
model OfferProperties {
  /**
   * Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Identifier of the Publisher for the offer
   */
  publisherId?: string;

  /**
   * JSON serialized catalog content of the offer
   */
  content?: string;

  /**
   * The API version of the catalog service used to serve the catalog content
   */
  contentVersion?: string;

  /**
   * Array of SKU mappings
   */
  @identifiers(#[])
  skuMappings?: SkuMappings[];
}

/**
 * SKU Mapping details.
 */
model SkuMappings {
  /**
   * Identifier of the CatalogPlan for the sku
   */
  catalogPlanId?: string;

  /**
   * Identifier for the sku
   */
  marketplaceSkuId?: string;

  /**
   * Array of SKU versions available
   */
  marketplaceSkuVersions?: string[];
}

/**
 * List of Publisher proxy resources for the HCI cluster.
 */
model PublisherList is Azure.Core.Page<Publisher>;

/**
 * Publisher properties.
 */
model PublisherProperties {
  /**
   * Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Security properties of the resource
 */
model SecurityProperties {
  /**
   * Secured Core Compliance Assignment
   */
  securedCoreComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * WDAC Compliance Assignment
   */
  wdacComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * SMB encryption for intra-cluster traffic Compliance Assignment
   */
  smbEncryptionForIntraClusterTrafficComplianceAssignment?: ComplianceAssignmentType = ComplianceAssignmentType.Audit;

  /**
   * Security Compliance Status
   */
  @visibility(Lifecycle.Read)
  securityComplianceStatus?: SecurityComplianceStatus;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Security compliance properties of the resource
 */
model SecurityComplianceStatus {
  /**
   * Indicates whether HCI hosts meets secured-core server requirements.
   */
  @visibility(Lifecycle.Read)
  securedCoreCompliance?: ComplianceStatus;

  /**
   * Indicates whether HCI hosts have enforced consistent Windows Defender Application Control.
   */
  @visibility(Lifecycle.Read)
  wdacCompliance?: ComplianceStatus;

  /**
   * Indicates whether data at-rest encryption is enabled on Azure Stack HCI clustered volumes.
   */
  @visibility(Lifecycle.Read)
  dataAtRestEncrypted?: ComplianceStatus;

  /**
   * Indicates whether HCI cluster has data in-transit protection.
   */
  @visibility(Lifecycle.Read)
  dataInTransitProtected?: ComplianceStatus;

  /**
   * Time in UTC when compliance status was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

/**
 * List of SKU proxy resources for the HCI cluster.
 */
model SkuList is Azure.Core.Page<Sku>;

/**
 * SKU properties.
 */
model SkuProperties {
  /**
   * Provisioning State
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Identifier of the Publisher for the offer
   */
  publisherId?: string;

  /**
   * Identifier of the Offer for the sku
   */
  offerId?: string;

  /**
   * JSON serialized catalog content of the sku offer
   */
  content?: string;

  /**
   * The API version of the catalog service used to serve the catalog content
   */
  contentVersion?: string;

  /**
   * Array of SKU mappings
   */
  @identifiers(#[])
  skuMappings?: SkuMappings[];
}

/**
 * List of Update runs
 */
model UpdateRunList is Azure.Core.Page<UpdateRun>;

/**
 * Details of an Update run
 */
model UpdateRunProperties {
  /**
   * Provisioning state of the UpdateRuns proxy resource. Indicates the current lifecycle status of the update operation, such as whether it has been accepted, is in progress, or has completed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Timestamp of the update run was started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeStarted?: utcDateTime;

  /**
   * Timestamp of the most recently completed step in the update run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * Duration of the update run.
   */
  duration?: string;

  /**
   * Represents the current state of the update run. Indicates whether the update is in progress, has completed successfully, failed, or is in an unknown state.
   */
  state?: UpdateRunPropertiesState;

  /**
   * Progress representation of the update run steps.
   */
  progress?: Step;
}

/**
 * Progress representation of the update run steps.
 */
model Step {
  /**
   * Name of the step.
   */
  name?: string;

  /**
   * More detailed description of the step.
   */
  description?: string;

  /**
   * Error message, specified if the step is in a failed state.
   */
  errorMessage?: string;

  /**
   * Status of the step, bubbled up from the ECE action plan for installation attempts. Values are: 'Success', 'Error', 'InProgress', and 'Unknown status'.
   */
  status?: string;

  /**
   * When the step started, or empty if it has not started executing.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * When the step reached a terminal state.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Completion time of this step or the last completed sub-step.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTimeUtc?: utcDateTime;

  /**
   * Expected execution time of a given step. This is optionally authored in the update action plan and can be empty.
   */
  expectedExecutionTime?: string;

  /**
   * Recursive model for child steps of this step.
   */
  @identifiers(#["name"])
  steps?: Step[];
}

/**
 * List of Updates
 */
model UpdateList is Azure.Core.Page<Update>;

/**
 * Details of a singular Update in HCI Cluster
 */
model UpdateProperties {
  /**
   * Provisioning state of the Updates proxy resource. Indicates the current lifecycle status of the update operation, such as whether it has been accepted, is in progress, or has completed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Date that the update was installed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installedDate?: utcDateTime;

  /**
   * Description of the update.
   */
  description?: string;

  /**
   * Minimum Sbe Version of the update.
   */
  minSbeVersionRequired?: string;

  /**
   * Represents the current state of the update as it relates to this stamp. This includes phases such as preparation, installation, scanning, and error handling, providing insight into the update's progress and any issues encountered.
   */
  state?: State;

  /**
   * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
   */
  @identifiers(#["packageName"])
  prerequisites?: UpdatePrerequisite[];

  /**
   * An array of component versions for a Solution Bundle update, and an empty array otherwise.
   */
  @identifiers(#["version"])
  componentVersions?: PackageVersionInfo[];

  /**
   * Indicates whether a reboot is required after the update or operation. Helps determine if a system restart is necessary to complete the process.
   */
  rebootRequired?: RebootRequirement;

  /**
   * Overall health state for update-specific health checks.
   */
  healthState?: HealthState;

  /**
   * An array of PrecheckResult objects.
   */
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Path where the update package is available.
   */
  packagePath?: string;

  /**
   * Size of the package. This value is a combination of the size from update metadata and size of the payload that results from the live scan operation for OS update content.
   */
  packageSizeInMb?: float32;

  /**
   * Display name of the Update
   */
  displayName?: string;

  /**
   * Version of the update.
   */
  version?: string;

  /**
   * Publisher of the update package.
   */
  publisher?: string;

  /**
   * Link to release notes for the update.
   */
  releaseLink?: string;

  /**
   * Indicates how the update content is made available for download. This determines whether the update is sourced locally, from an online repository, or requires user notification.
   */
  availabilityType?: AvailabilityType;

  /**
   * Customer-visible type of the update.
   */
  packageType?: string;

  /**
   * Extensible KV pairs serialized as a string. This is currently used to report the stamp OEM family and hardware model information when an update is flagged as Invalid for the stamp based on OEM type.
   */
  additionalProperties?: string;

  /**
   * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
   */
  updateStateProperties?: UpdateStateProperties;
}

/**
 * If update State is HasPrerequisite, this property contains an array of objects describing prerequisite updates before installing this update. Otherwise, it is empty.
 */
model UpdatePrerequisite {
  /**
   * Updatable component type.
   */
  updateType?: string;

  /**
   * Version of the prerequisite.
   */
  version?: string;

  /**
   * Friendly name of the prerequisite.
   */
  packageName?: string;
}

/**
 * Current version of each updatable component.
 */
model PackageVersionInfo {
  /**
   * Package type
   */
  packageType?: string;

  /**
   * Package version
   */
  version?: string;

  /**
   * Last time this component was updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrecheckResult {
  /**
   * Name of the individual test/rule/alert that was executed. Unique, not exposed to the customer.
   */
  name?: string;

  /**
   * The health check DisplayName localized of the individual test executed.
   */
  displayName?: string;

  /**
   * Key-value pairs that allow grouping/filtering individual tests.
   */
  tags?: PrecheckResultTags;

  /**
   * Key-value pairs that allow grouping/filtering individual tests.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  healthCheckTags?: unknown;

  /**
   * User-facing name; one or more sentences indicating the direct issue.
   */
  title?: string;

  /**
   * Represents the current status of the check being performed. Indicates whether the check has completed successfully, failed, or is still in progress.
   */
  status?: Status;

  /**
   * Indicates the importance or impact level of the result. Determines whether the result is informational, a warning, or a critical issue that may block updates.
   */
  severity?: Severity;

  /**
   * Detailed overview of the issue and what impact the issue has on the stamp.
   */
  description?: string;

  /**
   * Set of steps that can be taken to resolve the issue found.
   */
  remediation?: string;

  /**
   * The unique identifier for the affected resource (such as a node or drive).
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  targetResourceID?: string;

  /**
   * The name of the affected resource.
   */
  targetResourceName?: string;

  /**
   * The type of resource being referred to (well-known set of nouns in infrastructure, aligning with Monitoring).
   */
  targetResourceType?: string;

  /**
   * The time in which the HealthCheck was called.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Property bag of key value pairs for additional information.
   */
  additionalData?: string;

  /**
   * The name of the services called for the HealthCheck (I.E. Test-AzureStack, Test-Cluster).
   */
  healthCheckSource?: string;
}

/**
 * Key-value pairs that allow grouping/filtering individual tests.
 */
model PrecheckResultTags {
  /**
   * Key that allow grouping/filtering individual tests.
   */
  key?: string;

  /**
   * Value of the key that allow grouping/filtering individual tests.
   */
  value?: string;
}

/**
 * Additional information regarding the state of the update. See definition of UpdateStateProperties type below for more details on this property.
 */
model UpdateStateProperties {
  /**
   * Progress percentage of ongoing operation. Currently this property is only valid when the update is in the Downloading state, where it maps to how much of the update content has been downloaded.
   */
  progressPercentage?: float32;

  /**
   * Brief message with instructions for updates of AvailabilityType Notify.
   */
  notifyMessage?: string;
}

/**
 * List of Update Summaries
 */
model UpdateSummariesList is Azure.Core.Page<UpdateSummaries>;

/**
 * Properties of Update summaries
 */
model UpdateSummariesProperties {
  /**
   * Provisioning state of the UpdateSummaries proxy resource. Indicates the current lifecycle status of the update summary operation, such as whether it has been accepted, is in progress, or has completed.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * OEM family name.
   */
  oemFamily?: string;

  /**
   * Current OEM Version.
   */
  currentOemVersion?: string;

  /**
   * Name of the hardware model.
   */
  hardwareModel?: string;

  /**
   * Current version of each updatable component.
   */
  @identifiers(#["version"])
  packageVersions?: PackageVersionInfo[];

  /**
   * Current Solution Bundle version of the stamp.
   */
  currentVersion?: string;

  /**
   * Current Sbe version of the stamp.
   */
  currentSbeVersion?: string;

  /**
   * Last time an update installation completed successfully.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * Last time the update service successfully checked for updates
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastChecked?: utcDateTime;

  /**
   * Overall health state for update-specific health checks.
   */
  healthState?: HealthState;

  /**
   * An array of pre-check result objects.
   */
  @identifiers(#["name"])
  healthCheckResult?: PrecheckResult[];

  /**
   * Last time the package-specific checks were run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthCheckDate?: utcDateTime;

  /**
   * Overall update state of the stamp. Indicates the current status of update deployment across the stamp, including preparation, application, and any issues encountered.
   */
  state?: UpdateSummariesPropertiesState;
}

/**
 * Represents properties of a validated solution recipe resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ValidatedSolutionRecipeProperties {
  /**
   * Represents contents of a validated solution recipe.
   */
  recipeContent: ValidatedSolutionRecipeContent;

  /**
   * Represents the signature of the recipe, to be used for ensuring its integrity.
   */
  signature?: string;
}

/**
 * Represents contents of a validated solution recipe resource.
 */
model ValidatedSolutionRecipeContent {
  /**
   * Represents information about a validated solution recipe.
   */
  info: ValidatedSolutionRecipeInfo;

  /**
   * Represents capabilities available in a validated solution recipe.
   */
  capabilities?: ValidatedSolutionRecipeCapabilities;

  /**
   * Represents components available in a validated solution recipe.
   */
  @identifiers(#[])
  components: ValidatedSolutionRecipeComponent[];
}

/**
 * Represents information about a validated solution recipe.
 */
model ValidatedSolutionRecipeInfo {
  /**
   * Represents the solution type for which this validated solution recipe is applicable.
   */
  solutionType: string;

  /**
   * Represents the version for which this validated solution recipe is applicable.
   */
  version: string;
}

/**
 * Represents capabilities available in a validated solution recipe.
 */
model ValidatedSolutionRecipeCapabilities {
  /**
   * Represents the cluster capabilities.
   */
  @identifiers(#[])
  clusterCapabilities: ValidatedSolutionRecipeCapability[];

  /**
   * Represents the node capabilities.
   */
  @identifiers(#[])
  nodeCapabilities: ValidatedSolutionRecipeCapability[];
}

/**
 * Represents capability available in a validated solution recipe.
 */
model ValidatedSolutionRecipeCapability {
  /**
   * Represents the capability name.
   */
  capabilityName: string;
}

/**
 * Represents component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponent {
  /**
   * Represents the component's name.
   */
  name: string;

  /**
   * Represents the component's type.
   */
  type: string;

  /**
   * Represents the component's required version.
   */
  requiredVersion?: string;

  /**
   * Represents the component's install order.
   */
  installOrder?: int64;

  /**
   * Represents the component's tags.
   */
  tags: string[];

  /**
   * Represents the component's payloads.
   */
  @identifiers(#[])
  payloads?: ValidatedSolutionRecipeComponentPayload[];

  /**
   * Represents the component's metadata.
   */
  metadata?: ValidatedSolutionRecipeComponentMetadata;
}

/**
 * Represents payloads associated with a component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponentPayload {
  /**
   * Represents the unique identifier of the payload used to query the URL.
   */
  identifier: string;

  /**
   * Represents the cryptographic hash of the payload, ensuring data integrity.
   */
  hash: string;

  /**
   * Represents the name of the file associated with the payload.
   */
  fileName: string;

  /**
   * Represents the URL from which the payload can be downloaded.
   */
  url: string;
}

/**
 * Represents metadata associated with a component available in a validated solution recipe.
 */
model ValidatedSolutionRecipeComponentMetadata {
  /**
   * Represents the type of extension.
   */
  extensionType?: string;

  /**
   * Represents the publisher of the extension.
   */
  publisher?: string;

  /**
   * Indicates whether automatic upgrades of the extension are enabled.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates whether the LCM (Lifecycle Management) update of the extension is enabled.
   */
  lcmUpdate?: boolean;

  /**
   * Specifies the catalog to which the extension belongs.
   */
  catalog?: string;

  /**
   * Specifies the ring to which the extension belongs, internally used by component.
   */
  ring?: string;

  /**
   * Specifies the release train to which given component belongs.
   */
  releaseTrain?: string;

  /**
   * Specifies the link associated with the extension.
   */
  link?: string;

  /**
   * Specifies the name of the extension.
   */
  name?: string;

  /**
   * Specifies the expected hash of the extension.
   */
  expectedHash?: string;

  /**
   * Specifies the preview source of the extension.
   */
  previewSource?: string;
}

/**
 * Connectivity related configuration required by arc server.
 */
model ArcConnectivityProperties {
  /**
   * True indicates ARC connectivity is enabled
   */
  enabled?: boolean;

  /**
   * Service configurations associated with the connectivity resource. They are only processed by the server if 'enabled' property is set to 'true'.
   */
  @identifiers(#["serviceName"])
  serviceConfigurations?: ServiceConfiguration[];
}

/**
 * Service configuration details
 */
model ServiceConfiguration {
  /**
   * Specifies the name of the service associated with the update or operation. This helps identify which system component or tool is involved.
   */
  serviceName: ServiceName;

  /**
   * The port on which service is enabled.
   */
  port: int64;
}

/**
 * Represents the properties of a log collection job.
 */
model CollectLogJobProperties {
  /**
   * From date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;

  /**
   * To date for log collection.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: LogCollectionReportedProperties;
}

/**
 * Represents the reported properties of a log collection job.
 */
model LogCollectionReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;

  /**
   * Details of the log collection session.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["correlationId"])
  logCollectionSessionDetails?: LogCollectionJobSession[];
}

/**
 * Represents a session for collecting logs from an edge device.
 */
model LogCollectionJobSession {
  /**
   * The timestamp when log collection started, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The timestamp when log collection ended, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * The total time logs were collected for, in ISO 8601 duration format.
   */
  @visibility(Lifecycle.Read)
  timeCollected?: string;

  /**
   * The size of the collected logs in bytes.
   */
  @visibility(Lifecycle.Read)
  logSize?: int32;

  /**
   * The status of the log collection session.
   */
  @visibility(Lifecycle.Read)
  status?: DeviceLogCollectionStatus;

  /**
   * A unique identifier for correlating this log collection session with other operations or sessions.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

/**
 * Edge device job properties
 */
model EdgeDeviceJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode;

  /**
   * Job provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of Edge device job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;
}

/**
 * Represents the properties of an HCI Collect Log job.
 */
model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties {
  /**
   * From date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;

  /**
   * To date for log collection.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: LogCollectionReportedProperties;

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: "CollectLog";
}

/**
 * HCI Edge device job properties
 */
@discriminator("jobType")
model HciEdgeDeviceJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode;

  /**
   * Job provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of Edge device job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * Job Type to support polymorphic resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobType: HciEdgeDeviceJobType;
}

/**
 * Edge device job for Azure Stack HCI solution.
 */
model HciEdgeDeviceJob extends EdgeDeviceJob {
  /**
   * HCI Edge device job properties
   */
  properties: HciEdgeDeviceJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: "HCI";
}

/**
 * Represents the properties of a remote support job for HCI.
 */
model HciRemoteSupportJobProperties extends HciEdgeDeviceJobProperties {
  /**
   * Remote support access level.
   */
  accessLevel: RemoteSupportAccessLevel;

  /**
   * Remote support expiration timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimestamp: utcDateTime;

  /**
   * Remote support type.
   */
  type: RemoteSupportType;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: RemoteSupportJobReportedProperties;

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: "RemoteSupport";
}

/**
 * Represents the reported properties of a remote support job.
 */
model RemoteSupportJobReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;

  /**
   * Optional settings for configuring the node for remote support.
   */
  @visibility(Lifecycle.Read)
  nodeSettings?: RemoteSupportJobNodeSettings;

  /**
   * Details of the remote support session.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["sessionId"])
  sessionDetails?: RemoteSupportSession[];
}

/**
 * Represents the settings of a remote support node.
 */
model RemoteSupportJobNodeSettings {
  /**
   * The state of the remote support node.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The timestamp when the node settings were created, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The timestamp when the node settings were last updated, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * The current connection status of the remote support session.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /**
   * The error message, if any, from the last connection attempt.
   */
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;
}

/**
 * Represents a remote support session.
 */
model RemoteSupportSession {
  /**
   * Unique session Id.
   */
  @visibility(Lifecycle.Read)
  sessionId?: string;

  /**
   * The start time of the remote support session, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionStartTime?: utcDateTime;

  /**
   * The end time of the remote support session, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionEndTime?: utcDateTime;

  /**
   * The level of access granted during the remote support session.
   */
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;

  /**
   * The location where the session transcript is stored.
   */
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

/**
 * Reported Properties for job triggered from cloud.
 */
model JobReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;
}

/**
 * Represents the properties of a remote support job.
 */
model RemoteSupportJobProperties {
  /**
   * Remote support access level.
   */
  accessLevel: RemoteSupportAccessLevel;

  /**
   * Remote support expiration timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimestamp: utcDateTime;

  /**
   * Remote support type.
   */
  type: RemoteSupportType;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: RemoteSupportJobReportedProperties;
}

/**
 * The AdapterPropertyOverrides of a cluster.
 */
model HciEdgeDeviceAdapterPropertyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  jumboPacket?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  networkDirect?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'
   */
  @visibility(Lifecycle.Read)
  networkDirectTechnology?: string;
}

/**
 * The device Configuration for edge device.
 */
model DeviceConfiguration {
  /**
   * NIC Details of device
   */
  @identifiers(#["adapterName"])
  nicDetails?: NicDetail[];

  /**
   * Device metadata details.
   */
  deviceMetadata?: string;
}

/**
 * The NIC Detail of a device.
 */
model NicDetail {
  /**
   * Adapter Name of NIC
   */
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  defaultIsolationId?: string;
}

/**
 * Edge Device properties
 */
model EdgeDeviceProperties {
  /**
   * Device Configuration
   */
  deviceConfiguration?: DeviceConfiguration;

  /**
   * Provisioning state of edgeDevice resource
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * details of validation failure
 */
model HciValidationFailureDetail {
  /**
   * Exception details while installing extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;
}

/**
 * Arc extension installed on edge device.
 */
model HciEdgeDeviceArcExtension {
  /**
   * Arc extension name installed on edge device.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * Arc extension state from arc machine extension.
   */
  @visibility(Lifecycle.Read)
  state?: ArcExtensionState;

  /**
   * Error details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorDetails?: HciValidationFailureDetail[];

  /**
   * Arc Extension Azure resource id.
   */
  @visibility(Lifecycle.Read)
  extensionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Extension version installed.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension is managed by the user or by Azure.
   */
  @visibility(Lifecycle.Read)
  managedBy?: ExtensionManagedBy;
}

/**
 * Extensions details for edge device.
 */
model ExtensionProfile {
  /**
   * List of Arc extensions installed on edge device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["extensionName"])
  extensions?: HciEdgeDeviceArcExtension[];
}

/**
 * Arc-enabled edge device with HCI OS.
 */
model HciEdgeDevice extends EdgeDevice {
  /**
   * properties for Arc-enabled edge device with HCI OS.
   */
  properties?: HciEdgeDeviceProperties;

  /**
   * Device kind to support polymorphic resource.
   */
  kind: "HCI";
}

/**
 * properties for Arc-enabled edge device with HCI OS.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HciEdgeDeviceProperties extends EdgeDeviceProperties {
  /**
   * The instance view of all current configurations on HCI device.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: HciReportedProperties;
}

/**
 * The device Configuration for HCI device.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model HciReportedProperties extends ReportedProperties {
  /**
   * HCI device network information.
   */
  @visibility(Lifecycle.Read)
  networkProfile?: HciNetworkProfile;

  /**
   * HCI device OS specific information.
   */
  @visibility(Lifecycle.Read)
  osProfile?: HciOsProfile;

  /**
   * Solution builder extension (SBE) deployment package information.
   */
  @visibility(Lifecycle.Read)
  sbeDeploymentPackageInfo?: SbeDeploymentPackageInfo;

  /**
   * Hci device storage specific information.
   */
  @visibility(Lifecycle.Read)
  storageProfile?: HciStorageProfile;

  /**
   * Hci device hardware specific information.
   */
  @visibility(Lifecycle.Read)
  hardwareProfile?: HciHardwareProfile;
}

/**
 * The network profile of a device.
 */
model HciNetworkProfile {
  /**
   * List of NIC Details of device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["adapterName"])
  nicDetails?: HciNicDetail[];

  /**
   * List of switch details for edge device.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["switchName"])
  switchDetails?: SwitchDetail[];

  /**
   * HostNetwork config to deploy AzureStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  hostNetwork?: HciEdgeDeviceHostNetwork;

  /** 
    oftware Defined Networking Properties of the cluster
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_12_01_preview)
  @removed(Versions.v2026_02_01)
  sdnProperties?: SdnProperties;
}

/**
 * The NIC Detail of a device.
 */
model HciNicDetail {
  /**
   * Adapter Name of NIC
   */
  @visibility(Lifecycle.Read)
  adapterName?: string;

  /**
   * Interface Description of NIC
   */
  @visibility(Lifecycle.Read)
  interfaceDescription?: string;

  /**
   * Component Id of NIC
   */
  @visibility(Lifecycle.Read)
  componentId?: string;

  /**
   * Driver Version of NIC
   */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  ip4Address?: string;

  /**
   * Subnet Mask of NIC
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;

  /**
   * Default Gateway of NIC
   */
  @visibility(Lifecycle.Read)
  defaultGateway?: string;

  /**
   * DNS Servers for NIC
   */
  @visibility(Lifecycle.Read)
  dnsServers?: string[];

  /**
   * Default Isolation of Management NIC
   */
  @visibility(Lifecycle.Read)
  defaultIsolationId?: string;

  /**
   * MAC address information of NIC.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The slot attached to the NIC.
   */
  @visibility(Lifecycle.Read)
  slot?: string;

  /**
   * The switch attached to the NIC, if any.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of NIC, physical, virtual, management.
   */
  @visibility(Lifecycle.Read)
  nicType?: string;

  /**
   * The VLAN ID of the physical NIC.
   */
  @visibility(Lifecycle.Read)
  vlanId?: string;

  /**
   * The status of NIC, up, disconnected.
   */
  @visibility(Lifecycle.Read)
  nicStatus?: string;

  /**
   * Describes the RDMA capability of the network adapter.
   */
  @visibility(Lifecycle.Read)
  rdmaCapability?: RdmaCapability = RdmaCapability.Disabled;
}

/**
 * List of switch details for edge device.
 */
model SwitchDetail {
  /**
   * The name of the switch.
   */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /**
   * The type of the switch. e.g. external, internal.
   */
  @visibility(Lifecycle.Read)
  switchType?: string;

  /**
   * This represents extensions installed on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["extensionName"])
  extensions?: SwitchExtension[];
}

/**
 * This represents extensions installed on virtualSwitch.
 */
model SwitchExtension {
  /**
   * Unique identifier for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  switchId?: string;

  /**
   * This will show extension name for virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * This represents whether extension is enabled on virtualSwitch.
   */
  @visibility(Lifecycle.Read)
  extensionEnabled?: boolean;
}

/**
 * The HostNetwork of a cluster.
 */
model HciEdgeDeviceHostNetwork {
  /**
   * The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["intentName"])
  intents?: HciEdgeDeviceIntents[];

  /**
   * List of StorageNetworks config to deploy AzureStackHCI Cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["networkAdapterName"])
  storageNetworks?: HciEdgeDeviceStorageNetworks[];

  /**
   * Defines how the storage adapters between nodes are connected either switch or switch less.
   */
  @visibility(Lifecycle.Read)
  storageConnectivitySwitchless?: boolean;

  /**
   * Optional parameter required only for 3 Nodes Switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.
   */
  @visibility(Lifecycle.Read)
  enableStorageAutoIp?: boolean = false;
}

/**
 * The Intents of a cluster.
 */
model HciEdgeDeviceIntents {
  /**
   * Scope for host network intent.
   */
  @visibility(Lifecycle.Read)
  scope?: int64;

  /**
   * IntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  intentType?: int64;

  /**
   * IsComputeIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isComputeIntentSet?: boolean;

  /**
   * IsStorageIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isStorageIntentSet?: boolean;

  /**
   * IntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  isOnlyStorage?: boolean;

  /**
   * IsManagementIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isManagementIntentSet?: boolean;

  /**
   * IsStretchIntentSet for host network intent.
   */
  @visibility(Lifecycle.Read)
  isStretchIntentSet?: boolean;

  /**
   * IsOnlyStretch for host network intent.
   */
  @visibility(Lifecycle.Read)
  isOnlyStretch?: boolean;

  /**
   * IsNetworkIntentType for host network intent.
   */
  @visibility(Lifecycle.Read)
  isNetworkIntentType?: boolean;

  /**
   * Name of the network intent you wish to create.
   */
  @visibility(Lifecycle.Read)
  intentName?: string;

  /**
   * Array of adapters used for the network intent.
   */
  @visibility(Lifecycle.Read)
  intentAdapters?: string[];

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideVirtualSwitchConfiguration?: boolean;

  /**
   * Set virtualSwitch ConfigurationOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  virtualSwitchConfigurationOverrides?: HciEdgeDeviceVirtualSwitchConfigurationOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideQosPolicy?: boolean;

  /**
   * Set QoS PolicyOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  qosPolicyOverrides?: QosPolicyOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @visibility(Lifecycle.Read)
  overrideAdapterProperty?: boolean;

  /**
   * Set Adapter PropertyOverrides for cluster.
   */
  @visibility(Lifecycle.Read)
  adapterPropertyOverrides?: HciEdgeDeviceAdapterPropertyOverrides;
}

/**
 * The VirtualSwitchConfigurationOverrides of a cluster.
 */
model HciEdgeDeviceVirtualSwitchConfigurationOverrides {
  /**
   * Enable IoV for Virtual Switch
   */
  @visibility(Lifecycle.Read)
  enableIov?: string;

  /**
   * Load Balancing Algorithm for Virtual Switch
   */
  @visibility(Lifecycle.Read)
  loadBalancingAlgorithm?: string;
}

/**
 * The StorageNetworks of a cluster.
 */
model HciEdgeDeviceStorageNetworks {
  /**
   * Name of the storage network.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Name of the storage network adapter.
   */
  @visibility(Lifecycle.Read)
  networkAdapterName?: string;

  /**
   * ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic.
   */
  @visibility(Lifecycle.Read)
  storageVlanId?: string;

  /**
   * List of Storage adapter physical nodes config to deploy AzureStackHCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["physicalNode"])
  storageAdapterIPInfo?: HciEdgeDeviceStorageAdapterIPInfo[];
}

/**
 * The StorageAdapter physical nodes of a cluster.
 */
model HciEdgeDeviceStorageAdapterIPInfo {
  /**
   * storage adapter physical node name.
   */
  @visibility(Lifecycle.Read)
  physicalNode?: string;

  /**
   * The IPv4 address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * The SubnetMask address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  @visibility(Lifecycle.Read)
  subnetMask?: string;
}

/**
 * OS configurations for HCI device.
 */
model HciOsProfile {
  /**
   * The boot type of the device. e.g. UEFI, Legacy etc
   */
  @visibility(Lifecycle.Read)
  bootType?: string;

  /**
   * Version of assembly present on device
   */
  @visibility(Lifecycle.Read)
  assemblyVersion?: string;
}

/**
 * Solution builder extension (SBE) deployment package information.
 */
model SbeDeploymentPackageInfo {
  /**
   * SBE deployment validation code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A detailed message that explains the SBE package validation result.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * This represents discovered update results for matching updates and store it as SBE manifest.
   */
  @visibility(Lifecycle.Read)
  sbeManifest?: string;
}

/**
 * Storage configurations for HCI device.
 */
model HciStorageProfile {
  /**
   * Number of storage disks in the device with $CanPool as true.
   */
  @visibility(Lifecycle.Read)
  poolableDisksCount?: int64;
}

/**
 * Hardware configurations for HCI device.
 */
model HciHardwareProfile {
  /**
   * Process type of the device
   */
  @visibility(Lifecycle.Read)
  processorType?: string;
}

/**
 * Reported properties pushed from edge device.
 */
model ReportedProperties {
  /**
   * edge device state.
   */
  @visibility(Lifecycle.Read)
  deviceState?: DeviceState;

  /**
   * Extensions details for edge device.
   */
  @visibility(Lifecycle.Read)
  extensionProfile?: ExtensionProfile;

  /**
   * Most recent edge device sync timestamp in UTC.
   */
  @added(Versions.v2025_12_01_preview)
  @removed(Versions.v2026_02_01)
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;

  /**
   * CVM support details for edge device.
   */
  @added(Versions.v2025_12_01_preview)
  @removed(Versions.v2026_02_01)
  @visibility(Lifecycle.Read)
  confidentialVmProfile?: ConfidentialVmProfile;
}
