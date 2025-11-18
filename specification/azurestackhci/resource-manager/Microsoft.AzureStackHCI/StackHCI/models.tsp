import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

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
 * Aggregate state of Arc agent across the nodes in this HCI cluster.
 */
union ArcSettingAggregateState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The arc setting is connected. */
  Connected: "Connected",

  /** The arc setting is disconnected. */
  Disconnected: "Disconnected",

  /** The arc setting is deleted. */
  Deleted: "Deleted",

  /** The arc setting is being created. */
  Creating: "Creating",

  /** The arc setting is being updated. */
  Updating: "Updating",

  /** The arc setting is being deleted. */
  Deleting: "Deleting",

  /** The arc setting is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The arc setting is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The arc setting is provisioning. */
  Provisioning: "Provisioning",

  /** Disable operation is in progress. */
  DisableInProgress: "DisableInProgress",
}

/**
 * State of Arc agent in this node.
 */
union NodeArcState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The arc agent is connected. */
  Connected: "Connected",

  /** The arc agent is disconnected. */
  Disconnected: "Disconnected",

  /** The arc agent is deleted. */
  Deleted: "Deleted",

  /** The arc agent is being created. */
  Creating: "Creating",

  /** The arc agent is being updated. */
  Updating: "Updating",

  /** The arc agent is being deleted. */
  Deleting: "Deleting",

  /** The arc agent is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The arc agent is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The arc agent is provisioning. */
  Provisioning: "Provisioning",

  /** Disable operation is in progress. */
  DisableInProgress: "DisableInProgress",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /** The resource was created by a user. */
  User: "User",

  /** The resource was created by an application. */
  Application: "Application",

  /** The resource was created by a managed identity. */
  ManagedIdentity: "ManagedIdentity",

  /** The resource was created by a key. */
  Key: "Key",
}

/**
 * Status of the cluster agent.
 */
union Status {
  string,

  /** The cluster agent is not yet registered. */
  NotYetRegistered: "NotYetRegistered",

  /** The cluster agent connected recently. */
  ConnectedRecently: "ConnectedRecently",

  /** The cluster agent has not connected recently. */
  NotConnectedRecently: "NotConnectedRecently",

  /** The cluster agent is disconnected. */
  Disconnected: "Disconnected",

  /** An error occurred. */
  Error: "Error",

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** Validation is in progress. */
  ValidationInProgress: "ValidationInProgress",

  /** Validation was successful. */
  ValidationSuccess: "ValidationSuccess",

  /** Validation failed. */
  ValidationFailed: "ValidationFailed",

  /** Deployment is in progress. */
  DeploymentInProgress: "DeploymentInProgress",

  /** Deployment failed. */
  DeploymentFailed: "DeploymentFailed",

  /** Deployment was successful. */
  DeploymentSuccess: "DeploymentSuccess",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation failed. */
  Failed: "Failed",

  /** The operation is in progress. */
  InProgress: "InProgress",
}

/**
 * Overall connectivity status for the cluster resource.
 */
union ConnectivityStatus {
  string,

  /** The cluster is not yet registered. */
  NotYetRegistered: "NotYetRegistered",

  /** The cluster is connected. */
  Connected: "Connected",

  /** The cluster has not connected recently. */
  NotConnectedRecently: "NotConnectedRecently",

  /** The cluster is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The cluster is disconnected. */
  Disconnected: "Disconnected",

  /** The state is not specified. */
  NotSpecified: "NotSpecified",
}

/**
 * Status of the Software Assurance for the cluster.
 */
union SoftwareAssuranceStatus {
  string,

  /** Software Assurance is enabled. */
  Enabled: "Enabled",

  /** Software Assurance is disabled. */
  Disabled: "Disabled",
}

/**
 * Customer Intent for Software Assurance Benefit.
 */
union SoftwareAssuranceIntent {
  string,

  /** Enable Software Assurance. */
  Enable: "Enable",

  /** Disable Software Assurance. */
  Disable: "Disable",
}

/**
 * LogCollection job type
 */
union LogCollectionJobType {
  string,

  /** On-demand log collection job. */
  OnDemand: "OnDemand",

