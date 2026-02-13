import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./AgentPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// Machine resource and operations
// =============================================================================

/**
 * A machine. Contains details about the underlying virtual machine. A machine may be visible here but not in kubectl get nodes; if so it may be because the machine has not been registered with the Kubernetes API Server yet.
 */
@parentResource(AgentPool)
model Machine is Azure.ResourceManager.ProxyResource<MachineProperties> {
  ...ResourceNameParameter<
    Resource = Machine,
    KeyName = "machineName",
    SegmentName = "machines",
    NamePattern = "^[a-z][a-z0-9]{0,11}$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,39}$"
  >;

  /**
   * The Availability zone in which machine is located.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  zones?: string[];
}

@@doc(Machine.name, "Host name of the machine.");
@@doc(Machine.properties, "The properties of the machine");
@@doc(Machines.createOrUpdate::parameters.resource,
  "The machine to create or update."
);

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Machines {
  /**
   * Get a specific machine in the specified agent pool.
   */
  get is ArmResourceRead<Machine>;

  /**
   * Creates or updates a machine in the specified agent pool.
   */
  @added(Versions.v2025_10_02_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Machine,
    Parameters = {
      /**
       * The request should only proceed if an entity matches this string.
       */
      @header
      ifMatch?: string;

      /**
       * The request should only proceed if no entity matches this string.
       */
      @header
      ifNoneMatch?: string;
    }
  >;

  /**
   * Gets a list of machines in the specified agent pool.
   */
  list is ArmResourceListByParent<Machine>;
}

// =============================================================================
// Machine models
// =============================================================================

/**
 * The drift action of the machine. Indicates whether a machine has deviated from its expected state due to changes in managed cluster properties, requiring corrective action.
 */
@added(Versions.v2025_10_02_preview)
union DriftAction {
  string,

  /**
   * The machine is up to date.
   */
  Synced: "Synced",

  /**
   * The machine has drifted and needs to be deleted and recreated.
   */
  Recreate: "Recreate",
}

/**
 * Virtual machine state. Indicates the current state of the underlying virtual machine.
 */
union VmState {
  string,

  /**
   * The virtual machine is currently running.
   */
  Running: "Running",

  /**
   * The virtual machine has been deleted by the user or due to spot eviction.
   */
  Deleted: "Deleted",
}

/**
 * The security settings of the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineSecurityProfile {
  /**
   * vTPM is a Trusted Launch feature for configuring a dedicated secure vault for keys and measurements held locally on the node. For more details, see aka.ms/aks/trustedlaunch. If not specified, the default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableVTPM?: boolean;

  /**
   * Secure Boot is a feature of Trusted Launch which ensures that only signed operating systems and drivers can boot. For more details, see aka.ms/aks/trustedlaunch.  If not specified, the default is false.
   */
  enableSecureBoot?: boolean;

  /**
   * SSH access method of an agent pool.
   */
  sshAccess?: AgentPoolSSHAccess;

  /**
   * Whether to enable host based OS and data drive encryption. This is only supported on certain VM sizes and in certain Azure regions. For more information, see: https://docs.microsoft.com/azure/aks/enable-host-encryption
   */
  enableEncryptionAtHost?: boolean;
}

/**
 * The hardware and GPU settings of the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineHardwareProfile {
  /**
   * The size of the VM. VM size availability varies by region. If a node contains insufficient compute resources (memory, cpu, etc) pods might fail to run correctly. For more details on restricted VM sizes, see: https://docs.microsoft.com/azure/aks/quotas-skus-regions
   */
  vmSize?: string;

  /**
   * GPUInstanceProfile to be used to specify GPU MIG instance profile for supported GPU VM SKU.
   */
  gpuInstanceProfile?: GPUInstanceProfile;

  /**
   * The GPU settings of the machine.
   */
  gpuProfile?: GPUProfile;
}

