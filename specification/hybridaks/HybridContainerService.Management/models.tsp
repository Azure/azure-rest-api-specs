import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HybridContainerService;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Network policy used for building Kubernetes network. Possible values include: 'calico'.
 */
union NetworkPolicy {
  /** Use the calico policy */
  calico: "calico",

  string,
}

/**
 * The particular KubernetesVersion Image OS Type (Linux, Windows)
 */
union OsType {
  /** The Windows OS */
  Windows: "Windows",

  /** A Linux OS */
  Linux: "Linux",

  string,
}

/**
 * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
 */
union OSSKU {
  string,

  /**
   * Use Mariner as the OS for node images.
   */
  CBLMariner: "CBLMariner",

  /**
   * Use Windows2019 as the OS for node images.
   */
  Windows2019: "Windows2019",

  /**
   * Use Windows2022 as the OS for node images.
   */
  Windows2022: "Windows2022",
}

/**
 * Provisioning state of the resource
 */
union ResourceProvisioningState {
  string,

  /** Operation successful */
  Succeeded: "Succeeded",

  /** Operation failed */
  Failed: "Failed",

  /** Operation cancelled */
  Canceled: "Canceled",

  /** Operation is pending */
  Pending: "Pending",

  /** Resource is being created */
  Creating: "Creating",

  /** Resource is being delete */
  Deleting: "Deleting",

  /** Update in progress */
  Updating: "Updating",

  /** Upgrade in progress */
  Upgrading: "Upgrading",

  /** Operation accepted */
  Accepted: "Accepted",
}

/**
 * Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'
 */
union AddonPhase {
  string,

  /**
   * Indicates addon or component is pending.
   */
  pending: "pending",

  /**
   * Indicates addon or component is provisioning.
   */
  provisioning: "provisioning",

  /**
   * Indicates addon or component is provisioning {HelmChartInstalled}.
   */
  `provisioning {HelmChartInstalled}`: "provisioning {HelmChartInstalled}",

  /**
   * Indicates addon or component is provisioning {MSICertificateDownloaded}.
   */
  `provisioning {MSICertificateDownloaded}`: "provisioning {MSICertificateDownloaded}",

  /**
   * Indicates addon or component is provisioned.
   */
  provisioned: "provisioned",

  /**
   * Indicates addon or component is deleting.
   */
  deleting: "deleting",

  /**
   * Indicates addon or component is failed.
   */
  failed: "failed",

  /**
   * Indicates addon or component is upgrading.
   */
  upgrading: "upgrading",
}

/**
 * Indicates whether Azure Hybrid Benefit is opted in. Default value is false
 */
union AzureHybridBenefit {
  string,

  /**
   * Indicates Azure Hybrid Benefit is opted in.
   */
  True: "True",

  /**
   * Indicates Azure Hybrid Benefit is not opted in.
   */
  False: "False",

  /**
   * Indicates Azure Hybrid Benefit is not applicable.
   */
  NotApplicable: "NotApplicable",
}

/**
 * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
 */
union Expander {
  string,

  /**
   * Selects the node group that will have the least idle CPU (if tied, unused memory) after scale-up. This is useful when you have different classes of nodes, for example, high CPU or high memory nodes, and only want to expand those when there are pending pods that need a lot of those resources.
   */
  `least-waste`: "least-waste",

  /**
   * Selects the node group that would be able to schedule the most pods when scaling up. This is useful when you are using nodeSelector to make sure certain pods land on certain nodes. Note that this won't cause the autoscaler to select bigger nodes vs. smaller, as it can add multiple smaller nodes at once.
   */
  `most-pods`: "most-pods",

  /**
   * Selects the node group that has the highest priority assigned by the user. It's configuration is described in more details [here](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/expander/priority/readme.md).
   */
  priority: "priority",

  /**
   * Used when you don't have a particular need for the node groups to scale differently.
   */
  random: "random",
}

/**
 * The extended location type. Allowed value: 'CustomLocation'
 */
union ExtendedLocationTypes {
  string,

  /**
   * The custom location extended location type.
   */
  CustomLocation: "CustomLocation",
}

