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

@doc("The provisioning state of a resource.")
union ProvisioningState {
  string,

  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("The resource provision state is not specified")
  NotSpecified: "NotSpecified",

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
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
  @visibility("read")
  status?: string;

  @doc("List of steps of Edge device job.")
  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  steps?: Step[];
}

@doc("Step details during job execution.")
model Step {
  @doc("Name of step.")
  @visibility("read")
  name?: string;

  @doc("Description of step.")
  @visibility("read")
  description?: string;

  @doc("FullStepIndex of step.")
  @visibility("read")
  fullStepIndex?: string;

  @doc("Start time in utc of step.")
  @visibility("read")
  startTimeUtc?: string;

  @doc("End time in utc of step.")
  @visibility("read")
  endTimeUtc?: string;

  @doc("Status of step. Allowed values are 'Error', 'Success', 'InProgress'")
  @visibility("read")
  status?: string;

  @doc("List of nested steps during job execution..")
  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  steps?: Step[];

  @doc("List of exceptions in job execution.")
  @visibility("read")
  exception?: string[];
}

@doc("The HostNetwork of a cluster.")
model DeploymentHostNetwork {
  @doc("The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  intents?: DeploymentIntents[];

  @doc("List of StorageNetworks config to deploy AzureStackHCI Cluster.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
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
  @OpenAPI.extension("x-ms-identifiers", ["physicalNode"])
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

  @doc("Arc-enabled edge device with WindowsServer OS.")
  WindowsServer: "WindowsServer",

  @doc("Arc-enabled edge device with WindowsIoT OS.")
  WindowsIoT: "WindowsIoT",

  @doc("Arc-enabled edge device with AzureLinux OS.")
  AzureLinux: "AzureLinux",

  @doc("Arc-enabled edge device with UbuntuLinux OS.")
  UbuntuLinux: "UbuntuLinux",
}
