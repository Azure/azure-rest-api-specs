import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

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

@doc("Represents the various statuses a job can have throughout its lifecycle.")
union JobStatus {
  string,

  @doc("The job status has not been specified.")
  NotSpecified: "NotSpecified",

  @doc("The job is currently undergoing validation.")
  ValidationInProgress: "ValidationInProgress",

  @doc("The job has successfully passed validation.")
  ValidationSuccess: "ValidationSuccess",

  @doc("The job has failed validation.")
  ValidationFailed: "ValidationFailed",

  @doc("The job's deployment is currently in progress.")
  DeploymentInProgress: "DeploymentInProgress",

  @doc("The job's deployment has failed.")
  DeploymentFailed: "DeploymentFailed",

  @doc("The job has been successfully deployed.")
  DeploymentSuccess: "DeploymentSuccess",

  @doc("The job has succeeded.")
  Succeeded: "Succeeded",

  @doc("The job has failed.")
  Failed: "Failed",

  @doc("The job has been canceled.")
  Canceled: "Canceled",

  @doc("The job is paused.")
  Paused: "Paused",

  @doc("The job is scheduled to run.")
  Scheduled: "Scheduled",
}

@doc("Deployment mode to trigger job.")
union DeploymentMode {
  string,

  @doc("Validate ECE action deployment for a cluster.")
  Validate: "Validate",

  @doc("Deploy ECE action deployment for a cluster.")
  Deploy: "Deploy",
}

@doc("Validation / deployment status details for Job.")
model EceActionStatus {
  @doc("Job status.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("List of steps of Edge device job.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: Step[];
}

@doc("Step details during job execution.")
model Step {
  @doc("Name of step.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Description of step.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("FullStepIndex of step.")
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  @doc("Start time in utc of step.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  @doc("End time in utc of step.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  @doc("Status of step. Allowed values are 'Error', 'Success', 'InProgress'")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("List of nested steps during job execution..")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: Step[];

  @doc("List of exceptions in job execution.")
  @visibility(Lifecycle.Read)
  exception?: string[];
}

@doc("Local Availability Zone information for HCI cluster")
model LocalAvailabilityZones {
  @doc("Local Availability Zone name for HCI cluster")
  localAvailabilityZoneName?: string;

  @doc("Nodes belonging to a particular zone")
  nodes?: string[];
}

@doc("The QoSPolicyOverrides of a cluster.")
model QosPolicyOverrides {
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  priorityValue8021Action_Cluster?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  priorityValue8021Action_SMB?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  bandwidthPercentage_SMB?: string;
}

@doc("Edge device type based on host OS installed.")
union EdgeDeviceKind {
  string,

  @doc("Arc-enabled edge device with HCI OS.")
  HCI: "HCI",
}

@doc("Defines the level of remote support access granted.")
union RemoteSupportAccessLevel {
  @doc("A custom access level provided as a string.")
  string,

  @doc("No remote support access is granted.")
  None: "None",

  @doc("Access is limited to diagnostics information only.")
  Diagnostics: "Diagnostics",

  @doc("Access includes diagnostics information and the ability to perform repairs.")
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

@doc("Defines the type of remote support action to be performed on an edge device.")
union RemoteSupportType {
  @doc("A custom action type provided as a string.")
  string,

  @doc("Enables remote support for the edge device.")
  Enable: "Enable",

  @doc("Revokes previously granted remote support access for the edge device.")
  Revoke: "Revoke",
}

@doc("Represents the status of a log collection operation.")
union LogCollectionStatus {
  @doc("A custom status provided as a string.")
  string,

  @doc("Indicates that no log collection operation has been initiated.")
  None: "None",

  @doc("Indicates that the log collection operation is currently in progress.")
  InProgress: "InProgress",

  @doc("Indicates that the log collection operation has failed.")
  Failed: "Failed",

  @doc("Indicates that the log collection operation has completed successfully.")
  Succeeded: "Succeeded",
}

@doc("Edge solution type.")
union EdgeSolutionType {
  string,

  @doc("Edge solution for Windows based edge devices.")
  WindowsServer: "WindowsServer",
}

@doc("Identity Provider for the cluster")
union IdentityProvider {
  string,

  @doc("Active Directory as the Identity Provider. This is the default option.")
  ActiveDirectory: "ActiveDirectory",

  @doc("Use local identity with Azure Keyvault")
  LocalIdentity: "LocalIdentity",
}

@doc("Reported Properties for job triggered from cloud.")
model JobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  @doc("Validation status of job.")
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;
}

@doc("IP assignment types")
union IpAssignmentType {
  string,

  @doc("Automatic IP assignment")
  Automatic: "Automatic",

  @doc("Manual IP assignment")
  Manual: "Manual",
}

@doc("Represents the provisioning operating system type.")
union ProvisioningOsType {
  string,

  @doc("HCI OS.")
  HCI: "HCI",
}

@doc("Represents the status of a log collection operation.")
union DeviceLogCollectionStatus {
  @doc("A custom status provided as a string.")
  string,

  @doc("Log collection operation has not been initiated.")
  NotStarted: "NotStarted",

  @doc("Indicates that the log collection operation is currently running.")
  Running: "Running",

  @doc("Indicates that the log collection operation has failed.")
  Failed: "Failed",

  @doc("Indicates that the log collection operation has completed successfully.")
  Succeeded: "Succeeded",

  @doc("Indicates that the log collection operation has completed successfully.")
  Canceled: "Canceled",
}

@doc("Represents the reported properties of a log collection job.")
model LogCollectionReportedProperties {
  ...JobReportedProperties;

  @doc("Details of the log collection session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["correlationId"])
  logCollectionSessionDetails?: LogCollectionJobSession[];
}

@doc("Represents a session for collecting logs from an edge device.")
model LogCollectionJobSession {
  @doc("The timestamp when log collection started, in ISO 8601 format.")
  @visibility(Lifecycle.Read)
  startTime?: string;

  @doc("The timestamp when log collection ended, in ISO 8601 format.")
  @visibility(Lifecycle.Read)
  endTime?: string;

  @doc("The total time logs were collected for, in ISO 8601 duration format.")
  @visibility(Lifecycle.Read)
  timeCollected?: string;

  @doc("The size of the collected logs in bytes.")
  @visibility(Lifecycle.Read)
  logSize?: int32;

  @doc("The status of the log collection session.")
  @visibility(Lifecycle.Read)
  status?: DeviceLogCollectionStatus;

  @doc("A unique identifier for correlating this log collection session with other operations or sessions.")
  @visibility(Lifecycle.Read)
  correlationId?: string;
}