/**
 * Provisioning state of the resource.
 */
union ProvisioningState {
  string,

  /**
   * Succeeded state.
   */
  Succeeded: "Succeeded",

  /**
   * Failed state.
   */
  Failed: "Failed",

  /**
   * Canceled state.
   */
  Canceled: "Canceled",

  /**
   * Pending state.
   */
  Pending: "Pending",

  /**
   * Creating state.
   */
  Creating: "Creating",

  /**
   * Deleting state.
   */
  Deleting: "Deleting",

  /**
   * Updating state.
   */
  Updating: "Updating",

  /**
   * Accepted state.
   */
  Accepted: "Accepted",
}

/**
 * Properties of the provisioned cluster.
 */
model ProvisionedClusterProperties {
  /**
   * The profile for Linux VMs in the provisioned cluster.
   */
  linuxProfile?: LinuxProfileProperties;

  /**
   * The profile for control plane of the provisioned cluster.
   */
  controlPlane?: ControlPlaneProfile;

  /**
   * The version of Kubernetes in use by the provisioned cluster.
   */
  kubernetesVersion?: string;

  /**
   * The network configuration profile for the provisioned cluster.
   */
  networkProfile?: NetworkProfile;

  /**
   * The storage configuration profile for the provisioned cluster.
   */
  storageProfile?: StorageProfile;

  /**
   * The SSH restricted access profile for the VMs in the provisioned cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  clusterVMAccessProfile?: ClusterVMAccessProfile;

  /**
   * The agent pool properties for the provisioned cluster.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    [
      "osType",
      "osSKU",
      "nodeLabels",
      "nodeTaints",
      "maxCount",
      "minCount",
      "enableAutoScaling",
      "maxPods",
      "availabilityZones",
      "count",
      "vmSize",
      "kubernetesVersion",
      "name",
      "gpuCountPerNode"
    ]
  )
  agentPoolProfiles?: NamedAgentPoolProfile[];

  /**
   * The profile for the underlying cloud infrastructure provider for the provisioned cluster.
   */
  cloudProviderProfile?: CloudProviderProfile;

  /**
   * The status of the latest long running operation for the provisioned cluster.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * The observed status of the provisioned cluster.
   */
  @visibility("read")
  status?: ProvisionedClusterPropertiesStatus;

  /**
   * The license profile of the provisioned cluster.
   */
  licenseProfile?: ProvisionedClusterLicenseProfile;

  /**
   * Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.
   */
  autoScalerProfile?: ProvisionedClusterPropertiesAutoScalerProfile;
}

/**
 * SSH profile for control plane and nodepool VMs of the provisioned cluster.
 */
model LinuxProfileProperties {
  /**
   * SSH configuration for VMs of the provisioned cluster.
   */
  ssh?: LinuxProfilePropertiesSsh;
}

/**
 * SSH configuration for VMs of the provisioned cluster.
 */
model LinuxProfilePropertiesSsh {
  /**
   * The list of SSH public keys used to authenticate with VMs. A maximum of 1 key may be specified.
   */
  @OpenAPI.extension("x-ms-identifiers", ["keyData"])
  publicKeys?: LinuxProfilePropertiesSshPublicKeysItem[];
}

/**
 * Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.
 */
model LinuxProfilePropertiesSshPublicKeysItem {
  /**
   * Certificate public key used to authenticate with VMs through SSH. The certificate must be in PEM format with or without headers.
   */
  keyData?: string;
}

/**
 * The properties of the control plane nodes of the provisioned cluster
 */
model ControlPlaneProfile {
  /**
   * Number of control plane nodes. The default value is 1, and the count can be either 2 or odd numbers.
   */
  count?: int32 = 1;

  /**
   * VM sku size of the control plane nodes
   */
  vmSize?: string;

  /**
   * IP Address of the Kubernetes API server
   */
  controlPlaneEndpoint?: ControlPlaneProfileControlPlaneEndpoint;
}

/**
 * IP Address of the Kubernetes API server
 */