  /** Scheduled log collection job. */
  Scheduled: "Scheduled",
}

/**
 * Remote Support Access Level
 */
union AccessLevel {
  string,

  /** Diagnostics access level. */
  Diagnostics: "Diagnostics",

  /** Diagnostics and repair access level. */
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/**
 * Desired state of Windows Server Subscription.
 */
union WindowsServerSubscription {
  string,

  /** Windows Server Subscription is disabled. */
  Disabled: "Disabled",

  /** Windows Server Subscription is enabled. */
  Enabled: "Enabled",
}

/**
 * Desired level of diagnostic data emitted by the cluster.
 */
union DiagnosticLevel {
  string,

  /** Diagnostic data is turned off. */
  Off: "Off",

  /** Basic level of diagnostic data. */
  Basic: "Basic",

  /** Enhanced level of diagnostic data. */
  Enhanced: "Enhanced",
}

/**
 * The node type of all the nodes of the cluster.
 */
union ClusterNodeType {
  string,

  /** First party cluster node. */
  FirstParty: "FirstParty",

  /** Third party cluster node. */
  ThirdParty: "ThirdParty",
}

/**
 * OEM activation status of the cluster.
 */
union OemActivation {
  string,

  /** OEM activation is disabled. */
  Disabled: "Disabled",

  /** OEM activation is enabled. */
  Enabled: "Enabled",
}

/**
 * IMDS attestation status of the cluster.
 */
union ImdsAttestation {
  string,

  /** IMDS attestation is disabled. */
  Disabled: "Disabled",

  /** IMDS attestation is enabled. */
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
union DeviceKind {
  string,

  /**
   * Arc-enabled edge device with HCI OS.
   */
  HCI: "HCI",
}

/**
 * Aggregate state of Arc Extensions across the nodes in this HCI cluster.
 */
union ExtensionAggregateState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The extension is connected. */
  Connected: "Connected",

  /** The extension is disconnected. */
  Disconnected: "Disconnected",

  /** The extension is deleted. */
  Deleted: "Deleted",

  /** The extension is being created. */
  Creating: "Creating",

  /** The extension is being updated. */
  Updating: "Updating",

  /** The extension is being deleted. */
  Deleting: "Deleting",

  /** The extension is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The extension is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The extension is provisioning. */
  Provisioning: "Provisioning",

  /** Upgrade failed but rollback succeeded. */
  UpgradeFailedRollbackSucceeded: "UpgradeFailedRollbackSucceeded",
}

/**
 * State of Arc Extension in this node.
 */
union NodeExtensionState {
  string,

  /** The state is not specified. */
  NotSpecified: "NotSpecified",

  /** An error occurred. */
  Error: "Error",

  /** The operation succeeded. */
  Succeeded: "Succeeded",

  /** The operation was canceled. */
  Canceled: "Canceled",

  /** The operation failed. */
  Failed: "Failed",

  /** The extension is connected. */
  Connected: "Connected",

  /** The extension is disconnected. */
  Disconnected: "Disconnected",

  /** The extension is deleted. */
  Deleted: "Deleted",

  /** The extension is being created. */
  Creating: "Creating",

  /** The extension is being updated. */
  Updating: "Updating",

  /** The extension is being deleted. */
  Deleting: "Deleting",

  /** The extension is being moved. */
  Moving: "Moving",

  /** The operation partially succeeded. */
  PartiallySucceeded: "PartiallySucceeded",

  /** The extension is partially connected. */
  PartiallyConnected: "PartiallyConnected",

  /** The operation is in progress. */
  InProgress: "InProgress",

  /** The operation has been accepted. */
  Accepted: "Accepted",

  /** The extension is provisioning. */
  Provisioning: "Provisioning",
}

/**
 * The level code.
 */
union StatusLevelTypes {
  string,

  /** Information level. */
  Info: "Info",

  /** Warning level. */
  Warning: "Warning",

  /** Error level. */
  Error: "Error",
}

/**
 * Extension managed by user or Azure.
 */
union ExtensionManagedBy {
  string,

  /** Extension is managed by user. */
  User: "User",

