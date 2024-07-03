import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./hciCommon.tsp";
// import "./clusters.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;



@doc("A Cluster")
model Clusters is TrackedResource<ClusterProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("clusterName")
  @doc("Name of Cluster")
  @segment("clusters")
  @visibility("read")
  @path("/clusters/{clusterName}")
  name: string
}
@doc("A ClusterProperties")
model ClusterProperties {
  /**
   * The provisioning state of the cluster.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}



// FIXME: ClusterJob has no properties property
/**
 * Jobs resource
 */
@doc("Cluster Jobs resource")
@parentResource(Clusters)
@discriminator("kind")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model ClusterJob is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ClusterJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  /**
   * Edge Solution type to support polymorphic resource.
   */
  @visibility("read", "create")
  kind: EdgeSolutionType;
}

@armResourceOperations
interface ClusterJobs {
  /**
   * Get a ClusterJob
   */
  get is ArmResourceRead<ClusterJob>;

  /**
   * Create a ClusterJob
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterJob>;

  /**
   * Delete a ClusterJob
   */
  delete is ArmResourceDeleteWithoutOkAsync<ClusterJob>;

  /**
   * List ClusterJob resources by Clusters
   */
  listByClusters is ArmResourceListByParent<ClusterJob>;
}

@@doc(ClusterJob.name, "Name of ClusterJob");

////////////////////models////////////////////

/**
 * Edge solution type.
 */
union EdgeSolutionType {
  string,

  /**
   * Edge solution for Windows based edge devices.
   */
  Windows: "Windows",

  /**
   * Edge solution for Azure linux edge devices.
   */
  AzureLinux: "AzureLinux",
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
 * ClusterJob Type supported.
 */
union AzureLinuxJobType {
  string,

  /**
   * Job to add a server to the cluster.
   */
  AddServer: "AddServer",

  /**
   * Job to repair a server in the cluster.
   */
  RepairServer: "RepairServer"
}

/**
 * ClusterJob Type supported.
 */
union HciJobType {
  string,

  /**
   * Job to add a server to the cluster.
   */
  AddServer: "AddServer",

  /**
   * Job to repair a server in the cluster.
   */
  RepairServer: "RepairServer",

  /**
   * Job to resume a paused server in the cluster.
   */
  ResumeServer: "ResumeServer",

  /**
   * Job to pause an active server in the cluster.
   */
  PauseServer: "PauseServer",

  /**
   * Job to add a network intent to the cluster.
   */
  AddNetworkIntent: "AddNetworkIntent",

  /**
   * Job to set or update information in the cluster.
   */
  SetInformation: "SetInformation",
}

/**
 * Properties for adding a server to the cluster.
 */
model AddServerJobProperties {
  ...ClusterJobProperties,
  /**
   * Name of server to be added to the cluster.
   */
  serverName: string;

  /**
   * IP address of server to be added to the cluster.
   */
  hostIpv4Address: string;

  /**
   * List of protected parameters to pass to trigger the job for the cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];
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
   * Secret name expected for job execution.
   */
  eceSecretName?: EceSecrets;

  /**
   * Secret URI stored in keyvault.
   */
  secretLocation?: url;
}

/**
 * Cluster Job properties
 */
model ClusterJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy;

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @extension("x-ms-mutability", ["create", "read"])
  arcNodeResourceIds?: string[];

  /**
   * Job provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility("read")
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility("read")
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility("read")
  endTimeUtc?: utcDateTime;

  /**
   * Status of Cluster job. Allowed values are 'Failed', 'Success', 'Running', 'canceled'
   */
  @visibility("read")
  status?: string;

  /**
   * Reported properties for job
   */
  @visibility("read")
  reportedProperties?: JobReportedProperties;
}

/**
 * Reported Properties for cluster job triggered from cloud.
 */
model JobReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Validation status of ob.
   */
  @visibility("read")
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility("read")
  deploymentStatus?: EceActionStatus;
}

/**
 * Properties for adding a server in Azure Linux cluster job.
 */
model AzureLinuxAddServerJobProperties extends AzureLinuxClusterJobProperties {
  ...AddServerJobProperties,

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: "AddServer";
}

/**
 * Cluster Job properties
 */
@discriminator("jobType") 
@doc("Cluster Job properties")
model AzureLinuxClusterJobProperties  {
  ...ClusterJobProperties,
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxJobType
}

/**
 * Cluster job for Azure Linux solution.
 */
model AzureLinuxJob extends ClusterJob {
  /**
   * Cluster Job properties
   */
  properties: AzureLinuxClusterJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: EdgeSolutionType.AzureLinux;
}

/**
 * Properties for repairing a server in the cluster.
 */
