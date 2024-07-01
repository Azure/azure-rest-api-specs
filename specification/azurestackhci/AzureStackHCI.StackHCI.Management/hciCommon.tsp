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
 * The provisioning state of a resource.
 */
union ProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The resource provision state is not specified
   */
  NotSpecified: "NotSpecified",

  /**
   * The resource is being provisioned
   */
  Provisioning: "Provisioning",

  /**
   * The resource is updating
   */
  Updating: "Updating",

  /**
   * The resource is being deleted
   */
  Deleting: "Deleting",

  /**
   * The resource create request has been accepted
   */
  Accepted: "Accepted",
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
 * Validation / deployment status details for Job.
 */
model EceActionStatus {
    /**
     * Job status.
     */
    @visibility("read")
    status?: string;
  
    /**
     * List of steps of Edge device job.
     */
    @visibility("read")
    @extension("x-ms-identifiers", ["name"])
    steps?: Step[];
  }

/**
 * Step details during job execution.
 */
model Step {
    /**
     * Name of step.
     */
    @visibility("read")
    name?: string;
  
    /**
     * Description of step.
     */
    @visibility("read")
    description?: string;
  
    /**
     * FullStepIndex of step.
     */
    @visibility("read")
    fullStepIndex?: string;
  
    /**
     * Start time of step.
     */
    @visibility("read")
    startTimeUtc?: string;
  
    /**
     * End time of step.
     */
    @visibility("read")
    endTimeUtc?: string;
  
    /**
     * Status of step. Allowed values are 'Error', 'Success', 'InProgress'
     */
    @visibility("read")
    status?: string;
  
    /**
     * List of nested steps during job execution..
     */
    @visibility("read")
    @extension("x-ms-identifiers", ["name"])
    steps?: Step[];
  
    /**
     * List of exceptions in job execution.
     */
    @visibility("read")
    exception?: string[];
  }
  
  /**
 * The HostNetwork of a cluster.
 */
model DeploymentHostNetwork {
  /**
   * The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  intents?: DeploymentIntents[];

  /**
   * List of StorageNetworks config to deploy AzureStackHCI Cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  storageNetworks?: DeploymentStorageNetworks[];

  /**
   * Defines how the storage adapters between nodes are connected either switch or switch less..
   */
  storageConnectivitySwitchless?: boolean;

  /**
   * Optional parameter required only for 3 Nodes Switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.
   */
  enableStorageAutoIp?: boolean;
}

/**
 * The Intents of a cluster.
 */
model DeploymentIntents {
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
  overrideVirtualSwitchConfiguration?: boolean;

  /**
   * Set virtualSwitch ConfigurationOverrides for cluster.
   */
  virtualSwitchConfigurationOverrides?: DeploymentVirtualSwitchConfigurationOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideQosPolicy?: boolean;

  /**
   * Set QoS PolicyOverrides for cluster.
   */
  qosPolicyOverrides?: DeploymentQosPolicyOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideAdapterProperty?: boolean;

  /**
   * Set Adapter PropertyOverrides for cluster.
   */
  adapterPropertyOverrides?: DeploymentAdapterPropertyOverrides;
}

/**
 * The VirtualSwitchConfigurationOverrides of a cluster.
 */
model DeploymentVirtualSwitchConfigurationOverrides {
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
model DeploymentQosPolicyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @encodedName("application/json", "priorityValue8021Action_Cluster")
  priorityValue8021ActionCluster?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @encodedName("application/json", "priorityValue8021Action_SMB")
  priorityValue8021ActionSMB?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  @encodedName("application/json", "bandwidthPercentage_SMB")
  bandwidthPercentageSMB?: string;
}

/**
 * The AdapterPropertyOverrides of a cluster.
 */
model DeploymentAdapterPropertyOverrides {
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
model DeploymentStorageNetworks {
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
  @OpenAPI.extension("x-ms-identifiers", ["physicalNode"])
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  storageAdapterIPInfo?: DeploymentStorageAdapterIPInfo[];
}


/**
 * The StorageAdapter physical nodes of a cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model DeploymentStorageAdapterIPInfo {
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