model ControlPlaneProfileControlPlaneEndpoint {
  /**
   * IP address of the Kubernetes API server
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  hostIP?: string;
}

/**
 * The network configuration profile for the provisioned cluster.
 */
model NetworkProfile {
  /**
   * Profile of the HA Proxy load balancer.
   */
  loadBalancerProfile?: NetworkProfileLoadBalancerProfile;

  /**
   * Network policy used for building Kubernetes network. Possible values include: 'calico'.
   */
  networkPolicy?: NetworkPolicy = NetworkPolicy.calico;

  /**
   * A CIDR notation IP Address range from which to assign pod IPs.
   */
  podCidr?: string;
}

/**
 * Profile of the HA Proxy load balancer.
 */
model NetworkProfileLoadBalancerProfile {
  /**
   * Number of HA Proxy load balancer VMs. The default value is 0.
   */
  count?: int32;
}

/**
 * The storage configuration profile for the provisioned cluster.
 */
model StorageProfile {
  /**
   * SMB CSI Driver settings for the storage profile.
   */
  smbCsiDriver?: StorageProfileSmbCSIDriver;

  /**
   * NFS CSI Driver settings for the storage profile.
   */
  nfsCsiDriver?: StorageProfileNfsCSIDriver;
}

/**
 * SMB CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model StorageProfileSmbCSIDriver {
  /**
   * Indicates whether to enable SMB CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * NFS CSI Driver settings for the storage profile.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model StorageProfileNfsCSIDriver {
  /**
   * Indicates whether to enable NFS CSI Driver. The default value is true.
   */
  enabled?: boolean = true;
}

/**
 * The SSH restricted access profile for the VMs in the provisioned cluster.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
model ClusterVMAccessProfile {
  /**
   * IP Address or CIDR for SSH access to VMs in the provisioned cluster
   */
  authorizedIPRanges?: string;
}

/**
 * Profile of the default agent pool along with a name parameter
 */
model NamedAgentPoolProfile {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolName;
}

/**
 * Profile for agent pool properties specified during creation
 */
model AgentPoolProfile {
  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  osType?: OsType;

  /**
   * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  osSKU?: OSSKU;

  /**
   * The node labels to be persisted across all nodes in agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Node Labels needs to be record following AKS behavior"
  nodeLabels?: Record<string>;

  /**
   * Taints added to new nodes during node pool create and scale. For example, key=value:NoSchedule.
   */
  nodeTaints?: string[];

  /**
   * The maximum number of nodes for auto-scaling
   */
  maxCount?: int32;

  /**
   * The minimum number of nodes for auto-scaling
   */
  minCount?: int32;

  /**
   * Whether to enable auto-scaler. Default value is false
   */
  enableAutoScaling?: boolean;

  /**
   * The maximum number of pods that can run on a node.
   */
  maxPods?: int32;

  /**
   * The list of Availability zones to use for nodes.
   */
  availabilityZones?: string[];

  /**
   * The number of gpus attached to a node.
   */
  gpuCountPerNode?: int32;
}

/**
 * Profile for agent pool properties that can be updated
 */
model AgentPoolUpdateProfile {
  /**
   * Number of nodes in the agent pool. The default value is 1.
   */
  count?: int32 = 1;

  /**
   * The VM sku size of the agent pool node VMs.
   */
  vmSize?: string;

  /**
   * Version of Kubernetes in use by the agent pool. This is inherited from the kubernetesVersion of the provisioned cluster.
   */
  @visibility("read")
  kubernetesVersion?: string;
}

/**
 * Name of the default Agent Pool
 */
model AgentPoolName {
  /**
   * Unique name of the default agent pool in the context of the provisioned cluster. Default value is <clusterName>-nodepool1
   */
  name?: string;
}

/**
 * The profile for the underlying cloud infrastructure provider for the provisioned cluster.
 */
model CloudProviderProfile {
  /**
   * The profile for the infrastructure networks used by the provisioned cluster
   */
  infraNetworkProfile?: CloudProviderProfileInfraNetworkProfile;
}

/**
 * The profile for the infrastructure networks used by the provisioned cluster
 */