/**
 * The operating system and disk used by the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineOSProfile {
  /**
   * The operating system type. The default is Linux.
   */
  osType?: OSType = OSType.Linux;

  /**
   * Specifies the OS SKU used by the agent pool. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  osSKU?: OSSKU;

  /**
   * OS Disk Size in GB to be used to specify the disk size for every machine in the master/agent pool. If you specify 0, it will apply the default osDisk size according to the vmSize specified.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @maxValue(2048)
  @minValue(0)
  osDiskSizeGB?: int32;

  /**
   * The OS disk type to be used for machines in the agent pool. The default is 'Ephemeral' if the VM supports it and has a cache disk larger than the requested OSDiskSizeGB. Otherwise, defaults to 'Managed'. May not be changed after creation. For more information see [Ephemeral OS](https://docs.microsoft.com/azure/aks/cluster-configuration#ephemeral-os).
   */
  osDiskType?: OSDiskType;

  /**
   * Whether to use a FIPS-enabled OS.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enableFIPS?: boolean;

  /**
   * The Linux machine's specific profile.
   */
  linuxProfile?: MachineOSProfileLinuxProfile;

  /**
   * The Windows machine's specific profile.
   */
  windowsProfile?: AgentPoolWindowsProfile;
}

/**
 * The Linux machine's specific profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_10_02_preview)
model MachineOSProfileLinuxProfile {
  /**
   * The OS configuration of Linux machine.
   */
  linuxOSConfig?: LinuxOSConfig;

  /**
   * Message of the day for Linux nodes, base64-encoded. A base64-encoded string which will be written to /etc/motd after decoding. This allows customization of the message of the day for Linux nodes. It must not be specified for Windows nodes. It must be a static string (i.e., will be printed raw and not be executed as a script).
   */
  messageOfTheDay?: string;
}

/**
 * The Kubernetes configurations used by the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineKubernetesProfile {
  /**
   * The node labels on the machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  nodeLabels?: Record<string>;

  /**
   * The version of Kubernetes specified by the user. Both patch version <major.minor.patch> and <major.minor> are supported. When <major.minor> is specified, the latest supported patch version is chosen automatically.
   */
  orchestratorVersion?: string;

  /**
   * The version of Kubernetes running on the machine. If orchestratorVersion was a fully specified version <major.minor.patch>, this field will be exactly equal to it. If orchestratorVersion was <major.minor>, this field will contain the full <major.minor.patch> version being used.
   */
  @visibility(Lifecycle.Read)
  currentOrchestratorVersion?: string;

  /**
   * Determines the placement of emptyDir volumes, container runtime data root, and Kubelet ephemeral storage.
   */
  kubeletDiskType?: KubeletDiskType;

  /**
   * The Kubelet configuration on the machine.
   */
  kubeletConfig?: KubeletConfig;

  /**
   * Taints added on the node during creation that will not be reconciled by AKS. These taints will not be reconciled by AKS and can be removed with a kubectl call. These taints allow for required configuration to run before the node is ready to accept workloads, for example 'key1=value1:NoSchedule' that then can be removed with `kubectl taint nodes node1 key1=value1:NoSchedule-`
   */
  nodeInitializationTaints?: string[];

  /**
   * The taints added to new node during machine create. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * The maximum number of pods that can run on a node.
   */
  maxPods?: int32;

  /**
   * The node name in the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Determines the type of workload a node can run.
   */
  workloadRuntime?: WorkloadRuntime;

  /**
   * Configuration for using artifact streaming on AKS.
   */
  artifactStreamingProfile?: AgentPoolArtifactStreamingProfile;
}

/**
 * Contains read-only information about the machine.
 */
