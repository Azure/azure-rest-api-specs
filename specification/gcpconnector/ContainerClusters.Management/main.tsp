import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Suppress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service(#{ title: "Microsoft.GcpConnector" })
@doc("Microsoft.GcpConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.GcpConnector;

/** Api versions */
enum Versions {
  /** 2025-12-01-preview api version */
  `2025-12-01-preview`,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@doc("A Microsoft.GCPConnector resource")
@singleton
model ContainerCluster is ExtensionResource<ClusterProperties> {
  @doc("Name of ContainerCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("containerClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the property name is defined in GCP."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "GCPConnector will not generate SDK. So, Suppressing this error"
@doc("Definition of ContainerCluster")
model ClusterProperties {
  @doc("GCP Properties")
  gcpProperties?: GcpContainerClusterProperties;

  ...GcpCommonProperties;
}

/**
 * A Google Kubernetes Engine cluster.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
model GcpContainerClusterProperties {
  /**
   * Configurations for the various addons available to run in the cluster.
   */
  addonsConfig?: AddonsConfig;

  /**
   * Configuration controlling RBAC group membership information.
   */
  authenticatorGroupsConfig?: AuthenticatorGroupsConfig;

  /**
   * Autopilot configuration for the cluster.
   */
  autopilot?: Autopilot;

  /**
   * Cluster-level autoscaling configuration.
   */
  autoscaling?: ClusterAutoscaling;

  /**
   * Configuration for Binary Authorization.
   */
  binaryAuthorization?: BinaryAuthorization;

  /**
   * The IP address range of the container pods in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `10.96.0.0/14`). Leave blank to have one automatically chosen or specify a `/14` block in `10.0.0.0/8`.
   */
  clusterIpv4Cidr?: string;

  /**
   * Which conditions caused the current cluster state.
   */
  @extension("x-ms-identifiers", #[])
  conditions?: StatusCondition[];

  /**
   * Configuration of Confidential Nodes. All the nodes in the cluster will be Confidential VM once enabled.
   */
  confidentialNodes?: ConfidentialNodes;

  /**
   * Configuration for the fine-grained cost management feature.
   */
  costManagementConfig?: CostManagementConfig;

  /**
   * [Output only] The time the cluster was created, in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
   */
  createTime?: utcDateTime;

  /**
   * [Output only] The current software version of the master endpoint.
   */
  currentMasterVersion?: string;

  /**
   * [Output only] The number of nodes currently in the cluster. Deprecated. Call Kubernetes API directly to retrieve node information.
   * @deprecated [Output only] The number of nodes currently in the cluster. Deprecated. Call Kubernetes API directly to retrieve node information.
   */
  currentNodeCount?: int32;

  /**
   * [Output only] Deprecated, use [NodePools.version](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters.nodePools) instead. The current version of the node software components. If they are currently at multiple versions because they're in the process of being upgraded, this reflects the minimum version of all nodes.
   * @deprecated [Output only] Deprecated, use [NodePools.version](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters.nodePools) instead.
   */
  currentNodeVersion?: string;

  /**
   * Configuration of etcd encryption.
   */
  databaseEncryption?: DatabaseEncryption;

  /**
   * The default constraint on the maximum number of pods that can be run simultaneously on a node in the node pool of this cluster. Only honored if cluster created with IP Alias support.
   */
  defaultMaxPodsConstraint?: MaxPodsConstraint;

  /**
   * An optional description of this cluster.
   */
  description?: string;

  /**
   * Beta APIs Config
   */
  enableK8sBetaApis?: K8sBetaApiConfig;

  /**
   * Kubernetes alpha features are enabled on this cluster. This includes alpha API groups (e.g. v1alpha1) and features that may not be production ready in the kubernetes version of the master and nodes. The cluster has no SLA for uptime and master/node upgrades are disabled. Alpha enabled clusters are automatically deleted thirty days after creation.
   */
  enableKubernetesAlpha?: boolean;

  /**
   * Enable the ability to use Cloud TPUs in this cluster.
   */
  enableTpu?: boolean;

  /**
   * [Output only] The IP address of this cluster's master endpoint. The endpoint can be accessed from the internet at `https://username:password@endpoint/`. See the `masterAuth` property of this resource for username and password information.
   */
  endpoint?: string;

  /**
   * GKE Enterprise Configuration.
   */
  enterpriseConfig?: EnterpriseConfig;

  /**
   * This checksum is computed by the server based on the value of cluster fields, and may be sent on update requests to ensure the client has an up-to-date value before proceeding.
   */
  etag?: string;

  /**
   * [Output only] The time the cluster will be automatically deleted in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
   */
  expireTime?: utcDateTime;

  /**
   * Fleet information for the cluster.
   */
  fleet?: Fleet;

  /**
   * Output only. Unique id for the cluster.
   */
  id?: string;

  /**
   * Configuration for Identity Service component.
   */
  identityServiceConfig?: IdentityServiceConfig;

  /**
   * The initial Kubernetes version for this cluster. Valid versions are those found in validMasterVersions returned by getServerConfig. The version can be upgraded over time; such upgrades are reflected in currentMasterVersion and currentNodeVersion. Users may specify either explicit versions offered by Kubernetes Engine or version aliases, which have the following behavior: - "latest": picks the highest valid Kubernetes version - "1.X": picks the highest valid patch+gke.N patch in the 1.X version - "1.X.Y": picks the highest valid gke.N patch in the 1.X.Y version - "1.X.Y-gke.N": picks an explicit Kubernetes version - "","-": picks the default Kubernetes version
   */
  initialClusterVersion?: string;

  /**
   * The number of nodes to create in this cluster. You must ensure that your Compute Engine [resource quota](https://cloud.google.com/compute/quotas) is sufficient for this number of instances. You must also have available firewall and routes quota. For requests, this field should only be used in lieu of a "node_pool" object, since this configuration (along with the "node_config") will be used to create a "NodePool" object with an auto-generated name. Do not use this and a node_pool at the same time. This field is deprecated, use node_pool.initial_node_count instead.
   * @deprecated The number of nodes to create in this cluster. This field is deprecated, use node_pool.initial_node_count instead.
   */
  initialNodeCount?: int32;

  /**
   * Deprecated. Use node_pools.instance_group_urls.
   * @deprecated Deprecated. Use node_pools.instance_group_urls.
   */
  instanceGroupUrls?: string[];

  /**
   * Configuration for cluster IP allocation.
   */
  ipAllocationPolicy?: IpAllocationPolicy;

  /**
   * The fingerprint of the set of labels for this cluster.
   */
  labelFingerprint?: string;

  /**
   * Configuration for the legacy ABAC authorization mode.
   */
  legacyAbac?: LegacyAbac;

  /**
   * [Output only] The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) or [region](https://cloud.google.com/compute/docs/regions-zones/regions-zones#available) in which the cluster resides.
   */
  location?: string;

  /**
   * The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/zones#available) in which the cluster's nodes should be located. This field provides a default value if [NodePool.Locations](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters.nodePools#NodePool.FIELDS.locations) are not specified during node pool creation. Warning: changing cluster locations will update the [NodePool.Locations](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters.nodePools#NodePool.FIELDS.locations) of all node pools and will result in nodes being added and/or removed.
   */
  locations?: string[];

  /**
   * Logging configuration for the cluster.
   */
  loggingConfig?: LoggingConfig;

  /**
   * The logging service the cluster should use to write logs. Currently available options: * `logging.googleapis.com/kubernetes` - The Cloud Logging service with a Kubernetes-native resource model * `logging.googleapis.com` - The legacy Cloud Logging service (no longer available as of GKE 1.15). * `none` - no logs will be exported from the cluster. If left as an empty string,`logging.googleapis.com/kubernetes` will be used for GKE 1.14+ or `logging.googleapis.com` for earlier versions.
   */
  loggingService?: string;

  /**
   * Configure the maintenance policy for this cluster.
   */
  maintenancePolicy?: MaintenancePolicy;

  /**
   * The authentication information for accessing the master endpoint. If unspecified, the defaults are used: For clusters before v1.12, if master_auth is unspecified, `username` will be set to "admin", a random password will be generated, and a client certificate will be issued.
   */
  masterAuth?: MasterAuth;

  /**
   * The configuration options for master authorized networks feature.
   */
  masterAuthorizedNetworksConfig?: MasterAuthorizedNetworksConfig;

  /**
   * Configuration for issuance of mTLS keys and certificates to Kubernetes pods.
   */
  meshCertificates?: MeshCertificates;

  /**
   * Monitoring configuration for the cluster.
   */
  monitoringConfig?: MonitoringConfig;

  /**
   * The monitoring service the cluster should use to write metrics. Currently available options: * "monitoring.googleapis.com/kubernetes" - The Cloud Monitoring service with a Kubernetes-native resource model * `monitoring.googleapis.com` - The legacy Cloud Monitoring service (no longer available as of GKE 1.15). * `none` - No metrics will be exported from the cluster. If left as an empty string,`monitoring.googleapis.com/kubernetes` will be used for GKE 1.14+ or `monitoring.googleapis.com` for earlier versions.
   */
  monitoringService?: string;

  /**
   * The name of this cluster. The name must be unique within this project and location (e.g. zone or region), and can be up to 40 characters with the following restrictions: * Lowercase letters, numbers, and hyphens only. * Must start with a letter. * Must end with a number or a letter.
   */
  name?: string;

  /**
   * The name of the Google Compute Engine [network](https://cloud.google.com/compute/docs/networks-and-firewalls#networks) to which the cluster is connected. If left unspecified, the `default` network will be used.
   */
  network?: string;

  /**
   * Configuration for cluster networking.
   */
  networkConfig?: NetworkConfig;

  /**
   * Configuration options for the NetworkPolicy feature.
   */
  networkPolicy?: NetworkPolicy;

  /**
   * Parameters used in creating the cluster's nodes. For requests, this field should only be used in lieu of a "node_pool" object, since this configuration (along with the "initial_node_count") will be used to create a "NodePool" object with an auto-generated name. Do not use this and a node_pool at the same time. For responses, this field will be populated with the node configuration of the first node pool. (For configuration of each node pool, see `node_pool.config`) If unspecified, the defaults are used. This field is deprecated, use node_pool.config instead.
   * @deprecated Parameters used in creating the cluster's nodes. This field is deprecated, use node_pool.config instead.
   */
  nodeConfig?: NodeConfig;

  /**
   * [Output only] The size of the address space on each node for hosting containers. This is provisioned from within the `container_ipv4_cidr` range. This field will only be set when cluster is in route-based network mode.
   */
  nodeIpv4CidrSize?: int32;

  /**
   * Node pool configs that apply to all auto-provisioned node pools in autopilot clusters and node auto-provisioning enabled clusters.
   */
  nodePoolAutoConfig?: NodePoolAutoConfig;

  /**
   * Default NodePool settings for the entire cluster. These settings are overridden if specified on the specific NodePool object.
   */
  nodePoolDefaults?: NodePoolDefaults;

  /**
   * The node pools associated with this cluster. This field should not be set if "node_config" or "initial_node_count" are specified.
   */
  nodePools?: NodePool[];

  /**
   * Notification configuration of the cluster.
   */
  notificationConfig?: NotificationConfig;

  /**
   * The configuration of the parent product of the cluster. This field is used by Google internal products that are built on top of the GKE cluster and take the ownership of the cluster.
   */
  parentProductConfig?: ParentProductConfig;

  /**
   * Configuration for private cluster.
   */
  privateClusterConfig?: PrivateClusterConfig;

  /**
   * Release channel configuration. If left unspecified on cluster creation and a version is specified, the cluster is enrolled in the most mature release channel where the version is available (first checking STABLE, then REGULAR, and finally RAPID). Otherwise, if no release channel configuration and no version is specified, the cluster is enrolled in the REGULAR channel with its default version.
   */
  releaseChannel?: ReleaseChannel;

  /**
   * The resource labels for the cluster to use to annotate any related Google Compute Engine resources.
   */
  resourceLabels?: Record<string>;

  /**
   * Configuration for exporting resource usages. Resource usage export is disabled when this config is unspecified.
   */
  resourceUsageExportConfig?: ResourceUsageExportConfig;

  /**
   * Enable/Disable Security Posture API features for the cluster.
   */
  securityPostureConfig?: SecurityPostureConfig;

  /**
   * [Output only] Server-defined URL for the resource.
   */
  selfLink?: string;

  /**
   * [Output only] The IP address range of the Kubernetes services in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `1.2.3.4/29`). Service addresses are typically put in the last `/16` from the container CIDR.
   */
  servicesIpv4Cidr?: string;

  /**
   * Shielded Nodes configuration.
   */
  shieldedNodes?: ShieldedNodes;

  /**
   * [Output only] The current status of this cluster.
   */
  status?: ClusterStatus;

  /**
   * [Output only] Deprecated. Use conditions instead. Additional information about the current status of this cluster, if available.
   * @deprecated [Output only] Deprecated. Use conditions instead.
   */
  statusMessage?: string;

  /**
   * The name of the Google Compute Engine [subnetwork](https://cloud.google.com/compute/docs/subnetworks) to which the cluster is connected.
   */
  subnetwork?: string;

  /**
   * [Output only] The IP address range of the Cloud TPUs in this cluster, in [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `1.2.3.4/29`).
   */
  tpuIpv4CidrBlock?: string;

  /**
   * Cluster-level Vertical Pod Autoscaling configuration.
   */
  verticalPodAutoscaling?: VerticalPodAutoscaling;

  /**
   * Configuration for the use of Kubernetes Service Accounts in GCP IAM policies.
   */
  workloadIdentityConfig?: WorkloadIdentityConfig;

  /**
   * [Output only] The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster resides. This field is deprecated, use location instead.
   * @deprecated [Output only] The name of the Google Compute Engine [zone](https://cloud.google.com/compute/docs/zones#available) in which the cluster resides. This field is deprecated, use location instead.
   */
  zone?: string;
}

/**
 * Cluster status options.
 */
union ClusterStatus {
  string,

  /** Status is unspecified */
  STATUS_UNSPECIFIED: "STATUS_UNSPECIFIED",

  /** The cluster is being provisioned */
  PROVISIONING: "PROVISIONING",

  /** The cluster is running */
  RUNNING: "RUNNING",

  /** The cluster is being reconciled */
  RECONCILING: "RECONCILING",

  /** The cluster is stopping */
  STOPPING: "STOPPING",

  /** There was an error */
  ERROR: "ERROR",

  /** The cluster is degraded */
  DEGRADED: "DEGRADED",
}

/**
 * Parameters that describe the nodes in a cluster. GKE Autopilot clusters do not recognize parameters in `NodeConfig`. Use AutoprovisioningNodePoolDefaults instead.
 */
model NodeConfig {
  /**
   * A list of hardware accelerators to be attached to each node. See https://cloud.google.com/compute/docs/gpus for more information about support for GPUs.
   */
  @extension("x-ms-identifiers", #[])
  accelerators?: AcceleratorConfig[];

  /**
   * Advanced features for the Compute Engine VM.
   */
  advancedMachineFeatures?: AdvancedMachineFeatures;

  /**
   * The Customer Managed Encryption Key used to encrypt the boot disk attached to each node in the node pool. This should be of the form projects/[KEY_PROJECT_ID]/locations/[LOCATION]/keyRings/[RING_NAME]/cryptoKeys/[KEY_NAME]. For more information about protecting resources with Cloud KMS Keys please see: https://cloud.google.com/compute/docs/disks/customer-managed-encryption
   */
  bootDiskKmsKey?: string;

  /**
   * Confidential nodes config. All the nodes in the node pool will be Confidential VM once enabled.
   */
  confidentialNodes?: ConfidentialNodes;

  /**
   * Size of the disk attached to each node, specified in GB. The smallest allowed disk size is 10GB. If unspecified, the default disk size is 100GB.
   */
  diskSizeGb?: int32;

  /**
   * Type of the disk attached to each node (e.g. 'pd-standard', 'pd-ssd' or 'pd-balanced') If unspecified, the default disk type is 'pd-standard'
   */
  diskType?: string;

  /**
   * Optional. Reserved for future use.
   */
  enableConfidentialStorage?: boolean;

  /**
   * Parameters for the node ephemeral storage using Local SSDs. If unspecified, ephemeral storage is backed by the boot disk.
   */
  ephemeralStorageLocalSsdConfig?: EphemeralStorageLocalSsdConfig;

  /**
   * Enable or disable NCCL fast socket for the node pool.
   */
  fastSocket?: FastSocket;

  /**
   * Google Container File System (image streaming) configs.
   */
  gcfsConfig?: GcfsConfig;

  /**
   * Enable or disable gvnic in the node pool.
   */
  gvnic?: VirtualNic;

  /**
   * The image type to use for this node. Note that for a given image type, the latest version of it will be used. Please see https://cloud.google.com/kubernetes-engine/docs/concepts/node-images for available image types.
   */
  imageType?: string;

  /**
   * Node kubelet configs.
   */
  kubeletConfig?: NodeKubeletConfig;

  /**
   * The map of Kubernetes labels (key/value pairs) to be applied to each node. These will added in addition to any default label(s) that Kubernetes may apply to the node. In case of conflict in label keys, the applied set may differ depending on the Kubernetes version -- it's best to assume the behavior is undefined and conflicts should be avoided. For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  labels?: Record<string>;

  /**
   * Parameters that can be configured on Linux nodes.
   */
  linuxNodeConfig?: LinuxNodeConfig;

  /**
   * Parameters for using raw-block Local NVMe SSDs.
   */
  localNvmeSsdBlockConfig?: LocalNvmeSsdBlockConfig;

  /**
   * The number of local SSD disks to be attached to the node. The limit for this value is dependent upon the maximum number of disks available on a machine per zone. See: https://cloud.google.com/compute/docs/disks/local-ssd for more information.
   */
  localSsdCount?: int32;

  /**
   * Logging configuration.
   */
  loggingConfig?: NodePoolLoggingConfig;

  /**
   * The name of a Google Compute Engine [machine type](https://cloud.google.com/compute/docs/machine-types) If unspecified, the default machine type is `e2-medium`.
   */
  machineType?: string;

  /**
   * The metadata key/value pairs assigned to instances in the cluster. Keys must conform to the regexp `[a-zA-Z0-9-_]+` and be less than 128 bytes in length. These are reflected as part of a URL in the metadata server. Additionally, to avoid ambiguity, keys must not conflict with any other metadata keys for the project or be one of the reserved keys: - \"cluster-location\" - \"cluster-name\" - \"cluster-uid\" - \"configure-sh\" - \"containerd-configure-sh\" - \"enable-os-login\" - \"gci-ensure-gke-docker\" - \"gci-metrics-enabled\" - \"gci-update-strategy\" - \"instance-template\" - \"kube-env\" - \"startup-script\" - \"user-data\" - \"disable-address-manager\" - \"windows-startup-script-ps1\" - \"common-psm1\" - \"k8s-node-setup-psm1\" - \"install-ssh-psm1\" - \"user-profile-psm1\" Values are free-form strings, and only have meaning as interpreted by the image running in the instance. The only restriction placed on them is that each value's size must be less than or equal to 32 KB. The total size of all keys and values must be less than 512 KB.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  metadata?: Record<string>;

  /**
   * Minimum CPU platform to be used by this instance. The instance may be scheduled on the specified or newer CPU platform. Applicable values are the friendly names of CPU platforms, such as `minCpuPlatform: "Intel Haswell"` or `minCpuPlatform: "Intel Sandy Bridge"`. For more information, read [how to specify min CPU platform](https://cloud.google.com/compute/docs/instances/specify-min-cpu-platform)
   */
  minCpuPlatform?: string;

  /**
   * Setting this field will assign instances of this pool to run on the specified node group. This is useful for running workloads on [sole tenant nodes](https://cloud.google.com/compute/docs/nodes/sole-tenant-nodes).
   */
  nodeGroup?: string;

  /**
   * The set of Google API scopes to be made available on all of the node VMs under the "default" service account. The following scopes are recommended, but not required, and by default are not included: * `https://www.googleapis.com/auth/compute` is required for mounting persistent storage on your nodes. * `https://www.googleapis.com/auth/devstorage.read_only` is required for communicating with **gcr.io** (the [Google Container Registry](https://cloud.google.com/container-registry/)). If unspecified, no scopes are added, unless Cloud Logging or Cloud Monitoring are enabled, in which case their required scopes will be added.
   */
  oauthScopes?: string[];

  /**
   * Whether the nodes are created as preemptible VM instances. See: https://cloud.google.com/compute/docs/instances/preemptible for more information about preemptible VM instances.
   */
  preemptible?: boolean;

  /**
   * The optional reservation affinity. Setting this field will apply the specified [Zonal Compute Reservation](https://cloud.google.com/compute/docs/instances/reserving-zonal-resources) to this node pool.
   */
  reservationAffinity?: ReservationAffinity;

  /**
   * The resource labels for the node pool to use to annotate any related Google Compute Engine resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  resourceLabels?: Record<string>;

  /**
   * A map of resource manager tag keys and values to be attached to the nodes.
   */
  resourceManagerTags?: ResourceManagerTags;

  /**
   * Sandbox configuration for this node.
   */
  sandboxConfig?: SandboxConfig;

  /**
   * List of secondary boot disks attached to the nodes.
   */
  @extension("x-ms-identifiers", #[])
  secondaryBootDisks?: SecondaryBootDisk[];

  /**
   * The Google Cloud Platform Service Account to be used by the node VMs. Specify the email address of the Service Account; otherwise, if no Service Account is specified, the "default" service account is used.
   */
  serviceAccount?: string;

  /**
   * Shielded Instance options.
   */
  shieldedInstanceConfig?: ShieldedInstanceConfig;

  /**
   * Parameters for node pools to be backed by shared sole tenant node groups.
   */
  soleTenantConfig?: SoleTenantConfig;

  /**
   * Spot flag for enabling Spot VM, which is a rebrand of the existing preemptible flag.
   */
  spot?: boolean;

  /**
   * The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster or node pool creation. Each tag within the list must comply with RFC1035.
   */
  tags?: string[];

  /**
   * List of kubernetes taints to be applied to each node. For more information, including usage and the valid values, see: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
   */
  @extension("x-ms-identifiers", #[])
  taints?: NodeTaint[];

  /**
   * Parameters that can be configured on Windows nodes.
   */
  windowsNodeConfig?: WindowsNodeConfig;

  /**
   * The workload metadata configuration for this node.
   */
  workloadMetadataConfig?: WorkloadMetadataConfig;
}

/**
 * NodePool contains the name and configuration for a cluster's node pool. Node pools are a set of nodes (i.e. VM's), with a common configuration and specification, under the control of the cluster master. They may have a set of Kubernetes labels applied to them, which may be used to reference them during pod scheduling. They may also be resized up or down, to accommodate the workload.
 */
model NodePool {
  /**
   * Autoscaler configuration for this NodePool. Autoscaler is enabled only if a valid configuration is present.
   */
  autoscaling?: NodePoolAutoscaling;

  /**
   * Enable best effort provisioning for nodes
   */
  bestEffortProvisioning?: BestEffortProvisioning;

  /**
   * Which conditions caused the current node pool state.
   */
  @extension("x-ms-identifiers", #[])
  conditions?: StatusCondition[];

  /**
   * The node configuration of the pool.
   */
  config?: NodeConfig;

  /**
   * This checksum is computed by the server based on the value of node pool fields, and may be sent on update requests to ensure the client has an up-to-date value before proceeding.
   */
  etag?: string;

  /**
   * The initial node count for the pool. You must ensure that your Compute Engine [resource quota](https://cloud.google.com/compute/quotas) is sufficient for this number of instances. You must also have available firewall and routes quota.
   */
  initialNodeCount?: int32;

  /**
   * [Output only] The resource URLs of the [managed instance groups](https://cloud.google.com/compute/docs/instance-groups/creating-groups-of-managed-instances) associated with this node pool. During the node pool blue-green upgrade operation, the URLs contain both blue and green resources.
   */
  instanceGroupUrls?: string[];

  /**
   * The list of Google Compute Engine [zones](https://cloud.google.com/compute/docs/zones#available) in which the NodePool's nodes should be located. If this value is unspecified during node pool creation, the [Cluster.Locations](https://cloud.google.com/kubernetes-engine/docs/reference/rest/v1/projects.locations.clusters#Cluster.FIELDS.locations) value will be used, instead. Warning: changing node pool locations will result in nodes being added and/or removed.
   */
  locations?: string[];

  /**
   * NodeManagement configuration for this NodePool.
   */
  management?: NodeManagement;

  /**
   * The constraint on the maximum number of pods that can be run simultaneously on a node in the node pool.
   */
  maxPodsConstraint?: MaxPodsConstraint;

  /**
   * The name of the node pool.
   */
  name?: string;

  /**
   * Networking configuration for this NodePool. If specified, it overrides the cluster-level defaults.
   */
  networkConfig?: NodeNetworkConfig;

  /**
   * Specifies the node placement policy.
   */
  placementPolicy?: PlacementPolicy;

  /**
   * [Output only] The pod CIDR block size per node in this node pool.
   */
  podIpv4CidrSize?: int32;

  /**
   * Specifies the configuration of queued provisioning.
   */
  queuedProvisioning?: QueuedProvisioning;

  /**
   * [Output only] Server-defined URL for the resource.
   */
  selfLink?: string;

  /**
   * [Output only] The status of the nodes in this pool instance.
   */
  status?: NodePoolStatus;

  /**
   * [Output only] Deprecated. Use conditions instead. Additional information about the current status of this node pool instance, if available.
   * @deprecated Use conditions instead
   */
  statusMessage?: string;

  /**
   * Output only. [Output only] Update info contains relevant information during a node pool update.
   */
  updateInfo?: UpdateInfo;

  /**
   * Upgrade settings control disruption and speed of the upgrade.
   */
  upgradeSettings?: UpgradeSettings;

  /**
   * The version of Kubernetes running on this NodePool's nodes. If unspecified, it defaults as described [here](https://cloud.google.com/kubernetes-engine/versioning#specifying_node_version).
   */
  version?: string;
}

/**
 * Network configuration for node pools.
 */
model NodeNetworkConfig {
  /**
   * Whether to create a pod range for this node pool.
   */
  createPodRange?: boolean;

  /**
   * The ID of the secondary range for pod IPs.
   */
  podRange?: string;

  /**
   * The IP address range for pods in this node pool.
   */
  podIpv4CidrBlock?: string;

  /**
   * Configuration of additional node network interfaces.
   */
  @extension("x-ms-identifiers", #[])
  additionalNodeNetworkConfigs?: AdditionalNodeNetworkConfig[];

  /**
   * Configuration of additional pod network interfaces.
   */
  @extension("x-ms-identifiers", #[])
  additionalPodNetworkConfigs?: AdditionalPodNetworkConfig[];

  /**
   * List of pod CIDR ranges to be used for the node pool.
   */
  podCidrOverprovisionConfig?: PodCidrOverprovisionConfig;

  /**
   * Whether to enable private nodes.
   */
  enablePrivateNodes?: boolean;
}

/**
 * Configuration for additional node network interfaces.
 */
model AdditionalNodeNetworkConfig {
  /**
   * Name of the VPC where the additional interface belongs.
   */
  network?: string;

  /**
   * Name of the subnetwork where the additional interface belongs.
   */
  subnetwork?: string;
}

/**
 * Configuration for additional pod network interfaces.
 */
model AdditionalPodNetworkConfig {
  /**
   * Name of the subnetwork where the additional pod network belongs.
   */
  subnetwork?: string;

  /**
   * Name of the secondary range on the subnetwork.
   */
  secondaryPodRange?: string;

  /**
   * The maximum number of pods per node which use this pod network.
   */
  maxPodsPerNode?: MaxPodsConstraint;
}

/**
 * Configuration for pod CIDR overprovision.
 */
model PodCidrOverprovisionConfig {
  /**
   * Whether to disable pod CIDR overprovision.
   */
  disable?: boolean;
}

/**
 * Node pool status options.
 */
union NodePoolStatus {
  string,

  /** Status is unknown */
  STATUS_UNSPECIFIED: "STATUS_UNSPECIFIED",

  /** The node pool is being provisioned */
  PROVISIONING: "PROVISIONING",

  /** The node pool is running */
  RUNNING: "RUNNING",

  /** The node pool is running with error */
  RUNNING_WITH_ERROR: "RUNNING_WITH_ERROR",

  /** The node pool is being reconciled */
  RECONCILING: "RECONCILING",

  /** The node pool is stopping */
  STOPPING: "STOPPING",

  /** There was an error */
  ERROR: "ERROR",
}

/**
 * Upgrade settings control disruption and speed of the upgrade.
 */
model UpgradeSettings {
  /**
   * The maximum number of nodes that can be created beyond the current size of the node pool during the upgrade process.
   */
  maxSurge?: int32;

  /**
   * The maximum number of nodes that can be simultaneously unavailable during the upgrade process.
   */
  maxUnavailable?: int32;

  /**
   * Update strategy of the node pool.
   */
  strategy?: UpgradeStrategy;

  /**
   * Settings for blue-green upgrade.
   */
  blueGreenSettings?: BlueGreenSettings;
}

/**
 * Upgrade strategy options.
 */
union UpgradeStrategy {
  string,

  /** Strategy is unspecified */
  NODE_POOL_UPDATE_STRATEGY_UNSPECIFIED: "NODE_POOL_UPDATE_STRATEGY_UNSPECIFIED",

  /** Use surge upgrade */
  SURGE: "SURGE",

  /** Use blue-green upgrade */
  BLUE_GREEN: "BLUE_GREEN",
}

/**
 * Settings for blue-green upgrade strategy.
 */
model BlueGreenSettings {
  /**
   * Time needed after draining entire blue pool. After this period, blue pool will be cleaned up.
   */
  nodePoolSoakDuration?: string;

  /**
   * Standard policy for the blue-green upgrade.
   */
  standardRolloutPolicy?: StandardRolloutPolicy;
}

/**
 * Standard rollout policy for blue-green upgrades.
 */
model StandardRolloutPolicy {
  /**
   * Number of blue nodes to drain in a batch.
   */
  batchNodeCount?: int32;

  /**
   * Percentage of the blue pool nodes to drain in a batch.
   */
  batchPercentage?: float32;

  /**
   * Soak time after each batch gets drained.
   */
  batchSoakDuration?: string;
}

/**
 * Specifies the node placement policy.
 */
model PlacementPolicy {
  /**
   * The type of placement.
   */
  type?: PlacementType;

  /**
   * TPU placement topology for pod slice node pool.
   */
  tpuTopology?: string;

  /**
   * If set, refers to the name of a custom resource policy supplied by the user.
   */
  policyName?: string;
}

/**
 * Placement type options.
 */
union PlacementType {
  string,

  /** Placement type is unspecified */
  TYPE_UNSPECIFIED: "TYPE_UNSPECIFIED",

  /** Compact placement */
  COMPACT: "COMPACT",
}

/**
 * Information about the current update.
 */
model UpdateInfo {
  /**
   * Information about a blue-green upgrade.
   */
  blueGreenInfo?: BlueGreenInfo;
}

/**
 * Information about a blue-green upgrade.
 */
model BlueGreenInfo {
  /**
   * Current blue-green upgrade phase.
   */
  phase?: BlueGreenPhase;

  /**
   * The resource URLs of the managed instance groups associated with blue pool.
   */
  blueInstanceGroupUrls?: string[];

  /**
   * The resource URLs of the managed instance groups associated with green pool.
   */
  greenInstanceGroupUrls?: string[];

  /**
   * Time to start deleting blue pool to complete blue-green upgrade.
   */
  bluePoolDeletionStartTime?: string;

  /**
   * The resource name of the green pool.
   */
  greenPoolVersion?: string;
}

/**
 * Blue-green upgrade phase options.
 */
union BlueGreenPhase {
  string,

  /** Phase is unspecified */
  PHASE_UNSPECIFIED: "PHASE_UNSPECIFIED",

  /** Update has started */
  UPDATE_STARTED: "UPDATE_STARTED",

  /** Green pool has been created */
  CREATING_GREEN_POOL: "CREATING_GREEN_POOL",

  /** Cordoning blue pool */
  CORDONING_BLUE_POOL: "CORDONING_BLUE_POOL",

  /** Draining blue pool */
  DRAINING_BLUE_POOL: "DRAINING_BLUE_POOL",

  /** Node pool soaking */
  NODE_POOL_SOAKING: "NODE_POOL_SOAKING",

  /** Deleting blue pool */
  DELETING_BLUE_POOL: "DELETING_BLUE_POOL",

  /** Rolling back blue-green upgrade */
  ROLLBACK_STARTED: "ROLLBACK_STARTED",
}

/**
 * Specifies the configuration of queued provisioning.
 */
model QueuedProvisioning {
  /**
   * Denotes that this nodepool is QRM specific.
   */
  enabled?: boolean;
}

/**
 * Specifies the configuration of best effort provisioning.
 */
model BestEffortProvisioning {
  /**
   * When this is enabled, cluster/node pool creations will ignore non-fatal errors like stockout to best provision as many nodes as possible.
   */
  enabled?: boolean;

  /**
   * Minimum number of nodes to be provisioned.
   */
  minProvisionNodes?: int32;
}

/**
 * NodePoolAutoscaling contains information required by cluster autoscaler to adjust the size of the node pool to the current cluster usage.
 */
model NodePoolAutoscaling {
  /**
   * Can this node pool be deleted automatically.
   */
  autoprovisioned?: boolean;

  /**
   * Is autoscaling enabled for this node pool.
   */
  enabled?: boolean;

  /**
   * Location policy used when scaling up a nodepool.
   */
  locationPolicy?: LocationPolicy;

  /**
   * Maximum number of nodes for one location in the NodePool. Must be >= min_node_count. There has to be enough quota to scale up the cluster.
   */
  maxNodeCount?: int32;

  /**
   * Minimum number of nodes for one location in the NodePool. Must be >= 1 and <= max_node_count.
   */
  minNodeCount?: int32;

  /**
   * Maximum number of nodes in the node pool. Must be greater than total_min_node_count. There has to be enough quota to scale up the cluster. The total_*_node_count fields are mutually exclusive with the *_node_count fields.
   */
  totalMaxNodeCount?: int32;

  /**
   * Minimum number of nodes in the node pool. Must be greater than 1 less than total_max_node_count. The total_*_node_count fields are mutually exclusive with the *_node_count fields.
   */
  totalMinNodeCount?: int32;
}

/**
 * Location policy options used when scaling up a nodepool.
 */
union LocationPolicy {
  string,

  /** Location policy is unspecified */
  LOCATION_POLICY_UNSPECIFIED: "LOCATION_POLICY_UNSPECIFIED",

  /** Balanced location policy */
  BALANCED: "BALANCED",

  /** Any location policy */
  ANY: "ANY",
}

/**
 * NodeManagement defines the set of node management services turned on for the node pool.
 */
model NodeManagement {
  /**
   * A flag that specifies whether node auto-upgrade is enabled.
   */
  autoUpgrade?: boolean;

  /**
   * A flag that specifies whether the node auto-repair is enabled.
   */
  autoRepair?: boolean;
}

/**
 * The authentication information for accessing the master endpoint.
 */
model MasterAuth {
  /**
   * The username to use for HTTP basic authentication.
   */
  username?: string;

  /**
   * The password to use for HTTP basic authentication.
   */
  password?: string;

  /**
   * Configuration for client certificate authentication on the cluster.
   */
  clientCertificateConfig?: ClientCertificateConfig;

  /**
   * Base64-encoded public certificate used as the root of trust for the cluster.
   */
  clusterCaCertificate?: string;

  /**
   * Base64-encoded public certificate used by clients to authenticate to the cluster endpoint. Issued only if clientCertificateConfig is set.
   */
  clientCertificate?: string;

  /**
   * Base64-encoded private key used by clients to authenticate to the cluster endpoint.
   */
  clientKey?: string;
}

/**
 * Configuration for client certificate authentication on the cluster.
 */
model ClientCertificateConfig {
  /**
   * Issue a client certificate.
   */
  issueClientCertificate?: boolean;
}

/**
 * This operation resource represents operations that may have happened or are happening on the cluster.
 */
model Operation {
  /**
   * The server-assigned ID for the operation.
   */
  name?: string;

  /**
   * The name of the Google Compute Engine zone in which the operation resides.
   */
  zone?: string;

  /**
   * The operation type.
   */
  operationType?: string;

  /**
   * The current status of the operation.
   */
  status?:
    | "STATUS_UNSPECIFIED"
    | "PENDING"
    | "RUNNING"
    | "DONE"
    | "ABORTING"
    | string;

  /**
   * Detailed operation progress, if available.
   */
  detail?: string;

  /**
   * If an error has occurred, a textual description of the error.
   */
  statusMessage?: string;

  /**
   * Server-defined URL for the target of the operation.
   */
  targetLink?: string;

  /**
   * The name of the Google Compute Engine zone or region in which the cluster resides.
   */
  location?: string;
}

/**
 * Configuration for the addons that can be automatically enabled
 */
model AddonsConfig {
  /**
   * Configuration for the HTTP Load Balancing addon
   */
  httpLoadBalancing?: HttpLoadBalancing;

  /**
   * Configuration for the Horizontal Pod Autoscaling addon
   */
  horizontalPodAutoscaling?: HorizontalPodAutoscaling;

  /**
   * Configuration for the Kubernetes Dashboard addon
   */
  kubernetesDashboard?: KubernetesDashboard;

  /**
   * Configuration for the Network Policy addon
   */
  networkPolicyConfig?: NetworkPolicyConfig;

  /**
   * Configuration for the Cloud Run addon
   */
  cloudRunConfig?: CloudRunConfig;

  /**
   * Configuration for the DNS Cache addon
   */
  dnsCacheConfig?: DnsCacheConfig;

  /**
   * Configuration for the Config Connector addon
   */
  configConnectorConfig?: ConfigConnectorConfig;

  /**
   * Configuration for the GCE Persistent Disk CSI Driver addon
   */
  gcePersistentDiskCsiDriverConfig?: GcePersistentDiskCsiDriverConfig;

  /**
   * Configuration for the GCP Filestore CSI Driver addon
   */
  gcpFilestoreCsiDriverConfig?: GcpFilestoreCsiDriverConfig;

  /**
   * Configuration for the GKE Backup Agent addon
   */
  gkeBackupAgentConfig?: GkeBackupAgentConfig;

  /**
   * Configuration for the GCS Fuse CSI Driver addon
   */
  gcsFuseCsiDriverConfig?: GcsFuseCsiDriverConfig;

  /**
   * Configuration for the Stateful HA addon
   */
  statefulHaConfig?: StatefulHaConfig;

  /**
   * Configuration for the Parallelstore CSI Driver addon
   */
  parallelstoreCsiDriverConfig?: ParallelstoreCsiDriverConfig;

  /**
   * Configuration for the Ray Operator addon
   */
  rayOperatorConfig?: RayOperatorConfig;

  /**
   * Configuration for the High Scale Checkpointing addon
   */
  highScaleCheckpointingConfig?: HighScaleCheckpointingConfig;

  /**
   * Configuration for the Lustre CSI Driver addon
   */
  lustreCsiDriverConfig?: LustreCsiDriverConfig;
}

/**
 * Configuration for the HTTP Load Balancing addon
 */
model HttpLoadBalancing {
  /**
   * Whether the HTTP Load Balancing addon is disabled
   */
  disabled?: boolean;
}

/**
 * Configuration for the Horizontal Pod Autoscaling addon
 */
model HorizontalPodAutoscaling {
  /**
   * Whether the Horizontal Pod Autoscaling addon is disabled
   */
  disabled?: boolean;
}

/**
 * Configuration for the Kubernetes Dashboard addon
 */
model KubernetesDashboard {
  /**
   * Whether the Kubernetes Dashboard addon is disabled
   */
  disabled?: boolean;
}

/**
 * Configuration for the Network Policy addon
 */
model NetworkPolicyConfig {
  /**
   * Whether the Network Policy addon is disabled
   */
  disabled?: boolean;
}

/**
 * Configuration for the Cloud Run addon
 */
model CloudRunConfig {
  /**
   * Whether the Cloud Run addon is disabled
   */
  disabled?: boolean;

  /**
   * The load balancer type for Cloud Run
   */
  loadBalancerType?: CloudRunLoadBalancerType;
}

/**
 * Configuration for the DNS Cache addon
 */
model DnsCacheConfig {
  /**
   * Whether the DNS Cache addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the Config Connector addon
 */
model ConfigConnectorConfig {
  /**
   * Whether the Config Connector addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the GCE Persistent Disk CSI Driver addon
 */
model GcePersistentDiskCsiDriverConfig {
  /**
   * Whether the GCE Persistent Disk CSI Driver addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the GCP Filestore CSI Driver addon
 */
model GcpFilestoreCsiDriverConfig {
  /**
   * Whether the GCP Filestore CSI Driver addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the GKE Backup Agent addon
 */
model GkeBackupAgentConfig {
  /**
   * Whether the GKE Backup Agent addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the GCS Fuse CSI Driver addon
 */
model GcsFuseCsiDriverConfig {
  /**
   * Whether the GCS Fuse CSI Driver addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the Stateful HA addon
 */
model StatefulHaConfig {
  /**
   * Whether the Stateful HA addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the Parallelstore CSI Driver addon
 */
model ParallelstoreCsiDriverConfig {
  /**
   * Whether the Parallelstore CSI Driver addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the Ray Operator addon
 */
model RayOperatorConfig {
  /**
   * Whether the Ray Operator addon is enabled
   */
  enabled?: boolean;

  /**
   * Configuration for Ray logging
   */
  rayClusterLoggingConfig?: RayClusterLoggingConfig;

  /**
   * Configuration for Ray monitoring
   */
  rayClusterMonitoringConfig?: RayClusterMonitoringConfig;
}

/**
 * Configuration for the High Scale Checkpointing addon
 */
model HighScaleCheckpointingConfig {
  /**
   * Whether the High Scale Checkpointing addon is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the Lustre CSI Driver addon
 */
model LustreCsiDriverConfig {
  /**
   * Whether the Lustre CSI Driver addon is enabled
   */
  enabled?: boolean;
}

/**
 * Load balancer type options for Cloud Run
 */
union CloudRunLoadBalancerType {
  string,

  /** External load balancer */
  EXTERNAL: "EXTERNAL",

  /** Internal load balancer */
  INTERNAL: "INTERNAL",
}

/**
 * Configuration for Ray cluster logging
 */
model RayClusterLoggingConfig {
  /**
   * Whether Ray cluster logging is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for Ray cluster monitoring
 */
model RayClusterMonitoringConfig {
  /**
   * Whether Ray cluster monitoring is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for the legacy Attribute Based Access Control authorization mode
 */
model LegacyAbac {
  /**
   * Whether the Legacy Authorization mode is enabled
   */
  enabled?: boolean;

  /**
   * The provider of the legacy ABAC authorization mode
   */
  provider?: string;
}

/**
 * Configuration options for the NetworkPolicy feature
 */
model NetworkPolicy {
  /**
   * Whether network policy is enabled on the cluster
   */
  enabled?: boolean;

  /**
   * The selected network policy provider
   */
  provider?: string;
}

/**
 * Configuration for controlling how IPs are allocated in the cluster.
 */
model IpAllocationPolicy {
  /**
   * Output only. [Output only] The additional pod ranges that are added to the cluster. These pod ranges can be used by new node pools to allocate pod IPs automatically. Once the range is removed it will not show up in IPAllocationPolicy.
   */
  additionalPodRangesConfig?: AdditionalPodRangesConfig;

  /**
   * This field is deprecated, use cluster_ipv4_cidr_block.
   * @deprecated This field is deprecated, use cluster_ipv4_cidr_block.
   */
  clusterIpv4Cidr?: string;

  /**
   * The IP address range for the cluster pod IPs. If this field is set, then `cluster.cluster_ipv4_cidr` must be left blank. This field is only applicable when `use_ip_aliases` is true. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
   */
  clusterIpv4CidrBlock?: string;

  /**
   * The name of the secondary range to be used for the cluster CIDR block. The secondary range will be used for pod IP addresses. This must be an existing secondary range associated with the cluster subnetwork. This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
   */
  clusterSecondaryRangeName?: string;

  /**
   * Whether a new subnetwork will be created automatically for the cluster. This field is only applicable when `use_ip_aliases` is true.
   */
  createSubnetwork?: boolean;

  /**
   * Output only. [Output only] The utilization of the cluster default IPv4 range for the pod. The ratio is Usage/[Total number of IPs in the secondary range], Usage=numNodes*numZones*podIPsPerNode.
   */
  defaultPodIpv4RangeUtilization?: float64;

  /**
   * The ipv6 access type (internal or external) when create_subnetwork is true
   */
  ipv6AccessType?: IPv6AccessType;

  /**
   * This field is deprecated, use node_ipv4_cidr_block.
   * @deprecated This field is deprecated, use node_ipv4_cidr_block.
   */
  nodeIpv4Cidr?: string;

  /**
   * The IP address range of the instance IPs in this cluster. This is applicable only if `create_subnetwork` is true. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
   */
  nodeIpv4CidrBlock?: string;

  /**
   * [PRIVATE FIELD] Pod CIDR size overprovisioning config for the cluster. Pod CIDR size per node depends on max_pods_per_node. By default, the value of max_pods_per_node is doubled and then rounded off to next power of 2 to get the size of pod CIDR block per node. Example: max_pods_per_node of 30 would result in 64 IPs (/26). This config can disable the doubling of IPs (we still round off to next power of 2) Example: max_pods_per_node of 30 will result in 32 IPs (/27) when overprovisioning is disabled.
   */
  podCidrOverprovisionConfig?: PodCidrOverprovisionConfig;

  /**
   * This field is deprecated, use services_ipv4_cidr_block.
   * @deprecated This field is deprecated, use services_ipv4_cidr_block.
   */
  servicesIpv4Cidr?: string;

  /**
   * The IP address range of the services IPs in this cluster. If blank, a range will be automatically chosen with the default size. This field is only applicable when `use_ip_aliases` is true. Set to blank to have a range chosen with the default size. Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
   */
  servicesIpv4CidrBlock?: string;

  /**
   * Output only. [Output only] The services IPv6 CIDR block for the cluster.
   */
  servicesIpv6CidrBlock?: string;

  /**
   * The name of the secondary range to be used as for the services CIDR block. The secondary range will be used for service ClusterIPs. This must be an existing secondary range associated with the cluster subnetwork. This field is only applicable with use_ip_aliases is true and create_subnetwork is false.
   */
  servicesSecondaryRangeName?: string;

  /**
   * The IP stack type of the cluster
   */
  stackType?: StackType;

  /**
   * Output only. [Output only] The subnet's IPv6 CIDR block used by nodes and pods.
   */
  subnetIpv6CidrBlock?: string;

  /**
   * A custom subnetwork name to be used if `create_subnetwork` is true. If this field is empty, then an automatic name will be chosen for the new subnetwork.
   */
  subnetworkName?: string;

  /**
   * The IP address range of the Cloud TPUs in this cluster. If unspecified, a range will be automatically chosen with the default size. This field is only applicable when `use_ip_aliases` is true. If unspecified, the range will use the default size. Set to /netmask (e.g. `/14`) to have a range chosen with a specific netmask. Set to a [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) notation (e.g. `10.96.0.0/14`) from the RFC-1918 private networks (e.g. `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`) to pick a specific range to use.
   */
  tpuIpv4CidrBlock?: string;

  /**
   * Whether alias IPs will be used for pod IPs in the cluster. This is used in conjunction with use_routes. It cannot be true if use_routes is true. If both use_ip_aliases and use_routes are false, then the server picks the default IP allocation mode
   */
  useIpAliases?: boolean;

  /**
   * Whether routes will be used for pod IPs in the cluster. This is used in conjunction with use_ip_aliases. It cannot be true if use_ip_aliases is true. If both use_ip_aliases and use_routes are false, then the server picks the default IP allocation mode
   */
  useRoutes?: boolean;
}

/**
 * IP stack type options for the cluster
 */
union StackType {
  string,

  /** Stack type is unspecified */
  STACK_TYPE_UNSPECIFIED: "STACK_TYPE_UNSPECIFIED",

  /** IPv4 only */
  IPV4: "IPV4",

  /** IPv4/IPv6 dual stack */
  IPV4_IPV6: "IPV4_IPV6",
}

/**
 * IPv6 access type options for the cluster
 */
union IPv6AccessType {
  string,

  /** IPv6 access type is unspecified */
  IPV6_ACCESS_TYPE_UNSPECIFIED: "IPV6_ACCESS_TYPE_UNSPECIFIED",

  /** IPv6 access is internal only */
  INTERNAL: "INTERNAL",

  /** IPv6 access is external */
  EXTERNAL: "EXTERNAL",
}

/**
 * AdditionalPodRangesConfig is the configuration for additional pod secondary ranges supporting the ClusterUpdate message.
 */
model AdditionalPodRangesConfig {
  /**
   * Output only. [Output only] Information for additional pod range.
   */
  @extension("x-ms-identifiers", #[])
  podRangeInfo?: RangeInfo[];

  /**
   * Name for pod secondary ipv4 range which has the actual range defined ahead.
   */
  podRangeNames?: string[];
}

/**
 * Information for additional pod range.
 */
model RangeInfo {
  /**
   * The name of the range.
   */
  rangeName?: string;

  /**
   * The utilization of the range.
   */
  utilization?: float64;
}

/**
 * Configuration for controlling which IP addresses can access the cluster master endpoint
 */
model MasterAuthorizedNetworksConfig {
  /**
   * Whether or not master authorized networks is enabled
   */
  enabled?: boolean;

  /**
   * External networks that can access Kubernetes master through HTTPS
   */
  @extension("x-ms-identifiers", #[])
  cidrBlocks?: CidrBlock[];

  /**
   * Whether access from Google Cloud public IP addresses is enabled
   */
  gcpPublicCidrsAccessEnabled?: boolean;

  /**
   * Whether private endpoint enforcement is enabled
   */
  privateEndpointEnforcementEnabled?: boolean;
}

/**
 * Configuration for a CIDR block that can access the cluster master endpoint
 */
model CidrBlock {
  /**
   * An optional field for users to identify CIDR blocks
   */
  displayName?: string;

  /**
   * The CIDR block in IPv4 or IPv6 format
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "Suppress property having same name as its enclosing model as its defined in  GCP schema"
  cidrBlock?: string;
}

/**
 * Specifies the maintenance policy for the cluster
 */
model MaintenancePolicy {
  /**
   * Specifies the maintenance window for this cluster
   */
  window?: MaintenanceWindow;

  /**
   * A hash identifying the version of this policy, so that updates to fields of the policy won't accidentally undo intermediate changes
   */
  resourceVersion?: string;
}

/**
 * Maintenance window configuration for the cluster
 */
model MaintenanceWindow {
  /**
   * Daily maintenance window configuration
   */
  dailyMaintenanceWindow?: DailyMaintenanceWindow;

  /**
   * Recurring maintenance window configuration
   */
  recurringWindow?: RecurringTimeWindow;

  /**
   * Exceptions to maintenance window
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  maintenanceExclusions?: Record<MaintenanceExclusion>;
}

/**
 * Daily maintenance window configuration
 */
model DailyMaintenanceWindow {
  /**
   * Time of day the maintenance window starts
   */
  startTime?: string;

  /**
   * Duration of the maintenance window
   */
  duration?: string;
}

/**
 * Recurring time window for maintenance
 */
model RecurringTimeWindow {
  /**
   * The window of the first recurrence
   */
  window?: TimeWindow;

  /**
   * An RRULE for how this window recurs
   */
  recurrence?: string;
}

/**
 * Time window for maintenance operations
 */
model TimeWindow {
  /**
   * The start time of the time window
   */
  startTime?: string;

  /**
   * The end time of the time window
   */
  endTime?: string;
}

/**
 * Maintenance exclusion configuration
 */
model MaintenanceExclusion {
  /**
   * The time window during which maintenance is excluded
   */
  window?: TimeWindow;

  /**
   * The scope of the exclusion
   */
  exclusionOptions?: MaintenanceExclusionOptions;
}

/**
 * Options for maintenance exclusions
 */
model MaintenanceExclusionOptions {
  /**
   * The scope of automatic upgrades to restrict
   */
  scope?: MaintenanceExclusionScope;
}

/**
 * Scope of maintenance exclusions
 */
union MaintenanceExclusionScope {
  string,

  /** No exclusions */
  NO_EXCLUSIONS: "NO_EXCLUSIONS",

  /** Exclude minor upgrades */
  NO_MINOR_UPGRADES: "NO_MINOR_UPGRADES",

  /** Exclude minor and node upgrades */
  NO_MINOR_OR_NODE_UPGRADES: "NO_MINOR_OR_NODE_UPGRADES",
}

/**
 * Configuration for Binary Authorization
 */
model BinaryAuthorization {
  /**
   * Whether Binary Authorization is enabled for this cluster
   */
  enabled?: boolean;

  /**
   * Mode of operation for Binary Authorization policy evaluation
   */
  evaluationMode?: string;
}

/**
 * Cluster-level autoscaling configuration
 */
model ClusterAutoscaling {
  /**
   * Enables automatic node pool creation and deletion
   */
  enableNodeAutoprovisioning?: boolean;

  /**
   * Contains global constraints regarding minimum and maximum amount of resources in the cluster
   */
  @extension("x-ms-identifiers", #[])
  resourceLimits?: ResourceLimit[];

  /**
   * Defines the autoscaling behavior
   */
  autoscalingProfile?: AutoscalingProfile;

  /**
   * AutoprovisioningNodePoolDefaults contains defaults for a node pool created by NAP
   */
  autoprovisioningNodePoolDefaults?: AutoprovisioningNodePoolDefaults;

  /**
   * The list of Google Compute Engine zones in which the NodePool's nodes can be created by NAP
   */
  autoprovisioningLocations?: string[];

  /**
   * Default configuration for the Compute Class of the node pool
   */
  defaultComputeClassConfig?: DefaultComputeClassConfig;
}

/**
 * ResourceLimit contains resource type and range specification
 */
model ResourceLimit {
  /**
   * The type of the resource
   */
  resourceType?: string;

  /**
   * Minimum amount of the resource in the cluster
   */
  minimum?: string;

  /**
   * Maximum amount of the resource in the cluster
   */
  maximum?: string;
}

/**
 * Autoscaling profile options for the cluster autoscaler
 */
union AutoscalingProfile {
  string,

  /** Profile is unspecified */
  PROFILE_UNSPECIFIED: "PROFILE_UNSPECIFIED",

  /** Optimize for utilization */
  OPTIMIZE_UTILIZATION: "OPTIMIZE_UTILIZATION",

  /** Balanced profile */
  BALANCED: "BALANCED",
}

/**
 * AutoprovisioningNodePoolDefaults contains defaults for a node pool created by NAP
 */
model AutoprovisioningNodePoolDefaults {
  /**
   * Scopes that are used by NAP when creating node pools
   */
  oauthScopes?: string[];

  /**
   * The Google Cloud Platform Service Account to be used by the node VMs
   */
  serviceAccount?: string;

  /**
   * Upgrade settings for NAP created node pools
   */
  upgradeSettings?: UpgradeSettings;

  /**
   * The node management for NAP created node pools
   */
  management?: NodeManagement;

  /**
   * Minimum CPU platform for NAP created node pools
   */
  minCpuPlatform?: string;

  /**
   * Size of the disk attached to each node
   */
  diskSizeGb?: string;

  /**
   * Type of the disk attached to each node
   */
  diskType?: string;

  /**
   * Shielded Instance options for NAP created node pools
   */
  shieldedInstanceConfig?: ShieldedInstanceConfig;

  /**
   * Boot disk KMS key for NAP created node pools
   */
  bootDiskKmsKey?: string;

  /**
   * The image type to use for NAP created node pools
   */
  imageType?: string;

  /**
   * Whether the nodes are preemptible or not
   */
  insecureKubeletReadonlyPortEnabled?: boolean;

  /**
   * Whether the nodes are created as spot VM instances or not
   */
  enableSpotInstances?: boolean;

  /**
   * Resource labels for NAP created node pools
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  resourceLabels?: Record<string>;

  /**
   * Resource manager tags for NAP created node pools
   */
  resourceManagerTags?: ResourceManagerTags;
}

/**
 * Default configuration for the Compute Class of the node pool
 */
model DefaultComputeClassConfig {
  /**
   * The compute class to use for NAP created node pools
   */
  computeClass?: ComputeClass;
}

/**
 * Compute class options for node pools
 */
union ComputeClass {
  string,

  /** Compute class is unspecified */
  COMPUTE_CLASS_UNSPECIFIED: "COMPUTE_CLASS_UNSPECIFIED",

  /** Performance compute class */
  PERFORMANCE: "PERFORMANCE",

  /** Balanced compute class */
  BALANCED: "BALANCED",

  /** Arm64 compute class */
  ARM64: "ARM64",

  /** Memory optimized compute class */
  MEMORY_OPTIMIZED: "MEMORY_OPTIMIZED",
}

/**
 * NetworkConfig reports the relative names of network & subnetwork
 */
model NetworkConfig {
  /**
   * Name of the Google Compute Engine network
   */
  network?: string;

  /**
   * Name of the Google Compute Engine subnetwork
   */
  subnetwork?: string;

  /**
   * Whether Intra-node visibility is enabled for this cluster
   */
  enableIntraNodeVisibility?: boolean;

  /**
   * Configuration for default SNAT status
   */
  defaultSnatStatus?: DefaultSnatStatus;

  /**
   * Whether L4ILB Subsetting is enabled for this cluster
   */
  enableL4ilbSubsetting?: boolean;

  /**
   * The datapath provider for this cluster
   */
  datapathProvider?: DatapathProvider;

  /**
   * Private IPv6 Google Access configuration
   */
  privateIpv6GoogleAccess?: PrivateIPv6GoogleAccess;

  /**
   * DNS configuration for the cluster
   */
  dnsConfig?: DnsConfig;

  /**
   * Configuration for external IPs on services
   */
  serviceExternalIpsConfig?: ServiceExternalIpsConfig;

  /**
   * Gateway API configuration
   */
  gatewayApiConfig?: GatewayApiConfig;

  /**
   * Whether multi-networking is enabled for this cluster
   */
  enableMultiNetworking?: boolean;

  /**
   * Network performance configuration for the cluster
   */
  networkPerformanceConfig?: ClusterNetworkPerformanceConfig;

  /**
   * Whether FQDN network policy is enabled
   */
  enableFqdnNetworkPolicy?: boolean;

  /**
   * In-transit encryption configuration
   */
  inTransitEncryptionConfig?: InTransitEncryptionConfig;

  /**
   * Whether Cilium cluster-wide network policy is enabled
   */
  enableCiliumClusterwideNetworkPolicy?: boolean;

  /**
   * Whether private nodes are enabled by default
   */
  defaultEnablePrivateNodes?: boolean;

  /**
   * Whether to disable L4 load balancer firewall reconciliation
   */
  disableL4LbFirewallReconciliation?: boolean;
}

/**
 * Configuration for external IPs on services
 */
model ServiceExternalIpsConfig {
  /**
   * Whether Services with ExternalIPs field are allowed or not.
   */
  enabled?: boolean;
}

/**
 * Constraints applied to pods
 */
model MaxPodsConstraint {
  /**
   * The maximum number of pods that can run on a node
   */
  maxPodsPerNode?: string;
}

/**
 * Configuration for exporting cluster resource usage
 */
model ResourceUsageExportConfig {
  /**
   * Configuration to use BigQuery as destination of resource usage export
   */
  bigqueryDestination?: BigQueryDestination;

  /**
   * Whether to enable network egress metering for this cluster
   */
  enableNetworkEgressMetering?: boolean;

  /**
   * Configuration to enable resource consumption metering
   */
  consumptionMeteringConfig?: ConsumptionMeteringConfig;
}

/**
 * Configuration for the Google Groups for GKE feature
 */
model AuthenticatorGroupsConfig {
  /**
   * Whether Google Groups for RBAC and IAM are enabled
   */
  enabled?: boolean;

  /**
   * The name of the security group for the cluster
   */
  securityGroup?: string;
}

/**
 * Configuration for private clusters
 */
model PrivateClusterConfig {
  /**
   * Whether nodes have internal IP addresses only
   */
  enablePrivateNodes?: boolean;

  /**
   * Whether the master's internal IP address is used as the cluster endpoint
   */
  enablePrivateEndpoint?: boolean;

  /**
   * The IP range in CIDR notation to use for the hosted master network
   */
  masterIpv4CidrBlock?: string;

  /**
   * The internal IP address of this cluster's master endpoint
   */
  privateEndpoint?: string;

  /**
   * The external IP address of this cluster's master endpoint
   */
  publicEndpoint?: string;

  /**
   * The name of the VPC Network peering connection
   */
  peeringName?: string;

  /**
   * Controls master global access settings
   */
  masterGlobalAccessConfig?: PrivateClusterMasterGlobalAccessConfig;

  /**
   * Subnet to provision the master's private endpoint during cluster creation
   */
  privateEndpointSubnetwork?: string;
}

/**
 * Configuration for private cluster master global access
 */
model PrivateClusterMasterGlobalAccessConfig {
  /**
   * Whether the cluster master is accessible globally or not
   */
  enabled?: boolean;
}

/**
 * Configuration of etcd encryption
 */
model DatabaseEncryption {
  /**
   * Name of CloudKMS key to use for the encryption of secrets
   */
  keyName?: string;

  /**
   * Encryption state
   */
  state?: DatabaseEncryptionState;

  /**
   * List of decryption keys used for encryption
   */
  decryptionKeys?: string[];

  /**
   * Errors that occurred during the last operation
   */
  @extension("x-ms-identifiers", #[])
  lastOperationErrors?: OperationError[];

  /**
   * Current state of the database encryption
   */
  currentState?: DatabaseEncryptionCurrentState;
}

/**
 * Vertical Pod Autoscaling configuration
 */
model VerticalPodAutoscaling {
  /**
   * Enables vertical pod autoscaling
   */
  enabled?: boolean;
}

/**
 * Configuration of Shielded Nodes
 */
model ShieldedNodes {
  /**
   * Whether Shielded Nodes features are enabled on all nodes in this cluster
   */
  enabled?: boolean;
}

/**
 * ReleaseChannel indicates which release channel a cluster is subscribed to
 */
model ReleaseChannel {
  /**
   * The release channel the cluster is subscribed to
   */
  channel?: "UNSPECIFIED" | "RAPID" | "REGULAR" | "STABLE" | string;
}

/**
 * Configuration for the use of Kubernetes Service Accounts in GCP IAM policies
 */
model WorkloadIdentityConfig {
  /**
   * The workload pool to attach all Kubernetes service accounts to
   */
  workloadPool?: string;
}

/**
 * Configuration for issuance of mTLS keys and certificates to Kubernetes pods
 */
model MeshCertificates {
  /**
   * Whether to enable certificates for service mesh
   */
  enableCertificates?: boolean;
}

/**
 * Configuration for the cost management feature
 */
model CostManagementConfig {
  /**
   * Whether the cost management feature is enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for cluster notifications
 */
model NotificationConfig {
  /**
   * Configuration for Pub/Sub notifications
   */
  pubsub?: PubSub;
}

/**
 * PubSub configuration for the cluster
 */
model PubSub {
  /**
   * Whether notifications are enabled
   */
  enabled?: boolean;

  /**
   * The Pub/Sub topic for notifications
   */
  topic?: string;

  /**
   * Filter configuration for notifications
   */
  filter?: Filter;
}

/**
 * Filter configuration for notifications
 */
model Filter {
  /**
   * Event types to include in the filter
   */
  eventType?: (
    | "EVENT_TYPE_UNSPECIFIED"
    | "UPGRADE_AVAILABLE_EVENT"
    | "UPGRADE_EVENT"
    | "SECURITY_BULLETIN_EVENT"
    | string)[];
}

/**
 * Configuration of Confidential Nodes
 */
model ConfidentialNodes {
  /**
   * Whether Confidential Nodes feature is enabled for this cluster
   */
  enabled?: boolean;

  /**
   * The type of Confidential Compute offering used by the node pool
   */
  confidentialInstanceType?: ConfidentialInstanceType;
}

/**
 * Confidential instance type options
 */
union ConfidentialInstanceType {
  string,

  /** Instance type is unspecified */
  CONFIDENTIAL_INSTANCE_TYPE_UNSPECIFIED: "CONFIDENTIAL_INSTANCE_TYPE_UNSPECIFIED",

  /** Confidential VM */
  CONFIDENTIAL_VM: "CONFIDENTIAL_VM",

  /** Confidential Space */
  CONFIDENTIAL_SPACE: "CONFIDENTIAL_SPACE",
}

/**
 * Configuration for Identity Service component
 */
model IdentityServiceConfig {
  /**
   * Whether Identity Service is enabled for this cluster
   */
  enabled?: boolean;
}

/**
 * Cluster condition and state
 */
model StatusCondition {
  /**
   * Machine-readable code indicating the condition state
   */
  code?:
    | "UNKNOWN"
    | "GCE_STOCKOUT"
    | "GKE_SERVICE_ACCOUNT_DELETED"
    | "GCE_QUOTA_EXCEEDED"
    | "SET_BY_OPERATOR"
    | "CLOUD_KMS_KEY_ERROR"
    | "CA_EXPIRING"
    | string;

  /**
   * Human-readable message indicating details about the condition
   */
  message?: string;

  /**
   * Canonical code of the condition.
   */
  canonicalCode?:
    | "OK"
    | "CANCELLED"
    | "UNKNOWN"
    | "INVALID_ARGUMENT"
    | "DEADLINE_EXCEEDED"
    | "NOT_FOUND"
    | "ALREADY_EXISTS"
    | "PERMISSION_DENIED"
    | "UNAUTHENTICATED"
    | "RESOURCE_EXHAUSTED"
    | "FAILED_PRECONDITION"
    | "ABORTED"
    | "OUT_OF_RANGE"
    | "UNIMPLEMENTED"
    | "INTERNAL"
    | "UNAVAILABLE"
    | "DATA_LOSS"
    | string;
}

/**
 * Autopilot cluster configuration
 */
model Autopilot {
  /**
   * Whether the cluster is an Autopilot cluster
   */
  enabled?: boolean;
}

/**
 * Configuration for parent product integration
 */
model ParentProductConfig {
  /**
   * The ID of the parent product
   */
  productId?: string;

  /**
   * The project ID where the parent product is deployed
   */
  projectId?: string;
}

/**
 * Logging configuration for the cluster
 */
model LoggingConfig {
  /**
   * Configuration of cluster logging components
   */
  componentConfig?: {
    enableComponents?: (
      | "COMPONENT_UNSPECIFIED"
      | "SYSTEM_COMPONENTS"
      | "WORKLOADS"
      | string)[];
  };
}

/**
 * Monitoring configuration for the cluster
 */
model MonitoringConfig {
  /**
   * Configuration of cluster monitoring components
   */
  componentConfig?: {
    enableComponents?: (
      | "COMPONENT_UNSPECIFIED"
      | "SYSTEM_COMPONENTS"
      | "WORKLOADS"
      | string)[];
  };
}

/**
 * Node pool configs that apply to all auto-provisioned node pools in autopilot clusters and node auto-provisioning enabled clusters
 */
model NodePoolAutoConfig {
  /**
   * The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster creation. Each tag within the list must comply with RFC1035.
   */
  networkTags?: NetworkTags;

  /**
   * Resource manager tag keys and values to be attached to the nodes for managing Compute Engine firewalls using Network Firewall Policies.
   */
  resourceManagerTags?: ResourceManagerTags;
}

/**
 * Pod autoscaling configuration
 */
model PodAutoscaling {
  /**
   * Whether pod autoscaling is enabled
   */
  enabled?: boolean;
}

/**
 * Fleet configuration
 */
model Fleet {
  /**
   * The project number for the fleet host project
   */
  project?: string;
}

/**
 * Security posture configuration
 */
model SecurityPostureConfig {
  /**
   * Mode of the security posture
   */
  mode?: "MODE_UNSPECIFIED" | "BASIC" | "STANDARD" | string;
}

/**
 * Control plane endpoints configuration
 */
model ControlPlaneEndpointsConfig {
  /**
   * Network access configuration for the control plane endpoints
   */
  networkAccess?: {
    accessTypes?: (
      | "ACCESS_TYPE_UNSPECIFIED"
      | "PUBLIC"
      | "PRIVATE"
      | "SERVERLESS"
      | string)[];
  };
}

/**
 * Kubernetes Beta API configuration
 */
model K8sBetaApiConfig {
  /**
   * Whether Beta APIs are enabled
   */
  enableBetaApis?: boolean;

  /**
   * List of allowed Beta APIs
   */
  allowedBetaApis?: string[];
}

/**
 * Enterprise features configuration
 */
model EnterpriseConfig {
  /**
   * Whether enterprise features are enabled
   */
  enableEnterpriseFeatures?: boolean;

  /**
   * The enterprise project ID associated with this cluster
   */
  enterpriseProjectId?: string;

  /**
   * The enterprise tier level
   */
  enterpriseTier?:
    | "TIER_UNSPECIFIED"
    | "STANDARD"
    | "ADVANCED"
    | "PREMIUM"
    | string;
}

/**
 * Secret Manager configuration
 */
model SecretManagerConfig {
  /**
   * Whether Secret Manager integration is enabled
   */
  enabled?: boolean;
}

/**
 * Compliance posture configuration
 */
model CompliancePostureConfig {
  /**
   * Whether compliance posture features are enabled
   */
  enabled?: boolean;
}

/**
 * GKE auto-upgrade configuration
 */
model GkeAutoUpgradeConfig {
  /**
   * Whether auto-upgrade is enabled
   */
  enabled?: boolean;

  /**
   * Time when auto-upgrade should start
   */
  autoUpgradeStartTime?: string;
}

/**
 * Anonymous authentication configuration
 */
model AnonymousAuthenticationConfig {
  /**
   * Whether anonymous authentication is enabled
   */
  enabled?: boolean;
}

/**
 * Default configurations for node pools
 */
model NodePoolDefaults {
  /**
   * Default node configuration for node pools
   */
  nodeConfigDefaults?: {
    gcfsConfig?: {
      enabled?: boolean;
    };
  };
}

/**
 * User-managed keys configuration
 */
model UserManagedKeysConfig {
  /**
   * Whether user-managed keys are enabled
   */
  enabled?: boolean;
}

/**
 * Configuration for default SNAT status
 */
model DefaultSnatStatus {
  /**
   * Whether SNAT is disabled
   */
  disabled?: boolean;
}

/**
 * Datapath provider options
 */
union DatapathProvider {
  string,

  /** Legacy datapath provider */
  DATAPATH_PROVIDER_UNSPECIFIED: "DATAPATH_PROVIDER_UNSPECIFIED",

  /** Legacy datapath provider */
  LEGACY: "LEGACY",

  /** Advanced datapath provider */
  ADVANCED: "ADVANCED",
}

/**
 * Private IPv6 Google Access options
 */
union PrivateIPv6GoogleAccess {
  string,

  /** Unspecified private IPv6 Google access */
  PRIVATE_IPV6_GOOGLE_ACCESS_UNSPECIFIED: "PRIVATE_IPV6_GOOGLE_ACCESS_UNSPECIFIED",

  /** Private IPv6 Google access disabled */
  PRIVATE_IPV6_GOOGLE_ACCESS_DISABLED: "PRIVATE_IPV6_GOOGLE_ACCESS_DISABLED",

  /** Private IPv6 Google access to Google only */
  PRIVATE_IPV6_GOOGLE_ACCESS_TO_GOOGLE: "PRIVATE_IPV6_GOOGLE_ACCESS_TO_GOOGLE",

  /** Private IPv6 Google access bidirectional */
  PRIVATE_IPV6_GOOGLE_ACCESS_BIDIRECTIONAL: "PRIVATE_IPV6_GOOGLE_ACCESS_BIDIRECTIONAL",
}

/**
 * DNS configuration for the cluster
 */
model DnsConfig {
  /**
   * DNS scope for the cluster
   */
  dnsScope?: "DNS_SCOPE_UNSPECIFIED" | "CLUSTER_SCOPE" | "VPC_SCOPE" | string;

  /**
   * Custom DNS endpoint for the cluster
   */
  customDnsEndpoint?: string;

  /**
   * Additional DNS search domains
   */
  additionalDnsSearchDomains?: string[];
}

/**
 * Gateway API configuration
 */
model GatewayApiConfig {
  /**
   * The Gateway API release channel to subscribe to
   */
  channel?: "CHANNEL_UNSPECIFIED" | "RAPID" | "REGULAR" | "STABLE" | string;
}

/**
 * Network performance configuration for the cluster
 */
model ClusterNetworkPerformanceConfig {
  /**
   * Total egress bandwidth tier for the cluster
   */
  totalEgressBandwidthTier?: "TIER_UNSPECIFIED" | "TIER_1" | string;
}

/**
 * In-transit encryption configuration options
 */
union InTransitEncryptionConfig {
  string,

  /** Unspecified in-transit encryption */
  IN_TRANSIT_ENCRYPTION_UNSPECIFIED: "IN_TRANSIT_ENCRYPTION_UNSPECIFIED",

  /** In-transit encryption disabled */
  IN_TRANSIT_ENCRYPTION_DISABLED: "IN_TRANSIT_ENCRYPTION_DISABLED",

  /** In-transit encryption with inter-node transparent encryption */
  IN_TRANSIT_ENCRYPTION_INTER_NODE_TRANSPARENT: "IN_TRANSIT_ENCRYPTION_INTER_NODE_TRANSPARENT",
}

/**
 * Configuration for BigQuery destination
 */
model BigQueryDestination {
  /**
   * The BigQuery dataset ID
   */
  datasetId?: string;
}

/**
 * Configuration for consumption metering
 */
model ConsumptionMeteringConfig {
  /**
   * Whether consumption metering is enabled
   */
  enabled?: boolean;
}

/**
 * Database encryption state options
 */
union DatabaseEncryptionState {
  string,

  /** Unknown encryption state */
  UNKNOWN: "UNKNOWN",

  /** Database is encrypted */
  ENCRYPTED: "ENCRYPTED",

  /** Database is decrypted */
  DECRYPTED: "DECRYPTED",
}

/**
 * Database encryption current state options
 */
union DatabaseEncryptionCurrentState {
  string,

  /** Current state is unknown */
  CURRENT_STATE_UNSPECIFIED: "CURRENT_STATE_UNSPECIFIED",

  /** Encryption is being applied */
  CURRENT_STATE_ENCRYPTING: "CURRENT_STATE_ENCRYPTING",

  /** Database is encrypted */
  CURRENT_STATE_ENCRYPTED: "CURRENT_STATE_ENCRYPTED",

  /** Decryption is being applied */
  CURRENT_STATE_DECRYPTING: "CURRENT_STATE_DECRYPTING",

  /** Database is decrypted */
  CURRENT_STATE_DECRYPTED: "CURRENT_STATE_DECRYPTED",

  /** Encryption/decryption operation failed */
  CURRENT_STATE_ENCRYPTION_ERROR: "CURRENT_STATE_ENCRYPTION_ERROR",
}

/**
 * Operation error information
 */
model OperationError {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Timestamp when the error occurred
   */
  timestamp?: utcDateTime;

  /**
   * Additional details about the error
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  details?: Record<string>;
}

/**
 * Configuration for hardware accelerators attached to each node
 */
model AcceleratorConfig {
  /**
   * The number of the accelerator cards exposed to an instance
   */
  acceleratorCount?: string;

  /**
   * The accelerator type resource name
   */
  acceleratorType?: string;

  /**
   * Size of partitions to create on the GPU
   */
  gpuPartitionSize?: string;

  /**
   * The configuration for GPU sharing options
   */
  gpuSharingConfig?: GpuSharingConfig;

  /**
   * The configuration for auto-installing GPU driver
   */
  gpuDriverInstallationConfig?: GpuDriverInstallationConfig;
}

/**
 * GpuSharingConfig represents the GPU sharing configuration for Hardware Accelerators
 */
model GpuSharingConfig {
  /**
   * The type of GPU sharing strategy to enable on the GPU node
   */
  gpuSharingStrategy?:
    | "GPU_SHARING_STRATEGY_UNSPECIFIED"
    | "TIME_SHARING"
    | "MPS"
    | string;

  /**
   * The max number of containers that can share a physical GPU
   */
  maxSharedClientsPerGpu?: string;
}

/**
 * GPUDriverInstallationConfig specifies the version of GPU driver to be auto installed
 */
model GpuDriverInstallationConfig {
  /**
   * Mode for how the GPU driver is installed
   */
  gpuDriverVersion?:
    | "GPU_DRIVER_VERSION_UNSPECIFIED"
    | "INSTALLATION_DISABLED"
    | "DEFAULT"
    | "LATEST"
    | string;
}

/**
 * WorkloadMetadataConfig defines the metadata configuration to expose to workloads on the node pool
 */
model WorkloadMetadataConfig {
  /**
   * Mode is the configuration for how to expose metadata to workloads running on the node pool
   */
  mode?: "MODE_UNSPECIFIED" | "GCE_METADATA" | "GKE_METADATA" | string;
}

/**
 * Kubernetes taint is composed of three fields: key, value, and effect
 */
model NodeTaint {
  /**
   * Key for taint
   */
  key?: string;

  /**
   * Value for taint
   */
  value?: string;

  /**
   * Effect for taint
   */
  effect?:
    | "EFFECT_UNSPECIFIED"
    | "NO_SCHEDULE"
    | "PREFER_NO_SCHEDULE"
    | "NO_EXECUTE"
    | string;
}

/**
 * SandboxConfig contains configurations of the sandbox to use for the node
 */
model SandboxConfig {
  /**
   * Type of the sandbox to use for the node
   */
  type?: "UNSPECIFIED" | "GVISOR" | string;
}

/**
 * ReservationAffinity is the configuration of desired reservation which instances could take capacity from
 */
model ReservationAffinity {
  /**
   * Corresponds to the type of reservation consumption
   */
  consumeReservationType?:
    | "UNSPECIFIED"
    | "NO_RESERVATION"
    | "ANY_RESERVATION"
    | "SPECIFIC_RESERVATION"
    | string;

  /**
   * Corresponds to the label key of a reservation resource
   */
  key?: string;

  /**
   * Corresponds to the label value(s) of reservation resource(s)
   */
  values?: string[];
}

/**
 * A set of Shielded Instance options
 */
model ShieldedInstanceConfig {
  /**
   * Defines whether the instance has Secure Boot enabled
   */
  enableSecureBoot?: boolean;

  /**
   * Defines whether the instance has integrity monitoring enabled
   */
  enableIntegrityMonitoring?: boolean;
}

/**
 * Parameters that can be configured on Linux nodes
 */
model LinuxNodeConfig {
  /**
   * The Linux kernel parameters to be applied to the nodes and all pods running on the nodes
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  sysctls?: Record<string>;

  /**
   * cgroup_mode specifies the cgroup mode to be used on the node
   */
  cgroupMode?:
    | "CGROUP_MODE_UNSPECIFIED"
    | "CGROUP_MODE_V1"
    | "CGROUP_MODE_V2"
    | string;
}

/**
 * Node kubelet configs
 */
model NodeKubeletConfig {
  /**
   * Control the CPU management policy on the node
   */
  cpuManagerPolicy?: string;

  /**
   * Enable CPU CFS quota enforcement for containers that specify CPU limits
   */
  cpuCfsQuota?: boolean;

  /**
   * Set the CPU CFS quota period value 'cpu.cfs_period_us'
   */
  cpuCfsQuotaPeriod?: string;

  /**
   * Set the verbosity level of the kubelet logs
   */
  podPidsLimit?: string;

  /**
   * Set flag to enable/disable the logs verbosity for the node
   */
  insecureKubeletReadonlyPortEnabled?: boolean;
}

/**
 * Google Container File System (image streaming) configs
 */
model GcfsConfig {
  /**
   * Whether to use GCFS or not
   */
  enabled?: boolean;
}

/**
 * Specifies options for controlling advanced machine features
 */
model AdvancedMachineFeatures {
  /**
   * The number of threads per physical core
   */
  threadsPerCore?: string;

  /**
   * Whether or not to enable nested virtualization
   */
  enableNestedVirtualization?: boolean;
}

/**
 * Configuration of gVNIC feature
 */
model VirtualNic {
  /**
   * Whether gVNIC features are enabled in the node pool
   */
  enabled?: boolean;
}

/**
 * NodePoolLoggingConfig specifies logging configuration for nodepools
 */
model NodePoolLoggingConfig {
  /**
   * Logging variant configuration
   */
  variantConfig?: LoggingVariantConfig;
}

/**
 * LoggingVariantConfig specifies the behaviour of the logging agent
 */
model LoggingVariantConfig {
  /**
   * Logging variant deployed on nodes
   */
  variant?: "VARIANT_UNSPECIFIED" | "DEFAULT" | "MAX_THROUGHPUT" | string;
}

/**
 * Parameters that can be configured on Windows nodes
 */
model WindowsNodeConfig {
  /**
   * OSVersion specifies the Windows node config to be used on the node
   */
  osVersion?:
    | "OS_VERSION_UNSPECIFIED"
    | "OS_VERSION_LTSC2019"
    | "OS_VERSION_LTSC2022"
    | string;
}

/**
 * Configuration for the local NVMe SSD block device
 */
model LocalNvmeSsdBlockConfig {
  /**
   * Number of raw-block local NVMe SSD disks to be attached to the node
   */
  localSsdCount?: int32;
}

/**
 * Configuration for the ephemeral storage local SSD
 */
model EphemeralStorageLocalSsdConfig {
  /**
   * Number of local SSD disks to use to back ephemeral storage
   */
  localSsdCount?: int32;
}

/**
 * SoleTenantConfig contains the Sole Tenant configuration
 */
model SoleTenantConfig {
  /**
   * List of node affinities associated with the sole tenant node pool
   */
  @extension("x-ms-identifiers", #[])
  nodeAffinities?: NodeAffinity[];
}

/**
 * Specifies the NodeAffinity key, values, and affinity operator according to shared sole tenant node group affinities
 */
model NodeAffinity {
  /**
   * Key for NodeAffinity
   */
  key?: string;

  /**
   * Operator for NodeAffinity
   */
  operator?: "OPERATOR_UNSPECIFIED" | "IN" | "NOT_IN" | string;

  /**
   * Values for NodeAffinity
   */
  values?: string[];
}

/**
 * ContainerdConfig contains configuration to customize containerd
 */
model ContainerdConfig {
  /**
   * PrivateRegistryAccessConfig is used to configure access to private registries
   */
  privateRegistryAccessConfig?: PrivateRegistryAccessConfig;
}

/**
 * PrivateRegistryAccessConfig contains access configuration for private container registries
 */
model PrivateRegistryAccessConfig {
  /**
   * Whether or not private registries are configured
   */
  enabled?: boolean;

  /**
   * List of certificate authority certificates for private registries
   */
  @extension("x-ms-identifiers", #[])
  certificateAuthorityDomainConfig?: CertificateAuthorityDomainConfig[];
}

/**
 * Configuration for issuance of mTLS keys and certificates to Kubernetes pods
 */
model CertificateAuthorityDomainConfig {
  /**
   * List of fully-qualified-domain-names
   */
  fqdns?: string[];

  /**
   * Google Secret Manager URI for the certificate authority certificate
   */
  gcpSecretManagerCertificateConfig?: GcpSecretManagerCertificateConfig;
}

/**
 * GCPSecretManagerCertificateConfig specifies a certificate stored in Google Secret Manager
 */
model GcpSecretManagerCertificateConfig {
  /**
   * Secret Manager secret URI for the certificate authority certificate
   */
  secretUri?: string;
}

/**
 * The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls and are specified by the client during cluster creation. Each tag within the list must comply with RFC1035.
 */
model NetworkTags {
  /**
   * List of network tags
   */
  tags?: string[];
}

/**
 * A map of resource manager tag keys and values to be attached to the nodes for managing Compute Engine firewalls using Network Firewall Policies
 */
model ResourceManagerTags {
  /**
   * TagKeyId is the namespaced and unique ID of the tag key
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in GCP"
  tags?: Record<string>;
}

/**
 * SecondaryBootDisk represents a persistent disk attached to a node with special configurations based on its mode
 */
model SecondaryBootDisk {
  /**
   * Fully-qualified resource ID for an existing disk image
   */
  diskImage?: string;

  /**
   * Disk boot mode
   */
  mode?: "MODE_UNSPECIFIED" | "CONTAINER_IMAGE_CACHE" | string;
}

/**
 * Configuration of NCCL Fast Socket
 */
model FastSocket {
  /**
   * Whether or not NCCL Fast Socket is enabled
   */
  enabled?: boolean;
}

/**
 * SecondaryBootDiskUpdateStrategy is a placeholder which will be extended in the future to define different options for updating secondary boot disks
 */
model SecondaryBootDiskUpdateStrategy {
  /**
   * Update strategy for secondary boot disks
   */
  strategy?: "STRATEGY_UNSPECIFIED" | string;
}

/**
 * Local SSD encryption mode
 */
union LocalSsdEncryptionMode {
  string,

  /** Local SSD encryption mode is unspecified */
  LOCAL_SSD_ENCRYPTION_MODE_UNSPECIFIED: "LOCAL_SSD_ENCRYPTION_MODE_UNSPECIFIED",

  /** Use Google-managed encryption keys for local SSD encryption */
  GOOGLE_MANAGED: "GOOGLE_MANAGED",

  /** Use customer-managed encryption keys for local SSD encryption */
  CUSTOMER_MANAGED: "CUSTOMER_MANAGED",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppress casing style as the name is defined in GCP."
@armResourceOperations
interface ContainerClusters {
  get is ArmResourceRead<ContainerCluster>;
  @doc("Create a ContainerCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrReplace is ArmResourceCreateOrReplaceAsync<ContainerCluster>;
  delete is ArmResourceDeleteWithoutOkAsync<ContainerCluster>;
  list is ArmResourceListByParent<ContainerCluster>;
}
