import "../common/models.tsp";
import "../common/service.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job.")
@discriminator("distributionType")
model DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: string;
}

@doc("PyTorch distribution configuration.")
model PyTorchDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "PyTorch";

  @doc("Number of processes per node.")
  processCountPerInstance?: int32;
}

@doc("MPI distribution configuration.")
model MpiDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "Mpi";

  @doc("Number of processes per MPI node.")
  processCountPerNode?: int32;
}

@doc("TensorFlow distribution configuration.")
model TensorFlowDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "TensorFlow";

  @doc("Number of workers.")
  workerCount?: int32;

  @doc("Number of parameter server tasks.")
  parameterServerCount?: int32;
}

@doc("Ray distribution configuration.")
model RayDistribution extends DistributionConfiguration {
  @doc("Specifies the type of distribution framework.")
  distributionType: "Ray";

  @doc("The port of the head Ray process.")
  port?: int32;

  @doc("The address of the Ray head node.")
  address?: string;

  @doc("Whether to start the Ray dashboard GUI.")
  includeDashboard?: boolean;

  @doc("The port to bind the dashboard server to.")
  dashboardPort?: int32;

  @doc("Additional arguments passed to ray start on the head node.")
  headNodeAdditionalArgs?: string;

  @doc("Additional arguments passed to ray start on worker nodes.")
  workerNodeAdditionalArgs?: string;
}

@doc("Enum to determine the input/output data delivery mode.")
union InputOutputModes {
  string,

  @doc("Read-only mount mode.")
  ReadOnlyMount: "ReadOnlyMount",

  @doc("Read-write mount mode.")
  ReadWriteMount: "ReadWriteMount",

  @doc("Download mode.")
  Download: "Download",

  @doc("Direct mode.")
  Direct: "Direct",

  @doc("Upload mode.")
  Upload: "Upload",
}

@doc("Type of job input/output asset.")
union AssetTypes {
  string,

  @doc("URI file asset.")
  UriFile: "uri_file",

  @doc("URI folder asset.")
  UriFolder: "uri_folder",

  @doc("Safetensors model asset.")
  SafetensorsModel: "safetensors_model",

  @doc("Literal value (inputs only).")
  Literal: "literal",
}

@doc("Job input definition.")
model Input {
  @doc("Specifies the type of job input.")
  @encodedName("application/json", "jobInputType")
  type: AssetTypes;

  @doc("Input Asset URI.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Input Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Literal value for literal-type inputs.")
  value?: string;
}

@doc("Job output definition.")
model Output {
  @doc("Specifies the type of job output.")
  @encodedName("application/json", "jobOutputType")
  type: AssetTypes;

  @doc("Output Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Name of the output data asset to register.")
  assetName?: string;

  @doc("Version of the output data asset to register.")
  assetVersion?: string;

  @doc("Output Asset URI.")
  uri?: string;

  @doc("Base model ID.")
  baseModelId?: string;

  @doc("Description for the output.")
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Nodes that user would like to start the service on.")
@discriminator("nodesValueType")
model NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: string;
}

@doc("All nodes means the service will be running on all of the nodes of the job.")
model AllNodes extends NodeCollection {
  @doc("Type of the Nodes value.")
  nodesValueType: "All";
}