@added(Versions.v2025_10_02_preview)
model MachineStatus {
  /**
   * The error details information of the machine. Preserves the detailed info of failure. If there was no error, this field is omitted.
   */
  @visibility(Lifecycle.Read)
  provisioningError?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * Specifies the time at which the machine was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTimestamp?: utcDateTime;

  /**
   * The drift action of the machine. Indicates whether a machine has deviated from its expected state due to changes in managed cluster properties, requiring corrective action.
   */
  @visibility(Lifecycle.Read)
  driftAction?: DriftAction;

  /**
   * Reason for machine drift. Provides detailed information on why the machine has drifted. This field is omitted if the machine is up to date.
   */
  @visibility(Lifecycle.Read)
  driftReason?: string;

  /**
   * Virtual machine state. Indicates the current state of the underlying virtual machine.
   */
  @visibility(Lifecycle.Read)
  vmState?: VmState;
}

/**
 * The properties of the machine
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MachineProperties {
  /**
   * network properties of the machine
   */
  @visibility(Lifecycle.Read)
  network?: MachineNetworkProperties;

  /**
   * Azure resource id of the machine. It can be used to GET underlying VM Instance
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachines";
    },
    {
      type: "Microsoft.Compute/virtualMachineScaleSets/virtualMachines";
    }
  ]>;

  /**
   * The hardware and GPU settings of the machine.
   */
  @added(Versions.v2025_10_02_preview)
  hardware?: MachineHardwareProfile;

  /**
   * The operating system and disk used by the machine.
   */
  @added(Versions.v2025_10_02_preview)
  operatingSystem?: MachineOSProfile;

  /**
   * The Kubernetes configurations used by the machine.
   */
  @added(Versions.v2025_10_02_preview)
  kubernetes?: MachineKubernetesProfile;

  /**
   * Machine only allows 'System' and 'User' mode.
   */
  @added(Versions.v2025_10_02_preview)
  mode?: AgentPoolMode;

  /**
   * The security settings of the machine.
   */
  @added(Versions.v2025_10_02_preview)
  security?: MachineSecurityProfile;

  /**
   * The priority for the machine. If not specified, the default is 'Regular'.
   */
  @added(Versions.v2025_10_02_preview)
  priority?: ScaleSetPriority = ScaleSetPriority.Regular;

  /**
   * The version of node image.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  nodeImageVersion?: string;

  /**
   * The current deployment or provisioning state.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The tags to be persisted on the machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  tags?: Record<string>;

  /**
   * Unique read-only string used to implement optimistic concurrency. The eTag value will change when the resource is updated. Specify an if-match or if-none-match header with the eTag value for a subsequent request to enable optimistic concurrency per the normal eTag convention.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Contains read-only information about the machine.
   */
  @added(Versions.v2025_10_02_preview)
  @visibility(Lifecycle.Read)
  status?: MachineStatus;
}

/**
 * network properties of the machine
 */
model MachineNetworkProperties {
  /**
   * IPv4, IPv6 addresses of the machine
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  ipAddresses?: MachineIpAddress[];

  /**
   * The ID of the subnet which node and optionally pods will join on startup. If this is not specified, a VNET and subnet will be generated and used. If no podSubnetID is specified, this applies to nodes and pods, otherwise it applies to just nodes. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  vnetSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * The ID of the subnet which pods will join when launched. If omitted, pod IPs are statically assigned on the node subnet (see vnetSubnetID for more details). This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  podSubnetID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Whether the machine is allocated its own public IP. Some scenarios may require the machine to receive their own dedicated public IP addresses. A common scenario is for gaming workloads, where a console needs to make a direct connection to a cloud virtual machine to minimize hops. The default is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  enableNodePublicIP?: boolean;

  /**
   * The public IP prefix ID which VM node should use IPs from. This is of the form: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/publicIPPrefixes/{publicIPPrefixName}
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  nodePublicIPPrefixID?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * IPTags of instance-level public IPs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_10_02_preview)
  @identifiers(#[])
  nodePublicIPTags?: IPTag[];
}

/**
 * The machine IP address details.
 */
model MachineIpAddress {
  /**
   * To determine if address belongs IPv4 or IPv6 family
   */
  @visibility(Lifecycle.Read)
  family?: IPFamily;

  /**
   * IPv4 or IPv6 address of the machine
   */
  @visibility(Lifecycle.Read)
  ip?: string;
}
