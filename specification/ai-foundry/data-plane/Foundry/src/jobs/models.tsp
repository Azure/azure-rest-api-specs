import "../common/models.tsp";
import "../common/service.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union instead of a plain string"
@doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
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

  @doc("Number of workers. If not specified, will default to the instance count.")
  workerCount?: int32;

  @doc("Number of parameter server tasks.")
  parameterServerCount?: int32;
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

  @doc("Input Asset URI. Required for uri_file, uri_folder, and safetensors_model types.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Input Asset Delivery Mode. Applies to uri-based inputs.")
  mode?: InputOutputModes;

  @doc("Literal value. Required for literal type.")
  value?: string;

  @doc("Description for the input.")
  description?: string;
}

@doc("Job output definition.")
model Output {
  @doc("Specifies the type of job output.")
  @encodedName("application/json", "jobOutputType")
  type: AssetTypes;

  @doc("Output Asset URI.")
  @encodedName("application/json", "uri")
  path?: string;

  @doc("Output Asset Delivery Mode.")
  mode?: InputOutputModes;

  @doc("Name of the output data asset to register.")
  assetName?: string;

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

  @doc("Nodes that user would like to start the service on. If Nodes is not set or set to null, the service will only be started on leader node.")
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

  @doc("Size of the docker container's shared memory block. This should be in the format of (number)(unit) where number as to be greater than 0 and the unit can be one of b(bytes), k(kilobytes), m(megabytes), or g(gigabytes).")
  shmSize?: string;

  @doc("Extra arguments to pass to the Docker run command. This would override any parameters that have already been set by the system, or in this section. This parameter is only supported for Azure ML compute types.")
  dockerArgs?: string;
}

@doc("Command Job limit class.")
model CommandJobLimits {
  @doc("JobLimit type.")
  jobLimitsType: "Command";

  @doc("The max run duration in ISO 8601 format, after which the job will be cancelled. Only supports duration with precision as low as Seconds.")
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
  code?: string;

  @doc("Compute resource ID.")
  compute: string;

  @doc("Mapping of input data bindings used in the job.")
  inputs?: Record<Input>;

  @doc("Mapping of output data bindings used in the job.")
  outputs?: Record<Output>;

  @doc("Environment variables included in the job.")
  environmentVariables?: Record<string>;

  @doc("Compute Resource configuration for the job.")
  resources?: JobResourceConfiguration;

  @doc("Distribution configuration of the job. If set, this should be one of Mpi, Tensorflow, PyTorch, or null.")
  distribution?: DistributionConfiguration;

  @doc("Command Job limit.")
  limits?: CommandJobLimits;

  @doc("List of job services.")
  @visibility(Lifecycle.Read)
  services?: Record<JobService>;

  @doc("Queue settings for the job.")
  queueSettings?: QueueSettings;

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
