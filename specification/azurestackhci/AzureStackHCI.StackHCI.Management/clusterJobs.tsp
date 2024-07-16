import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("A Cluster")
model Cluster is TrackedResource<ClusterProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("clusterName")
  @doc("Name of Cluster")
  @segment("clusters")
  @visibility("read")
  @path("/clusters/{clusterName}")
  name: string;
}
@doc("A ClusterProperties")
model ClusterProperties {
  @doc("The provisioning state of the cluster.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("Cluster Jobs resource")
@parentResource(Cluster)
@discriminator("kind")
model ClusterJob is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = ClusterJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Edge Solution type to support polymorphic resource.")
  @visibility("read", "create")
  kind: EdgeSolutionType;
}

@armResourceOperations
interface ClusterJobs {
  @doc("Get a ClusterJob")
  get is ArmResourceRead<ClusterJob>;

  @doc("Create a ClusterJob")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ClusterJob>;

  @doc("Delete a ClusterJob")
  delete is ArmResourceDeleteWithoutOkAsync<ClusterJob>;

  @doc("List ClusterJob resources by Clusters")
  listByClusters is ArmResourceListByParent<ClusterJob>;
}

@@doc(ClusterJob.name, "Name of ClusterJob");

////////////////////models////////////////////

@doc("Edge solution type.")
union EdgeSolutionType {
  string,

  @doc("Edge solution for Windows based edge devices.")
  Windows: "Windows",

  @doc("Edge solution for Azure linux edge devices.")
  AzureLinux: "AzureLinux",
}

@doc("Secret names allowed for Enterprise Cloud Engine (ECE) deployment.")
union EceSecrets {
  string,

  @doc("AzureStackLCMUserCredential used for LCM operations for AzureStackHCI cluster.")
  AzureStackLCMUserCredential: "AzureStackLCMUserCredential",

  @doc("DefaultARBApplication used to manage Azure Arc resource bridge (ARB) for AzureStackHCI cluster.")
  DefaultARBApplication: "DefaultARBApplication",

  @doc("LocalAdminCredential used for admin operations for AzureStackHCI cluster.")
  LocalAdminCredential: "LocalAdminCredential",

  @doc("WitnessStorageKey used for setting up a cloud witness for AzureStackHCI cluster.")
  WitnessStorageKey: "WitnessStorageKey",
}

@doc("ClusterJob Type supported.")
union AzureLinuxJobType {
  string,

  @doc("Job to add a server to the cluster.")
  AddServer: "AddServer",

  @doc("Job to repair a server in the cluster.")
  RepairServer: "RepairServer",
}

@doc("ClusterJob Type supported.")
union HciJobType {
  string,

  @doc("Job to add a server to the cluster.")
  AddServer: "AddServer",

  @doc("Job to repair a server in the cluster.")
  RepairServer: "RepairServer",

  @doc("Job to resume a paused server in the cluster.")
  ResumeServer: "ResumeServer",

  @doc("Job to pause an active server in the cluster.")
  PauseServer: "PauseServer",

  @doc("Job to add a network intent to the cluster.")
  AddNetworkIntent: "AddNetworkIntent",

  @doc("Job to set or update information in the cluster.")
  SetInformation: "SetInformation",
}

@doc("Properties for adding a server to the cluster.")
model AddServerJobProperties {
  ...ClusterJobProperties;

  @doc("Name of server to be added to the cluster.")
  serverName: string;

  @doc("IP address of server to be added to the cluster.")
  hostIpv4Address: string;

  @doc("List of protected parameters to pass to trigger the job for the cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];
}

@doc("Protected parameters list stored in keyvault.")
model EceDeploymentSecrets {
  @doc("Secret name stored in keyvault.")
  secretName?: string;

  @doc("Secret name expected for job execution.")
  eceSecretName?: EceSecrets;

  @doc("Secret URI stored in keyvault.")
  secretLocation?: url;
}

@doc("Cluster Job properties")
model ClusterJobProperties {
  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy;

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @extension("x-ms-mutability", ["create", "read"])
  arcNodeResourceIds?: string[];

  @doc("Job provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable job id.")
  @visibility("read")
  jobId?: string;

  @doc("The UTC date and time at which the job started.")
  @visibility("read")
  startTimeUtc?: utcDateTime;

  @doc("The UTC date and time at which the job completed.")
  @visibility("read")
  endTimeUtc?: utcDateTime;

  @doc("Status of Cluster job.")
  @visibility("read")
  status?: JobStatus;

  @doc("Reported properties for job")
  @visibility("read")
  reportedProperties?: JobReportedProperties;
}

@doc("Reported Properties for cluster job triggered from cloud.")
model JobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Validation status of ob.")
  @visibility("read")
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus?: EceActionStatus;
}

@doc("Properties for adding a server in Azure Linux cluster job.")
model AzureLinuxAddServerJobProperties extends AzureLinuxClusterJobProperties {
  ...AddServerJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: "AddServer";
}

@discriminator("jobType")
@doc("Cluster Job properties")
model AzureLinuxClusterJobProperties {
  ...ClusterJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxJobType;
}

@doc("Cluster job for Azure Linux solution.")
model AzureLinuxJob extends ClusterJob {
  @doc("Cluster Job properties")
  properties: AzureLinuxClusterJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeSolutionType.AzureLinux;
}

@doc("Properties for repairing a server in the cluster.")
model AzureLinuxRepairServerJobProperties
  extends AzureLinuxClusterJobProperties {
  @doc("Name of server to be repaired in cluster.")
  serverName: string;

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: AzureLinuxJobType.RepairServer;
}

@doc("Cluster job for Azure Stack HCI solution.")
model AzureStackHciJob extends ClusterJob {
  @doc("HCI Cluster Job properties")
  properties: HciClusterJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeSolutionType.Windows;
}

@doc("HCI Cluster Job properties")
@discriminator("jobType")
model HciClusterJobProperties {
  ...ClusterJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: HciJobType;
}

@doc("Properties for adding network intent to a cluster.")
model HciAddNetworkIntentJobProperties extends HciClusterJobProperties {
  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("HostNetwork properties to set network intent.")
  hostNetwork?: DeploymentHostNetwork;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.AddNetworkIntent;
}

@doc("Properties for adding a server in the cluster.")
model HciAddServerJobProperties extends HciClusterJobProperties {
  @doc("Name of server to be added to cluster.")
  serverName: string;

  @doc("Ip address of server to be added to cluster.")
  hostIpv4Address: string;

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  @doc("Job Type to support polymorphic resource.")
  jobType: HciJobType.AddServer;
}

@doc("Properties for pausing a server in the cluster.")
model HciPauseServerJobProperties extends HciClusterJobProperties {
  @doc("Trigger pause job for given server name in cluster.")
  serverName: string;

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.PauseServer;
}

@doc("Properties for repairing a server in the cluster.")
model HciRepairServerJobProperties extends HciClusterJobProperties {
  @doc("Name of server to be repaired in cluster.")
  serverName: string;

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.RepairServer;
}

@doc("Properties for resuming a server in the cluster.")
model HciResumeServerJobProperties extends HciClusterJobProperties {
  @doc("Trigger resume job for given server name in cluster.")
  serverName: string;

  @doc("List of Azure resource ids of Arc machines part of cluster for which job will be triggered.")
  @visibility("read", "create")
  arcNodeResourceIds?: string[];

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.ResumeServer;
}

@doc("Properties for setting information in the HCI cluster.")
model HciSetInformationJobProperties extends HciClusterJobProperties {
  @doc("Set to represent if the system is configured in a switchless or switched configuration.")
  switchless?: boolean;

  @doc("A string with a list of comma-separated name of the network adapters to use for the storage intent.")
  storageIntentAdapters?: string;

  @doc("A string with the name of the storage intent. If not provided a default one storage is used.")
  name?: string;

  @doc("A string with a list of comma-separated vlan ids to use which should map exactly and in order to the adapters provided in StorageIntentAdapters. If not provided the system uses the defaults set by Network ATC.")
  vlanId?: string;

  @doc("A string with the size to be set for jumbo packet frame size for the storage adapters.")
  jumboPacket?: string;

  @doc("A string to be set to enabled or disabled to specify if network direct mode should be enabled/disabled.")
  networkDirect?: string;

  @doc("A string that specifies the network direct technology to be used. Possible values are iWARP, RoCE and RoCEv2.")
  networkDirectTechnology?: string;

  @doc("A string to specify the 802.1Q priority for the cluster.")
  priorityValue8021ActionCluster?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("A string to specify the 802.1Q priority for SMB.")
  priorityValue8021ActionSMB?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @doc("A string to specify the bandwidth percentage to be used for SMB.")
  bandwidthPercentageSMB?: string;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: "SetInformation";
}

@doc("Properties for pausing a server in the cluster.")
model PauseServerJobProperties {
  ...ClusterJobProperties;

  @doc("Trigger pause job for given server name in cluster.")
  serverName: string;
}

@doc("Properties for repairing a server in the cluster.")
model RepairServerJobProperties {
  ...ClusterJobProperties;

  @doc("Name of server to be repaired in cluster.")
  serverName: string;

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];
}

@doc("Properties for resuming a server in the cluster.")
model ResumeServerJobProperties {
  ...ClusterJobProperties;

  @doc("Trigger resume job for given server name in cluster.")
  serverName: string;
}