  /** Extension is managed by Azure. */
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
 * State of the update run.
 */
union UpdateRunPropertiesState {
  string,

  /** The update run state is unknown. */
  Unknown: "Unknown",

  /** The update run succeeded. */
  Succeeded: "Succeeded",

  /** The update run is in progress. */
  InProgress: "InProgress",

  /** The update run failed. */
  Failed: "Failed",
}

/**
 * State of the update as it relates to this stamp.
 */
union State {
  string,

  /** The update has prerequisites that need to be installed first. */
  HasPrerequisite: "HasPrerequisite",

  /** The update is obsolete. */
  Obsolete: "Obsolete",

  /** The update is ready to be installed. */
  Ready: "Ready",

  /** The update is not applicable because another update is in progress. */
  NotApplicableBecauseAnotherUpdateIsInProgress: "NotApplicableBecauseAnotherUpdateIsInProgress",

  /** The update is being prepared for installation. */
  Preparing: "Preparing",

  /** The update is being installed. */
  Installing: "Installing",

  /** The update has been installed. */
  Installed: "Installed",

  /** The update preparation failed. */
  PreparationFailed: "PreparationFailed",

  /** The update installation failed. */
  InstallationFailed: "InstallationFailed",

  /** The update is invalid. */
  Invalid: "Invalid",

  /** The update has been recalled. */
  Recalled: "Recalled",

  /** The update is being downloaded. */
  Downloading: "Downloading",

  /** The update download failed. */
  DownloadFailed: "DownloadFailed",

  /** The update is undergoing health checking. */
  HealthChecking: "HealthChecking",

  /** The update health check failed. */
  HealthCheckFailed: "HealthCheckFailed",

  /** The update is ready to be installed. */
  ReadyToInstall: "ReadyToInstall",

  /** The update scan is in progress. */
  ScanInProgress: "ScanInProgress",

  /** The update scan failed. */
  ScanFailed: "ScanFailed",

  /** The update requires additional content. */
  AdditionalContentRequired: "AdditionalContentRequired",
}

/**
 * Whether a reboot is required after applying the update.
 */
union RebootRequirement {
  string,

  /** The reboot requirement is unknown. */
  Unknown: "Unknown",

  /** A reboot is required. */
  True: "True",

  /** A reboot is not required. */
  False: "False",
}

/**
 * The overall health state.
 */
union HealthState {
  string,

  /** The health state is unknown. */
  Unknown: "Unknown",

  /** The health check was successful. */
  Success: "Success",

  /** The health check failed. */
  Failure: "Failure",

  /** The health check returned a warning. */
  Warning: "Warning",

  /** The health check returned an error. */
  Error: "Error",

  /** The health check is in progress. */
  InProgress: "InProgress",
}

/**
 * Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.
 */
union Severity {
  string,

  /** Critical severity - blocks updates. */
  Critical: "Critical",

  /** Warning severity. */
  Warning: "Warning",

  /** Informational severity. */
  Informational: "Informational",

  /** Hidden severity. */
  Hidden: "Hidden",
}

/**
 * Indicates the way the update content can be downloaded.
 */
union AvailabilityType {
  string,

  /** Update content is available locally. */
  Local: "Local",

  /** Update content is available online. */
  Online: "Online",

  /** Update content requires notification. */
  Notify: "Notify",
}

/**
 * Overall update state of the stamp.
 */
union UpdateSummariesPropertiesState {
  string,

  /** The update state is unknown. */
  Unknown: "Unknown",

  /** Updates were applied successfully. */
  AppliedSuccessfully: "AppliedSuccessfully",

  /** An update is available. */
  UpdateAvailable: "UpdateAvailable",

  /** An update is in progress. */
  UpdateInProgress: "UpdateInProgress",

  /** An update failed. */
  UpdateFailed: "UpdateFailed",

  /** The update needs attention. */
  NeedsAttention: "NeedsAttention",

  /** Update preparation is in progress. */
  PreparationInProgress: "PreparationInProgress",

  /** Update preparation failed. */
  PreparationFailed: "PreparationFailed",
}

/**
 * Name of the service.
 */
union ServiceName {
  string,

  /** Windows Admin Center service. */
  WAC: "WAC",
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