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

@doc("The HostNetwork of a cluster.")
model DeploymentHostNetwork {
  @doc("The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.")
  @identifiers(#["name"])
  intents?: DeploymentIntents[];

  @doc("List of StorageNetworks config to deploy AzureStackHCI Cluster.")
  @identifiers(#["name"])
  storageNetworks?: DeploymentStorageNetworks[];

  @doc("Defines how the storage adapters between nodes are connected either switch or switch less..")
  storageConnectivitySwitchless?: boolean;

  @doc("Optional parameter required only for 3 Nodes switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.")
  enableStorageAutoIp?: boolean;
}

@doc("The Intents of a cluster.")
model DeploymentIntents {
  @doc("Name of the network intent you wish to create.")
  name?: string;

  @doc("List of network traffic types. Only allowed values are 'Compute', 'Storage', 'Management'.")
  trafficType?: string[];

  @doc("Array of network interfaces used for the network intent.")
  adapter?: string[];

  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideVirtualSwitchConfiguration?: boolean;

  @doc("Set virtualSwitch ConfigurationOverrides for cluster.")
  virtualSwitchConfigurationOverrides?: DeploymentVirtualSwitchConfigurationOverrides;

  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideQosPolicy?: boolean;

  @doc("Set QoS PolicyOverrides for cluster.")
  qosPolicyOverrides?: QosPolicyOverrides;

  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideAdapterProperty?: boolean;

  @doc("Set Adapter PropertyOverrides for cluster.")
  adapterPropertyOverrides?: DeploymentAdapterPropertyOverrides;
}

@doc("Local Availability Zone information for HCI cluster")
model LocalAvailabilityZones {
  @doc("Local Availability Zone name for HCI cluster")
  localAvailabilityZoneName?: string;

  @doc("Local Availability Zone Mode for HCI cluster. Can be active or passive.")
  localAvailabilityZoneMode?: LocalAvailabilityZoneMode;

  @doc("Nodes belonging to a particular zone")
  nodes?: string[];
}

@doc("The VirtualSwitchConfigurationOverrides of a cluster.")
model DeploymentVirtualSwitchConfigurationOverrides {
  @doc("Enable IoV for Virtual Switch")
  enableIov?: string;

  @doc("Load Balancing Algorithm for Virtual Switch")
  loadBalancingAlgorithm?: string;
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

@doc("The network adapter properties to override during deployment of a cluster.")
model DeploymentAdapterPropertyOverrides {
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  jumboPacket?: string;

  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  networkDirect?: string;

  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'")
  networkDirectTechnology?: string;
}

@doc("The StorageNetworks of a cluster.")
model DeploymentStorageNetworks {
  @doc("Name of the storage network.")
  name?: string;

  @doc("Name of the storage network adapter.")
  networkAdapterName?: string;

  @doc("ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic.")
  vlanId?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("List of Storage adapter physical nodes config to deploy AzureStackHCI Cluster.")
  @Azure.ResourceManager.identifiers(#["physicalNode"])
  storageAdapterIPInfo?: DeploymentStorageAdapterIPInfo[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@doc("The storage network adapter info.")
model DeploymentStorageAdapterIPInfo {
  @doc("physical node name.")
  physicalNode?: string;

  @doc("The IPv4 address assigned to network adapter used for storage.")
  ipv4Address?: string;

  @doc("The SubnetMask address assigned to network adapter used for storage.")
  subnetMask?: string;
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

@doc("Local Availability Zone Mode for HCI cluster.")
union LocalAvailabilityZoneMode {
  string,

  @doc("Local Availability Zone in active mode.")
  Active: "Active",

  @doc("Local Availability Zone in passive mode.")
  Passive: "Passive",
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

@doc("Network configuration.")
model NetworkConfiguration {
  @Azure.ResourceManager.identifiers(#[])
  @doc("List of network adapters.")
  networkAdapters?: NetworkAdapter[];
}

@doc("Network adapter configuration.")
model NetworkAdapter {
  @doc("Type of IP assignment.")
  ipAssignmentType: IpAssignmentType;

  @doc("IP address.")
  ipAddress?: string;

  @doc("Adapter Name.")
  adapterName?: string;

  @doc("MAC address.")
  macAddress?: string;

  @doc("IP address range.")
  ipAddressRange?: IpAddressRange;

  @doc("Gateway id.")
  gateway?: string;

  @doc("Subnet mask.")
  subnetMask?: string;

  @doc("Array of DNS addresses.")
  dnsAddressArray?: string[];

  @doc("VLAN ID for the network setup.")
  vlanId?: string;
}

@doc("IP assignment types")
union IpAssignmentType {
  string,

  @doc("Automatic IP assignment")
  Automatic: "Automatic",

  @doc("Manual IP assignment")
  Manual: "Manual",
}

@doc("IP address range configuration.")
model IpAddressRange {
  @doc("Start IP address.")
  startIp: string;

  @doc("End IP address.")
  endIp: string;
}

@doc("Web proxy configuration.")
model WebProxyConfiguration {
  @doc("Connection URI of the web proxy.")
  connectionUri?: string;

  @doc("Port of the web proxy.")
  port?: string;

  @doc("Bypass list for the web proxy.")
  bypassList?: string[];
}

@doc("Time configuration.")
model TimeConfiguration {
  @doc("Primary NTP server.")
  primaryTimeServer?: string;

  @doc("Secondary NTP server.")
  secondaryTimeServer?: string;

  @doc("Time zone.")
  timeZone?: string;
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
  logCollectionSessionDetails?: LogCollectionSession[];
}

@doc("Represents a session for collecting logs from an edge device.")
model LogCollectionSession {
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

@doc("Reported Properties for Provision Os job")
model ProvisionOsReportedProperties {
  ...JobReportedProperties;
}