model AzureLinuxRepairServerJobProperties extends AzureLinuxClusterJobProperties {
  /**
   * Name of server to be repaired in cluster.
   */
  serverName: string;

  /**
   * List of protected parameters to pass to trigger job for cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: AzureLinuxJobType.RepairServer;
}

/**
 * Cluster job for Azure Stack HCI solution.
 */
model AzureStackHciJob extends ClusterJob {
  /**
   * HCI Cluster Job properties
   */
  properties: HciClusterJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: EdgeSolutionType.Windows;
}

/**
 * HCI Cluster Job properties
 */
@discriminator("jobType")
model HciClusterJobProperties {
  ...ClusterJobProperties,
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: HciJobType
}


/**
 * Properties for adding network intent to a cluster.
 */
model HciAddNetworkIntentJobProperties extends HciClusterJobProperties {
  /**
   * List of protected parameters to pass to trigger job for cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * HostNetwork properties to set network intent.
   */
  hostNetwork?: Record<unknown>;

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: HciJobType.AddNetworkIntent;
}

/**
 * Properties for adding a server in the cluster.
 */
model HciAddServerJobProperties extends HciClusterJobProperties {
  /**
   * Name of server to be added to cluster.
   */
  serverName: string;

  /**
   * Ip address of server to be added to cluster.
   */
  hostIpv4Address: string;

  /**
   * List of protected parameters to pass to trigger job for cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: HciJobType.AddServer;
}

/**
 * Properties for pausing a server in the cluster.
 */
model HciPauseServerJobProperties extends HciClusterJobProperties {
  /**
   * Trigger pause job for given server name in cluster.
   */
  serverName: string;

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: HciJobType.PauseServer;
}

/**
 * Properties for repairing a server in the cluster.
 */
model HciRepairServerJobProperties extends HciClusterJobProperties {
  /**
   * Name of server to be repaired in cluster.
   */
  serverName: string;

  /**
   * List of protected parameters to pass to trigger job for cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: HciJobType.RepairServer;
}

/**
 * Properties for resuming a server in the cluster.
 */
model HciResumeServerJobProperties extends HciClusterJobProperties {
  /**
   * Trigger resume job for given server name in cluster.
   */
  serverName: string;

  /**
   * List of ARM resource ids of Arc machines part of cluster for which job will be triggered.
   */
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: HciJobType.ResumeServer;
}

/**
 * Properties for setting information in the HCI cluster.
 */
model HciSetInformationJobProperties extends HciClusterJobProperties {
  /**
   * Set to represent if the system is configured in a switchless or switched configuration.
   */
  switchless?: boolean;

  /**
   * A string with a list of comma-separated name of the network adapters to use for the storage intent.
   */
  storageIntentAdapters?: string;

  /**
   * A string with the name of the storage intent. If not provided a default one storage is used.
   */
  name?: string;

  /**
   * A string with a list of comma-separated vlan ids to use which should map exactly and in order to the adapters provided in StorageIntentAdapters. If not provided the system uses the defaults set by Network ATC.
   */
  vlanId?: string;

  /**
   * A string with the size to be set for jumbo packet frame size for the storage adapters.
   */
   jumboPacket?: string;

  /**
   * A string to be set to enabled or disabled to specify if network direct mode should be enabled/disabled.
   */
  networkDirect?: string;

  /**
   * A string that specifies the network direct technology to be used. Possible values are iWARP, RoCE and RoCEv2.
   */
   networkDirectTechnology?: string;

  /**
   * A string to specify the 802.1Q priority for the cluster.
   */
   priorityValue8021ActionCluster?: string;

  /**
   * A string to specify the 802.1Q priority for SMB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  priorityValue8021ActionSMB?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  /**
   * A string to specify the bandwidth percentage to be used for SMB.
   */
   bandwidthPercentageSMB?: string;

  /**
   * ClusterJob Type to support polymorphic resource.
   */
  jobType: "SetInformation";
}

/**
 * Properties for pausing a server in the cluster.
 */
model PauseServerJobProperties {
  ...ClusterJobProperties,
  /**
   * Trigger pause job for given server name in cluster.
   */
  serverName: string;
}

/**
 * Properties for repairing a server in the cluster.
 */
model RepairServerJobProperties {
  ...ClusterJobProperties,
  /**
   * Name of server to be repaired in cluster.
   */
  serverName: string;

  /**
   * List of protected parameters to pass to trigger job for cluster.
   */
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];
}

/**
 * Properties for resuming a server in the cluster.
 */
model ResumeServerJobProperties  {
  ...ClusterJobProperties,
  /**
   * Trigger resume job for given server name in cluster.
   */
  serverName: string;
}
