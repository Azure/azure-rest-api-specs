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
  listByCluster is ArmResourceListByParent<ClusterJob>;
}

@@doc(ClusterJob.name, "Name of ClusterJob");

////////////////////models////////////////////

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
}

@doc("Properties for adding a server to the cluster.")
model AddServerJobProperties {
  ...ClusterJobProperties;

  @doc("List of protected parameters to pass to trigger the job for the cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("Details of servers to be added to the cluster")
  @extension("x-ms-identifiers", [])
  addServerJobServerDetails: AddServerJobServerDetails[];

  @doc("Use a cloud witness if you have internet access and if you use an Azure Storage account to provide a vote on cluster quorum. A cloud witness uses Azure Blob Storage to read or write a blob file and then uses it to arbitrate in split-brain resolution. Only allowed values are 'Cloud', 'FileShare'")
  witnessType?: string;

  @doc("Specify the fileshare path for the local witness for your Azure Stack HCI cluster.")
  witnessPath?: string;

  @doc("Specify the Azure Storage account name for cloud witness for your Azure Stack HCI cluster.")
  cloudAccountName?: string;
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

@doc("Properties for adding a server in Azure Linux cluster job.")
model AzureLinuxAddServerJobProperties extends AzureLinuxClusterJobProperties {
  ...AddServerJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: AzureLinuxJobType.AddServer;
}

@discriminator("jobType")
@doc("Cluster Job properties")
model AzureLinuxClusterJobProperties {
  ...ClusterJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @visibility("create", "read")
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
  ...RepairServerJobProperties;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: AzureLinuxJobType.RepairServer;
}

@doc("Cluster job for Azure Stack HCI solution.")
model AzureStackHciJob extends ClusterJob {
  @doc("HCI Cluster Job properties")
  properties: HciClusterJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeSolutionType.WindowsServer;
}

@doc("HCI Cluster Job properties")
@discriminator("jobType")
model HciClusterJobProperties {
  ...ClusterJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @visibility("create", "read")
  jobType: HciJobType;
}

@doc("Details of servers to be added to the cluster")
model AddServerJobServerDetails {
  @doc("Name of server to be added to cluster.")
  serverName: string;

  @doc("Ip address of server to be added to cluster.")
  hostIpv4Address: string;

  @doc("Azure resource id of Arc machine part of cluster for which job will be triggered.")
  arcNodeResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Properties for adding a server in the cluster.")
model HciAddServerJobProperties extends HciClusterJobProperties {
  ...AddServerJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: HciJobType.AddServer;
}

@doc("Properties for pausing a server in the cluster.")
model HciPauseServerJobProperties extends HciClusterJobProperties {
  ...PauseServerJobProperties;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.PauseServer;
}

@doc("Properties for repairing a server in the cluster.")
model HciRepairServerJobProperties extends HciClusterJobProperties {
  ...RepairServerJobProperties;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.RepairServer;
}

@doc("Properties for resuming a server in the cluster.")
model HciResumeServerJobProperties extends HciClusterJobProperties {
  ...ResumeServerJobProperties;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.ResumeServer;
}

@doc("Properties for adding network intent to a cluster.")
model HciAddNetworkIntentJobProperties extends HciClusterJobProperties {
  ...AddNetworkIntentJobProperties;

  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: HciJobType.AddNetworkIntent;
}

@doc("Properties for adding network intent to a cluster.")
model AddNetworkIntentJobProperties {
  ...ClusterJobProperties;

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];

  @doc("Host and Network details for which the intent has to be added.")
  @extension("x-ms-identifiers", [])
  addNetworkIntentJobDetails: AddNetworkIntentJobDetails[];
}

@doc("Host and Network details for which the intent has to be added.")
model AddNetworkIntentJobDetails {
  @doc("HostNetwork properties to set network intent.")
  hostNetwork: DeploymentHostNetwork;

  @doc("Azure resource id of Arc machine part of cluster for which job will be triggered.")
  arcNodeResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Details of servers to be paused in the cluster")
model PauseServerJobServerDetails {
  @doc("Name of server to be added to cluster.")
  serverName: string;

  @doc("Azure resource id of Arc machine part of cluster for which job will be triggered.")
  arcNodeResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Properties for pausing a server in the cluster.")
model PauseServerJobProperties {
  ...ClusterJobProperties;

  @doc("Details of servers to be paused in the cluster")
  @extension("x-ms-identifiers", [])
  pauseServerJobServerDetails: PauseServerJobServerDetails[];
}

@doc("Details of servers to be repaired in the cluster")
model RepairServerJobServerDetails {
  @doc("Name of server to be repaired in cluster.")
  serverName: string;

  @doc("Azure resource id of Arc machine part of cluster for which job will be triggered.")
  arcNodeResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Properties for repairing a server in the cluster.")
model RepairServerJobProperties {
  ...ClusterJobProperties;

  @doc("Details of servers to be repaired in the cluster")
  @extension("x-ms-identifiers", [])
  repairServerJobServerDetails: RepairServerJobServerDetails[];

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[];
}

@doc("Details of servers to be resumes in the cluster")
model ResumeServerJobServerDetails {
  @doc("Name of server to be resume in cluster.")
  serverName: string;

  @doc("Azure resource id of Arc machine part of cluster for which job will be triggered.")
  arcNodeResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Properties for resuming a server in the cluster.")
model ResumeServerJobProperties {
  ...ClusterJobProperties;

  @doc("Details of servers to be resumed in the cluster")
  @extension("x-ms-identifiers", [])
  resumeServerJobServerDetails: ResumeServerJobServerDetails[];
}