model CloudProviderProfileInfraNetworkProfile {
  /**
   * List of ARM resource Ids (maximum 1) for the infrastructure network object e.g. /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AzureStackHCI/logicalNetworks/{logicalNetworkName}
   */
  vnetSubnetIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/logicalNetworks";
    },
    {
      type: "Microsoft.HybridContainerService/virtualNetworks";
    }
  ]>[];
}

/**
 * The observed status of the provisioned cluster.
 */
model ProvisionedClusterPropertiesStatus {
  /**
   * The detailed status of the provisioned cluster components including addons.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["name", "phase", "ready", "errorMessage"]
  )
  controlPlaneStatus?: AddonStatusProfile[];

  /**
   * The current state of the provisioned cluster.
   */
  @visibility("read")
  currentState?: ResourceProvisioningState;

  /**
   * Error messages during a provisioned cluster operation or steady state.
   */
  errorMessage?: string;
}

/**
 * The status profile of the addons and other kubernetes components
 */
model AddonStatusProfile {
  /**
   * Name of the addon or component
   */
  name?: string;

  /**
   * Observed phase of the addon or component on the provisioned cluster. Possible values include: 'pending', 'provisioning', 'provisioning {HelmChartInstalled}', 'provisioning {MSICertificateDownloaded}', 'provisioned', 'deleting', 'failed', 'upgrading'
   */
  phase?: AddonPhase;

  /**
   * Indicates whether the addon or component is ready
   */
  ready?: boolean;

  /**
   * Observed error message from the addon or component
   */
  errorMessage?: string;
}

/**
 * The license profile of the provisioned cluster.
 */
model ProvisionedClusterLicenseProfile {
  /**
   * Indicates whether Azure Hybrid Benefit is opted in. Default value is false
   */
  azureHybridBenefit?: AzureHybridBenefit = AzureHybridBenefit.NotApplicable;
}

/**
 * Parameters to be applied to the cluster-autoscaler when auto scaling is enabled for the provisioned cluster.
 */
model ProvisionedClusterPropertiesAutoScalerProfile {
  /**
   * Valid values are 'true' and 'false'
   */
  @encodedName("application/json", "balance-similar-node-groups")
  balanceSimilarNodeGroups?: string;

  /**
   * If not specified, the default is 'random'. See [expanders](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#what-are-expanders) for more information.
   */
  expander?: Expander;

  /**
   * The default is 10.
   */
  @encodedName("application/json", "max-empty-bulk-delete")
  maxEmptyBulkDelete?: string;

  /**
   * The default is 600.
   */
  @encodedName("application/json", "max-graceful-termination-sec")
  maxGracefulTerminationSec?: string;

  /**
   * The default is '15m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "max-node-provision-time")
  maxNodeProvisionTime?: string;

  /**
   * The default is 45. The maximum is 100 and the minimum is 0.
   */
  @encodedName("application/json", "max-total-unready-percentage")
  maxTotalUnreadyPercentage?: string;

  /**
   * For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. The default is '0s'. Values must be an integer followed by a unit ('s' for seconds, 'm' for minutes, 'h' for hours, etc).
   */
  @encodedName("application/json", "new-pod-scale-up-delay")
  newPodScaleUpDelay?: string;

  /**
   * This must be an integer. The default is 3.
   */
  @encodedName("application/json", "ok-total-unready-count")
  okTotalUnreadyCount?: string;

  /**
   * The default is '10'. Values must be an integer number of seconds.
   */
  @encodedName("application/json", "scan-interval")
  scanInterval?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "scale-down-delay-after-add")
  scaleDownDelayAfterAdd?: string;

  /**
   * The default is the scan-interval. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "scale-down-delay-after-delete")
  scaleDownDelayAfterDelete?: string;

  /**
   * The default is '3m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "scale-down-delay-after-failure")
  scaleDownDelayAfterFailure?: string;

  /**
   * The default is '10m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "scale-down-unneeded-time")
  scaleDownUnneededTime?: string;

  /**
   * The default is '20m'. Values must be an integer followed by an 'm'. No unit of time other than minutes (m) is supported.
   */
  @encodedName("application/json", "scale-down-unready-time")
  scaleDownUnreadyTime?: string;

  /**
   * The default is '0.5'.
   */
  @encodedName("application/json", "scale-down-utilization-threshold")
  scaleDownUtilizationThreshold?: string;

  /**
   * The default is true.
   */
  @encodedName("application/json", "skip-nodes-with-local-storage")
  skipNodesWithLocalStorage?: string;

  /**
   * The default is true.
   */
  @encodedName("application/json", "skip-nodes-with-system-pods")
  skipNodesWithSystemPods?: string;
}

