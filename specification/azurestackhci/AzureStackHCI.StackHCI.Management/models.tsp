import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AzureStackHCI;

/**
 * Aggregate state of Arc agent across the nodes in this HCI cluster.
 */
union ArcSettingAggregateState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallySucceeded: "PartiallySucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallyConnected: "PartiallyConnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DisableInProgress: "DisableInProgress",
}

/**
 * State of Arc agent in this node.
 */
union NodeArcState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallySucceeded: "PartiallySucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallyConnected: "PartiallyConnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DisableInProgress: "DisableInProgress",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Status of the cluster agent.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotYetRegistered: "NotYetRegistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ConnectedRecently: "ConnectedRecently",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotConnectedRecently: "NotConnectedRecently",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationInProgress: "ValidationInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationSuccess: "ValidationSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidationFailed: "ValidationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeploymentInProgress: "DeploymentInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeploymentFailed: "DeploymentFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeploymentSuccess: "DeploymentSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
}

/**
 * Overall connectivity status for the cluster resource.
 */
union ConnectivityStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotYetRegistered: "NotYetRegistered",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotConnectedRecently: "NotConnectedRecently",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallyConnected: "PartiallyConnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
}

/**
 * Status of the Software Assurance for the cluster.
 */
union SoftwareAssuranceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Customer Intent for Software Assurance Benefit.
 */
union SoftwareAssuranceIntent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enable: "Enable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disable: "Disable",
}

/**
 * LogCollection job type
 */
union LogCollectionJobType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OnDemand: "OnDemand",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
}

/**
 * Remote Support Access Level
 */
union AccessLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Diagnostics: "Diagnostics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/**
 * Desired state of Windows Server Subscription.
 */
union WindowsServerSubscription {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Desired level of diagnostic data emitted by the cluster.
 */
union DiagnosticLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Off: "Off",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enhanced: "Enhanced",
}

/**
 * The node type of all the nodes of the cluster.
 */
union ClusterNodeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FirstParty: "FirstParty",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ThirdParty: "ThirdParty",
}

/**
 * OEM activation status of the cluster.
 */
union OemActivation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * IMDS attestation status of the cluster.
 */
union ImdsAttestation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallySucceeded: "PartiallySucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallyConnected: "PartiallyConnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradeFailedRollbackSucceeded: "UpgradeFailedRollbackSucceeded",
}

/**
 * State of Arc Extension in this node.
 */
union NodeExtensionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallySucceeded: "PartiallySucceeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartiallyConnected: "PartiallyConnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Provisioning: "Provisioning",
}

/**
 * The level code.
 */
union StatusLevelTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Info: "Info",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
}

/**
 * Extension managed by user or Azure.
 */
union ExtensionManagedBy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * State of the update as it relates to this stamp.
 */
union State {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HasPrerequisite: "HasPrerequisite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Obsolete: "Obsolete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotApplicableBecauseAnotherUpdateIsInProgress: "NotApplicableBecauseAnotherUpdateIsInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Installing: "Installing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Installed: "Installed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreparationFailed: "PreparationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InstallationFailed: "InstallationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Recalled: "Recalled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Downloading: "Downloading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DownloadFailed: "DownloadFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HealthChecking: "HealthChecking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HealthCheckFailed: "HealthCheckFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadyToInstall: "ReadyToInstall",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScanInProgress: "ScanInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScanFailed: "ScanFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AdditionalContentRequired: "AdditionalContentRequired",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union RebootRequirement {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  False: "False",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union HealthState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failure: "Failure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
}

/**
 * Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.
 */
union Severity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Critical: "Critical",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Informational: "Informational",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hidden: "Hidden",
}

/**
 * Indicates the way the update content can be downloaded.
 */
union AvailabilityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Local: "Local",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Notify: "Notify",
}

/**
 * Overall update state of the stamp.
 */
union UpdateSummariesPropertiesState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AppliedSuccessfully: "AppliedSuccessfully",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdateAvailable: "UpdateAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdateInProgress: "UpdateInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdateFailed: "UpdateFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NeedsAttention: "NeedsAttention",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreparationInProgress: "PreparationInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreparationFailed: "PreparationFailed",
}

/**
 * Name of the service.
 */
union ServiceName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WAC: "WAC",
}

/**
 * Job Type supported by Azure Linux Edge Devices.
 */
union AzureLinuxEdgeDeviceJobType {
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  steps?: DeploymentStep[];

  /**
   * List of exceptions in AzureStackHCI Cluster Deployment.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  exception?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backward compatibility to maintain consistency with old swagger"
  healthCheckTags?: Record<unknown>;

  /**
   * User-facing name; one or more sentences indicating the direct issue.
   */
  title?: string;

  /**
   * The status of the check running (i.e. Failed, Succeeded, In Progress). This answers whether the check ran, and passed or failed.
   */
  status?: Status;

  /**
   * Severity of the result (Critical, Warning, Informational, Hidden). This answers how important the result is. Critical is the only update-blocking severity.
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
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