@doc("Job endpoint definition.")
model JobService {
  @doc("Endpoint type.")
  jobServiceType?: string;

  @doc("Port for endpoint.")
  port?: int32;

  @doc("Url for endpoint.")
  endpoint?: string;

  @doc("Additional properties to set on the endpoint.")
  properties?: Record<string>;

  @doc("Nodes that user would like to start the service on.")
  nodes?: AllNodes;

  @doc("Status of endpoint.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Any error in the service.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

@doc("Compute Resource configuration for the job.")
model JobResourceConfiguration {
  @doc("Optional number of instances or nodes used by the compute target.")
  instanceCount?: int32;

  @doc("Optional type of VM used as supported by the compute target.")
  instanceType?: string;

  @doc("Additional properties bag.")
  properties?: Record<unknown>;

  @doc("Size of the docker container's shared memory block.")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command.")
  dockerArgs?: string;
}

@doc("Command Job limit class.")
model CommandJobLimits {
  @doc("JobLimit type.")
  jobLimitsType: "Command";

  @doc("The max run duration, after which the job will be cancelled.")
  timeout?: duration;
}

@doc("Queue settings for the job.")
model QueueSettings {
  @doc("Controls the compute job tier.")
  jobTier?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  @visibility(Lifecycle.Read)
  createdByType?: string;

  @doc("The timestamp of resource creation (UTC).")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  @visibility(Lifecycle.Read)
  lastModifiedByType?: string;

  @doc("The timestamp of resource last modification (UTC).")
  @visibility(Lifecycle.Read)
  lastModifiedAt?: utcDateTime;
}

@doc("Type of a job.")
union JobType {
  string,

  @doc("Command job.")
  Command: "Command",
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Base properties of a Job.")
@discriminator("jobType")
model JobProperties {
  @doc("Job type.")
  jobType: string;
}

@doc("Properties of a Command Job.")
model CommandJob extends JobProperties {
  @doc("Job type.")
  jobType: "Command";

  @doc("The command to execute on startup of the job.")
  command: string;

  @doc("ACR path of environment.")
  environmentImageReference: string;

  @doc("Display name of job.")
  displayName?: string;

  @doc("The asset description text.")
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  tags?: Record<string>;

  @doc("The asset property dictionary.")
  properties?: Record<string>;

  @doc("Code asset reference.")
  @encodedName("application/json", "codeId")
  code?: string;

  @doc("Compute resource ID.")
  @encodedName("application/json", "computeId")
  compute: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<Input>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<Output>;

  @doc("Environment variables included in the job.")
  environmentVariables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Distribution configuration of the job.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("List of job services.")
  services?: Record<JobService>;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

  @doc("user-assigned managed identity")
  userAssignedIdentityId?: string;

  @doc("Number of GPUs to allocate for the job.")
  gpuCount?: int32;

  @doc("Is the asset archived?")
  isArchived?: boolean;

  @doc("Status of the job.")
  @visibility(Lifecycle.Read)
  status?: string;
}

@doc("Job resource.")
@Rest.resource("jobs")
model Job {
  @doc("The name of the Job. This is case-sensitive.")
  @key("name")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The resource ID.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The resource type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("Properties of the job.")
  properties: JobProperties;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

@doc("Response returned when a job delete operation is accepted asynchronously.")
@clientName("JobDeleteAcceptedResult", "csharp")
model JobDeleteAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the status of the delete operation.")
  @header("Location")
  location: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Response returned when a job cancel operation is accepted asynchronously.")
@clientName("JobCancelAcceptedResult", "csharp")
model JobCancelAcceptedResponse {
  @statusCode statusCode: 202;

  @doc("URL to poll for the status of the cancel operation.")
  @header("Location")
  location: string;

  @doc("Suggested delay in seconds before polling.")
  @header("Retry-After")
  retryAfter?: int32;
}

@doc("Specifies which jobs to include in a list result based on their lifecycle state.")
union ListViewType {
  string,

  @doc("Show only active (non-archived) jobs.")
  ActiveOnly: "ActiveOnly",

  @doc("Show only archived jobs.")
  ArchivedOnly: "ArchivedOnly",

  @doc("Show all jobs regardless of archived state.")
  All: "All",
}

@doc("A data store path.")
model ArtifactDataPath {
  @doc("The data store name.")
  dataStoreName?: string;

  @doc("The relative path within the data store.")
  relativePath?: string;

  @doc("SQL data path information.")
  sqlDataPath?: unknown;
}

@doc("An artifact.")
model Artifact {
  @doc("The artifact id.")
  artifactId?: string;

  @doc("The artifact origin.")
  origin: string;

  @doc("The container name.")
  container: string;

  @doc("The artifact path.")
  path: string;

  @doc("The artifact Etag.")
  etag?: string;

  @doc("The artifact creation time in UTC.")
  createdTime?: utcDateTime;

  @doc("The artifact data path.")
  dataPath?: ArtifactDataPath;

  @doc("The artifact tags.")
  tags?: Record<string>;
}

@doc("A page of artifacts.")
model ArtifactList {
  @doc("The artifacts in the page.")
  value: Artifact[];

  @doc("Token for the next page.")
  continuationToken?: string;

  @doc("URL for the next page.")
  nextLink?: string;
}

@doc("Artifact content information.")
model ArtifactContentInformation {
  @doc("The content URI.")
  contentUri?: url;

  @doc("The artifact origin.")
  origin?: string;

  @doc("The container name.")
  container?: string;

  @doc("The artifact path.")
  path?: string;

  @doc("The artifact tags.")
  tags?: Record<string>;

  @doc("The content byte length.")
  contentLength?: int64;
}

@doc("A page of artifact content information.")
model ArtifactContentInformationList {
  @doc("The entries in the page.")
  value: ArtifactContentInformation[];

  @doc("Token for the next page.")
  continuationToken?: string;

  @doc("URL for the next page.")
  nextLink?: string;
}