/**
 * Extended location pointing to the underlying infrastructure
 */
model ExtendedLocation {
  /**
   * The extended location type. Allowed value: 'CustomLocation'
   */
  type?: ExtendedLocationTypes;

  /**
   * ARM Id of the extended location.
   */
  name?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * Control plane and agent pool upgrade profiles.
 */
model ProvisionedClusterUpgradeProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * The list of available kubernetes version upgrades for the control plane.
   */
  controlPlaneProfile: ProvisionedClusterPoolUpgradeProfile;
}

/**
 * The list of available kubernetes versions for upgrade.
 */
model ProvisionedClusterPoolUpgradeProfile {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility("read")
  osType?: OsType;

  /**
   * List of available kubernetes versions for upgrade.
   */
  @OpenAPI.extension("x-ms-identifiers", ["kubernetesVersion", "isPreview"])
  upgrades?: ProvisionedClusterPoolUpgradeProfileProperties[];
}

/**
 * The upgrade properties.
 */
model ProvisionedClusterPoolUpgradeProfileProperties {
  /**
   * The Kubernetes version (major.minor.patch).
   */
  @visibility("read")
  kubernetesVersion?: string;

  /**
   * Whether the Kubernetes version is currently in preview.
   */
  @visibility("read")
  isPreview?: boolean;
}

/**
 * Defines the resource properties for the hybrid identity metadata.
 */
model HybridIdentityMetadataProperties {
  /**
   * Unique id of the parent provisioned cluster resource.
   */
  resourceUid?: string;

  /**
   * Onboarding public key for provisioning the Managed identity for the connected cluster.
   */
  publicKey?: string;

  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

/**
 * Properties of the agent pool resource
 */
model AgentPoolProperties {
  ...AgentPoolProfile;
  ...AgentPoolUpdateProfile;
  ...AgentPoolProvisioningStatus;
}

/**
 * The agentPool resource provisioning status definition
 */
model AgentPoolProvisioningStatus {
  /**
   * The status of the latest long running operation for the agent pool.
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * The observed status of the agent pool.
   */
  status?: AgentPoolProvisioningStatusStatus;
}

/**
 * The observed status of the agent pool.
 */
model AgentPoolProvisioningStatusStatus {
  /**
   * The current state of the agent pool.
   */
  @visibility("read")
  currentState?: ResourceProvisioningState;

  /**
   * Error messages during an agent pool operation or steady state.
   */
  errorMessage?: string;

  /**
   * The agent pools that are ready.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["count", "vmSize", "kubernetesVersion"]
  )
  readyReplicas?: AgentPoolUpdateProfile[];
}

/**
 * The list kubeconfig result response.
 */
model ListCredentialResponse {
  /**
   * Operation Id
   */
  @visibility("read")
  id?: string;

  /**
   * Operation Name
   */
  @visibility("read")
  name?: string;

  /**
   * ARM Resource Id of the provisioned cluster instance
   */
  @visibility("read")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridContainerService/provisionedClusterInstances";
    }
  ]>;

  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  status?: ResourceProvisioningState;

  /**
   * Error listing the kubeconfig credential response.
   */
  error?: ListCredentialResponseError;

  /**
   * Properties of the kubeconfig credential response.
   */
  properties?: ListCredentialResponseProperties;
}

/**
 * The error listing the kubeconfig credential response.
 */
model ListCredentialResponseError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Properties of the kubeconfig credential response.
 */
model ListCredentialResponseProperties {
  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name", "value"])
  kubeconfigs?: CredentialResult[];
}

/**
 * The credential result response.
 */
model CredentialResult {
  /**
   * The name of the credential.
   */
  @visibility("read")
  name?: string;

  /**
   * Base64-encoded Kubernetes configuration file.
   */
  @visibility("read")
  value?: bytes;
}

/**
 * Base64-encoded Kubernetes configuration file.
 */
model KubernetesVersionProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported Kubernetes versions
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["version", "isPreview", "patchVersions"]
  )
  values?: KubernetesVersionProperties[];
}

/**
 * Kubernetes version profile for given major.minor release
 */
model KubernetesVersionProperties {
  /**
   * major.minor version of Kubernetes release
   */
  @visibility("read")
  version?: string;

  /**
   * Whether this version is in preview mode.
   */
  @visibility("read")
  isPreview?: boolean;

  /**
   * Patch versions of a Kubernetes release
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Patch Versions needs to be record following AKS behavior"
  @visibility("read")
  patchVersions?: Record<KubernetesPatchVersions>;
}

/**
 * Kubernetes Patch Version profile
 */
model KubernetesPatchVersions {
  /**
   * Indicates whether the kubernetes version image is ready or not
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["osType", "osSku", "ready", "errorMessage"]
  )
  readiness?: KubernetesVersionReadiness[];

  /**
   * Possible upgrade paths for given patch version
   */
  upgrades?: string[];
}

/**
 * Indicates whether the kubernetes version image is ready or not
 */
model KubernetesVersionReadiness {
  /**
   * The particular KubernetesVersion Image OS Type (Linux, Windows)
   */
  @visibility("read")
  osType?: OsType;

  /**
   * Specifies the OS SKU used by the agent pool. The default is CBLMariner if OSType is Linux. The default is Windows2019 when OSType is Windows.
   */
  osSku?: OSSKU;

  /**
   * Whether the kubernetes version image is ready or not
   */
  @visibility("read")
  ready?: boolean;

  /**
   * The error message for version not being ready
   */
  @visibility("read")
  errorMessage?: string;
}

/**
 * The profile for the list of supported VM SKUs.
 */
model VmSkuProfileProperties {
  /**
   * Provisioning state of the resource
   */
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  /**
   * List of supported VM SKUs.
   */
  @OpenAPI.extension(
    "x-ms-identifiers",
    ["resourceType", "capabilities", "name", "tier", "size"]
  )
  values?: VmSkuProperties[];
}

/**
 * The properties of a supported VM SKU.
 */
model VmSkuProperties {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The list of name-value pairs to describe VM SKU capabilities like MemoryGB, vCPUs, etc.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["name", "value"])
  capabilities?: VmSkuCapabilities[];

  /**
   * The name of the VM SKU
   */
  @visibility("read")
  name?: string;

  /**
   * The tier of the VM SKU
   */
  @visibility("read")
  tier?: string;

  /**
   * The size of the VM SKU
   */
  @visibility("read")
  size?: string;
}

/**
 * Describes the VM SKU capabilities like MemoryGB, vCPUs, etc.
 */
model VmSkuCapabilities {
  /**
   * Name of the VM SKU capability
   */
  @visibility("read")
  name?: string;

  /**
   * Value of the VM SKU capability
   */
  @visibility("read")
  value?: string;
}

/**
 * Properties of the virtual network resource
 */
model VirtualNetworkProperties {
  /**
   * Infrastructure network profile for HCI platform
   */
  infraVnetProfile?: VirtualNetworkPropertiesInfraVnetProfile;

  /**
   * Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer
   */
  @OpenAPI.extension("x-ms-identifiers", ["startIP", "endIP"])
  vipPool?: VirtualNetworkPropertiesVipPoolItem[];

  /**
   * Range of IP Addresses for Kubernetes node VMs
   */
  @OpenAPI.extension("x-ms-identifiers", ["startIP", "endIP"])
  vmipPool?: VirtualNetworkPropertiesVmipPoolItem[];

  /**
   * List of DNS server IP Addresses associated with the network
   */
  dnsServers?: string[];

  /**
   * IP Address of the Gateway associated with the network
   */
  gateway?: string;

  /**
   * IP Address Prefix of the network
   */
  ipAddressPrefix?: string;

  /**
   * VLAN Id used by the network
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  vlanID?: int32;

  /**
   * The provisioning state of the virtual network resource
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Status of the virtual network resource
   */
  @visibility("read")
  status?: VirtualNetworkPropertiesStatus;
}

/**
 * Infrastructure network VNet profile
 */
model VirtualNetworkPropertiesInfraVnetProfile {
  /**
   * Infrastructure network profile for HCI platform
   */
  hci?: VirtualNetworkPropertiesInfraVnetProfileHci;
}

/**
 * Infrastructure network profile for HCI platform
 */
model VirtualNetworkPropertiesInfraVnetProfileHci {
  /**
   * Group in MOC(Microsoft On-premises Cloud)
   */
  mocGroup?: string;

  /**
   * Location in MOC(Microsoft On-premises Cloud)
   */
  mocLocation?: string;

  /**
   * Virtual Network name in MOC(Microsoft On-premises Cloud)
   */
  mocVnetName?: string;
}

/**
 * Range of IP Addresses for Kubernetes API Server and services if using HA Proxy load balancer
 */
model VirtualNetworkPropertiesVipPoolItem {
  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;

  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;
}

/**
 * Range of IP Addresses for Kubernetes node VMs
 */
model VirtualNetworkPropertiesVmipPoolItem {
  /**
   * Starting IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  startIP?: string;

  /**
   * Ending IP address for the IP Pool
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
  endIP?: string;
}

/**
 * Status of the virtual network resource
 */
model VirtualNetworkPropertiesStatus {
  /**
   * The detailed status of the long running operation.
   */
  operationStatus?: VirtualNetworkPropertiesStatusOperationStatus;
}

/**
 * The detailed status of the long running operation.
 */
model VirtualNetworkPropertiesStatusOperationStatus {
  /**
   * The error if any from the operation.
   */
  error?: VirtualNetworkPropertiesStatusOperationStatusError;

  /**
   * The identifier of the operation.
   */
  operationId?: string;

  /**
   * The status of the operation.
   */
  status?: string;
}

/**
 * The error if any from the operation.
 */
model VirtualNetworkPropertiesStatusOperationStatusError {
  /**
   * The error code from the operation.
   */
  code?: string;

  /**
   * The error message from the operation.
   */
  message?: string;
}

/**
 * Extended location pointing to the underlying infrastructure
 */
model VirtualNetworkExtendedLocation {
  /**
   * The extended location type. Allowed value: 'CustomLocation'
   */
  type?: ExtendedLocationTypes;

  /**
   * ARM Id of the extended location.
   */
  name?: string;
}

/**
 * The Virtual Network resource patch definition.
 */
model VirtualNetworksPatch {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Tags needs to be record"
  tags?: Record<string>;
}

/**
 * The profile for Linux VMs in the provisioned cluster.
 */
model LinuxProfile {
  /**
   * Profile for Linux VMs in the container service cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "Initial suppression to prevent breaking change"
  linuxProfile?: LinuxProfileProperties;
}

/**
 * URI parameter for the connected cluster resource.
 */
model ConnectedClusterResourceUriParameter {
  @path(#{ allowReserved: true })
  @doc("The fully qualified Azure Resource Manager identifier of the connected cluster resource.")
  connectedClusterResourceUri: string;
}

/**
 * Common parameters that should be grouped for all ConnectedClusterResourceUriParameter usage.
 */
alias ConnectedClusterResourceUriParameters = {
  ...ApiVersionParameter;
  ...ConnectedClusterResourceUriParameter;
};

/**
 * URI parameter for the custom location resource.
 */
model CustomLocationResourceUriParameter {
  @path(#{ allowReserved: true })
  @doc("The fully qualified Azure Resource Manager identifier of the custom location resource.")
  customLocationResourceUri: string;
}

/**
 * Common parameters that should be grouped for all CustomLocationResourceUriParameter usage.
 */
alias CustomLocationResourceUriParameters = {
  ...ApiVersionParameter;
  ...CustomLocationResourceUriParameter;
};
